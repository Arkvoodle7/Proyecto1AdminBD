CREATE DATABASE SistemaEnviosDB;
USE SistemaEnviosDB;

-- Tabla Usuarios
CREATE TABLE Usuarios (
    id_usuario INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    email VARCHAR(100),
    password VARCHAR(255),
    rol VARCHAR(20) NOT NULL CHECK (rol IN ('cliente', 'transportista', 'proveedor'))
);

-- Tabla Clientes
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY,
    direccion VARCHAR(255),
    telefono VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES Usuarios(id_usuario)
);

-- Tabla Proveedores
CREATE TABLE Proveedores (
    id_proveedor INT PRIMARY KEY,
    nombre_empresa VARCHAR(100),
    direccion VARCHAR(255),
    contacto VARCHAR(50),
	horario VARCHAR(50),
	ubicacion VARCHAR(50),
    FOREIGN KEY (id_proveedor) REFERENCES Usuarios(id_usuario)
);

-- Tabla Productos
CREATE TABLE Productos (
    id_producto INT PRIMARY KEY IDENTITY(1,1),
    id_proveedor INT,
    nombre VARCHAR(100),
    categoria VARCHAR(20) NOT NULL CHECK (categoria IN ('ropa', 'comida', 'zapatos')),
    precio DECIMAL(10, 2),
    tiempo_entrega INT,
    FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id_proveedor)
);

-- Tabla Transportistas
CREATE TABLE Transportistas (
    id_transportista INT PRIMARY KEY,
    tipo_transporte VARCHAR(50),
    contacto VARCHAR(50),
    FOREIGN KEY (id_transportista) REFERENCES Usuarios(id_usuario)
);

-- Tabla Pedidos
CREATE TABLE Pedidos (
    id_pedido INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT,
    id_transportista INT,
    fecha_pedido DATE,
    estado VARCHAR(20) NOT NULL CHECK (estado IN ('pendiente', 'en camino', 'entregado')),
    costo_total DECIMAL(10, 2),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_transportista) REFERENCES Transportistas(id_transportista)
);

-- Tabla Carrito
CREATE TABLE Carrito (
    id_carrito INT PRIMARY KEY IDENTITY(1,1),
    id_pedido INT,
    id_producto INT,
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- Tabla Historial_Cliente
CREATE TABLE Historial_Cliente (
    id_historial INT PRIMARY KEY IDENTITY(1,1),
    id_pedido INT,
    fecha_entrega DATE,
    observaciones TEXT,
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido)
);

-- Tabla Historial_Empresa
CREATE TABLE Historial_Empresa (
    id_historial INT PRIMARY KEY IDENTITY(1,1),
    id_pedido INT,
    id_transportista INT,
    fecha_entrega DATE,
    observaciones TEXT,
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_transportista) REFERENCES Transportistas(id_transportista)
);


GO
USE SistemaEnviosDB;




-------------------------------------------------------------
--------------Productos-------------------------------------

GO ----Insert
CREATE PROCEDURE SP_InsertProducto (@IdProvedor INT, @Nombre VARCHAR(100), @Categoria VARCHAR(20), @Precio DECIMAL(10, 2), @Tiempo_Entrega INT)
AS
BEGIN
		INSERT INTO Productos(id_proveedor, nombre, categoria, precio, tiempo_entrega)
		VALUES (@IdProvedor,@Nombre, @Categoria, @Precio, @Tiempo_Entrega);
END;

GO --Update
CREATE PROCEDURE SP_UptadeProducto (@IdProducto INT ,@IdProvedor INT, @Nombre VARCHAR(100), @Categoria VARCHAR(20), @Precio DECIMAL(10, 2), @Tiempo_Entrega INT)
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

GO --Delete
CREATE PROCEDURE SP_DeleteProducto (@IdProducto INT)
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

GO  ---Busca productos por categoria
CREATE PROCEDURE SP_SelectProductoCategoria (@Categoria VARCHAR(20))
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Productos WHERE categoria = @Categoria)
    BEGIN
        RAISERROR ('La categoria no tiene registros', 16, 1);
        RETURN;
    END
	SELECT * FROM Productos WHERE categoria = @Categoria;
END;

GO  ---Busca productos por provedor
CREATE PROCEDURE SP_SelectProductoProvedores (@Provedor int)
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

GO		---Obtener un provedor por su id
CREATE PROCEDURE SP_SelectProductoProvedor (@Provedor int)
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

GO		---Obtiene la id de un historial por la cedula del usuario
CREATE PROCEDURE SP_ObtenerHistorial(@cedula INT)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Historial_Empresa he JOIN Pedidos pe)
    BEGIN
        return 2
    END
    return 1
END;

GO		---Calcula precios
CREATE TRIGGER trg_InsertProvedor
ON Proveedores
AFTER INSERT
AS
BEGIN
	INSERT INTO Productos(id_proveedor, nombre, categoria, precio, tiempo_entrega)
		VALUES ((select id_proveedor from inserted),'No especificado', 'Ropa', 0, 0);
END;

GO
CREATE PROCEDURE SP_UpdateProveedor @IdProveedor INT,@NombreEmpresa VARCHAR(100),
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