CREATE VIEW vw_mostrar_barberos AS (
SELECT nombre
FROM barbero
);

SELECT * 
FROM vw_mostrar_barberos;

CREATE VIEW vista_reservas_detalladas AS
SELECT 
    r.ID_RESERVA,
    c.NOMBRE AS Cliente,
    b.NOMBRE AS Barbero,
    co.NOMBRE_CORTE AS Corte,
    co.PRECIO AS Precio,
    mp.TIPO_DE_PAGO AS Medio_Pago,
    r.FECHA,
    r.HORARIO,
    r.ES_ESPONTANEO
FROM RESERVA r
JOIN CLIENTE c ON r.ID_CLIENTE = c.ID_CLIENTE
JOIN BARBERO b ON r.ID_BARBERO = b.ID_BARBERO
JOIN CORTE co ON r.ID_CORTE = co.ID_CORTE
JOIN MEDIOS_DE_PAGO mp ON r.ID_MEDIO_DE_PAGO = mp.ID_MEDIO_DE_PAGO;

SELECT *
FROM vista_reservas_detalladas;

CREATE VIEW vista_ingresos_diarios AS 
SELECT FECHA, SUM(costo_total) AS total_ingresos
FROM RESERVA
GROUP BY FECHA
ORDER BY FECHA DESC;

SELECT * FROM vista_ingresos_diarios;

CREATE VIEW vw_stock_total AS
SELECT NOMBRE_PRODUCTO, STOCK
FROM PRODUCTO;

SELECT * FROM vw_stock_total;


CREATE VIEW vw_productos_bajo_stock AS
SELECT NOMBRE_PRODUCTO, STOCK
FROM PRODUCTO
WHERE STOCK < 10;

SELECT * FROM vw_productos_bajo_stock;

CREATE VIEW vw_cortes_realizados AS
SELECT b.nombre AS barbero, COUNT(r.id_reserva) AS cortes_realizados
FROM reserva r
INNER JOIN barbero b ON r.id_barbero = b.id_barbero
GROUP BY b.nombre
ORDER BY cortes_realizados DESC;

SELECT * FROM vw_cortes_realizados;