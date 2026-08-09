DELIMITER $$

CREATE PROCEDURE sp_calcular_comisiones_entrega()
BEGIN
	INSERT INTO Log_ventas_comisiones (carnet, tipo_comision, monto_comision)
    SELECT r.carnet, 'Entrega', r.salario * 0.05 
    FROM Rh r
    JOIN (
		SELECT carnet, AVG(tiempo_entrega_min) AS promedio
        FROM Entregas
        GROUP BY carnet
	) e ON e.carnet = r.carnet
    WHERE r.puesto = 'Cocinera' OR 'Cocinero'
		AND e.promedio BETWEEN 3 AND 5;
END$$

DELIMITER ;