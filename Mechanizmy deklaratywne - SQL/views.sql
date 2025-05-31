CREATE OR REPLACE VIEW view_order_details AS
SELECT
    o.orders_id,
    COALESCE(u.username, g.username) AS customer_name,
    o.order_number,
    o.date,
    o.total_price,
    o.status,
    ol.food_id,
    f.name AS food_name,
    ol.quantity,
    ol.unit_price
FROM orders o
LEFT JOIN "user" u ON o.user_id = u.user_id
LEFT JOIN guest g ON o.guest_id = g.guest_id
JOIN order_list ol ON o.orders_id = ol.orders_id
JOIN food f ON ol.food_id = f.food_id;


CREATE OR REPLACE VIEW view_food_ratings AS
SELECT
    r.rate_id,
    f.name AS food_name,
    COALESCE(u.username, g.username) AS reviewer,
    r.rate
FROM rating r
JOIN food f ON r.food_id = f.food_id
LEFT JOIN "user" u ON r.user_id = u.user_id
LEFT JOIN guest g ON r.guest_id = g.guest_id;


CREATE OR REPLACE VIEW view_active_food_coupons AS
SELECT
    f.name AS food_name,
    c.name AS coupon_name,
    c.description,
    c.discount_type,
    c.discount_value,
    c.valid_until
FROM food_coupons fc
JOIN food f ON fc.food_id = f.food_id
JOIN coupon c ON fc.coupon_id = c.coupon_id
WHERE CURRENT_DATE BETWEEN c.valid_from AND c.valid_until;


CREATE OR REPLACE VIEW view_user_order_summary AS
SELECT
    u.user_id,
    u.username,
    COUNT(o.orders_id) AS total_orders,
    SUM(o.total_price) AS total_spent
FROM "user" u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id;


CREATE OR REPLACE VIEW view_cart_contents AS
SELECT
    ci.cart_item_id,
    COALESCE(u.username, g.username) AS cart_owner,
    f.name AS food_name,
    f.price,
    ci.quantity,
    (f.price * ci.quantity) AS total_price,
    sc.date AS added_to_cart
FROM cart_item ci
JOIN shopping_cart sc ON ci.shopping_cart_id = sc.shopping_cart_id
JOIN food f ON ci.food_id = f.food_id
LEFT JOIN "user" u ON ci.user_id = u.user_id
LEFT JOIN guest g ON ci.guest_id = g.guest_id;
