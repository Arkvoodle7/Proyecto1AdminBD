USE [master]
GO
/****** Object:  Database [SistemaEnviosDB]    Script Date: 28/11/2024 11:20:06 p. m. ******/
CREATE DATABASE [SistemaEnviosDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SistemaEnviosDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SistemaEnviosDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SistemaEnviosDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SistemaEnviosDB_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
/****** Object:  User [UsuarioTransportista]    Script Date: 28/11/2024 11:20:06 p. m. ******/
CREATE USER [UsuarioTransportista] FOR LOGIN [UsuarioTransportista] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [UsuarioOferente]    Script Date: 28/11/2024 11:20:06 p. m. ******/
CREATE USER [UsuarioOferente] FOR LOGIN [UsuarioOferente] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [UsuarioGenerico]    Script Date: 28/11/2024 11:20:06 p. m. ******/
CREATE USER [UsuarioGenerico] FOR LOGIN [UsuarioGenerico] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [UsuarioFuncionario]    Script Date: 28/11/2024 11:20:06 p. m. ******/
CREATE USER [UsuarioFuncionario] FOR LOGIN [UsuarioFuncionario] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [UsuarioCliente]    Script Date: 28/11/2024 11:20:06 p. m. ******/
CREATE USER [UsuarioCliente] FOR LOGIN [UsuarioCliente] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [RolTransportista]    Script Date: 28/11/2024 11:20:06 p. m. ******/
CREATE ROLE [RolTransportista]
GO
/****** Object:  DatabaseRole [RolOferente]    Script Date: 28/11/2024 11:20:06 p. m. ******/
CREATE ROLE [RolOferente]
GO
/****** Object:  DatabaseRole [RolGenerico]    Script Date: 28/11/2024 11:20:06 p. m. ******/
CREATE ROLE [RolGenerico]
GO
/****** Object:  DatabaseRole [RolFuncionario]    Script Date: 28/11/2024 11:20:06 p. m. ******/
CREATE ROLE [RolFuncionario]
GO
/****** Object:  DatabaseRole [RolCliente]    Script Date: 28/11/2024 11:20:06 p. m. ******/
CREATE ROLE [RolCliente]
GO
ALTER ROLE [RolTransportista] ADD MEMBER [UsuarioTransportista]
GO
ALTER ROLE [RolOferente] ADD MEMBER [UsuarioOferente]
GO
ALTER ROLE [RolGenerico] ADD MEMBER [UsuarioGenerico]
GO
ALTER ROLE [RolFuncionario] ADD MEMBER [UsuarioFuncionario]
GO
ALTER ROLE [RolCliente] ADD MEMBER [UsuarioCliente]
GO
/****** Object:  UserDefinedTableType [dbo].[CartItemType]    Script Date: 28/11/2024 11:20:07 p. m. ******/
CREATE TYPE [dbo].[CartItemType] AS TABLE(
	[id_producto] [int] NULL,
	[cantidad] [int] NULL
)
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  Table [dbo].[Contactos]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  Table [dbo].[DetallePedido]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  Table [dbo].[Funcionarios]    Script Date: 28/11/2024 11:20:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Funcionarios](
	[id_funcionario] [int] NOT NULL,
	[nombre_funcionario] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_funcionario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pedidos]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  Table [dbo].[Productos]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  Table [dbo].[Proveedores]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  Table [dbo].[Transportistas]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  Table [dbo].[Usuarios]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
INSERT [dbo].[Clientes] ([id_cliente], [direccion], [ubicacion_geografica], [telefono]) VALUES (1, N'San José Centro', 0xE6100000010C4B7842AF3F0555C0E4DC26DC2BDB2340, N'22224444')
INSERT [dbo].[Clientes] ([id_cliente], [direccion], [ubicacion_geografica], [telefono]) VALUES (2, N'Alajuela Centro', 0xE6100000010C92B1DAFCBF0D55C008E9297288082440, N'24332233')
INSERT [dbo].[Clientes] ([id_cliente], [direccion], [ubicacion_geografica], [telefono]) VALUES (3, N'Cartago Centro', 0xE6100000010C5EBA490C02FB54C008AC1C5A64BB2340, N'25556677')
INSERT [dbo].[Clientes] ([id_cliente], [direccion], [ubicacion_geografica], [telefono]) VALUES (4, N'Heredia Centro', 0xE6100000010C0CEA5BE6740755C0C993A46B26FF2340, N'22667788')
INSERT [dbo].[Clientes] ([id_cliente], [direccion], [ubicacion_geografica], [telefono]) VALUES (5, N'Liberia, Guanacaste', 0xE6100000010C645DDC46035C55C0F853E3A59B442540, N'26660000')
INSERT [dbo].[Clientes] ([id_cliente], [direccion], [ubicacion_geografica], [telefono]) VALUES (6, N'Puntarenas Centro', 0xE6100000010C5305A3923A3555C06B2BF697DDF32340, N'26661111')
INSERT [dbo].[Clientes] ([id_cliente], [direccion], [ubicacion_geografica], [telefono]) VALUES (7, N'Limón Centro', 0xE6100000010C273108AC1CC254C05E4BC8073DFB2340, N'27992222')
GO
INSERT [dbo].[Contactos] ([Nombre], [Email], [Mensaje]) VALUES (N'TestGenerico', N'generico@email.com', N'Test hola adios')
INSERT [dbo].[Contactos] ([Nombre], [Email], [Mensaje]) VALUES (N'TestCliente', N'client@email.com', N'Hola test cliente')
GO
INSERT [dbo].[Funcionarios] ([id_funcionario], [nombre_funcionario]) VALUES (25, N'Funcionario A')
INSERT [dbo].[Funcionarios] ([id_funcionario], [nombre_funcionario]) VALUES (26, N'Funcionario B')
GO
SET IDENTITY_INSERT [dbo].[Productos] ON 

INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (1, 15, N'Comida San José 1', N'comida', CAST(6000.00 AS Decimal(10, 2)), 0, 20)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (2, 15, N'Comida San José 2', N'comida', CAST(6500.00 AS Decimal(10, 2)), 0, 25)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (3, 15, N'Ropa San José 1', N'ropa', CAST(15000.00 AS Decimal(10, 2)), 5, 69)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (4, 15, N'Ropa San José 2', N'ropa', CAST(15500.00 AS Decimal(10, 2)), 5, 59)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (5, 15, N'Zapatos San José 1', N'zapatos', CAST(20000.00 AS Decimal(10, 2)), 5, 40)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (6, 15, N'Zapatos San José 2', N'zapatos', CAST(21000.00 AS Decimal(10, 2)), 5, 35)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (7, 16, N'Comida Alajuela 1', N'comida', CAST(5500.00 AS Decimal(10, 2)), 0, 35)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (8, 16, N'Comida Alajuela 2', N'comida', CAST(5800.00 AS Decimal(10, 2)), 0, 30)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (9, 16, N'Ropa Alajuela 1', N'ropa', CAST(13000.00 AS Decimal(10, 2)), 5, 60)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (10, 16, N'Ropa Alajuela 2', N'ropa', CAST(13500.00 AS Decimal(10, 2)), 5, 55)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (11, 16, N'Zapatos Alajuela 1', N'zapatos', CAST(22000.00 AS Decimal(10, 2)), 5, 20)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (12, 16, N'Zapatos Alajuela 2', N'zapatos', CAST(22500.00 AS Decimal(10, 2)), 5, 18)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (13, 17, N'Comida Cartago 1', N'comida', CAST(5000.00 AS Decimal(10, 2)), 0, 25)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (14, 17, N'Comida Cartago 2', N'comida', CAST(5300.00 AS Decimal(10, 2)), 0, 20)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (15, 17, N'Ropa Cartago 1', N'ropa', CAST(12000.00 AS Decimal(10, 2)), 5, 50)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (16, 17, N'Ropa Cartago 2', N'ropa', CAST(12500.00 AS Decimal(10, 2)), 5, 45)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (17, 17, N'Zapatos Cartago 1', N'zapatos', CAST(25000.00 AS Decimal(10, 2)), 5, 30)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (18, 17, N'Zapatos Cartago 2', N'zapatos', CAST(25500.00 AS Decimal(10, 2)), 5, 28)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (19, 18, N'Comida Heredia 1', N'comida', CAST(7000.00 AS Decimal(10, 2)), 0, 45)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (20, 18, N'Comida Heredia 2', N'comida', CAST(7300.00 AS Decimal(10, 2)), 0, 40)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (21, 18, N'Ropa Heredia 1', N'ropa', CAST(17000.00 AS Decimal(10, 2)), 5, 90)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (22, 18, N'Ropa Heredia 2', N'ropa', CAST(17500.00 AS Decimal(10, 2)), 5, 85)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (23, 18, N'Zapatos Heredia 1', N'zapatos', CAST(18000.00 AS Decimal(10, 2)), 5, 50)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (24, 18, N'Zapatos Heredia 2', N'zapatos', CAST(18500.00 AS Decimal(10, 2)), 5, 45)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (25, 19, N'Comida Guanacaste 1', N'comida', CAST(5200.00 AS Decimal(10, 2)), 0, 60)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (26, 19, N'Comida Guanacaste 2', N'comida', CAST(5500.00 AS Decimal(10, 2)), 0, 55)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (27, 19, N'Ropa Guanacaste 1', N'ropa', CAST(12500.00 AS Decimal(10, 2)), 5, 80)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (28, 19, N'Ropa Guanacaste 2', N'ropa', CAST(13000.00 AS Decimal(10, 2)), 5, 75)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (29, 19, N'Zapatos Guanacaste 1', N'zapatos', CAST(24000.00 AS Decimal(10, 2)), 5, 30)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (30, 19, N'Zapatos Guanacaste 2', N'zapatos', CAST(24500.00 AS Decimal(10, 2)), 5, 28)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (31, 20, N'Comida Puntarenas 1', N'comida', CAST(6300.00 AS Decimal(10, 2)), 0, 15)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (32, 20, N'Comida Puntarenas 2', N'comida', CAST(6600.00 AS Decimal(10, 2)), 0, 12)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (33, 20, N'Ropa Puntarenas 1', N'ropa', CAST(15500.00 AS Decimal(10, 2)), 5, 40)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (34, 20, N'Ropa Puntarenas 2', N'ropa', CAST(16000.00 AS Decimal(10, 2)), 5, 35)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (35, 20, N'Zapatos Puntarenas 1', N'zapatos', CAST(26000.00 AS Decimal(10, 2)), 5, 20)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (36, 20, N'Zapatos Puntarenas 2', N'zapatos', CAST(26500.00 AS Decimal(10, 2)), 5, 18)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (37, 21, N'Comida Limón 1', N'comida', CAST(6800.00 AS Decimal(10, 2)), 0, 50)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (38, 21, N'Comida Limón 2', N'comida', CAST(7100.00 AS Decimal(10, 2)), 0, 45)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (39, 21, N'Ropa Limón 1', N'ropa', CAST(14500.00 AS Decimal(10, 2)), 5, 60)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (40, 21, N'Ropa Limón 2', N'ropa', CAST(15000.00 AS Decimal(10, 2)), 5, 55)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (41, 21, N'Zapatos Limón 1', N'zapatos', CAST(23000.00 AS Decimal(10, 2)), 5, 40)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (42, 21, N'Zapatos Limón 2', N'zapatos', CAST(23500.00 AS Decimal(10, 2)), 5, 38)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (43, 22, N'Comida Dulce Nombre 1', N'comida', CAST(5100.00 AS Decimal(10, 2)), 0, 30)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (44, 22, N'Comida Dulce Nombre 2', N'comida', CAST(5400.00 AS Decimal(10, 2)), 0, 25)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (45, 22, N'Ropa Dulce Nombre 1', N'ropa', CAST(12800.00 AS Decimal(10, 2)), 5, 65)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (46, 22, N'Ropa Dulce Nombre 2', N'ropa', CAST(13000.00 AS Decimal(10, 2)), 5, 60)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (47, 22, N'Zapatos Dulce Nombre 1', N'zapatos', CAST(24800.00 AS Decimal(10, 2)), 5, 25)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (48, 22, N'Zapatos Dulce Nombre 2', N'zapatos', CAST(25500.00 AS Decimal(10, 2)), 5, 20)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (49, 23, N'Comida Llanos de Santa Lucía 1', N'comida', CAST(5300.00 AS Decimal(10, 2)), 0, 28)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (50, 23, N'Comida Llanos de Santa Lucía 2', N'comida', CAST(5600.00 AS Decimal(10, 2)), 0, 22)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (51, 23, N'Ropa Llanos de Santa Lucía 1', N'ropa', CAST(13500.00 AS Decimal(10, 2)), 5, 70)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (52, 23, N'Ropa Llanos de Santa Lucía 2', N'ropa', CAST(13800.00 AS Decimal(10, 2)), 5, 65)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (53, 23, N'Zapatos Llanos de Santa Lucía 1', N'zapatos', CAST(26000.00 AS Decimal(10, 2)), 5, 18)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (54, 23, N'Zapatos Llanos de Santa Lucía 2', N'zapatos', CAST(26500.00 AS Decimal(10, 2)), 5, 15)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (55, 24, N'Comida Orosi 1', N'comida', CAST(5200.00 AS Decimal(10, 2)), 0, 35)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (56, 24, N'Comida Orosi 2', N'comida', CAST(5500.00 AS Decimal(10, 2)), 0, 30)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (57, 24, N'Ropa Orosi 1', N'ropa', CAST(14000.00 AS Decimal(10, 2)), 5, 80)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (58, 24, N'Ropa Orosi 2', N'ropa', CAST(14200.00 AS Decimal(10, 2)), 5, 75)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (59, 24, N'Zapatos Orosi 1', N'zapatos', CAST(25500.00 AS Decimal(10, 2)), 5, 25)
INSERT [dbo].[Productos] ([id_producto], [id_proveedor], [nombre], [categoria], [precio], [tiempo_entrega], [StockDisponible]) VALUES (60, 24, N'Zapatos Orosi 2', N'zapatos', CAST(26200.00 AS Decimal(10, 2)), 5, 22)
SET IDENTITY_INSERT [dbo].[Productos] OFF
GO
INSERT [dbo].[Proveedores] ([id_proveedor], [nombre_empresa], [direccion], [contacto], [horario], [ubicacion_geografica]) VALUES (15, N'Proveedores San José', N'San José Centro', N'22557788', N'9:00-18:00', 0xE6100000010C4B7842AF3F0555C0E4DC26DC2BDB2340)
INSERT [dbo].[Proveedores] ([id_proveedor], [nombre_empresa], [direccion], [contacto], [horario], [ubicacion_geografica]) VALUES (16, N'Proveedores Alajuela', N'Alajuela Centro', N'24334455', N'8:00-17:00', 0xE6100000010C92B1DAFCBF0D55C008E9297288082440)
INSERT [dbo].[Proveedores] ([id_proveedor], [nombre_empresa], [direccion], [contacto], [horario], [ubicacion_geografica]) VALUES (17, N'Proveedores Cartago', N'Cartago Centro', N'27778899', N'8:00-17:00', 0xE6100000010C5EBA490C02FB54C008AC1C5A64BB2340)
INSERT [dbo].[Proveedores] ([id_proveedor], [nombre_empresa], [direccion], [contacto], [horario], [ubicacion_geografica]) VALUES (18, N'Proveedores Heredia', N'Heredia Centro', N'22660000', N'9:00-18:00', 0xE6100000010C0CEA5BE6740755C0C993A46B26FF2340)
INSERT [dbo].[Proveedores] ([id_proveedor], [nombre_empresa], [direccion], [contacto], [horario], [ubicacion_geografica]) VALUES (19, N'Proveedores Guanacaste', N'Liberia, Guanacaste', N'26668888', N'8:00-17:00', 0xE6100000010C645DDC46035C55C0F853E3A59B442540)
INSERT [dbo].[Proveedores] ([id_proveedor], [nombre_empresa], [direccion], [contacto], [horario], [ubicacion_geografica]) VALUES (20, N'Proveedores Puntarenas', N'Puntarenas Centro', N'26663333', N'9:00-18:00', 0xE6100000010C5305A3923A3555C06B2BF697DDF32340)
INSERT [dbo].[Proveedores] ([id_proveedor], [nombre_empresa], [direccion], [contacto], [horario], [ubicacion_geografica]) VALUES (21, N'Proveedores Limón', N'Limón Centro', N'27990000', N'8:00-17:00', 0xE6100000010C273108AC1CC254C05E4BC8073DFB2340)
INSERT [dbo].[Proveedores] ([id_proveedor], [nombre_empresa], [direccion], [contacto], [horario], [ubicacion_geografica]) VALUES (22, N'Proveedores Dulce Nombre', N'Dulce Nombre de Cartago', N'22771122', N'8:00-17:00', 0xE6100000010C7DD0B359F5F954C020D26F5F07AE2340)
INSERT [dbo].[Proveedores] ([id_proveedor], [nombre_empresa], [direccion], [contacto], [horario], [ubicacion_geografica]) VALUES (23, N'Proveedores Llanos de Santa Lucía', N'Llanos de Santa Lucía', N'22772233', N'9:00-18:00', 0xE6100000010C55C1A8A44EF854C0E561A1D634AF2340)
INSERT [dbo].[Proveedores] ([id_proveedor], [nombre_empresa], [direccion], [contacto], [horario], [ubicacion_geografica]) VALUES (24, N'Proveedores Orosi', N'Orosi', N'22773344', N'8:00-17:00', 0xE6100000010C910F7A36ABF654C0F2B0506B9A972340)
GO
INSERT [dbo].[Transportistas] ([id_transportista], [tipo_transporte], [contacto]) VALUES (8, N'Motocicleta Express', N'22557799')
INSERT [dbo].[Transportistas] ([id_transportista], [tipo_transporte], [contacto]) VALUES (9, N'Camioneta de Reparto', N'24338844')
INSERT [dbo].[Transportistas] ([id_transportista], [tipo_transporte], [contacto]) VALUES (10, N'Camión de Carga', N'25667788')
INSERT [dbo].[Transportistas] ([id_transportista], [tipo_transporte], [contacto]) VALUES (11, N'Furgón', N'22667700')
INSERT [dbo].[Transportistas] ([id_transportista], [tipo_transporte], [contacto]) VALUES (12, N'Camión Liviano', N'26660011')
INSERT [dbo].[Transportistas] ([id_transportista], [tipo_transporte], [contacto]) VALUES (13, N'Bicicleta de Carga', N'26661133')
INSERT [dbo].[Transportistas] ([id_transportista], [tipo_transporte], [contacto]) VALUES (14, N'Motocicleta de Mensajería', N'27993344')
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (1, N'Cliente', N'San José', N'cliente.sanjose@example.com', N'password123', N'cliente', CAST(N'1992-03-12' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (2, N'Cliente', N'Alajuela', N'cliente.alajuela@example.com', N'password123', N'cliente', CAST(N'1985-11-20' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (3, N'Cliente', N'Cartago', N'cliente.cartago@example.com', N'password123', N'cliente', CAST(N'1990-05-10' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (4, N'Cliente', N'Heredia', N'cliente.heredia@example.com', N'password123', N'cliente', CAST(N'1993-04-15' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (5, N'Cliente', N'Guanacaste', N'cliente.guanacaste@example.com', N'password123', N'cliente', CAST(N'1987-08-30' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (6, N'Cliente', N'Puntarenas', N'cliente.puntarenas@example.com', N'password123', N'cliente', CAST(N'1994-02-28' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (7, N'Cliente', N'Limón', N'cliente.limon@example.com', N'password123', N'cliente', CAST(N'1989-07-07' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (8, N'Transportista', N'A', N'transportista.A@example.com', N'password123', N'transportista', CAST(N'1985-09-30' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (9, N'Transportista', N'B', N'transportista.B@example.com', N'password123', N'transportista', CAST(N'1983-01-05' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (10, N'Transportista', N'C', N'transportista.C@example.com', N'password123', N'transportista', CAST(N'1980-06-21' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (11, N'Transportista', N'D', N'transportista.D@example.com', N'password123', N'transportista', CAST(N'1991-10-15' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (12, N'Transportista', N'E', N'transportista.E@example.com', N'password123', N'transportista', CAST(N'1984-12-20' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (13, N'Transportista', N'F', N'transportista.F@example.com', N'password123', N'transportista', CAST(N'1986-05-25' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (14, N'Transportista', N'G', N'transportista.G@example.com', N'password123', N'transportista', CAST(N'1988-03-22' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (15, N'Proveedor', N'San José', N'proveedor.sanjose@example.com', N'password123', N'proveedor', CAST(N'1983-04-25' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (16, N'Proveedor', N'Alajuela', N'proveedor.alajuela@example.com', N'password123', N'proveedor', CAST(N'1982-11-11' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (17, N'Proveedor', N'Cartago', N'proveedor.cartago@example.com', N'password123', N'proveedor', CAST(N'1988-02-17' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (18, N'Proveedor', N'Heredia', N'proveedor.heredia@example.com', N'password123', N'proveedor', CAST(N'1979-06-18' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (19, N'Proveedor', N'Guanacaste', N'proveedor.guanacaste@example.com', N'password123', N'proveedor', CAST(N'1981-09-05' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (20, N'Proveedor', N'Puntarenas', N'proveedor.puntarenas@example.com', N'password123', N'proveedor', CAST(N'1980-07-30' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (21, N'Proveedor', N'Limón', N'proveedor.limon@example.com', N'password123', N'proveedor', CAST(N'1977-03-03' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (22, N'Proveedor', N'Dulce Nombre', N'proveedor.dulcenombre@example.com', N'password123', N'proveedor', CAST(N'1985-01-15' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (23, N'Proveedor', N'Llanos de Santa Lucía', N'proveedor.llanosdesantalucia@example.com', N'password123', N'proveedor', CAST(N'1986-04-22' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (24, N'Proveedor', N'Orosi', N'proveedor.orosi@example.com', N'password123', N'proveedor', CAST(N'1984-07-10' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (25, N'Funcionario', N'A', N'funcionario.A@example.com', N'password123', N'funcionario', CAST(N'1983-04-25' AS Date))
INSERT [dbo].[Usuarios] ([id_usuario], [nombre], [apellido], [email], [password], [rol], [fecha_nacimiento]) VALUES (26, N'Funcionario', N'B', N'funcionario.B@example.com', N'password123', N'funcionario', CAST(N'1982-11-11' AS Date))
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_EmailRol]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [CK_Usuarios_Rol] CHECK  (([rol]='funcionario' OR [rol]='proveedor' OR [rol]='transportista' OR [rol]='cliente'))
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [CK_Usuarios_Rol]
GO
/****** Object:  StoredProcedure [dbo].[ObtenerPedidosPorProveedor]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_ActualizarEstadoPedido]    Script Date: 28/11/2024 11:20:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ActualizarEstadoPedido]
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
/****** Object:  StoredProcedure [dbo].[sp_ActualizarEstadoYAsignarTransportista]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_ActualizarStockProducto]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_AgregarCliente]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_AgregarProducto]    Script Date: 28/11/2024 11:20:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AgregarProducto]
    @IdProveedor INT,
    @Nombre NVARCHAR(100),
    @Categoria NVARCHAR(100),
    @Precio DECIMAL(18, 2),
    @TiempoEntrega INT,
    @StockDisponible INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Productos (id_proveedor, nombre, categoria, precio, tiempo_entrega, StockDisponible)
    VALUES (@IdProveedor, @Nombre, @Categoria, @Precio, @TiempoEntrega, @StockDisponible);
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AgregarProveedor]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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

        -- Validar que el proveedor tenga al menos 16 años
        IF DATEDIFF(YEAR, @FechaNacimiento, GETDATE()) < 16
        BEGIN
            RAISERROR('Debes tener al menos 16 años para registrarte como proveedor.', 16, 1);
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
/****** Object:  StoredProcedure [dbo].[SP_AgregarTransportista]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_CalcularCostoEnvio]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_CalcularDistancia]    Script Date: 28/11/2024 11:20:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CalcularDistancia]
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
/****** Object:  StoredProcedure [dbo].[sp_CalcularTotalesCarrito]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_CrearDetallePedido]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_CrearOrdenDeCompra]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_DeleteCliente]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_DeleteProducto]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_DeleteTransportista]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_EliminarCliente]    Script Date: 28/11/2024 11:20:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_EliminarCliente]
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        DELETE FROM Clientes WHERE id_cliente = @IdUsuario;
        DELETE FROM Usuarios WHERE id_usuario = @IdUsuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[SP_EliminarOferente]    Script Date: 28/11/2024 11:20:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_EliminarOferente]
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        DELETE FROM Proveedores WHERE id_proveedor = @IdUsuario;
        DELETE FROM Usuarios WHERE id_usuario = @IdUsuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[SP_EliminarProducto]    Script Date: 28/11/2024 11:20:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_EliminarProducto]
    @IdProducto INT
AS
BEGIN
    DELETE FROM Productos
    WHERE id_producto = @IdProducto;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_EliminarTransportista]    Script Date: 28/11/2024 11:20:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_EliminarTransportista]
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        DELETE FROM Transportistas WHERE id_transportista = @IdUsuario;
        DELETE FROM Usuarios WHERE id_usuario = @IdUsuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCategorias]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetProductoPorId]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetProductosPorCategoria]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_IniciarSesion]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_InsertarContacto]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_InsertProducto]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_InsertTransportista]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_ModificarCliente]    Script Date: 28/11/2024 11:20:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ModificarCliente]
    @IdUsuario INT,
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @Email NVARCHAR(100),
    @Password NVARCHAR(100),
    @Direccion NVARCHAR(200),
    @Telefono NVARCHAR(20),
    @FechaNacimiento DATE,
    @Ubicacion geography
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
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
GO
/****** Object:  StoredProcedure [dbo].[SP_ModificarOferente]    Script Date: 28/11/2024 11:20:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ModificarOferente]
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
    @Ubicacion GEOGRAPHY
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
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
GO
/****** Object:  StoredProcedure [dbo].[SP_ModificarProducto]    Script Date: 28/11/2024 11:20:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ModificarProducto]
    @IdProducto INT,
    @IdProveedor INT,
    @Nombre NVARCHAR(100),
    @Categoria NVARCHAR(50),
    @Precio DECIMAL(18, 2),
    @TiempoEntrega INT,
    @StockDisponible INT
AS
BEGIN
    UPDATE Productos
    SET id_proveedor = @IdProveedor,
        nombre = @Nombre,
        categoria = @Categoria,
        precio = @Precio,
        tiempo_entrega = @TiempoEntrega,
        StockDisponible = @StockDisponible
    WHERE id_producto = @IdProducto;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ModificarTransportista]    Script Date: 28/11/2024 11:20:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ModificarTransportista]
    @IdUsuario INT,
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @Email NVARCHAR(100),
    @Password NVARCHAR(100),
    @FechaNacimiento DATE,
    @TipoTransporte NVARCHAR(50),
    @Contacto NVARCHAR(20)
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
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
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerClientePorID]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_ObtenerDatosCliente]    Script Date: 28/11/2024 11:20:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ObtenerDatosCliente]
    @IdUsuario INT
AS
BEGIN
    SELECT Usuarios.nombre, Usuarios.apellido, Usuarios.email, Usuarios.password, Usuarios.fecha_nacimiento,
           Clientes.direccion, Clientes.telefono, Clientes.ubicacion_geografica
    FROM Usuarios
    INNER JOIN Clientes ON Usuarios.id_usuario = Clientes.id_cliente
    WHERE Usuarios.id_usuario = @IdUsuario;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ObtenerDatosOferente]    Script Date: 28/11/2024 11:20:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ObtenerDatosOferente]
    @IdUsuario INT
AS
BEGIN
    SELECT Usuarios.nombre, Usuarios.apellido, Usuarios.email, Usuarios.password, Usuarios.fecha_nacimiento,
           Proveedores.nombre_empresa, Proveedores.direccion, Proveedores.contacto, Proveedores.horario, Proveedores.ubicacion_geografica
    FROM Usuarios
    INNER JOIN Proveedores ON Usuarios.id_usuario = Proveedores.id_proveedor
    WHERE Usuarios.id_usuario = @IdUsuario;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ObtenerDatosProducto]    Script Date: 28/11/2024 11:20:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ObtenerDatosProducto]
    @IdProducto INT
AS
BEGIN
    SELECT id_producto, id_proveedor, nombre, categoria, precio, tiempo_entrega, StockDisponible
    FROM Productos
    WHERE id_producto = @IdProducto;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ObtenerDatosTransportista]    Script Date: 28/11/2024 11:20:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ObtenerDatosTransportista]
    @IdUsuario INT
AS
BEGIN
    SELECT Usuarios.nombre, Usuarios.apellido, Usuarios.email, Usuarios.password, Usuarios.fecha_nacimiento,
           Transportistas.tipo_transporte, Transportistas.contacto
    FROM Usuarios
    INNER JOIN Transportistas ON Usuarios.id_usuario = Transportistas.id_transportista
    WHERE Usuarios.id_usuario = @IdUsuario;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerHistorialComprasPorCliente]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ObtenerPedidosConDetalles]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ObtenerPedidosEntregadosPorCliente]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ObtenerTodosLosClientesCompletos]    Script Date: 28/11/2024 11:20:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ObtenerTodosLosClientesCompletos]
AS
BEGIN
    SELECT u.id_usuario, u.nombre, u.apellido, u.email, u.password, u.rol, u.fecha_nacimiento, c.direccion, c.telefono
    FROM Usuarios u
    INNER JOIN Clientes c ON u.id_usuario = c.id_cliente
    WHERE u.rol = 'cliente';
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerTodosLosOferentesCompletos]    Script Date: 28/11/2024 11:20:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ObtenerTodosLosOferentesCompletos]
AS
BEGIN
    SELECT u.id_usuario, u.nombre, u.apellido, u.email, u.password, u.rol, u.fecha_nacimiento, p.nombre_empresa, p.direccion, p.contacto, p.horario
    FROM Usuarios u
    INNER JOIN Proveedores p ON u.id_usuario = p.id_proveedor
    WHERE u.rol = 'proveedor';
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerTodosLosPedidos]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ObtenerTodosLosProductos]    Script Date: 28/11/2024 11:20:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ObtenerTodosLosProductos]
AS
BEGIN
    SELECT id_producto, id_proveedor, nombre, categoria, precio, tiempo_entrega, StockDisponible
    FROM Productos;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerTodosLosTransportistasCompletos]    Script Date: 28/11/2024 11:20:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ObtenerTodosLosTransportistasCompletos]
AS
BEGIN
    SELECT u.id_usuario, u.nombre, u.apellido, u.email, u.password, u.rol, u.fecha_nacimiento, t.tipo_transporte, t.contacto
    FROM Usuarios u
    INNER JOIN Transportistas t ON u.id_usuario = t.id_transportista
    WHERE u.rol = 'transportista';
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerTransPorID]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_PedidosPendientes]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_PendientesTransportista]    Script Date: 28/11/2024 11:20:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PendientesTransportista] (@id INT)
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
GO
/****** Object:  StoredProcedure [dbo].[SP_SelectProductoCategoria]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_SelectProductoProvedor]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_SelectProductoProvedores]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_SelectProvedo]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateCliente]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_UpdateProducto]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_UpdateProveedor]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateTransportista]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_UptadeProducto]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_VerificarStock]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
/****** Object:  Trigger [dbo].[trg_ValidarDistanciaMaxima]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
    IF @distancia > 12
    BEGIN
        RAISERROR ('La distancia entre el punto de venta y el punto de entrega excede los 12 km para el producto.', 16, 1);
        ROLLBACK;
    END
END;
GO
ALTER TABLE [dbo].[DetallePedido] ENABLE TRIGGER [trg_ValidarDistanciaMaxima]
GO
/****** Object:  Trigger [dbo].[trg_VerificarTransportistaActivo]    Script Date: 28/11/2024 11:20:07 p. m. ******/
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
