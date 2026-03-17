-- ============================================================
-- Funciones definidas por el usuario
-- ============================================================

USE tienda;

DELIMITER $$

-- Función: Calcular el total con IVA (21%)
CREATE FUNCTION fn_total_con_iva(
    p_precio DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN ROUND(p_precio * 1.21, 2);
END $$

-- Función: Obtener la categoría de precio de un producto
CREATE FUNCTION fn_categoria_precio(
    p_precio DECIMAL(10,2)
)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE v_categoria VARCHAR(20);

    IF p_precio < 50 THEN
        SET v_categoria = 'Económico';
    ELSEIF p_precio < 200 THEN
        SET v_categoria = 'Medio';
    ELSE
        SET v_categoria = 'Premium';
    END IF;

    RETURN v_categoria;
END $$

DELIMITER ;

-- Usar las funciones
SELECT
    nombre,
    precio,
    fn_total_con_iva(precio)   AS precio_con_iva,
    fn_categoria_precio(precio) AS categoria
FROM productos;
