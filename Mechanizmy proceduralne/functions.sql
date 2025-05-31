
CREATE OR REPLACE FUNCTION calculate_order_total(p_order_id BIGINT)
RETURNS DOUBLE PRECISION AS $$
DECLARE
    total DOUBLE PRECISION := 0;
BEGIN
    SELECT SUM(quantity * unit_price)
    INTO total
    FROM order_list
    WHERE orders_id = p_order_id;

    RETURN COALESCE(total, 0);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_food_rating(
    p_food_id BIGINT,
    p_user_id BIGINT,
    p_guest_id BIGINT,
    p_rate DOUBLE PRECISION
)
RETURNS TEXT AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM rating
        WHERE food_id = p_food_id AND user_id IS NOT DISTINCT FROM p_user_id AND guest_id IS NOT DISTINCT FROM p_guest_id
    ) THEN
        RETURN 'Ocena już istnieje.';
    END IF;

    INSERT INTO rating (rating_id, food_id, user_id, guest_id, rate)
    VALUES (DEFAULT, p_food_id, p_user_id, p_guest_id, p_rate);

    RETURN 'Ocena dodana.';
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION is_coupon_active(p_coupon_id BIGINT)
RETURNS BOOLEAN AS $$
DECLARE
    is_active BOOLEAN;
BEGIN
    SELECT CURRENT_DATE BETWEEN valid_from AND valid_until
    INTO is_active
    FROM coupon
    WHERE coupon_id = p_coupon_id;

    RETURN COALESCE(is_active, FALSE);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION count_cart_items(p_user_id BIGINT)
RETURNS INT AS $$
DECLARE
    item_count INT;
BEGIN
    SELECT COALESCE(SUM(quantity), 0)
    INTO item_count
    FROM cart_item
    WHERE user_id = p_user_id;

    RETURN item_count;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION get_max_food_rating(p_food_id BIGINT)
RETURNS DOUBLE PRECISION AS $$
DECLARE
    max_rating DOUBLE PRECISION;
BEGIN
    SELECT MAX(rate)
    INTO max_rating
    FROM rating
    WHERE food_id = p_food_id;

    RETURN COALESCE(max_rating, 0);
END;
$$ LANGUAGE plpgsql;
