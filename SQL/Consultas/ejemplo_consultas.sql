-- ============================================================
-- Consultas SQL
-- SELECT simple, JOIN, subconsultas y agrupaciones
-- ============================================================

USE tienda;

-- ─────────────────────────────────────────────
-- 1. Consultas básicas
-- ─────────────────────────────────────────────

-- Todos los clientes
SELECT * FROM clientes;

-- Productos con precio mayor a 50, ordenados de mayor a menor precio
SELECT nombre, precio
FROM productos
WHERE precio > 50
ORDER BY precio DESC;

-- Primeros 3 productos más caros
SELECT nombre, precio
FROM productos
ORDER BY precio DESC
LIMIT 3;

-- ─────────────────────────────────────────────
-- 2. Consultas con JOIN
-- ─────────────────────────────────────────────

-- Pedidos con información del cliente
SELECT
    p.id_pedido,
    c.nombre,
    c.apellido,
    p.fecha_pedido,
    p.total
FROM pedidos p
INNER JOIN clientes c ON p.id_cliente = c.id_cliente;

-- Detalle completo de pedidos (cliente + productos)
SELECT
    c.nombre        AS cliente,
    p.id_pedido,
    pr.nombre       AS producto,
    dp.cantidad,
    dp.precio_unit,
    (dp.cantidad * dp.precio_unit) AS subtotal
FROM detalle_pedido dp
INNER JOIN pedidos   p  ON dp.id_pedido   = p.id_pedido
INNER JOIN clientes  c  ON p.id_cliente   = c.id_cliente
INNER JOIN productos pr ON dp.id_producto = pr.id_producto
ORDER BY p.id_pedido;

-- Clientes que NO tienen pedidos (LEFT JOIN)
SELECT c.id_cliente, c.nombre, c.apellido
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IS NULL;

-- ─────────────────────────────────────────────
-- 3. Funciones de agregación y GROUP BY
-- ─────────────────────────────────────────────

-- Total de ventas por cliente
SELECT
    c.nombre,
    c.apellido,
    COUNT(p.id_pedido)  AS total_pedidos,
    SUM(p.total)        AS monto_total
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre, c.apellido
ORDER BY monto_total DESC;

-- Producto más vendido (por cantidad)
SELECT
    pr.nombre,
    SUM(dp.cantidad) AS total_vendido
FROM detalle_pedido dp
INNER JOIN productos pr ON dp.id_producto = pr.id_producto
GROUP BY pr.id_producto, pr.nombre
ORDER BY total_vendido DESC
LIMIT 1;

-- ─────────────────────────────────────────────
-- 4. Subconsultas
-- ─────────────────────────────────────────────

-- Clientes que han realizado algún pedido
SELECT nombre, apellido
FROM clientes
WHERE id_cliente IN (
    SELECT DISTINCT id_cliente FROM pedidos
);

-- Productos con precio superior al promedio
SELECT nombre, precio
FROM productos
WHERE precio > (SELECT AVG(precio) FROM productos);

-- ─────────────────────────────────────────────
-- 5. Consultas con HAVING
-- ─────────────────────────────────────────────

-- Clientes con más de 1 pedido
SELECT
    c.id_cliente,
    c.nombre,
    COUNT(p.id_pedido) AS cantidad_pedidos
FROM clientes c
INNER JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre
HAVING COUNT(p.id_pedido) > 1;
