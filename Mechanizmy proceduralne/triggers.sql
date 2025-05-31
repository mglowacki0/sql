CREATE OR REPLACE FUNCTION set_shopping_cart_date()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.date IS NULL THEN
        NEW.date := CURRENT_DATE;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_set_cart_date
BEFORE INSERT ON shopping_cart
FOR EACH ROW
EXECUTE FUNCTION set_shopping_cart_date();



CREATE OR REPLACE FUNCTION reduce_food_quantity()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE food
    SET quantity = quantity - NEW.quantity
    WHERE food_id = NEW.food_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_reduce_food_quantity
AFTER INSERT ON order_list
FOR EACH ROW
EXECUTE FUNCTION reduce_food_quantity();



CREATE OR REPLACE FUNCTION validate_rating_range()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.rate < 0 OR NEW.rate > 5 THEN
        RAISE EXCEPTION 'Ocena musi być w zakresie od 0 do 5';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validate_rating_range
BEFORE INSERT OR UPDATE ON rating
FOR EACH ROW
EXECUTE FUNCTION validate_rating_range();



CREATE OR REPLACE FUNCTION set_default_order_status()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status IS NULL THEN
        NEW.status := 'Złożone';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_set_default_order_status
BEFORE INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION set_default_order_status();
