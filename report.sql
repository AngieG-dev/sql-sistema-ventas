-- =====================================
-- REPORTE SQL - CHALLENGER SISTEMA VENTAS
-- =====================================

-- CONSULTAS BÁSICAS --
-- 1. Mostrar todos los clientes registrados
select * from clientes; -- estrellita selecciona TODO desde clientes

-- 2. Mostrar todos los productos disponibles
select * from productos;

-- 3. Mostrar todas las ventas realizadas
select * from ventas;

-- 4. Mostrar solo nombre y email de clientes
select nombre, email 
from clientes;

-- 5. Mostrar solo nombre y precio de productos
select nombre, precio
from productos;

-- FUNCIONES DE ORDEN Y FILTROS --

-- 6. Productos con precio mayor a 50000
select * 
from producto
where precio > 50000;

-- 7. Ventas realizadas el 2026-04-02
select *
from ventas
where fecha = '2026-04-02';

-- 8. Productos ordenados de mayor a menor precio
select *
from productos
order by precio desc;

-- 9. Clientes ordenados por nombre
select *
from clientes
order by nombre;

-- 10. Detalles de venta con cantidad >= 2
select *
from detalle_venta
where cantidad >= 2;

-- FUNCIONES DE AGREGACIÓN --

-- 11. Total de clientes
select count(*) --selecciona todo y lo cuenta 
from cliente; -- selecciona leer DESDE clientes

-- 12. Total de productos
select count(*)
from productos;

-- 13. Total de ventas
select count(*) as total_de_ventas -- el 'as' le pone un nombre a la casilla :O debe ser todo en minuscula
from ventas;

-- 14. Precio promedio de productos
select round(avg(precio)) -- avg o average es el promedio, round es para redondear decimales, exxtra
from productos; 

-- 15. Suma total de precios de productos
select sum(precio)
from productos;

-- CONSULTAS CON JOIN --

-- 16. Mostrar venta + nombre del cliente + fecha
select v.id_venta, c.nombre, v.fecha -- seleccionamos los datos
from ventas v -- desde donde se toma la información
join clientes c -- hasta donde se toma la información
    on (v.id_cliente = c.id_cliente); -- la unión entre las dos tablas :O

-- 17. Mostrar detalle de ventas con id_venta + nombre producto + cantidad
select dv.id_venta, p.nombre, dv.cantidad
from productos p join detalle_venta dv
    on (dv.id_producto = p.id_producto);

-- 18. Mostrar nombre del cliente + id de venta + fecha
select c.nombre, v.id_venta, v.fecha
from clientes c join ventas v
    on (c.id_cliente = v.id_cliente);

-- 19. Mostrar nombre del producto + cantidad vendida + id de venta
select p.nombre, dv.cantidad, dv.id_venta
from productos p join detalle_venta dv
    on (p.id_producto = dv.id_producto);

-- 20. Mostrar cuántas ventas ha realizado cada cliente
select c.nombre, count(v.id_cliente)
from clientes c join ventas v
    on (c.id_cliente = v.id_cliente)
group by c.id_cliente; -- agrupa en una misma tabla pero en distintas lineas la información solicitada

-- 21. Mostrar solo los clientes con más de una venta
select c.nombre, count(v.id_cliente)
from clientes c join ventas v
    on (c.id_cliente = v.id_cliente) 
group by c.id_cliente
having count(v.id_cliente) > 1; -- filtra los clientes los cuales que el contador contó más de 1 vez sus id

-- 22. Mostrar cuántas veces aparece cada producto en detalle_venta
select p.nombre, count(dv.id_producto)
from productos p join detalle_venta dv
    on (p.id_producto = dv.id_producto) 
group by p.id_producto;

-- 23. Mostrar solo los productos que aparecen más de una vez
select p.nombre, count(dv.id_producto)
from productos p join detalle_venta dv
    on (p.id_producto = dv.id_producto) 
group by p.id_producto
having count(dv.id_producto) > 1;

-- 24. Mostrar las ventas que tienen más de un producto asociado
select id_venta, count(id_producto)
from detalle_venta
group by id_venta
having count(id_producto) > 1;

-- 25. Mostrar clientes cuya suma total de unidades compradas sea mayor a 2
select v.id_cliente, sum(dv.cantidad)
from ventas v join detalle_venta dv
    on (v.id_venta = dv.id_venta) 
group by v.id_cliente
having count(dv.id_producto) > 2;

-- 26. Consulta trampa que no devuelva resultados
select *
from ventas
where fecha < '2026-04-01';

-- Explicar por qué el resultado vacío es correcto
-- Porque la query filtra por una fecha anterior al primero de abril, y no hay registros que coincidan.

-- Bonus 1. Producto más caro
select nombre, precio
from producto
order by precio desc
limit 1;

-- Bonus 2. Cliente con más ventas
select nombre, sum(v.id_cliente)
from clientes c join ventas v
    on (c.id_cliente = v.id_cliente)
group by c.id_cliente
order by sum(v.id_cliente) desc
limit 1;

-- Bonus 3. fecha con más ventas
select fecha, count(*)
from ventas
group by fecha 
having count(*) = (
    select count(*) from ventas
    group by fecha 
    order by count(*) desc
    limit 1
);
--omg un select dentro de un select!!! se llama subquery :O lo hicimos así porque hay 2 fechas que empatan teniendo más ventas.