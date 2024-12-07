USE SistemaEnviosDB;

--Tablas
--Tabla productos
ALTER TABLE Productos
ADD tiempo TIMESTAMP;
--Tabla cliente
ALTER TABLE Clientes
ADD tiempo TIMESTAMP;
--Tabla tranportista
ALTER TABLE Transportistas
ADD tiempo TIMESTAMP;
--Tabla vendedor
ALTER TABLE Proveedores
ADD tiempo TIMESTAMP;



---Metodos de select de dtos
--Select de prductos 
--Listo

--Select de provedor (select provedo)
--Listo

--Select de cliente
--Actualizado
GO
ALTER PROCEDURE [dbo].[sp_ObtenerClientePorID]
    @id_cliente INT
AS
BEGIN
    SELECT id_cliente, telefono, direccion, tiempo
    FROM Clientes
    WHERE id_cliente = @id_cliente;
END;

--Transportista
--Modificado
GO
ALTER PROCEDURE [dbo].[sp_ObtenerTransPorID]
    @id_transportista INT
AS
BEGIN
    SELECT 
        id_transportista, 
        tipo_transporte, 
        contacto,
		tiempo
    FROM 
        Transportistas
    WHERE 
        id_transportista = @id_transportista
END







----Metodos de actualizacion

--1 /Stock
---No aplicado


--2 / Productos actalizar(mal nombrado) listo
GO
ALTER PROCEDURE [dbo].[SP_UptadeProducto] (@IdProducto INT ,@IdProvedor INT, @Nombre VARCHAR(100), @Categoria VARCHAR(20), @Precio DECIMAL(10, 2), @Tiempo_Entrega INT,@times BINARY(8) )
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Productos WHERE id_producto = @IdProducto)
    BEGIN
        RAISERROR ('El producto no esta registrado', 16, 1);
        RETURN;
    END;

	IF NOT EXISTS (SELECT 1 FROM Productos WHERE id_producto = @IdProducto AND tiempo = @times) BEGIN
		RAISERROR('No fue posible actualizar. La informacion habia sido actualizada previamente, vuelva a cargar la pantalla con sus datos.', 16, 1)
	END

    UPDATE Productos
     	SET id_proveedor = @IdProvedor,nombre = @Nombre,categoria = @Categoria,
			precio = @Precio,tiempo_Entrega = @Tiempo_Entrega
				WHERE id_producto = @IdProducto;

END;


--3 Cliente  --Listo
GO
ALTER PROCEDURE [dbo].[sp_UpdateCliente]
    @id_cliente INT,
    @telefono NVARCHAR(50),
    @direccion NVARCHAR(255),
    @times BINARY(8) 
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Clientes WHERE id_cliente = @id_cliente AND tiempo = @times)
    BEGIN
        RAISERROR('No fue posible actualizar. La informacion habia sido actualizada previamente, vuelva a cargar la pantalla con sus datos.', 16, 1);
        RETURN;
    END

    UPDATE Clientes
    SET telefono = @telefono,
    	direccion = @direccion
    WHERE id_cliente = @id_cliente;

END;


--4 Producto 2
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_UpdateProducto] 
    @IdProducto INT,
    @IdProveedor INT, 
    @Nombre VARCHAR(100), 
    @Categoria VARCHAR(20), 
    @Precio DECIMAL(10, 2), 
    @Tiempo_Entrega INT, 
    @Stock DECIMAL(10, 2),
    @times BINARY(8)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Productos WHERE id_producto = @IdProducto AND tiempo = @times)
    BEGIN
        RAISERROR('No fue posible actualizar. La informacion habia sido actualizada previamente, vuelva a cargar la pantalla con sus datos.', 16, 1);
        RETURN;
    END


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



--5 Provedir  --Listo
GO
ALTER PROCEDURE [dbo].[SP_UpdateProveedor] @IdProveedor INT,@NombreEmpresa VARCHAR(100),
									 @Direccion VARCHAR(255),@Contacto VARCHAR(50),
									  @Horario VARCHAR(50), @times BINARY(8)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Proveedores WHERE id_proveedor = @IdProveedor)
    BEGIN
        RAISERROR('El proveedor con ese id no existe', 16, 1, @IdProveedor);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Proveedores WHERE id_proveedor = @IdProveedor AND tiempo = @times)
    BEGIN
        RAISERROR('No fue posible actualizar. La informacion habia sido actualizada previamente, vuelva a cargar la pantalla con sus datos.', 16, 1);
        RETURN;
    END

    UPDATE Proveedores SET
    	nombre_empresa = @NombreEmpresa, direccion = @Direccion, contacto = @Contacto,
    	horario = @Horario
   	WHERE
     	id_proveedor = @IdProveedor;

END;


--6 Transportista  --Listo

GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_UpdateTransportista]
    @id_transportista INT,
    @tipo_transporte NVARCHAR(50),
    @contacto NVARCHAR(50), -- Agregar contacto
    @times BINARY(8)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Transportistas WHERE id_transportista = @id_transportista AND tiempo = @times)
    BEGIN
        RAISERROR('No fue posible actualizar. La informacion habia sido actualizada previamente, vuelva a cargar la pantalla con sus datos.', 16, 1);
        RETURN;
    END


    UPDATE Transportistas
    SET tipo_transporte = @tipo_transporte,
        contacto = @contacto -- Actualizar contacto
    WHERE id_transportista = @id_transportista;

END;

