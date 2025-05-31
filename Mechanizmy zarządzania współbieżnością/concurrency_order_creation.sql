
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;


SELECT quantity
FROM food
WHERE food_id = 2
FOR UPDATE;


DO $$
DECLARE
    available INT;
BEGIN
    SELECT quantity INTO available
    FROM food
    WHERE food_id = 2;

    IF available >= 3 THEN
       
        INSERT INTO orders (user_id, date, total_price, city, street, first_name, surname, order_number, status, phoneNumber)
        VALUES (1, CURRENT_DATE, 45.00, 'Warszawa', 'Miodowa 2', 'Jan', 'Kowalski', 'ORD12345', 'Złożone', 123456789);

       
        INSERT INTO order_list (orders_id, food_id, user_id, quantity, unit_price)
        VALUES (currval('orders_orders_id_seq'), 2, 1, 3, 15.00);

        
        UPDATE food
        SET quantity = quantity - 3
        WHERE food_id = 2;
    ELSE
        RAISE NOTICE 'Niewystarczający stan magazynowy';
    END IF;
END;
$$;

COMMIT;
