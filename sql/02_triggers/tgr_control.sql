#Se crea un trigger para llevar un control de lo que se introduce en compras para saber que se compró y cuanto se compró

use PromesasIT;
DELIMITER $$

CREATE TRIGGER tgr_control_oferta
AFTER INSERT ON detalle_compras
FOR EACH ROW
BEGIN
	DECLARE v_fecha DATE;
        
	SELECT fecha INTO v_fecha
    FROM Compras
    WHERE n_factura = NEW.n_factura;
    
	INSERT INTO Oferta (cod, cantidad, ultima_fecha_compra)
    VALUES (NEW,cod, NEW.cantidad, v_fecha)
    ON DUPLICATE KEY UPDATE
		cantidad = cantidad + NEW.cantidad,
        ultima_fecha_compra = v_fecha;
        
END $$

DELIMITER ;