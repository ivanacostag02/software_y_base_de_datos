-- ============================================================
-- Triggers (Disparadores)
-- ============================================================

USE tienda;

-- Tabla de auditoría para registrar cambios en precios
CREATE TABLE IF NOT EXISTS auditoria_precios (
    id_auditoria  INT          NOT NULL AUTO_INCREMENT,
    id_producto   INT          NOT NULL,
    precio_antes  DECIMAL(10,2),
    precio_despues DECIMAL(10,2),
    fecha_cambio  DATETIME     DEFAULT CURRENT_TIMESTAMP,
    usuario       VARCHAR(100) DEFAULT (CURRENT_USER()),
    PRIMARY KEY (id_auditoria)
);

DELIMITER $$

-- Trigger BEFORE UPDATE: Registrar cambio de precio
CREATE TRIGGER trg_auditoria_precio
BEFORE UPDATE ON productos
FOR EACH ROW
BEGIN
    IF OLD.precio <> NEW.precio THEN
        INSERT INTO auditoria_precios (id_producto, precio_antes, precio_despues)
        VALUES (OLD.id_producto, OLD.precio, NEW.precio);
    END IF;
END $$

DELIMITER ;

-- Probar el trigger de auditoría
UPDATE productos SET precio = 999.99 WHERE id_producto = 1;
SELECT * FROM auditoria_precios;
