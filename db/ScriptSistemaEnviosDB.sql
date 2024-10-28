USE [master]
GO
/****** Object:  Database [SistemaEnviosDB]    Script Date: 28/10/2024 04:53:55 p. m. ******/
CREATE DATABASE [SistemaEnviosDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SistemaEnviosDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SistemaEnviosDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SistemaEnviosDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SistemaEnviosDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [SistemaEnviosDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SistemaEnviosDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SistemaEnviosDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SistemaEnviosDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SistemaEnviosDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SistemaEnviosDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SistemaEnviosDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [SistemaEnviosDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SistemaEnviosDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SistemaEnviosDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SistemaEnviosDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SistemaEnviosDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SistemaEnviosDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SistemaEnviosDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SistemaEnviosDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SistemaEnviosDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SistemaEnviosDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SistemaEnviosDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SistemaEnviosDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SistemaEnviosDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SistemaEnviosDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SistemaEnviosDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SistemaEnviosDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SistemaEnviosDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SistemaEnviosDB] SET RECOVERY FULL 
GO
ALTER DATABASE [SistemaEnviosDB] SET  MULTI_USER 
GO
ALTER DATABASE [SistemaEnviosDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SistemaEnviosDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SistemaEnviosDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SistemaEnviosDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SistemaEnviosDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SistemaEnviosDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SistemaEnviosDB', N'ON'
GO
ALTER DATABASE [SistemaEnviosDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [SistemaEnviosDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SistemaEnviosDB]
GO
/****** Object:  UserDefinedTableType [dbo].[CartItemType]    Script Date: 28/10/2024 04:53:55 p. m. ******/
CREATE TYPE [dbo].[CartItemType] AS TABLE(
	[id_producto] [int] NULL,
	[cantidad] [int] NULL
)
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[id_cliente] [int] NOT NULL,
	[direccion] [varchar](255) NULL,
	[telefono] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contactos]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contactos](
	[Nombre] [varchar](100) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Mensaje] [varchar](250) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pedidos]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedidos](
	[id_pedido] [int] IDENTITY(1,1) NOT NULL,
	[id_cliente] [int] NULL,
	[id_producto] [int] NULL,
	[id_transportista] [int] NULL,
	[fecha_pedido] [date] NULL,
	[estado] [varchar](20) NOT NULL,
	[costo_total] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[id_producto] [int] IDENTITY(1,1) NOT NULL,
	[id_proveedor] [int] NULL,
	[nombre] [varchar](100) NULL,
	[categoria] [varchar](20) NOT NULL,
	[precio] [decimal](10, 2) NULL,
	[tiempo_entrega] [int] NOT NULL,
	[StockDisponible] [int] NULL,
 CONSTRAINT [PK__Producto__FF341C0D78E61B36] PRIMARY KEY CLUSTERED 
(
	[id_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proveedores]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedores](
	[id_proveedor] [int] NOT NULL,
	[nombre_empresa] [varchar](100) NULL,
	[direccion] [varchar](255) NULL,
	[contacto] [varchar](50) NULL,
	[horario] [varchar](50) NOT NULL,
	[ubicacion] [varchar](50) NOT NULL,
 CONSTRAINT [PK__Proveedo__8D3DFE285C03191F] PRIMARY KEY CLUSTERED 
(
	[id_proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transportistas]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transportistas](
	[id_transportista] [int] NOT NULL,
	[tipo_transporte] [varchar](50) NULL,
	[contacto] [varchar](50) NULL,
 CONSTRAINT [PK_Transportistas] PRIMARY KEY CLUSTERED 
(
	[id_transportista] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[id_usuario] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NULL,
	[apellido] [varchar](50) NULL,
	[email] [varchar](100) NULL,
	[password] [varchar](255) NULL,
	[rol] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Proveedores]  WITH CHECK ADD  CONSTRAINT [FK__Proveedor__id_pr__4F7CD00D] FOREIGN KEY([id_proveedor])
REFERENCES [dbo].[Usuarios] ([id_usuario])
GO
ALTER TABLE [dbo].[Proveedores] CHECK CONSTRAINT [FK__Proveedor__id_pr__4F7CD00D]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD CHECK  (([estado]='entregado' OR [estado]='en camino' OR [estado]='pendiente'))
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [CK__Productos__categ__52593CB8] CHECK  (([categoria]='zapatos' OR [categoria]='comida' OR [categoria]='ropa'))
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [CK__Productos__categ__52593CB8]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD CHECK  (([rol]='proveedor' OR [rol]='transportista' OR [rol]='cliente'))
GO
/****** Object:  StoredProcedure [dbo].[sp_ActualizarEstadoYAsignarTransportista]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ActualizarEstadoYAsignarTransportista]
    @id_pedido INT,
    @id_transportista INT,
    @nuevoEstado VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    -- Actualizar el estado del pedido y asignar el transportista
    UPDATE Pedidos
    SET id_transportista = @id_transportista,
        estado = @nuevoEstado
    WHERE id_pedido = @id_pedido;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AgregarCliente]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AgregarCliente]
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Email VARCHAR(100),
    @Password VARCHAR(255),
    @Direccion VARCHAR(255),
    @Telefono VARCHAR(20)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            --insertar en la tabla Usuarios
            INSERT INTO Usuarios (nombre, apellido, email, password, rol)
            VALUES (@Nombre, @Apellido, @Email, @Password, 'cliente');
            
            --obtener el id del usuario insertado
            DECLARE @IdUsuario INT = SCOPE_IDENTITY();

            --insertar en la tabla Clientes
            INSERT INTO Clientes (id_cliente, direccion, telefono)
            VALUES (@IdUsuario, @Direccion, @Telefono);

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AgregarProveedor]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AgregarProveedor]
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Email VARCHAR(100),
    @Password VARCHAR(255),
    @NombreEmpresa VARCHAR(100),
    @Direccion VARCHAR(255),
    @Contacto VARCHAR(50),
	@Horario VARCHAR(50),
	@UBICACION VARCHAR(50)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            --insertar en la tabla Usuarios
            INSERT INTO Usuarios (nombre, apellido, email, password, rol)
            VALUES (@Nombre, @Apellido, @Email, @Password, 'proveedor');
            
            --obtener el id del usuario insertado
            DECLARE @IdUsuario INT = SCOPE_IDENTITY();

            --insertar en la tabla Proveedores
            INSERT INTO Proveedores (id_proveedor, nombre_empresa, direccion, contacto, horario, ubicacion)
            VALUES (@IdUsuario, @NombreEmpresa, @Direccion, @Contacto, @Horario, @Ubicacion);

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AgregarTransportista]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_AgregarTransportista]
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Email VARCHAR(100),
    @Password VARCHAR(255),
    @TipoTransporte VARCHAR(50),
    @Contacto VARCHAR(50)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            --insertar en la tabla Usuarios
            INSERT INTO Usuarios (nombre, apellido, email, password, rol)
            VALUES (@Nombre, @Apellido, @Email, @Password, 'transportista');
            
            --obtener el id del usuario insertado
            DECLARE @IdUsuario INT = SCOPE_IDENTITY();

            --insertar en la tabla Transportistas
            INSERT INTO Transportistas (id_transportista, tipo_transporte, contacto)
            VALUES (@IdUsuario, @TipoTransporte, @Contacto);

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CalcularTotalesCarrito]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CalcularTotalesCarrito]
    @CartItems CartItemType READONLY
AS
BEGIN
    SELECT 
        p.id_producto,
        p.nombre,
        p.precio,
        ci.cantidad,
        Subtotal = p.precio * ci.cantidad,
        Impuestos = p.precio * ci.cantidad * 0.13,
        Total = p.precio * ci.cantidad * 1.13
    FROM 
        @CartItems ci
        INNER JOIN Productos p ON ci.id_producto = p.id_producto;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CrearOrdenDeCompra]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CrearOrdenDeCompra]
    @id_cliente INT,
    @id_producto INT,
    @cantidad INT,
    @id_transportista INT,
    @fecha_pedido DATE,
    @estado VARCHAR(20),
    @costo_total DECIMAL(10, 2)
AS
BEGIN
    -- Lógica para obtener el costo total y registrar la orden en la tabla Pedidos
    DECLARE @precio DECIMAL(10, 2);

    -- Obtener el precio del producto
    SELECT @precio = precio FROM Productos WHERE id_producto = @id_producto;

    -- Calcular el costo total
    SET @costo_total = @precio * @cantidad;

    -- Insertar en la tabla Pedidos
    INSERT INTO Pedidos (id_cliente, id_producto, id_transportista, fecha_pedido, estado, costo_total)
    VALUES (@id_cliente, @id_producto, @id_transportista, @fecha_pedido, @estado, @costo_total);

    -- Actualizar el stock del producto
    UPDATE Productos
    SET StockDisponible = StockDisponible - @cantidad
    WHERE id_producto = @id_producto;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteCliente]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_DeleteCliente]
    @id_cliente INT
AS
BEGIN
    DELETE FROM Clientes
    WHERE id_cliente = @id_cliente;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteProducto]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteProducto] (@IdProducto INT)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Productos WHERE id_producto = @IdProducto)
    BEGIN
        RAISERROR ('El producto no esta registrado', 16, 1);
        RETURN;
    END

	DELETE FROM Productos WHERE id_producto = @IdProducto
END;

-------------------------------------------------------------
--------------Select Productos-------------------------------------

GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteTransportista]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeleteTransportista]
    @id_transportista INT
AS
BEGIN
    DELETE FROM Transportistas
    WHERE id_transportista = @id_transportista;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCategorias]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetCategorias]
AS
BEGIN
    SELECT DISTINCT categoria
    FROM Productos;  -- O Servicios, dependiendo del nombre de tu tabla
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetProductoPorId]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetProductoPorId]
    @id_producto INT
AS
BEGIN
    SELECT id_producto, nombre, precio, tiempo_entrega
    FROM Productos
    WHERE id_producto = @id_producto;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetProductosPorCategoria]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetProductosPorCategoria]
    @categoria VARCHAR(20)
AS
BEGIN
    SELECT id_producto, nombre, precio, tiempo_entrega
    FROM Productos  -- O Servicios, dependiendo del nombre de tu tabla
    WHERE categoria = @categoria;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_IniciarSesion]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_IniciarSesion]
    @Email VARCHAR(100),
    @Password VARCHAR(255)
AS
BEGIN
    DECLARE @id_usuario INT;
    DECLARE @rol VARCHAR(20);

    --buscar al usuario en la tabla Usuarios
    SELECT @id_usuario = id_usuario, @rol = rol
    FROM Usuarios
    WHERE email = @Email AND password = @Password;

    --verificar si el usuario existe
    IF @id_usuario IS NOT NULL
    BEGIN
        --retornar el rol del usuario
        SELECT @rol AS Rol, @id_usuario AS IdUsuario;
    END
    ELSE
    BEGIN
        RAISERROR ('Credenciales incorrectas', 16, 1);
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertarContacto]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_InsertarContacto]
    @Nombre VARCHAR(100),
    @Email VARCHAR(100),
    @Mensaje VARCHAR(250)
AS
BEGIN
    INSERT INTO Contactos (Nombre, Email, Mensaje)
    VALUES (@Nombre, @Email, @Mensaje)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertProducto]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_InsertProducto] (@IdProvedor INT, @Nombre VARCHAR(100), @Categoria VARCHAR(20), @Precio DECIMAL(10, 2), @Tiempo_Entrega INT)
AS
BEGIN
		INSERT INTO Productos(id_proveedor, nombre, categoria, precio, tiempo_entrega)
		VALUES (@IdProvedor,@Nombre, @Categoria, @Precio, @Tiempo_Entrega);
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_InsertTransportista]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertTransportista]
    @id_transportista INT,
    @tipo_transporte NVARCHAR(50),
    @contacto NVARCHAR(50)
AS
BEGIN
    INSERT INTO Transportistas (id_transportista, tipo_transporte, contacto)
    VALUES (@id_transportista, @tipo_transporte, @contacto);
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerClientePorID]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ObtenerClientePorID]
    @id_cliente INT
AS
BEGIN
    SELECT id_cliente, telefono, direccion
    FROM Clientes
    WHERE id_cliente = @id_cliente;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerHistorialComprasPorCliente]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ObtenerHistorialComprasPorCliente]
    @IdCliente INT
AS
BEGIN
    SELECT id_historial, id_pedido, fecha_entrega, observaciones
    FROM Historial_Cliente
    WHERE id_cliente = @IdCliente;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerPedidosConDetalles]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ObtenerPedidosConDetalles]
    @IdCliente INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.id_pedido AS IdPedido,
        p.fecha_pedido AS FechaPedido,
        p.estado AS Estado,
        p.costo_total AS CostoTotal,
        t.tipo_transporte AS Transportista,
        t.contacto AS ContactoTransportista,
        prod.tiempo_entrega AS TiempoEntrega -- Se agrega el tiempo de entrega del producto
    FROM 
        pedidos p
    INNER JOIN 
        transportistas t ON p.id_transportista = t.id_transportista
    INNER JOIN 
        productos prod ON p.id_producto = prod.id_producto
    WHERE 
        p.id_cliente = @IdCliente
        AND (p.estado = 'pendiente' OR p.estado = 'en camino') -- Filtra solo pedidos pendientes o en camino
    ORDER BY 
        p.fecha_pedido DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerPedidosEntregadosPorCliente]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ObtenerPedidosEntregadosPorCliente]
    @IdCliente INT
AS
BEGIN
    SELECT id_pedido, fecha_pedido, estado, costo_total
    FROM Pedidos
    WHERE id_cliente = @IdCliente
      AND estado = 'Entregado';
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerTodosLosPedidos]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ObtenerTodosLosPedidos]
AS
BEGIN
    SELECT id_pedido, id_cliente, id_producto, id_transportista, fecha_pedido, estado, costo_total
    FROM Pedidos where estado = 'pendiente';
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerTransPorID]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ObtenerTransPorID]
    @id_transportista INT
AS
BEGIN
    SELECT 
        id_transportista, 
        tipo_transporte, 
        contacto
    FROM 
        Transportistas
    WHERE 
        id_transportista = @id_transportista
END

GO
/****** Object:  StoredProcedure [dbo].[SP_SelectProductoCategoria]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SelectProductoCategoria] (@Categoria VARCHAR(20))
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Productos WHERE categoria = @Categoria)
    BEGIN
        RAISERROR ('La categoria no tiene registros', 16, 1);
        RETURN;
    END
	SELECT * FROM Productos WHERE categoria = @Categoria;
END;

GO
/****** Object:  StoredProcedure [dbo].[SP_SelectProductoProvedor]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SelectProductoProvedor] (@Provedor int)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Productos WHERE id_proveedor = @Provedor)
    BEGIN
        RAISERROR ('El provedor no tiene registros', 16, 1);
        RETURN;
    END
	SELECT * FROM Productos WHERE id_proveedor = @Provedor;
END;

-------------------------------------------------------------
--------------Historial-------------------------------------

GO
/****** Object:  StoredProcedure [dbo].[SP_SelectProductoProvedores]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SelectProductoProvedores] (@Provedor int)
AS
BEGIN
	SELECT * FROM Productos WHERE id_proveedor = @Provedor;

	IF NOT EXISTS(SELECT 1 FROM Productos WHERE id_proveedor = @Provedor)
	BEGIN
        SELECT 
            0 AS id_producto, @Provedor AS id_proveedor, 'No definido' AS nombre, 'No definida' AS categoria, 0 AS precio, 'N/A' AS tiempo_entrega;
	END;
END;

-------------------------------------------------------------
--------------Select provedores-------------------------------------

GO
/****** Object:  StoredProcedure [dbo].[SP_SelectProvedo]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_SelectProvedo](@id int)
AS
BEGIN
    SELECT * FROM Proveedores WHERE id_proveedor = @id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateCliente]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateCliente]
    @id_cliente INT,
    @telefono NVARCHAR(50),
    @direccion NVARCHAR(255)
AS
BEGIN
    UPDATE Clientes
    SET telefono = @telefono,
        direccion = @direccion
    WHERE id_cliente = @id_cliente;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateProveedor]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdateProveedor] @IdProveedor INT,@NombreEmpresa VARCHAR(100),
									 @Direccion VARCHAR(255),@Contacto VARCHAR(50),
									  @Horario VARCHAR(50),@Ubicacion VARCHAR(50)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Proveedores WHERE id_proveedor = @IdProveedor)
    BEGIN
        RAISERROR('El proveedor con ese id no existe', 16, 1, @IdProveedor);
        RETURN;
    END

    UPDATE Proveedores SET
        nombre_empresa = @NombreEmpresa, direccion = @Direccion, contacto = @Contacto,
        horario = @Horario, ubicacion = @Ubicacion
    WHERE
        id_proveedor = @IdProveedor;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateTransportista]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateTransportista]
    @id_transportista INT,
    @tipo_transporte NVARCHAR(50)
AS
BEGIN
    UPDATE Transportistas
    SET tipo_transporte = @tipo_transporte
    WHERE id_transportista = @id_transportista;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_UptadeProducto]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UptadeProducto] (@IdProducto INT ,@IdProvedor INT, @Nombre VARCHAR(100), @Categoria VARCHAR(20), @Precio DECIMAL(10, 2), @Tiempo_Entrega INT)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Productos WHERE id_producto = @IdProducto)
    BEGIN
        RAISERROR ('El producto no esta registrado', 16, 1);
        RETURN;
    END

    UPDATE Productos
    SET id_proveedor = @IdProvedor,nombre = @Nombre,categoria = @Categoria,
		precio = @Precio,tiempo_Entrega = @Tiempo_Entrega
			WHERE id_producto = @IdProducto;
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_VerificarStock]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_VerificarStock]
    @id_producto INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT StockDisponible
    FROM Productos
    WHERE id_Producto = @id_producto;
END;
GO
/****** Object:  Trigger [dbo].[trg_Transportista_Unico]    Script Date: 28/10/2024 04:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_Transportista_Unico]
ON [dbo].[Pedidos]
AFTER UPDATE
AS
BEGIN
    DECLARE @id_transportista INT;
    
    SELECT @id_transportista = id_transportista FROM inserted;

    IF EXISTS (
        SELECT 1
        FROM Pedidos
        WHERE id_transportista = @id_transportista
        AND estado IN ('pendiente', 'en camino')
        AND id_pedido <> (SELECT id_pedido FROM inserted)
    )
    BEGIN
        -- Lanza un error que puede ser capturado por la aplicación
        THROW 50000, 'El transportista ya tiene un envío activo.', 1;
    END
END;
GO
ALTER TABLE [dbo].[Pedidos] ENABLE TRIGGER [trg_Transportista_Unico]
GO
/****** Object:  Trigger [dbo].[trg_InsertProvedor]    Script Date: 28/10/2024 04:53:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_InsertProvedor]
ON [dbo].[Proveedores]
AFTER INSERT
AS
BEGIN
	INSERT INTO Productos(id_proveedor, nombre, categoria, precio, tiempo_entrega)
		VALUES ((select id_proveedor from inserted),'No especificado', 'Ropa', 0, 0);
END;
GO
ALTER TABLE [dbo].[Proveedores] ENABLE TRIGGER [trg_InsertProvedor]
GO
USE [master]
GO
ALTER DATABASE [SistemaEnviosDB] SET  READ_WRITE 
GO
