-- ============================================================
-- Procedimientos Almacenados (Stored Procedures)
-- ============================================================

USE tienda;

DELIMITER $$

-- Procedimiento: Obtener todos los pedidos de un cliente
CREATE PROCEDURE sp_pedidos_por_cliente(
    IN p_id_cliente INT
)
BEGIN
    SELECT
        p.id_pedido,
        p.fecha_pedido,
        p.total
    FROM pedidos p
    WHERE p.id_cliente = p_id_cliente
    ORDER BY p.fecha_pedido DESC;
END $$

-- Procedimiento: Registrar un nuevo pedido
CREATE PROCEDURE sp_registrar_pedido(
    IN  p_id_cliente   INT,
    IN  p_id_producto  INT,
    IN  p_cantidad     INT,
    OUT p_id_pedido    INT,
    OUT p_mensaje      VARCHAR(255)
)
BEGIN
    DECLARE v_precio   DECIMAL(10,2);
    DECLARE v_stock    INT;
    DECLARE v_total    DECIMAL(10,2);

    -- Verificar stock
    SELECT precio, stock INTO v_precio, v_stock
    FROM productos
    WHERE id_producto = p_id_producto;

    IF v_stock < p_cantidad THEN
        SET p_id_pedido = 0;
        SET p_mensaje   = 'Stock insuficiente';
    ELSE
        SET v_total = v_precio * p_cantidad;

        -- Insertar pedido
        INSERT INTO pedidos (id_cliente, fecha_pedido, total)
        VALUES (p_id_cliente, CURRENT_DATE, v_total);

        SET p_id_pedido = LAST_INSERT_ID();

        -- Insertar detalle
        INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unit)
        VALUES (p_id_pedido, p_id_producto, p_cantidad, v_precio);

        -- Actualizar stock
        UPDATE productos
        SET stock = stock - p_cantidad
        WHERE id_producto = p_id_producto;

        SET p_mensaje = CONCAT('Pedido #', p_id_pedido, ' creado exitosamente');
    END IF;
END $$

DELIMITER ;

-- Llamar a los procedimientos
CALL sp_pedidos_por_cliente(1);

CALL sp_registrar_pedido(2, 3, 2, @nuevo_pedido, @mensaje);
SELECT @nuevo_pedido AS id_pedido, @mensaje AS resultado;
