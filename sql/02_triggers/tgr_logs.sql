#Aquí se crea el trigger para generar logs de los INSERT a la tabla compras.

DELIMITER $$

CREATE TRIGGER trg_logs_compras_insert
AFTER INSERT ON Compras
FOR EACH ROW
BEGIN
	INSERT INTO PIT_Logs (tabla, tipo_operacion, detalle)
    VALUES ('Compras', 'INSERT',
		CONCAT('Factura #', NEW.n_factura, ' - proveedor', NEW.proveedor,
				' - total ', NEW.total));
                
END$$

DELIMITER ;


#Aquí se crea otro trigger para generar logs pero esta vez para los UPDATE.
DELIMITER $$

CREATE TRIGGER tgr_logs_compras_update
AFTER UPDATE ON Compras
FOR EACH ROW
BEGIN
	INSERT INTO PIT_logs(tabla, tipo_operacion, detalle)
    VALUES ('Compras', 'UPDATE',
		CONCAT('Factura #', NEW.n_factura, ' - total anterior ', OLD.total,
        ' - total nuevo', NEW.total)
        );

END $$

DELIMITER ;







