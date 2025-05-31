
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;


SELECT quantity
FROM food
WHERE food_id = 1
FOR UPDATE;


UPDATE food
SET quantity = quantity - 2
WHERE food_id = 1 AND quantity >= 2;


COMMIT;
