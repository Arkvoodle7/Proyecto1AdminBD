
use SistemaEnviosDB;

---
---
---Modificaciones V2
---
alter table Usuarios add tiempo TIMESTAMP;


-----Select
----
--Transportista
GO
ALTER PROCEDURE [dbo].[SP_ObtenerDatosTransportista]
    @IdUsuario INT
AS
BEGIN
    SELECT Usuarios.nombre, Usuarios.apellido, Usuarios.email, Usuarios.password, Usuarios.fecha_nacimiento,
           Transportistas.tipo_transporte, Transportistas.contacto, Transportistas.tiempo, Usuarios.tiempo as tiempo2
    FROM Usuarios
    INNER JOIN Transportistas ON Usuarios.id_usuario = Transportistas.id_transportista
    WHERE Usuarios.id_usuario = @IdUsuario;
END

---Producto
GO
ALTER PROCEDURE [dbo].[SP_ObtenerDatosProducto]
    @IdProducto INT
AS
BEGIN
    SELECT id_producto, id_proveedor, nombre, categoria, precio, tiempo_entrega, StockDisponible, tiempo
    FROM Productos
    WHERE id_producto = @IdProducto;
END

---Oferente
GO
ALTER PROCEDURE [dbo].[SP_ObtenerDatosOferente]
    @IdUsuario INT
AS
BEGIN
    SELECT Usuarios.nombre, Usuarios.apellido, Usuarios.email, Usuarios.password, Usuarios.fecha_nacimiento,
           Proveedores.nombre_empresa, Proveedores.direccion, Proveedores.contacto, Proveedores.horario, Proveedores.ubicacion_geografica, Proveedores.tiempo, Usuarios.tiempo as tiempo2
    FROM Usuarios
    INNER JOIN Proveedores ON Usuarios.id_usuario = Proveedores.id_proveedor
    WHERE Usuarios.id_usuario = @IdUsuario;
END

--Cliente
GO
ALTER PROCEDURE [dbo].[SP_ObtenerDatosCliente]
    @IdUsuario INT
AS
BEGIN
    SELECT Usuarios.nombre, Usuarios.apellido, Usuarios.email, Usuarios.password, Usuarios.fecha_nacimiento,
           Clientes.direccion, Clientes.telefono, Clientes.ubicacion_geografica, Clientes.tiempo, Usuarios.tiempo as tiempo2
    FROM Usuarios
    INNER JOIN Clientes ON Usuarios.id_usuario = Clientes.id_cliente
    WHERE Usuarios.id_usuario = @IdUsuario;
END








---Modificar
---
--ModificarTransportista
GO
ALTER PROCEDURE [dbo].[SP_ModificarTransportista]
    @IdUsuario INT,
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @Email NVARCHAR(100),
    @Password NVARCHAR(100),
    @FechaNacimiento DATE,
    @TipoTransporte NVARCHAR(50),
    @Contacto NVARCHAR(20),
	@times BINARY(8),
	@times2 BINARY(8)
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY

		IF NOT EXISTS (SELECT 1 FROM Transportistas WHERE id_transportista = @IdUsuario AND tiempo = @times) 
		BEGIN
			RAISERROR('No fue posible actualizar. La informacion habia sido actualizada previamente, vuelva a cargar la pantalla con sus datos.', 16, 1)
		END
		IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE id_usuario = @IdUsuario AND tiempo = @times2) 
		BEGIN
			RAISERROR('No fue posible actualizar. La informacion del usuario habia sido actualizada previamente, vuelva a cargar la pantalla con sus datos.', 16, 1)
		END

		-- Modificar datos en la tabla Usuarios
		UPDATE Usuarios
		SET nombre = @Nombre,
			apellido = @Apellido,
			email = @Email,
			password = @Password,
			fecha_nacimiento = @FechaNacimiento
		WHERE id_usuario = @IdUsuario;

		-- Modificar datos en la tabla Transportistas
		UPDATE Transportistas
		SET tipo_transporte = @TipoTransporte,
			contacto = @Contacto
		WHERE id_transportista = @IdUsuario;

		COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END



--ModificarProductos
GO
ALTER PROCEDURE [dbo].[SP_ModificarProducto]
    @IdProducto INT,
    @IdProveedor INT,
    @Nombre NVARCHAR(100),
    @Categoria NVARCHAR(50),
    @Precio DECIMAL(18, 2),
    @TiempoEntrega INT,
    @StockDisponible INT,
	@times BINARY(8)
AS
BEGIN

	IF NOT EXISTS (SELECT 1 FROM Productos WHERE id_producto = @IdProducto AND tiempo = @times) 
	BEGIN
		RAISERROR('No fue posible actualizar. La informacion habia sido actualizada previamente, vuelva a cargar la pantalla con sus datos.', 16, 1)
	END

	UPDATE Productos
	SET id_proveedor = @IdProveedor,
		nombre = @Nombre,
		categoria = @Categoria,
		precio = @Precio,
		tiempo_entrega = @TiempoEntrega,
		StockDisponible = @StockDisponible
	WHERE id_producto = @IdProducto;

END

---Modificar oferente
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_ModificarOferente]
    @IdUsuario INT,
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @Email NVARCHAR(100),
    @Password NVARCHAR(100),
    @FechaNacimiento DATE,
    @NombreEmpresa NVARCHAR(100),
    @Direccion NVARCHAR(200),
    @Contacto NVARCHAR(20),
    @Horario NVARCHAR(50),
    @Ubicacion GEOGRAPHY,
	@times BINARY(8),
	@times2 BINARY(8)
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY

		IF NOT EXISTS (SELECT 1 FROM Productos WHERE id_proveedor = @IdUsuario AND tiempo = @times) 
		BEGIN
			RAISERROR('No fue posible actualizar. La informacion habia sido actualizada previamente, vuelva a cargar la pantalla con sus datos.', 16, 1)
		END

		IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE id_usuario = @IdUsuario AND tiempo = @times2) 
		BEGIN
			RAISERROR('No fue posible actualizar. La informacion del usuario habia sido actualizada previamente, vuelva a cargar la pantalla con sus datos.', 16, 1)
		END

        -- Actualizar datos en la tabla Usuarios
        UPDATE Usuarios
        SET nombre = @Nombre,
            apellido = @Apellido,
            email = @Email,
            password = @Password,
            fecha_nacimiento = @FechaNacimiento
        WHERE id_usuario = @IdUsuario;

        -- Actualizar datos en la tabla Proveedores
        UPDATE Proveedores
        SET nombre_empresa = @NombreEmpresa,
            direccion = @Direccion,
            contacto = @Contacto,
            horario = @Horario,
            ubicacion_geografica = @Ubicacion
        WHERE id_proveedor = @IdUsuario;

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END


--Modificar cliente
GO
ALTER PROCEDURE [dbo].[SP_ModificarCliente]
    @IdUsuario INT,
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @Email NVARCHAR(100),
    @Password NVARCHAR(100),
    @Direccion NVARCHAR(200),
    @Telefono NVARCHAR(20),
    @FechaNacimiento DATE,
    @Ubicacion geography,
	@times BINARY(8),
	@times2 BINARY(8)
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY

		IF NOT EXISTS (SELECT 1 FROM Clientes WHERE id_cliente = @IdUsuario AND tiempo = @times) 
		BEGIN
			RAISERROR('No fue posible actualizar. La informacion habia sido actualizada previamente, vuelva a cargar la pantalla con sus datos.', 16, 1)
		END
		
		IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE id_usuario = @IdUsuario AND tiempo = @times2) 
		BEGIN
			RAISERROR('No fue posible actualizar. La informacion del usuario habia sido actualizada previamente, vuelva a cargar la pantalla con sus datos.', 16, 1)
		END
        -- Modificar datos en la tabla Usuarios
        UPDATE Usuarios
        SET nombre = @Nombre,
            apellido = @Apellido,
            email = @Email,
            password = @Password,
			fecha_nacimiento = @FechaNacimiento
        WHERE id_usuario = @IdUsuario;

        -- Modificar datos en la tabla Clientes
        UPDATE Clientes
        SET direccion = @Direccion,
            telefono = @Telefono,
            ubicacion_geografica = @Ubicacion
        WHERE id_cliente = @IdUsuario;

        COMMIT TRANSACTION;



    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
