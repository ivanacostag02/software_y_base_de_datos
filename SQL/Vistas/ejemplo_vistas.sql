-- ============================================================
-- Vistas (VIEWS)
-- ============================================================

USE tienda;

-- Vista: Resumen de pedidos con datos del cliente
CREATE OR REPLACE VIEW v_pedidos_clientes AS
SELECT
    p.id_pedido,
    CONCAT(c.nombre, ' ', c.apellido) AS cliente,
    c.email,
    p.fecha_pedido,
    p.total
FROM pedidos p
INNER JOIN clientes c ON p.id_cliente = c.id_cliente;

-- Vista: Productos con stock bajo (menor a 10 unidades)
CREATE OR REPLACE VIEW v_stock_bajo AS
SELECT id_producto, nombre, precio, stock
FROM productos
WHERE stock < 10;

-- Vista: Reporte de ventas por producto
CREATE OR REPLACE VIEW v_ventas_por_producto AS
SELECT
    pr.id_producto,
    pr.nombre         AS producto,
    SUM(dp.cantidad)  AS unidades_vendidas,
    SUM(dp.cantidad * dp.precio_unit) AS ingresos_totales
FROM detalle_pedido dp
INNER JOIN productos pr ON dp.id_producto = pr.id_producto
GROUP BY pr.id_producto, pr.nombre;

-- Consultar una vista
SELECT * FROM v_pedidos_clientes;
SELECT * FROM v_stock_bajo;
SELECT * FROM v_ventas_por_producto ORDER BY ingresos_totales DESC;

-- Eliminar una vista
-- DROP VIEW IF EXISTS v_stock_bajo;
