USE [master]
GO
/****** Object:  Database [SistemaEnviosDB]    Script Date: 6/11/2024 04:27:34 p. m. ******/
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
/****** Object:  UserDefinedTableType [dbo].[CartItemType]    Script Date: 6/11/2024 04:27:36 p. m. ******/
CREATE TYPE [dbo].[CartItemType] AS TABLE(
	[id_producto] [int] NULL,
	[cantidad] [int] NULL
)
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 6/11/2024 04:27:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[id_cliente] [int] NOT NULL,
	[direccion] [varchar](255) NULL,
	[ubicacion_geografica] [geography] NULL,
	[telefono] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contactos]    Script Date: 6/11/2024 04:27:36 p. m. ******/
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
/****** Object:  Table [dbo].[DetallePedido]    Script Date: 6/11/2024 04:27:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetallePedido](
	[id_detalle_pedido] [int] IDENTITY(1,1) NOT NULL,
	[id_pedido] [int] NOT NULL,
	[id_producto] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[precio_unitario] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_detalle_pedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pedidos]    Script Date: 6/11/2024 04:27:36 p. m. ******/
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
	[cantidad] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 6/11/2024 04:27:36 p. m. ******/
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
/****** Object:  Table [dbo].[Proveedores]    Script Date: 6/11/2024 04:27:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedores](
	[id_proveedor] [int] NOT NULL,
	[nombre_empresa] [varchar](100) NULL,
	[direccion] [varchar](255) NULL,
	[contacto] [varchar](50) NULL,
	[horario] [varchar](50) NULL,
	[ubicacion_geografica] [geography] NULL,
 CONSTRAINT [PK__Proveedo__8D3DFE285C03191F] PRIMARY KEY CLUSTERED 
(
	[id_proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transportistas]    Script Date: 6/11/2024 04:27:36 p. m. ******/
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
/****** Object:  Table [dbo].[Usuarios]    Script Date: 6/11/2024 04:27:36 p. m. ******/
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
	[fecha_nacimiento] [date] NULL,
 CONSTRAINT [PK__Usuarios__4E3E04ADDFE7EA52] PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Clientes] ([id_cliente], [direccion], [ubicacion_geografica], [telefono]) VALUES (1, N'San José Centro, Av. Central', 0xE6100000010CE4DC26DC2BDB23404B7842AF3F0555C0, N'22222222')
INSERT [dbo].[Clientes] ([id_cliente], [direccion], [ubicacion_geografica], [telefono]) VALUES (2, N'Alajuela Centro, Calle Ancha', 0xE6100000010C08E929728808244092B1DAFCBF0D55C0, N'24332233')
GO
SET IDENTITY_INSERT [dbo].[DetallePedido] ON 

INSERT [dbo].[DetallePedido] ([id_detalle_pedido], [id_pedido], [id_producto], [cantidad], [precio_unitario]) VALUES (1, 1, 1, 1, CAST(49.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([id_detalle_pedido], [id_pedido], [id_producto], [cantidad], [precio_unitario]) VALUES (2, 2, 6, 1, CAST(24.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([id_detalle_pedido], [id_pedido], [id_producto], [cantidad], [precio_unitario]) VALUES (3, 3, 6, 1, CAST(24.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([id_detalle_pedido], [id_pedido], [id_producto], [cantidad], [precio_unitario]) VALUES (4, 4, 6, 1, CAST(24.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([id_detalle_pedido], [id_pedido], [id_producto], [cantidad], [precio_unitario]) VALUES (5, 5, 3, 1, CAST(79.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([id_detalle_pedido], [id_pedido], [id_producto], [cantidad], [precio_unitario]) VALUES (6, 6, 6, 1, CAST(24.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([id_detalle_pedido], [id_pedido], [id_producto], [cantidad], [precio_unitario]) VALUES (7, 6, 5, 1, CAST(8.99 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[DetallePedido] OFF
GO
SET IDENTITY_INSERT [dbo].[Pedidos] ON 

INSERT [dbo].[Pedidos] ([id_pedido], [id_cliente], [id_producto], [id_transportista], [fecha_pedido], [estado], [costo_total], [cantidad]) VALUES (1, 2, 1, 4, CAST(N'2024-11-06' AS Date), N'en camino', CAST(49.99 AS Decimal(10, 2)), 1)
INSERT [dbo].[Pedidos] ([id_pedido], [id_cliente], [id_producto], [id_transportista], [fecha_pedido], [estado], [costo_total], [cantidad]) VALUES (2, 2, 6, NULL, CAST(N'2024-11-06' AS Date), N'Entregado', CAST(800.00 AS Decimal(10, 2)), 1)
INSERT [dbo].[Pedidos] ([id_pedido], [id_cliente], [id_producto], [id_transportista], [fecha_pedido], [estado], [costo_total], [cantidad]) VALUES (3, 2, 6, NULL, CAST(N'2024-11-06' AS Date), N'Entregado', CAST(800.00 AS Decimal(10, 2)), 1)
INSERT [dbo].[Pedidos] ([id_pedido], [id_cliente], [id_producto], [id_transportista], [fecha_pedido], [estado], [costo_total], [cantidad]) VALUES (4, 2, 6, NULL, CAST(N'2024-11-06' AS Date), N'Entregado', CAST(800.00 AS Decimal(10, 2)), 1)
INSERT [dbo].[Pedidos] ([id_pedido], [id_cliente], [id_producto], [id_transportista], [fecha_pedido], [estado], [costo_total], [cantidad]) VALUES (5, 2, 3, 3, CAST(N'2024-11-06' AS Date), N'en camino', CAST(79.99 AS Decimal(10, 2)), 1)
INSERT [dbo].[Pedidos] ([id_pedido], [id_cliente], [id_producto], [id_transportista], [fecha_pedido], [estado], [costo_total], [cantidad]) VALUES (6, 2, 6, NULL, CAST(N'2024-11-06' AS Date), N'Pendiente', CAST(33.98 AS Decimal(10, 2)), 1)
SET IDENTITY_INSERT [dbo].[Pedidos] OFF
GO
SET IDENTITY_INSERT [dbo].[Productos] ON 

INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (1, 5, N'Zapatos de Cuero', N'zapatos', CAST(49.99 AS Decimal(10, 2)), 5, 99)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (2, 5, N'Camisa Casual', N'ropa', CAST(19.99 AS Decimal(10, 2)), 3, 50)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (3, 5, N'Chaqueta de Cuero', N'ropa', CAST(79.99 AS Decimal(10, 2)), 6, 29)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (4, 5, N'Botas de Montaña', N'zapatos', CAST(89.99 AS Decimal(10, 2)), 7, 70)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (5, 5, N'Pizza Personal', N'comida', CAST(8.99 AS Decimal(10, 2)), 0, 39)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (6, 6, N'Sandalias Verano', N'zapatos', CAST(24.99 AS Decimal(10, 2)), 3, 56)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (7, 6, N'Pantalón Deportivo', N'ropa', CAST(29.99 AS Decimal(10, 2)), 2, 120)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (8, 6, N'Hamburguesa Gourmet', N'comida', CAST(11.99 AS Decimal(10, 2)), 0, 90)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (9, 6, N'Sopa de Vegetales', N'comida', CAST(6.99 AS Decimal(10, 2)), 0, 150)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (10, 6, N'Camiseta Básica', N'ropa', CAST(12.99 AS Decimal(10, 2)), 2, 100)
SET IDENTITY_INSERT [dbo].[Productos] OFF
GO
INSERT [dbo].[Proveedores] ([id_proveedor], [nombre_empresa], [direccion], [contacto], [horario], [ubicacion_geografica]) VALUES (5, N'Empresa XYZ', N'Cartago Centro, Av. 2', N'27778899', N'8:00-17:00', 0xE6100000010CE4DC26DC2BDB23404B7842AF3F0555C0)
INSERT [dbo].[Proveedores] ([id_proveedor], [nombre_empresa], [direccion], [contacto], [horario], [ubicacion_geografica]) VALUES (6, N'Distribuidora SJ', N'San José, Barrio Escalante', N'22557788', N'9:00-18:00', 0xE6100000010C08E929728808244092B1DAFCBF0D55C0)
GO
INSERT [dbo].[Transportistas] ([id_transportista], [tipo_transporte], [contacto]) VALUES (3, N'Camión de Carga', N'25667788')
INSERT [dbo].[Transportistas] ([id_transportista], [tipo_transporte], [contacto]) VALUES (4, N'Motocicleta Express', N'25668899')
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (1, N'Juan', N'Perez', N'juan.perez@example.com', N'password123', N'cliente', CAST(N'1990-05-10' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (2, N'Ana', N'Martinez', N'ana.martinez@example.com', N'password123', N'cliente', CAST(N'1992-03-12' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (3, N'Carlos', N'Lopez', N'carlos.lopez@example.com', N'password123', N'transportista', CAST(N'1980-06-21' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (4, N'Luis', N'Ramirez', N'luis.ramirez@example.com', N'password123', N'transportista', CAST(N'1985-09-30' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (5, N'Maria', N'Gonzalez', N'maria.gonzalez@example.com', N'password123', N'proveedor', CAST(N'1988-02-17' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (6, N'Jorge', N'Rodriguez', N'jorge.rodriguez@example.com', N'password123', N'proveedor', CAST(N'1983-04-25' AS Date))
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_EmailRol]    Script Date: 6/11/2024 04:27:37 p. m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_EmailRol] ON [dbo].[Usuarios]
(
	[email] ASC,
	[rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Pedidos] ADD  DEFAULT ((1)) FOR [cantidad]
GO
ALTER TABLE [dbo].[DetallePedido]  WITH CHECK ADD FOREIGN KEY([id_pedido])
REFERENCES [dbo].[Pedidos] ([id_pedido])
GO
ALTER TABLE [dbo].[DetallePedido]  WITH CHECK ADD FOREIGN KEY([id_producto])
REFERENCES [dbo].[Productos] ([id_producto])
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD CHECK  (([estado]='entregado' OR [estado]='en camino' OR [estado]='pendiente'))
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [CK__Productos__categ__52593CB8] CHECK  (([categoria]='zapatos' OR [categoria]='comida' OR [categoria]='ropa'))
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [CK__Productos__categ__52593CB8]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [CK__Usuarios__rol__5CD6CB2B] CHECK  (([rol]='proveedor' OR [rol]='transportista' OR [rol]='cliente'))
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [CK__Usuarios__rol__5CD6CB2B]
GO
/****** Object:  StoredProcedure [dbo].[ObtenerPedidosPorProveedor]    Script Date: 6/11/2024 04:27:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerPedidosPorProveedor]
    @id_proveedor INT
AS
BEGIN
    SELECT * FROM dbo.Pedidos p
    INNER JOIN dbo.Productos pr ON p.id_producto = pr.id_producto
    WHERE pr.id_proveedor = @id_proveedor;    
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_ActualizarEstadoYAsignarTransportista]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Obtener la fecha del pedido y el tiempo máximo de entrega
        DECLARE @fecha_pedido DATETIME;
        DECLARE @tiempo_entrega INT;

        SELECT @fecha_pedido = p.fecha_pedido,
               @tiempo_entrega = pr.tiempo_entrega
        FROM Pedidos p
        JOIN Productos pr ON p.id_producto = pr.id_producto
        WHERE p.id_pedido = @id_pedido AND pr.categoria = 'comida';

        -- Verificar si el tiempo transcurrido excede el tiempo de entrega permitido
        IF DATEDIFF(MINUTE, @fecha_pedido, GETDATE()) > @tiempo_entrega
        BEGIN
            -- Lanzar error si el tiempo de entrega ha sido excedido
            RAISERROR('El pedido excede el tiempo máximo de entrega y no puede ser tomado.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Si la validación pasa, asignar el transportista y actualizar el estado
        UPDATE Pedidos
        SET id_transportista = @id_transportista,
            estado = @nuevoEstado
        WHERE id_pedido = @id_pedido;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_ActualizarStockProducto]    Script Date: 6/11/2024 04:27:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ActualizarStockProducto]
    @id_producto INT,
    @cantidad INT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE Productos
    SET StockDisponible = StockDisponible - @cantidad
    WHERE id_producto = @id_producto;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_AgregarCliente]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
    @Telefono VARCHAR(20),
    @FechaNacimiento DATE,
    @Ubicacion GEOGRAPHY -- Nuevo parámetro para almacenar las coordenadas
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        -- Validar que el usuario tenga al menos 16 años
        IF DATEDIFF(YEAR, @FechaNacimiento, GETDATE()) < 16
        BEGIN
            RAISERROR('Debes tener al menos 16 años para registrarte.', 16, 1);
            RETURN; -- Detener la ejecución del procedimiento
        END

        -- Verificar si el correo ya está registrado
        IF EXISTS (SELECT 1 FROM Usuarios WHERE email = @Email AND rol <> 'cliente')
        BEGIN
            RAISERROR('El correo electrónico ya está registrado para otro tipo de usuario.', 16, 1);
            RETURN; -- Detener la ejecución del procedimiento
        END

        -- Insertar en la tabla Usuarios
        INSERT INTO Usuarios (nombre, apellido, email, password, rol, fecha_nacimiento)
        VALUES (@Nombre, @Apellido, @Email, @Password, 'cliente', @FechaNacimiento);

        -- Obtener el id del usuario insertado
        DECLARE @IdUsuario INT = SCOPE_IDENTITY();

        -- Insertar en la tabla Clientes, incluyendo la ubicación geográfica
        INSERT INTO Clientes (id_cliente, direccion, ubicacion_geografica, telefono)
        VALUES (@IdUsuario, @Direccion, @Ubicacion, @Telefono);

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_AgregarProveedor]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
    @Ubicacion GEOGRAPHY, -- Nuevo parámetro para almacenar las coordenadas
    @FechaNacimiento DATE
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        -- Validar que el proveedor tenga al menos 18 años
        IF DATEDIFF(YEAR, @FechaNacimiento, GETDATE()) < 18
        BEGIN
            RAISERROR('Debes tener al menos 18 años para registrarte como proveedor.', 16, 1);
            RETURN; -- Detener la ejecución del procedimiento
        END

        -- Verificar si el correo ya está registrado
        IF EXISTS (SELECT 1 FROM Usuarios WHERE email = @Email AND rol <> 'proveedor')
        BEGIN
            RAISERROR('El correo electrónico ya está registrado para otro tipo de usuario.', 16, 1);
            RETURN; -- Detener la ejecución del procedimiento
        END

        -- Insertar en la tabla Usuarios
        INSERT INTO Usuarios (nombre, apellido, email, password, rol, fecha_nacimiento)
        VALUES (@Nombre, @Apellido, @Email, @Password, 'proveedor', @FechaNacimiento);

        -- Obtener el id del usuario insertado
        DECLARE @IdUsuario INT = SCOPE_IDENTITY();

        -- Insertar en la tabla Proveedores, incluyendo la ubicación geográfica
        INSERT INTO Proveedores (id_proveedor, nombre_empresa, direccion, contacto, horario, ubicacion_geografica)
        VALUES (@IdUsuario, @NombreEmpresa, @Direccion, @Contacto, @Horario, @Ubicacion);

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_AgregarTransportista]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
    @Contacto VARCHAR(50),
    @FechaNacimiento DATE
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        -- Validar que el transportista tenga al menos 16 años
        IF DATEDIFF(YEAR, @FechaNacimiento, GETDATE()) < 16
        BEGIN
            RAISERROR('Debes tener al menos 16 años para registrarte como transportista.', 16, 1);
            RETURN; -- Detener la ejecución del procedimiento
        END

        -- Verificar si el correo ya está registrado
        IF EXISTS (SELECT 1 FROM Usuarios WHERE email = @Email AND rol <> 'transportista')
        BEGIN
            RAISERROR('El correo electrónico ya está registrado para otro tipo de usuario.', 16, 1);
            RETURN; -- Detener la ejecución del procedimiento
        END

        -- Insertar en la tabla Usuarios
        INSERT INTO Usuarios (nombre, apellido, email, password, rol, fecha_nacimiento)
        VALUES (@Nombre, @Apellido, @Email, @Password, 'transportista', @FechaNacimiento);

        -- Obtener el id del usuario insertado
        DECLARE @IdUsuario INT = SCOPE_IDENTITY();

        -- Insertar en la tabla Transportistas
        INSERT INTO Transportistas (id_transportista, tipo_transporte, contacto)
        VALUES (@IdUsuario, @TipoTransporte, @Contacto);

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_CalcularCostoEnvio]    Script Date: 6/11/2024 04:27:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CalcularCostoEnvio]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_CalcularTotalesCarrito]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_CrearDetallePedido]    Script Date: 6/11/2024 04:27:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CrearDetallePedido]
    @id_pedido INT,
    @id_producto INT,
    @cantidad INT,
    @precio_unitario DECIMAL(10, 2)
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO DetallePedido (id_pedido, id_producto, cantidad, precio_unitario)
    VALUES (@id_pedido, @id_producto, @cantidad, @precio_unitario);
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CrearOrdenDeCompra]    Script Date: 6/11/2024 04:27:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CrearOrdenDeCompra]
    @id_cliente INT,
    @fecha_pedido DATE,
    @estado VARCHAR(20),
    @id_transportista INT = NULL,
    @id_producto INT,
    @costo_total DECIMAL(10, 2)  -- Nuevo parámetro para el costo total
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_pedido INT;

    -- Insertar en la tabla Pedidos, incluyendo el costo total
    INSERT INTO Pedidos (id_cliente, id_producto, id_transportista, fecha_pedido, estado, costo_total)
    VALUES (@id_cliente, @id_producto, @id_transportista, @fecha_pedido, @estado, @costo_total);

    -- Obtener el id_pedido generado
    SET @id_pedido = SCOPE_IDENTITY();

    -- Retornar el id_pedido
    SELECT @id_pedido AS id_pedido;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteCliente]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_DeleteProducto]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_DeleteTransportista]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetCategorias]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetProductoPorId]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetProductosPorCategoria]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_IniciarSesion]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_InsertarContacto]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_InsertProducto]    Script Date: 6/11/2024 04:27:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_InsertProducto] (@IdProvedor INT, @Nombre VARCHAR(100), @Categoria VARCHAR(20), 
@Precio DECIMAL(10, 2), @Tiempo_Entrega INT, @Stock Decimal(10, 2))
AS 
BEGIN 
	INSERT INTO Productos(id_proveedor, nombre, categoria, precio, tiempo_entrega, StockDisponible) 
	VALUES (@IdProvedor, @Nombre, @Categoria, @Precio, @Tiempo_Entrega, @Stock);
END




GO
/****** Object:  StoredProcedure [dbo].[sp_InsertTransportista]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ObtenerClientePorID]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ObtenerHistorialComprasPorCliente]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ObtenerPedidosConDetalles]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
        Subtotal = SUM(dp.precio_unitario * dp.cantidad),
        Impuestos = SUM(dp.precio_unitario * dp.cantidad) * 0.13,
        Total = SUM(dp.precio_unitario * dp.cantidad) * 1.13,
        t.tipo_transporte AS Transportista,
        t.contacto AS ContactoTransportista,
        MAX(prod.tiempo_entrega) AS TiempoEntrega
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
        p.id_pedido, p.fecha_pedido, p.estado, t.tipo_transporte, t.contacto
    ORDER BY 
        p.fecha_pedido DESC;
END 
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerPedidosEntregadosPorCliente]    Script Date: 6/11/2024 04:27:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ObtenerPedidosEntregadosPorCliente]
    @IdCliente INT
AS
BEGIN
    SELECT 
        p.id_pedido,
        p.fecha_pedido,
        p.estado,
        Subtotal = SUM(dp.precio_unitario * dp.cantidad),
        Impuestos = SUM(dp.precio_unitario * dp.cantidad) * 0.13,
        Total = SUM(dp.precio_unitario * dp.cantidad) * 1.13
    FROM 
        Pedidos p
    INNER JOIN 
        DetallePedido dp ON p.id_pedido = dp.id_pedido
    WHERE 
        p.id_cliente = @IdCliente
        AND p.estado = 'Entregado'
    GROUP BY 
        p.id_pedido, p.fecha_pedido, p.estado
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerTodosLosPedidos]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ObtenerTransPorID]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_PedidosPendientes]    Script Date: 6/11/2024 04:27:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PedidosPendientes] (@id INT)
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
/****** Object:  StoredProcedure [dbo].[SP_SelectProductoCategoria]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_SelectProductoProvedor]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_SelectProductoProvedores]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_SelectProvedo]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateCliente]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_UpdateProducto]    Script Date: 6/11/2024 04:27:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[SP_UpdateProveedor]    Script Date: 6/11/2024 04:27:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdateProveedor] @IdProveedor INT,@NombreEmpresa VARCHAR(100),
									 @Direccion VARCHAR(255),@Contacto VARCHAR(50),
									  @Horario VARCHAR(50)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Proveedores WHERE id_proveedor = @IdProveedor)
    BEGIN
        RAISERROR('El proveedor con ese id no existe', 16, 1, @IdProveedor);
        RETURN;
    END

    UPDATE Proveedores SET
        nombre_empresa = @NombreEmpresa, direccion = @Direccion, contacto = @Contacto,
        horario = @Horario
    WHERE
        id_proveedor = @IdProveedor;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateTransportista]    Script Date: 6/11/2024 04:27:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateTransportista]
    @id_transportista INT,
    @tipo_transporte NVARCHAR(50),
    @contacto NVARCHAR(50) -- Agregar contacto
AS
BEGIN
    UPDATE Transportistas
    SET tipo_transporte = @tipo_transporte,
        contacto = @contacto -- Actualizar contacto
    WHERE id_transportista = @id_transportista;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_UptadeProducto]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_VerificarStock]    Script Date: 6/11/2024 04:27:37 p. m. ******/
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
/****** Object:  Trigger [dbo].[trg_ValidarDistanciaMaxima]    Script Date: 6/11/2024 04:27:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_ValidarDistanciaMaxima]
ON [dbo].[DetallePedido]
AFTER INSERT
AS
BEGIN
    DECLARE @idCliente INT, @idPedido INT, @idProducto INT, @idProveedor INT;
    DECLARE @ubicacionCliente geography, @ubicacionProveedor geography, @distancia DECIMAL(10, 2);
    DECLARE @error BIT = 0; -- Variable para determinar si existe un error de distancia

    -- Obtener el id_pedido y el id_producto del detalle insertado
    SELECT @idPedido = id_pedido, @idProducto = id_producto
    FROM INSERTED;

    -- Obtener el id_cliente asociado al pedido
    SELECT @idCliente = id_cliente
    FROM Pedidos
    WHERE id_pedido = @idPedido;

    -- Obtener la ubicación del cliente
    SELECT @ubicacionCliente = ubicacion_geografica 
    FROM Clientes 
    WHERE id_cliente = @idCliente;

    -- Asegurarse de que se obtuvo la ubicación del cliente
    IF @ubicacionCliente IS NULL
    BEGIN
        RAISERROR ('No se pudo obtener la ubicación del cliente.', 16, 1);
        ROLLBACK;
        RETURN;
    END

    -- Obtener el id_proveedor asociado al producto
    SELECT @idProveedor = id_proveedor
    FROM Productos
    WHERE id_producto = @idProducto;

    -- Obtener la ubicación del proveedor
    SELECT @ubicacionProveedor = ubicacion_geografica 
    FROM Proveedores 
    WHERE id_proveedor = @idProveedor;

    -- Asegurarse de que se obtuvo la ubicación del proveedor
    IF @ubicacionProveedor IS NULL
    BEGIN
        RAISERROR ('No se pudo obtener la ubicación del proveedor.', 16, 1);
        ROLLBACK;
        RETURN;
    END

    -- Calcular la distancia en kilómetros
    SET @distancia = @ubicacionCliente.STDistance(@ubicacionProveedor) / 1000; -- convertir a kilómetros

    -- Validar la distancia máxima permitida
    IF @distancia > 50
    BEGIN
        RAISERROR ('La distancia entre el punto de venta y el punto de entrega excede los 50 km para el producto.', 16, 1);
        ROLLBACK;
    END
END;
GO
ALTER TABLE [dbo].[DetallePedido] ENABLE TRIGGER [trg_ValidarDistanciaMaxima]
GO
/****** Object:  Trigger [dbo].[trg_VerificarTransportistaActivo]    Script Date: 6/11/2024 04:27:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[trg_VerificarTransportistaActivo]
ON [dbo].[Pedidos]
AFTER UPDATE
AS
BEGIN
    -- Verificar que no haya conflictos en la asignación de transportistas
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Pedidos p ON i.id_transportista = p.id_transportista
        WHERE p.estado IN ('pendiente', 'en camino')
          AND i.id_pedido <> p.id_pedido
    )
    BEGIN
        -- Lanzar un error si el transportista tiene un envío activo
        RAISERROR('El transportista ya tiene un envío activo.', 16, 1);
        ROLLBACK;
    END
END;
GO
ALTER TABLE [dbo].[Pedidos] ENABLE TRIGGER [trg_VerificarTransportistaActivo]
GO
USE [master]
GO
ALTER DATABASE [SistemaEnviosDB] SET  READ_WRITE 
GO
