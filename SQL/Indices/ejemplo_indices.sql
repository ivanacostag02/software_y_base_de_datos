-- ============================================================
-- Índices y Optimización de Consultas
-- ============================================================

USE tienda;

-- ─────────────────────────────────────────────
-- Tipos de Índices
-- ─────────────────────────────────────────────

-- Índice simple en columna de búsqueda frecuente
CREATE INDEX idx_clientes_email
    ON clientes(email);

-- Índice en columna de filtrado frecuente
CREATE INDEX idx_productos_precio
    ON productos(precio);

-- Índice compuesto (útil para consultas que filtran por ambas columnas)
CREATE INDEX idx_pedidos_cliente_fecha
    ON pedidos(id_cliente, fecha_pedido);

-- Índice UNIQUE (garantiza unicidad además de acelerar búsquedas)
-- (el email ya tiene UNIQUE en la definición de la tabla, esto es un ejemplo)
-- CREATE UNIQUE INDEX idx_uq_email ON clientes(email);

-- ─────────────────────────────────────────────
-- Ver índices de una tabla
-- ─────────────────────────────────────────────
SHOW INDEX FROM clientes;
SHOW INDEX FROM pedidos;

-- ─────────────────────────────────────────────
-- EXPLAIN: Analizar el plan de ejecución
-- ─────────────────────────────────────────────
EXPLAIN SELECT * FROM clientes WHERE email = 'ana.garcia@email.com';

EXPLAIN
SELECT p.id_pedido, c.nombre, p.total
FROM pedidos p
INNER JOIN clientes c ON p.id_cliente = c.id_cliente
WHERE p.fecha_pedido BETWEEN '2024-01-01' AND '2024-12-31';

-- ─────────────────────────────────────────────
-- Eliminar un índice
-- ─────────────────────────────────────────────
-- DROP INDEX idx_productos_precio ON productos;
