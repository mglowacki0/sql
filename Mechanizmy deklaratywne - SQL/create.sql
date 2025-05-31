CREATE TYPE discount_enum AS ENUM ('percent', 'amount');


CREATE TABLE category (
    category_id BIGSERIAL PRIMARY KEY,
    categories VARCHAR(255) NOT NULL
);


CREATE TABLE food (
    food_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255),
    description VARCHAR(2000),
    category_id BIGINT NOT NULL,
    price DOUBLE PRECISION,
    quantity INT,
    file BYTEA,
    FOREIGN KEY (category_id) REFERENCES category(category_id) ON DELETE CASCADE
);


CREATE TABLE coupon (
    coupon_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255),
    description VARCHAR(1000),
    discount_type discount_enum,
    discount_value DOUBLE PRECISION,
    valid_from DATE,
    valid_until DATE
);


CREATE TABLE food_coupons (
    food_id BIGINT NOT NULL,
    coupon_id BIGINT NOT NULL,
    PRIMARY KEY (food_id, coupon_id),
    FOREIGN KEY (food_id) REFERENCES food(food_id) ON DELETE CASCADE,
    FOREIGN KEY (coupon_id) REFERENCES coupon(coupon_id) ON DELETE CASCADE
);


CREATE TABLE "user" (
    user_id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    enabled BOOLEAN DEFAULT TRUE,
    date DATE NOT NULL DEFAULT CURRENT_DATE,
    reset_password_token VARCHAR(255),
    username VARCHAR(255) NOT NULL,
    verification_code VARCHAR(255)
);


CREATE TABLE roles (
    role_id BIGSERIAL PRIMARY KEY,
    role VARCHAR(255) NOT NULL
);


CREATE TABLE users_roles (
    user_id BIGINT NOT NULL,
    role_id BIGINT NOT NULL,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES roles(role_id) ON DELETE CASCADE
);


CREATE TABLE guest (
    guest_id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255),
    password VARCHAR(255),
    provider_id VARCHAR(255),
    username VARCHAR(255),
    enabled BOOLEAN DEFAULT TRUE
);


CREATE TABLE shopping_cart (
    shopping_cart_id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    guest_id BIGINT NOT NULL,
    date DATE NOT NULL DEFAULT CURRENT_DATE,
    FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE CASCADE,
    FOREIGN KEY (guest_id) REFERENCES guest(guest_id) ON DELETE CASCADE
);


CREATE TABLE cart_item (
    cart_item_id BIGSERIAL PRIMARY KEY,
    shopping_cart_id BIGINT NOT NULL,
    food_id BIGINT NOT NULL,
    guest_id BIGINT,
    user_id BIGINT,
    date DATE DEFAULT CURRENT_DATE,
    quantity INT,
    items_id BIGINT,
    FOREIGN KEY (shopping_cart_id) REFERENCES shopping_cart(shopping_cart_id) ON DELETE CASCADE,
    FOREIGN KEY (food_id) REFERENCES food(food_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE SET NULL,
    FOREIGN KEY (guest_id) REFERENCES guest(guest_id) ON DELETE SET NULL
);


CREATE TABLE orders (
    orders_id BIGSERIAL PRIMARY KEY,
    user_id BIGINT,
    guest_id BIGINT,
    date DATE DEFAULT CURRENT_DATE,
    phoneNumber BIGINT,
    total_price DOUBLE PRECISION,
    city VARCHAR(255),
    first_name VARCHAR(255),
    order_number VARCHAR(255),
    status VARCHAR(255),
    street VARCHAR(255),
    surname VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE SET NULL,
    FOREIGN KEY (guest_id) REFERENCES guest(guest_id) ON DELETE SET NULL
);


CREATE TABLE order_list (
    order_list_id BIGSERIAL PRIMARY KEY,
    orders_id BIGINT NOT NULL,
    food_id BIGINT NOT NULL,
    guest_id BIGINT,
    user_id BIGINT,
    quantity INT,
    unit_price DOUBLE PRECISION,
    FOREIGN KEY (orders_id) REFERENCES orders(orders_id) ON DELETE CASCADE,
    FOREIGN KEY (food_id) REFERENCES food(food_id) ON DELETE CASCADE,
    FOREIGN KEY (guest_id) REFERENCES guest(guest_id) ON DELETE SET NULL,
    FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE SET NULL
);


CREATE TABLE rating (
    rate_id BIGSERIAL PRIMARY KEY,
    rating_id BIGINT NOT NULL,
    guest_id BIGINT,
    user_id BIGINT,
    food_id BIGINT,
    rate DOUBLE PRECISION,
    FOREIGN KEY (food_id) REFERENCES food(food_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE SET NULL,
    FOREIGN KEY (guest_id) REFERENCES guest(guest_id) ON DELETE SET NULL,
    CONSTRAINT unique_rating UNIQUE (user_id, guest_id, food_id)
);


CREATE TABLE page_rating (
    page_rating_id BIGSERIAL PRIMARY KEY,
    user_id BIGINT UNIQUE,
    guest_id BIGINT UNIQUE,
    rate DOUBLE PRECISION,
    opinion VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE CASCADE,
    FOREIGN KEY (guest_id) REFERENCES guest(guest_id) ON DELETE CASCADE
);


CREATE TABLE contact (
    contact_id BIGSERIAL PRIMARY KEY,
    guest_id BIGINT,
    user_id BIGINT,
    date DATE DEFAULT CURRENT_DATE,
    description VARCHAR(2000),
    title VARCHAR(255),
    file BYTEA,
    FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE CASCADE,
    FOREIGN KEY (guest_id) REFERENCES guest(guest_id) ON DELETE CASCADE
);

