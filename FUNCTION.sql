DELIMITER $$

CREATE FUNCTION obtener_ingresos(fecha_inicio DATE, fecha_fin DATE) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_ingresos DECIMAL(10,2);
    
    SELECT SUM(COSTO_TOTAL) 
    INTO total_ingresos 
    FROM RESERVA 
    WHERE FECHA BETWEEN fecha_inicio AND fecha_fin;

    RETURN IFNULL(total_ingresos, 0);
END$$

DELIMITER ;

SELECT obtener_ingresos('2025-03-1', '2025-03-31') AS ingresos_enero;


DELIMITER $$

CREATE FUNCTION cantidad_cortes_barbero(id_barbero_f INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_cortes INT;
    
    SELECT COUNT(*) 
    INTO total_cortes 
    FROM RESERVA 
    WHERE ID_BARBERO = id_barbero_f;

    RETURN total_cortes;
END$$

DELIMITER ;

DROP FUNCTION IF EXISTS cantidad_cortes_barbero;

SELECT cantidad_cortes_barbero(6) AS cant_cortes;


DELIMITER $$

CREATE FUNCTION stock_total_proveedor(id_proveedor_f INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_stock INT;
    
    SELECT SUM(STOCK) 
    INTO total_stock 
    FROM PRODUCTO 
    WHERE ID_PROVEEDOR = id_proveedor_f;

    RETURN IFNULL(total_stock, 0);
END$$

DELIMITER ;

DROP FUNCTION IF EXISTS stock_total_proveedor;

SELECT stock_total_proveedor(1);

DELIMITER $$

CREATE FUNCTION obtener_precio_corte(id_corte INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE precio_F DECIMAL(10,2) DEFAULT 0;
    
    SELECT PRECIO 
    INTO precio_F 
    FROM CORTE 
    WHERE ID_CORTE = id_corte
    LIMIT 1;

    RETURN precio_F;
END$$

DELIMITER ;



SELECT * FROM corte WHERE ID_CORTE = 2; -- Cambia "1" por el ID que estás probando

DROP FUNCTION IF EXISTS OBTENER_PRECIO_CORTE;

SELECT obtener_precio_corte(2);

