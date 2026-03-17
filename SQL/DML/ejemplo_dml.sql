-- ============================================================
-- DML - Data Manipulation Language
-- Ejemplos de inserción, actualización y eliminación de datos
-- ============================================================

USE tienda;

-- INSERT: Insertar datos en tablas

INSERT INTO clientes (nombre, apellido, email, telefono) VALUES
    ('Ana',    'García',    'ana.garcia@email.com',    '555-1001'),
    ('Carlos', 'Martínez',  'carlos.m@email.com',      '555-1002'),
    ('Lucía',  'Rodríguez', 'lucia.rod@email.com',     '555-1003'),
    ('Miguel', 'López',     'miguel.lopez@email.com',  '555-1004');

INSERT INTO productos (nombre, descripcion, precio, stock) VALUES
    ('Laptop Pro 15',   'Laptop de alto rendimiento 15"', 1299.99, 10),
    ('Mouse Inalámbrico', 'Mouse ergonómico sin cable',   25.99,  50),
    ('Teclado Mecánico', 'Teclado con switches Cherry MX', 89.99, 30),
    ('Monitor 27"',     'Monitor Full HD 27 pulgadas',   349.99, 15);

INSERT INTO pedidos (id_cliente, fecha_pedido, total) VALUES
    (1, '2024-01-15', 1325.98),
    (2, '2024-01-20',   89.99),
    (3, '2024-02-05',  375.98);

INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unit) VALUES
    (1, 1, 1, 1299.99),
    (1, 2, 1,   25.99),
    (2, 3, 1,   89.99),
    (3, 4, 1,  349.99),
    (3, 2, 1,   25.99);

-- UPDATE: Actualizar datos existentes

-- Actualizar el teléfono de un cliente
UPDATE clientes
SET telefono = '555-9999'
WHERE id_cliente = 1;

-- Actualizar el stock de un producto
UPDATE productos
SET stock = stock - 1
WHERE id_producto = 1;

-- Aplicar descuento del 10% a productos con precio mayor a 100
UPDATE productos
SET precio = precio * 0.90
WHERE precio > 100;

-- DELETE: Eliminar datos

-- Eliminar un cliente específico
-- DELETE FROM clientes WHERE id_cliente = 4;

-- Eliminar pedidos anteriores a una fecha
-- DELETE FROM pedidos WHERE fecha_pedido < '2023-01-01';

-- Vaciar tabla (sin eliminar la estructura)
-- TRUNCATE TABLE detalle_pedido;
