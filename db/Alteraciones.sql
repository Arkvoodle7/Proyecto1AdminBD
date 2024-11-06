
USE SistemaEnviosDB;

--Edits a SP

GO
CREATE PROCEDURE [dbo].[SP_UpdateProducto] 
    @IdProducto INT,
    @IdProveedor INT, 
    @Nombre VARCHAR(100), 
    @Categoria VARCHAR(20), 
    @Precio DECIMAL(10, 2), 
    @Tiempo_Entrega INT, 
    @Stock DECIMAL(10, 2)
AS
BEGIN
    UPDATE Productos
    SET 
        id_proveedor = @IdProveedor,
        nombre = @Nombre,
        categoria = @Categoria,
        precio = @Precio,
        tiempo_entrega = @Tiempo_Entrega,
        StockDisponible = @Stock
    WHERE id_producto = @IdProducto;
END;

GO
CREATE PROCEDURE ObtenerPedidosPorProveedor
    @id_proveedor INT
AS
BEGIN
    SELECT * FROM dbo.Pedidos p
    INNER JOIN dbo.Productos pr ON p.id_producto = pr.id_producto
    WHERE pr.id_proveedor = @id_proveedor;    
END;

GO
CREATE PROCEDURE SP_PedidosPendientes (@id INT)
AS
BEGIN
    SELECT 
        p.id_pedido,
        p.fecha_pedido,
        p.estado,
        subtotal = SUM(dp.precio_unitario * dp.cantidad),
        impuestos = SUM(dp.precio_unitario * dp.cantidad) * 0.13,
        total = SUM(dp.precio_unitario * dp.cantidad) * 1.13,
        t.tipo_transporte,
        t.contacto,
        MAX(prod.tiempo_entrega)
    FROM 
        Pedidos p
    INNER JOIN 
        DetallePedido dp ON p.id_pedido = dp.id_pedido
    INNER JOIN 
        Productos prod ON dp.id_producto = prod.id_producto
    LEFT JOIN 
        Transportistas t ON p.id_transportista = t.id_transportista
    WHERE 
        p.id_cliente = @id
        AND (p.estado = 'en camino')
    GROUP BY 
        p.id_pedido, p.fecha_pedido, p.estado, t.tipo_transporte, t.contacto
    ORDER BY 
        p.fecha_pedido DESC;
END;



GO 
ALTER PROCEDURE SP_InsertProducto (@IdProvedor INT, @Nombre VARCHAR(100), @Categoria VARCHAR(20), 
@Precio DECIMAL(10, 2), @Tiempo_Entrega INT, @Stock Decimal(10, 2))
AS 
BEGIN 
	INSERT INTO Productos(id_proveedor, nombre, categoria, precio, tiempo_entrega, StockDisponible) 
	VALUES (@IdProvedor, @Nombre, @Categoria, @Precio, @Tiempo_Entrega, @Stock);
END




GO     --Nuevos SP
CREATE PROCEDURE SP_CalcularCostoEnvio
    @IdPedido INT,
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

        -- Determinar el costo del envio
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
            -- Distancia fuera de cobertura
            RAISERROR('La distancia de km esta fuera de cobertura para el pedido', 16, 1);
            RETURN;
        END

        -- Actualizar el costo total del pedido
        UPDATE Pedidos
        SET costo_total = ISNULL(costo_total, 0) + @CostoEnvio,
            estado = 'Entregado'
        WHERE id_pedido = @IdPedido;

        -- Devolver el costo total actualizado
        SELECT @CostoTotal = costo_total
        FROM Pedidos
        WHERE id_pedido = @IdPedido;
    END TRY
    BEGIN CATCH
        RAISERROR('Ocurrio un error al calcular el precio del envio', 16, 1);
    END CATCH
END