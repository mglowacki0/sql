INSERT INTO category (categories) VALUES
('Pizza'),
('Sushi'),
('Burgery');


INSERT INTO "user" (email, password, username) VALUES
('john@example.com', 'password123', 'johnny'),
('alice@example.com', 'password456', 'alice');


INSERT INTO roles (role) VALUES
('USER'),
('ADMIN');


INSERT INTO users_roles (user_id, role_id) VALUES
(1, 1),
(2, 2);


INSERT INTO guest (email, password, username) VALUES
('guest1@example.com', 'pass123', 'guest1'),
('guest2@example.com', 'pass456', 'guest2');


INSERT INTO food (name, description, category_id, price, quantity) VALUES
('Margherita', 'Pizza z sosem pomidorowym i mozzarellą', 1, 25.50, 100),
('California Roll', 'Sushi z krabem i awokado', 2, 32.00, 80),
('Cheeseburger', 'Burger z serem cheddar i wołowiną', 3, 28.00, 50);


INSERT INTO coupon (name, description, discount_type, discount_value, valid_from, valid_until) VALUES
('ZNIŻKA10', '10% zniżki', 'percent', 10, '2025-01-01', '2025-12-31'),
('5PLN', '5 zł zniżki', 'amount', 5, '2025-01-01', '2025-06-30');


INSERT INTO food_coupons (food_id, coupon_id) VALUES
(1, 1),
(2, 2);


INSERT INTO shopping_cart (user_id, guest_id) VALUES
(1, 1),
(2, 2);


INSERT INTO cart_item (shopping_cart_id, food_id, guest_id, user_id, quantity, items_id) VALUES
(1, 1, 1, 1, 2, 101),
(2, 2, 2, 2, 1, 102);


INSERT INTO orders (user_id, guest_id, phoneNumber, total_price, city, first_name, order_number, status, street, surname) VALUES
(1, 1, 123456789, 51.00, 'Warszawa', 'Jan', 'ORD001', 'Przyjęte', 'ul. Kwiatowa 5', 'Kowalski'),
(2, 2, 987654321, 32.00, 'Kraków', 'Anna', 'ORD002', 'W realizacji', 'ul. Wiosny 12', 'Nowak');


INSERT INTO order_list (orders_id, food_id, guest_id, user_id, quantity, unit_price) VALUES
(1, 1, 1, 1, 2, 25.50),
(2, 2, 2, 2, 1, 32.00);


INSERT INTO rating (rating_id, guest_id, user_id, food_id, rate) VALUES
(1, 1, NULL, 1, 4.5),
(2, NULL, 2, 2, 5.0);


INSERT INTO page_rating (user_id, rate, opinion) VALUES
(1, 4.0, 'Dobra strona!');

INSERT INTO page_rating (guest_id, rate, opinion) VALUES
(2, 5.0, 'Szybkie i wygodne zakupy.');


INSERT INTO contact (guest_id, user_id, description, title) VALUES
(1, NULL, 'Nie mogę zrealizować zamówienia.', 'Problem z zamówieniem'),
(NULL, 2, 'Proszę o zmianę adresu.', 'Zmiana danych');
