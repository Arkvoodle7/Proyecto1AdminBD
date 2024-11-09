
USE SistemaEnviosDB;
GO
/*
CREATE PROCEDURE SP_CalcularDistancia
    @IdPedido INT,
    @DistanciaKilometros FLOAT OUTPUT
AS
BEGIN
    BEGIN TRY
        DECLARE @Distancia FLOAT;
        DECLARE @UbicacionCliente GEOGRAPHY;
        DECLARE @UbicacionProveedor GEOGRAPHY;

        -- Obtener la ubicacion del cliente
        SELECT @UbicacionCliente = c.ubicacion_geografica
        FROM Clientes c
        INNER JOIN Pedidos p ON c.id_cliente = p.id_cliente
        WHERE p.id_pedido = @IdPedido;

        -- Verificar si se obtuvo la ubicacion del cliente
        IF @UbicacionCliente IS NULL
        BEGIN
            RAISERROR('La ubicacion del cliente no se encontro para el pedido', 16, 1);
            RETURN;
        END

        -- Obtener la ubicacion del proveedor
        SELECT @UbicacionProveedor = pr.ubicacion_geografica
        FROM Proveedores pr
        INNER JOIN Productos prod ON pr.id_proveedor = prod.id_proveedor
        INNER JOIN Pedidos p ON prod.id_producto = p.id_producto
        WHERE p.id_pedido = @IdPedido;

        -- Verificar si se obtuvo la ubicacion del proveedor
        IF @UbicacionProveedor IS NULL
        BEGIN
            RAISERROR('La ubicacion del proveedor no se encontro para el pedido', 16, 1);
            RETURN;
        END

        -- Calcular la distancia en kilometros
        SET @Distancia = @UbicacionCliente.STDistance(@UbicacionProveedor) / 1000.0;

        -- Devolver la distancia como salida
        SET @DistanciaKilometros = @Distancia;

    END TRY
    BEGIN CATCH
        RAISERROR('Ocurrio un error al calcular la distancia del envio', 16, 1);
    END CATCH
END;

*/


/*
		Segunda version del SP
*/


GO
USE SistemaEnviosDB
GO
/****** Object:  StoredProcedure [dbo].[SP_CalcularCostoEnvioConDistancia]    Script Date: 9/11/2024 11:53:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE SP_CalcularDistancia
    @IdPedido INT,
    @DistanciaKm FLOAT OUTPUT,
    @CostoTotal DECIMAL(10, 2) OUTPUT
AS
BEGIN
    BEGIN TRY
        DECLARE @Distancia FLOAT; 
        DECLARE @CostoEnvio DECIMAL(10, 2);
        DECLARE @UbicacionCliente GEOGRAPHY;
        DECLARE @UbicacionProveedor GEOGRAPHY;

        -- Obtener la ubicacion del cliente
        SELECT @UbicacionCliente = c.ubicacion_geografica
        FROM Clientes c
        INNER JOIN Pedidos p ON c.id_cliente = p.id_cliente
        WHERE p.id_pedido = @IdPedido;

        -- Verificar si se obtuvo la ubicacion del cliente
        IF @UbicacionCliente IS NULL
        BEGIN
            RAISERROR('La ubicacion del cliente no se encontro para el pedido', 16, 1);
            RETURN;
        END

        -- Obtener la ubicacion del proveedor
        SELECT @UbicacionProveedor = pr.ubicacion_geografica
        FROM Proveedores pr
        INNER JOIN Productos prod ON pr.id_proveedor = prod.id_proveedor
        INNER JOIN Pedidos p ON prod.id_producto = p.id_producto
        WHERE p.id_pedido = @IdPedido;

        -- Verificar si se obtuvo la ubicacion del proveedor
        IF @UbicacionProveedor IS NULL
        BEGIN
            RAISERROR('La ubicacion del proveedor no se encontro para el pedido', 16, 1);
            RETURN;
        END

        -- Calcular la distancia en kilometros
        SET @Distancia = @UbicacionCliente.STDistance(@UbicacionProveedor) / 1000.0;

        -- Devolver la distancia como salida
        SET @DistanciaKm = @Distancia;

        -- Determinar el costo del envio y validar cobertura
        IF @Distancia <= 1
            SET @CostoEnvio = 800;
        ELSE IF @Distancia <= 3
            SET @CostoEnvio = 1400;
        ELSE IF @Distancia <= 6
            SET @CostoEnvio = 1800;
        ELSE IF @Distancia < 12
            SET @CostoEnvio = 2400;
        ELSE
        BEGIN
            -- Distancia fuera de cobertura: asignar costo total a 0 y no actualizar el estado
            SET @CostoTotal = 0;
            RETURN;
        END

        -- Si está dentro de la cobertura, calcular el costo y actualizar el estado y el costo total
        SET @CostoTotal = ISNULL(@CostoTotal, 0) + @CostoEnvio;

        -- Actualizar el costo total y el estado solo si está dentro de cobertura
        UPDATE Pedidos
        SET costo_total = @CostoTotal,
            estado = 'Entregado'
        WHERE id_pedido = @IdPedido AND @Distancia < 12;

    END TRY
    BEGIN CATCH
        RAISERROR('Ocurrio un error al calcular el precio del envio', 16, 1);
    END CATCH
END;


-----
GO
ALTER PROCEDURE [dbo].[sp_ObtenerPedidosConDetalles]
    @IdCliente INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.id_pedido AS IdPedido,
        p.fecha_pedido AS FechaPedido,
        p.estado AS Estado,
        Subtotal = SUM(dp.precio_unitario * dp.cantidad),
        Impuestos = SUM(dp.precio_unitario * dp.cantidad) * 0.13,
        Total = SUM(dp.precio_unitario * dp.cantidad) * 1.13,
        t.tipo_transporte AS Transportista,
        t.contacto AS ContactoTransportista,
        MAX(prod.tiempo_entrega) AS TiempoEntrega,
		p.costo_total AS CostoEntrega
    FROM 
        Pedidos p
    INNER JOIN 
        DetallePedido dp ON p.id_pedido = dp.id_pedido
    INNER JOIN 
        Productos prod ON dp.id_producto = prod.id_producto
    LEFT JOIN 
        Transportistas t ON p.id_transportista = t.id_transportista
    WHERE 
        p.id_cliente = @IdCliente
        AND (p.estado = 'pendiente' OR p.estado = 'en camino')
    GROUP BY 
        p.id_pedido, p.fecha_pedido, p.estado, t.tipo_transporte, t.contacto, p.costo_total
    ORDER BY 
        p.fecha_pedido DESC;
END 

--------------------------Alterar para que muester el total correcto
GO
ALTER PROCEDURE [dbo].[sp_ObtenerPedidosEntregadosPorCliente]
    @IdCliente INT
AS
BEGIN
    SELECT 
        p.id_pedido,
        p.fecha_pedido,
        p.estado,
        Subtotal = SUM(dp.precio_unitario * dp.cantidad),
        Impuestos = SUM(dp.precio_unitario * dp.cantidad) * 0.13,
		p.costo_total,
        Total = SUM(dp.precio_unitario * dp.cantidad) * 1.13 + p.costo_total
    FROM 
        Pedidos p
    INNER JOIN 
        DetallePedido dp ON p.id_pedido = dp.id_pedido
    WHERE 
        p.id_cliente = @IdCliente
        AND p.estado = 'Entregado'
    GROUP BY 
        p.id_pedido, p.fecha_pedido, p.estado, p.costo_total
END














------------------------------
--SP para actualizar a entregado

GO
CREATE PROCEDURE SP_ActualizarEstadoPedido
	@IdTransportista INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Actualizar el estado de los pedidos de "en camino" a "entregado"
    UPDATE Pedidos
    SET estado = 'Entregado'
    WHERE id_transportista = @IdTransportista
    AND estado = 'en camino';

	--Validacion
    IF @@ROWCOUNT = 0
    BEGIN
        PRINT 'No se actualizó ningun pedido.';
    END
END


------------------Pendientes por transportistaGO
GO
CREATE PROCEDURE SP_PendientesTransportista (@id INT)
AS
BEGIN
    SELECT 
        p.id_pedido,
        p.fecha_pedido,
        p.estado,
        total = SUM(dp.precio_unitario * dp.cantidad) * 1.13 + p.costo_total,
        --MAX(prod.tiempo_entrega),
        p.id_cliente,
        c.telefono
    FROM 
        Pedidos p
    INNER JOIN 
        DetallePedido dp ON p.id_pedido = dp.id_pedido
    INNER JOIN 
        Productos prod ON dp.id_producto = prod.id_producto
    LEFT JOIN 
        Transportistas t ON p.id_transportista = t.id_transportista
    JOIN 
        Clientes c ON p.id_cliente = c.id_cliente
    WHERE 
        p.id_transportista = @id
        AND (p.estado = 'en camino')
    GROUP BY 
        p.id_pedido, p.fecha_pedido, p.estado, p.costo_total, c.id_cliente, c.telefono, p.id_cliente
    ORDER BY 
        p.fecha_pedido DESC;
END;
