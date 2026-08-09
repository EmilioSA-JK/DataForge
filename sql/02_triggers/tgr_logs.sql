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







# En este trigger se va a descontar la cantidad vendida del saldo para llevar un control en inventario sobre la cantidad de ciertos productos
DELIMITER $$

CREATE TRIGGER trg_descuento_inventario
AFTER INSERT ON Detalle_ventas
FOR EACH ROW
BEGIN
	UPDATE Inventario
    SET saldo = saldo - NEW.cantidad
    WHERE cod = NEW.cod;
    
END$$

DELIMITER ;


#Se crea el trigger para generar la comision por venta(3%)
DELIMITER $$

CREATE TRIGGER trg_comision_venta
AFTER INSERT ON Detalle_ventas
FOR EACH ROW
BEGIN
	DECLARE v_carnet INT;
    DECLARE v_puesto VARCHAR(60);
    DECLARE v_precio DECIMAL(10,2);
    DECLARE v_saldo INT;
    DECLARE v_subtotal DECIMAL(10,2);
    DECLARE v_IVA DECIMAL(10,2);
    DECLARE v_total DECIMAL(10,2);
    
    SELECT carnet INTO v_carnet
    FROM Ventas
    WHERE n_factura_compra = NEW.n_factura_compra;
    
    SELECT puesto INTO v_puesto
    FROM Inventario
    WHERE cod = NEW.cod;
    
    SELECT precio, saldo INTO v_precio, v_saldo
    FROM Inventario
    WHERE cod = NEW.cod;
    
    SET v_subtotal = NEW.cantidad * v_precio;
    SET v_IVA = v_subtotal * 0.13;
    SET v_total = sub_total + v_IVA;
    
    IF v_puesto = 'Vendedor' THEN
		INSERT INTO Log_ventas_comisiones
			(carnet, tipo_comision, cod, saldo, sub_total, IVA, total, monto_comision)
				VALUES (
					v_carnet, 'Venta', NEW.cod, v_saldo,
                    v_subtotal, v_IVA, v_total,
                    v_total * 0,03
			);
            
	END IF;
			
            
END$$

DELIMITER ;







