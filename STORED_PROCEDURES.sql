DELIMITER $$

CREATE PROCEDURE registrar_reserva(
    IN p_id_cliente INT,
    IN p_id_barbero INT,
    IN p_id_corte INT,
    IN p_id_medio_pago INT,
    IN p_fecha DATE,
    IN p_horario TIME,
    IN p_costo_total DECIMAL(8,2),
    IN p_es_espontaneo TINYINT
)
BEGIN
    -- Verificar si algún parámetro obligatorio es NULL
    IF p_id_cliente IS NULL OR p_id_barbero IS NULL OR 
       p_id_corte IS NULL OR p_id_medio_pago IS NULL OR 
       p_fecha IS NULL OR p_horario IS NULL OR 
       p_costo_total IS NULL OR p_es_espontaneo IS NULL THEN
       
       SIGNAL SQLSTATE '45000'
       SET MESSAGE_TEXT = 'Error: Ningún campo puede ser NULL';
    ELSE
       -- Insertar la reserva si todos los valores son válidos
       INSERT INTO RESERVA (ID_CLIENTE, ID_BARBERO, ID_CORTE, ID_MEDIO_DE_PAGO, FECHA, HORARIO, COSTO_TOTAL, ES_ESPONTANEO)
       VALUES (p_id_cliente, p_id_barbero, p_id_corte, p_id_medio_pago, p_fecha, p_horario, p_costo_total, p_es_espontaneo);
    END IF;
    
END$$

DELIMITER ;


DROP PROCEDURE if exists registrar_reserva;
CALL registrar_reserva(10, 1, 2, 1, '2025-03-01', '10:00:00', 1500.00, 0);
CALL registrar_reserva(14, 3, 5, 2, '2025-03-28', '10:00:00', 8500.00, 1);

DELIMITER $$

CREATE PROCEDURE obtener_reservas_cliente(
    IN p_id_cliente INT
)
BEGIN
    SELECT R.ID_RESERVA, R.FECHA, R.HORARIO, B.NOMBRE AS BARBERO,CT.NOMBRE AS NOMBRE_CLIENTE, C.NOMBRE_CORTE, R.COSTO_TOTAL, M.TIPO_DE_PAGO
    FROM RESERVA R
    JOIN BARBERO B ON R.ID_BARBERO = B.ID_BARBERO
    JOIN CLIENTE CT ON R.ID_CLIENTE = CT.ID_CLIENTE
    JOIN CORTE C ON R.ID_CORTE = C.ID_CORTE
    JOIN MEDIOS_DE_PAGO M ON R.ID_MEDIO_DE_PAGO = M.ID_MEDIO_DE_PAGO
    WHERE R.ID_CLIENTE = p_id_cliente
    ORDER BY R.FECHA DESC, R.HORARIO DESC;
END$$

DELIMITER ;

DROP PROCEDURE IF EXISTS obtener_reservas_cliente;

CALL obtener_reservas_cliente(12);


DELIMITER $$

CREATE PROCEDURE obtener_reservas_barbero(
    IN p_id_barbero INT, 
    IN p_fecha DATE
)
BEGIN
    SELECT 
        r.ID_RESERVA, 
        c.NOMBRE AS Cliente, 
        co.NOMBRE_CORTE AS Corte, 
        r.HORARIO, 
        r.COSTO_TOTAL, 
        r.ES_ESPONTANEO
    FROM RESERVA r
    JOIN CLIENTE c ON r.ID_CLIENTE = c.ID_CLIENTE
    JOIN CORTE co ON r.ID_CORTE = co.ID_CORTE
    WHERE r.ID_BARBERO = p_id_barbero
    AND r.FECHA = p_fecha
    ORDER BY r.HORARIO;
END $$

DELIMITER ;

CALL obtener_reservas_barbero(6, '2025-03-25');
