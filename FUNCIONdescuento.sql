SELECT aplicar_descuento(1, 10); -- Esto aplicará un 10% de descuento a la compra con ID 1
use guru;

CREATE FUNCTION aplicar_descuento(id_comp INT, descuento DECIMAL(5,2)) RETURNS DECIMAL(10,2)
BEGIN
    DECLARE total DECIMAL(10,2);
    DECLARE descuento_aplicado DECIMAL(10,2);
    
    -- Obtener el total de la compra
    SELECT SUM(p.precio * dc.cantidad)
    INTO total
    FROM compra c
    INNER JOIN detalle_compra dc ON c.id_comp = dc.id_comp
    INNER JOIN producto p ON dc.id_prod = p.id_prod
    WHERE c.id_comp = id_comp;
    
    -- Calcular el descuento
    SET descuento_aplicado = total * (descuento / 100);
    
    -- Aplicar el descuento al total
    SET total = total - descuento_aplicado;
    
    RETURN total;
END;