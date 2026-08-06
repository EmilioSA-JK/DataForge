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