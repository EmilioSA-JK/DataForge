# Decisión sobre como definir los proveedores y las comisiones

## Proveedores
Los proveedores están definidos según el tipo de relación con el negocio, es decir que sí la relacion esta definida
 en una tupla como "proveedor" podrá pasar como proveedor en las demás tablas.

## Comisiones

Para las comisiones de los vendedores(atendedores) se tomó como referencia el artículo de Ennio Castillo llamado
"Guía definitiva para calcular comisiones por ventas paso a paso" el cual define que se debe oscilar entre el 1% y
el 3% sobre el valor total de la venta.
Link del artículo: https://www.fromdoppler.com/blog/calcular-comisiones-por-ventas/?utm_medium=organic&utm_source=google



Para los cocineros, la dinámica suele cambiar un poco. Ellos podrían tener una comisión que oscile entre el 2% y el 5% de
de su salario, o una cantidad fija por turno. Esto siempre y cuando los cocineros mantengan un promedio de tiempo de entrega 
adecuado. Esta información fue tomada de delfino.cr.
Link del artículo: https://delfino.cr/2024/03/proyecto-de-ley-obligaria-a-saloneros-y-meseros-a-compartir-propinas-y-cargo-del-10-por-servicio


Nota: Para este proyecto, se trabajará con una comisión del 3% sobre el valor de la venta para los vendedores y un 5% del
salario base extra de comisión para los cocineros.

Se utilizó un procedimiento almacenado para calcular de manera manual la comisión del 3% para los cocineros, solo habría que llamar al procedimiento.
En este caso se tomó como desición que las comisiones se pagarán a fin de mes, así que se creó un EVENT para activar este procedimiento cada fin de mes.

En el caso de los vendedores, estos obtienen su comisión a partir de sus ventas llevandose un porcentaje, entonces con cada venta se dispara el trigger
haciendo que se vayan registrando las comisiones correspondientes.
