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
    id_transportista INT NULL,
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


GO  ---Busca producto individual NO SE USO
CREATE PROCEDURE SP_SelectProducto (@IdProducto INT)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Productos WHERE id_producto = @IdProducto)
    BEGIN
        RAISERROR ('El producto no esta registrado', 16, 1);
        RETURN;
    END

	SELECT 1 FROM Productos WHERE id_producto = @IdProducto;
END;

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

GO		---Obtener un provedor por su id
CREATE PROCEDURE SP_SelectProvedo(@id int)
AS
BEGIN
	SELECT pr.id_proveedor,pr.contacto,pr.direccion, pr.horario, pr.nombre_empresa, pr.ubicacion
		FROM Proveedores pr LEFT JOIN Usuarios us ON pr.id_proveedor = us.id_usuario WHERE pr.id_proveedor = @id;
END;


GO			-----Crear un pedido
CREATE PROCEDURE SP_CreatePedido (@IdUsuario INT , @IdTransportista INT NULL, @FechaPedido DATETIME, @Estado VARCHAR(20))
AS
BEGIN
IF NOT EXISTS (SELECT 1 FROM Pedidos WHERE id_cliente = @IdUsuario AND estado != 'en camino' AND estado != 'entregado')
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE id_usuario = @IdUsuario)
		BEGIN
			RAISERROR ('El cliente no esta registrado', 16, 1);
			RETURN;
		END

		IF @IdTransportista IS NOT NULL 
		BEGIN
			IF NOT EXISTS (SELECT 1 FROM Transportistas WHERE id_transportista = @IdTransportista)
			BEGIN
				RAISERROR ('El transportista no está registrado', 16, 1);
				RETURN;
			END;
		END;

		INSERT INTO Pedidos (id_cliente, id_transportista, fecha_pedido, estado, costo_total)
		VALUES (@IdUsuario, @IdTransportista, @FechaPedido, @Estado, 
		0);
	END;
END;

GO		---Calcula precios
CREATE TRIGGER trg_InsertCarrito
ON Carrito
AFTER INSERT
AS
BEGIN
    UPDATE Pedidos
    SET costo_total = costo_total + pr.precio
    FROM Pedidos pe
    INNER JOIN inserted ins ON pe.id_pedido = ins.id_pedido
    INNER JOIN Productos pr ON ins.id_producto = pr.id_producto;
END;




GO		----Ingresar productos al carrito
CREATE PROCEDURE SP_InsertCarrito (@IdProducto INT, @cedula INT)
AS
BEGIN
	DECLARE @IdPedido INT;
	SELECT @IdPedido = id_pedido FROM Pedidos WHERE id_cliente = @cedula;

    IF NOT EXISTS (SELECT 1 FROM Pedidos WHERE id_pedido = @IdPedido AND estado IN ('en camino', 'pendiente'))
    BEGIN
        RAISERROR ('El pedido no está registrado o su estado no permite agregar al carrito', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Productos WHERE id_producto = @IdProducto)
    BEGIN
        RAISERROR ('El producto no esta registrado',16, 1);
        RETURN;
    END

    INSERT INTO Carrito(id_pedido, id_producto)
    VALUES (@IdPedido, @IdProducto);

END;

GO    ---Modificar el estado del pedido
CREATE PROCEDURE SP_UpdateEstadoPedido (@IdPedido INT, @NuevoEstado VARCHAR(20))
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Pedidos WHERE id_pedido = @IdPedido)
    BEGIN
        RAISERROR ('El pedido no esta registrado', 16, 1);
        RETURN;
    END
    IF @NuevoEstado NOT IN ('en camino', 'entregado')
    BEGIN
        RAISERROR ('El estado no es valido. Debe ser "en camino" o "entregado"', 16, 1);
        RETURN;
    END

    UPDATE Pedidos SET estado = @NuevoEstado
		WHERE id_pedido = @IdPedido;
END;


GO			---Crea historial de empresa
CREATE TRIGGER trg_InsertPedidos
ON Pedidos
AFTER INSERT
AS
BEGIN
    INSERT INTO Historial_Empresa (id_pedido, id_transportista, fecha_entrega, observaciones)
    SELECT 
        i.id_pedido, i.id_transportista, i.fecha_pedido, 'Pedido realizado'                        
    FROM 
        Pedidos i;                 
END;


GO		---Obtiene la id de un  pedido por la cedula del usuario (NO SE USO)
CREATE PROCEDURE SP_ObtenerIdPedido(@cedula INT)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Pedidos WHERE id_cliente = @cedula AND estado != 'en camino' AND estado != 'entregado')
    BEGIN
        return 2
    END
    return 1
END;




GO
CREATE TRIGGER trg_UpdatePedido
ON Pedidos
AFTER UPDATE
AS
BEGIN

	INSERT INTO Historial_Empresa (id_pedido, id_transportista, fecha_entrega, observaciones)
		SELECT 
			i.id_pedido, i.id_transportista, i.fecha_pedido, 'Pedido completado'                        
		FROM 
			inserted i
		WHERE 
			i.estado = 'entregado';
END;

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
