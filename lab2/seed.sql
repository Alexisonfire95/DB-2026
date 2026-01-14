INSERT INTO users (email, password_hash) VALUES
    ('admin@marketplace.com', 'hash123'),
    ('seller1@shop.com', 'hash456'),
    ('seller2@tech.com', 'hash789'),
    ('buyer1@mail.com', 'hashabc'),
    ('buyer2@test.com', 'hashdef');

INSERT INTO administrators (user_id, full_name, access_level) VALUES
    (1, 'Ivan Adminov', 'SUPER');

INSERT INTO sellers (user_id, store_name, tax_id, iban, is_verified) VALUES
    (2, 'Best Gadgets', '12345678', 'UA12345678901234567890123456', TRUE),
    (3, 'Tech World', '87654321', 'UA09876543210987654321098765', TRUE);

INSERT INTO buyers (user_id, first_name, last_name, phone) VALUES
    (4, 'Petro', 'Petrenko', '+380501112233'),
    (5, 'Oksana', 'Koval', '+380979998877');

INSERT INTO categories (name, parent_id) VALUES
    ('Electronics', NULL),
    ('Smartphones', 1),
    ('Laptops', 1),
    ('Clothing', NULL),
    ('Men Shoes', 4);

INSERT INTO addresses (user_id, country, city, street_line, zip_code, is_default) VALUES
    (4, 'Ukraine', 'Kyiv', 'Khreshchatyk 1', '01001', TRUE),
    (4, 'Ukraine', 'Lviv', 'Rynok Sq 10', '79000', FALSE),
    (5, 'Ukraine', 'Odesa', 'Deribasivska 5', '65000', TRUE);

INSERT INTO products (seller_id, category_id, name, description, price, stock_quantity, sku) VALUES
    (1, 2, 'iPhone 15', 'Latest Apple smartphone with A17 chip', 1000.00, 10, 'IPH-15-BLK'),
    (1, 2, 'Samsung S24', 'Android flagship with AI features', 950.00, 15, 'SAM-S24-GRY'),
    (2, 3, 'MacBook Pro', 'Professional laptop with M3 chip', 2000.00, 5, 'MBP-M3-14'),
    (2, 3, 'Dell XPS 15', 'Windows ultrabook for professionals', 1800.00, 8, 'DELL-XPS-15'),
    (1, 2, 'Xiaomi 14', 'Budget flagship smartphone', 700.00, 20, 'MI-14-WHT');

INSERT INTO product_price_history (product_id, price, changed_at) VALUES
    (1, 1100.00, '2025-10-01 10:00:00'),
    (1, 1050.00, '2025-11-15 12:00:00'),
    (1, 1000.00, '2025-12-20 09:00:00'),
    (2, 1000.00, '2025-10-01 10:00:00'),
    (2, 950.00, '2025-12-01 14:00:00'),
    (3, 2200.00, '2025-09-01 08:00:00'),
    (3, 2000.00, '2025-11-25 11:00:00');

INSERT INTO orders (buyer_id, total_amount, status) VALUES
    (1, 1950.00, 'PAID'),
    (1, 2000.00, 'PENDING'), 
    (2, 700.00, 'DELIVERED'),
    (2, 1800.00, 'SHIPPED');

INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase) VALUES
    (1, 1, 1, 1000.00),
    (1, 2, 1, 950.00), 
    (2, 3, 1, 2000.00),
    (3, 5, 1, 700.00),
    (4, 4, 1, 1800.00);

INSERT INTO payments (order_id, amount, status) VALUES
    (1, 1950.00, 'SUCCESS'),
    (2, 2000.00, 'PENDING'),
    (3, 700.00, 'SUCCESS'),
    (4, 1800.00, 'SUCCESS');

INSERT INTO shipments (order_id, address_id, status) VALUES
    (1, 1, 'SHIPPED'),
    (3, 3, 'DELIVERED'),
    (4, 3, 'SHIPPED');

INSERT INTO reviews (product_id, buyer_id, rating, comment) VALUES
    (1, 1, 5, 'Great phone! Excellent camera and performance.'),
    (2, 1, 4, 'Good Android phone, but battery could be better.'),
    (5, 2, 4, 'Good value for money, fast delivery.'),
    (4, 2, 5, 'Best laptop I ever had!');
