-- Creacion de la base de datos
DROP DATABASE IF EXISTS tiendaonline;
CREATE DATABASE tiendaonline;
USE tiendaonline;

CREATE TABLE productos(
    id INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    precio DECIMAL(10,2),
    descripcion TEXT,
    CONSTRAINT PK_productos_Id PRIMARY KEY(id)
);

CREATE TABLE usuarios(
    id INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    correo_electronico VARCHAR(100),
    fecha_registro DATE,
    CONSTRAINT PK_usuarios_Id PRIMARY KEY(id)
);

CREATE TABLE pedidos(
    id INT AUTO_INCREMENT,
    id_usuario INT,
    fecha DATE,
    total DECIMAL(10,2),
    CONSTRAINT PK_pedidos_Id PRIMARY KEY(id),
	CONSTRAINT FK_usuarios_Id FOREIGN KEY(id_usuario) REFERENCES usuarios(id)
);

CREATE TABLE detallespedidos(
    id_pedido INT,
    id_producto INT,
    cantidad INT,
    precio_unitario decimal(10,2),
    CONSTRAINT PK_detallespedidos_Id PRIMARY KEY(id_pedido,id_producto),
	CONSTRAINT FK_pedidos_Id FOREIGN KEY(id_pedido) REFERENCES pedidos(id),
	CONSTRAINT FK_productos_Id FOREIGN KEY(id_producto) REFERENCES productos(id)
);



