-- 1. Реєстрація нового користувача, з поверненням id та емейу створеного юзера
INSERT INTO users (email, password_hash)
VALUES ('new_email1@gmail.com', 'sicret_pass1')
RETURNING id, email;

-- 2. Зберігаємо його як баєра
INSERT INTO buyers(user_id, first_name, last_name, phone)
VALUES (6, 'Yevheniy', 'Trochun', '+380931234567');

-- 3. Додаємо новий товар
INSERT INTO products(seller_id, category_id, name, price, stock_quantity, sku)
VALUES(2, 1, 'headphones1', 3500, 50, 'EARS-BEST-1');

-- 4. збільшуємо ціну продукту на 10%
UPDATE products SET price = price * 1.1 WHERE id = 6;

-- 5. Знаходимо всі замовлення з сумою більше 1000 та сортуємо їх за спаданням ціни
SELECT id, total_amount FROM orders WHERE total_amount > 1000 ORDER BY total_amount DESC;

-- 6. Видаляємо відгук який нам не подобається
DELETE FROM reviews WHERE id = 4;

-- 7. Зменшуємо ціну продуктів категорії 2 на 5%, якщо поточна вартість більше за 800
UPDATE products SET price =  price * 0.95 WHERE category_id = 2 AND price > 800;

-- 8. Транзакція створення повного шляху замовлення з 2 позицій order_item,
--    списання відповідних одиниць товару з складського обліку, та оформлення
--    замовлення за домашньою адресою користувача

-- 8.1 Перевірка до транзакції
SELECT id, name, price, stock_quantity
FROM products
WHERE id IN (1, 2);

-- 8.2 Транзакція
BEGIN;
INSERT INTO orders (buyer_id, total_amount, status)
VALUES (1, 0.00, 'PENDING');

INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase)
SELECT
  currval('orders_id_seq'),  id, 2, price
FROM products
WHERE id = 1;

INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase)
SELECT
  currval('orders_id_seq'),  id, 1, price
FROM products
WHERE id = 2;

UPDATE products SET stock_quantity = stock_quantity - 2 WHERE id = 1;
UPDATE products SET stock_quantity = stock_quantity - 1 WHERE id = 2;

UPDATE orders SET total_amount = (
  SELECT SUM(quantity * price_at_purchase)
  FROM order_items  
  WHERE order_id = currval('orders_id_seq')
)
WHERE id = currval('orders_id_seq');

INSERT INTO shipments (order_id, status, country, city, street_line, zip_code)
  SELECT
  currval('orders_id_seq'),
  'PENDING',
  country, city, street_line, zip_code
FROM addresses
WHERE user_id = 4 AND is_default = TRUE;

COMMIT;

--8.3 Перевірка після транзакції

SELECT id, name, stock_quantity AS new_quantity
FROM products
WHERE id IN (1, 2);

SELECT
  orders.id, orders.total_amount, orders.status,
  s.city AS shipping_city, s.street_line, COUNT(oi.id) AS items_count
  FROM orders
  JOIN shipments s ON orders.id = s.order_id
  JOIN order_items oi ON orders.id = oi.order_id
  GROUP BY orders.id, orders.total_amount, orders.status, s.city, s.street_line
ORDER BY orders.id DESC
LIMIT 1;