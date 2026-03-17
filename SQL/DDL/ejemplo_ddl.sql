-- ============================================================
-- DDL - Data Definition Language
-- Ejemplos de creación y modificación de estructuras de datos
-- ============================================================

-- Crear base de datos
CREATE DATABASE IF NOT EXISTS tienda;
USE tienda;

-- Crear tabla de clientes
CREATE TABLE clientes (
    id_cliente   INT          NOT NULL AUTO_INCREMENT,
    nombre       VARCHAR(100) NOT NULL,
    apellido     VARCHAR(100) NOT NULL,
    email        VARCHAR(150) NOT NULL UNIQUE,
    telefono     VARCHAR(20),
    fecha_registro DATE        DEFAULT (CURRENT_DATE),
    PRIMARY KEY (id_cliente)
);

-- Crear tabla de productos
CREATE TABLE productos (
    id_producto  INT            NOT NULL AUTO_INCREMENT,
    nombre       VARCHAR(150)   NOT NULL,
    descripcion  TEXT,
    precio       DECIMAL(10, 2) NOT NULL,
    stock        INT            NOT NULL DEFAULT 0,
    PRIMARY KEY (id_producto)
);

-- Crear tabla de pedidos
CREATE TABLE pedidos (
    id_pedido    INT  NOT NULL AUTO_INCREMENT,
    id_cliente   INT  NOT NULL,
    fecha_pedido DATE NOT NULL DEFAULT (CURRENT_DATE),
    total        DECIMAL(10, 2),
    PRIMARY KEY (id_pedido),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Crear tabla de detalles de pedido
CREATE TABLE detalle_pedido (
    id_detalle  INT            NOT NULL AUTO_INCREMENT,
    id_pedido   INT            NOT NULL,
    id_producto INT            NOT NULL,
    cantidad    INT            NOT NULL DEFAULT 1,
    precio_unit DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id_detalle),
    FOREIGN KEY (id_pedido)   REFERENCES pedidos(id_pedido)   ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE RESTRICT
);

-- Agregar columna a tabla existente
ALTER TABLE clientes ADD COLUMN direccion VARCHAR(255);

-- Modificar tipo de dato de una columna
ALTER TABLE clientes MODIFY COLUMN telefono VARCHAR(30);

-- Eliminar columna
-- ALTER TABLE clientes DROP COLUMN direccion;

-- Eliminar tabla
-- DROP TABLE IF EXISTS detalle_pedido;

-- Eliminar base de datos
-- DROP DATABASE IF EXISTS tienda;
