-- 1. Verificar la distribución de empleados por puesto
--    (debe dar: 1 Administrador, 3 Vendedor, 3 Cocinera, 2 Guarda, 1 Miscelanea)
SELECT puesto, COUNT(*) AS total
FROM Rh
GROUP BY puesto;

-- 2. Ver empleados con su nombre completo (join Rh + Personas)
SELECT r.carnet, p.nombre, p.ape01, p.ape02, r.puesto, r.salario
FROM Rh r
JOIN Personas p ON p.ced = r.ced
ORDER BY r.carnet;

-- 3. Contar personas por tipo de relación (Cliente / Empleado / Proveedor)
SELECT relacion, COUNT(*) AS total
FROM Personas
GROUP BY relacion;

-- 4. Historial completo de una factura de compra (join Compras + detalle_compras + Inventario)
SELECT c.n_factura, c.proveedor, c.fecha, i.descripcion, d.cantidad, d.cod
FROM Compras c
JOIN detalle_compras d ON d.n_factura = c.n_factura
JOIN Inventario i ON i.cod = d.cod
ORDER BY c.fecha DESC;

-- 5. Total comprado por producto (comparar contra lo que debería quedar en Oferta)
SELECT cod, SUM(cantidad) AS total_comprado
FROM detalle_compras
GROUP BY cod
ORDER BY total_comprado DESC;

-- 6. Verificar que el trigger de Oferta esté cuadrando con la consulta anterior
SELECT o.cod, i.descripcion, o.cantidad_comprada, o.ultima_fecha_compra
FROM Oferta o
JOIN Inventario i ON i.cod = o.cod
ORDER BY o.cantidad_comprada DESC;

-- 7. Últimas transacciones auditadas (verificar que Registro se esté llenando)
SELECT codigo_transaccion, tabla_afectada, tipo_operacion, fecha_hora, detalle
FROM Registro
ORDER BY fecha_hora DESC
LIMIT 15;

-- 8. Cuántas transacciones se registraron por tabla y tipo de operación
SELECT tabla_afectada, tipo_operacion, COUNT(*) AS total
FROM Registro
GROUP BY tabla_afectada, tipo_operacion
ORDER BY tabla_afectada;

-- 9. Nombres y primer apellido junto a su salario y puesto de todos los empleados.

SELECT p.nombre, p.ape01, r.salario, r.puesto
FROM Rh r
INNER JOIN Personas p
ON r.ced = p.ced;

-- 10. Trae todos los distintos montos de salarios

SELECT COUNT(DISTINCT salario) as salarios FROM Rh;

-- 11. Trae cuantos salarios se pagan por cada puesto

SELECT puesto, COUNT(DISTINCT salario) as salarios FROM Rh GROUP by puesto;

-- 12. Da el total de dinero pagado a todos los empleados

SELECT SUM(salario) as empleados_pago
FROM Rh;

-- 13. Promedio de salarios

SELECT ROUND(AVG(salario), 2) as avg_salario
FROM Rh;

-- 14. Salario mas alto y mas bajo

SELECT
    MIN(salario) as salario_bajo
    MAX(salario) as salario_alto
FROM Rh;

-- 15. Salarios mayores a 400,000 colones, segun el puesto

SELECT salario 
FROM Rh 
GROUP BY puesto
HAVING salario > 400000.00;

-- 16. Muestra cuantos salarios mayores a 400,000 mil colones existen y los agrupa por puesto

SELECT 
	COUNT(*) as s_mayor_400,
	r.salario,
    r.puesto
FROM Rh r
INNER JOIN Personas p
ON r.ced = p.ced
WHERE salario > 400000.00
GROUP BY r.puesto
HAVING s_mayor_400 > 2;

