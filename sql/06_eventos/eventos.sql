#Se crea un evento para saber la comisiones correspondientes a cada cocinero al principio de cada mes
DELIMITER $$

CREATE EVENT ev_comision_mensual_cocineros
ON SCHEDULE EVERY 1 MONTH
STARTS '2026-08-31 00:00:00'
DO
	CALL sp_calcular_comisiones_entrega()$$
DELIMITER ;
    


