--1) 8 запитів з агрегатними функціями

-- 1.1 Вивести кількість юзерів
SELECT COUNT(*) AS all_user
FROM users;

-- 1.2 Вивести кількість активних товарів
SELECT COUNT(*) AS active_products
FROM products
WHERE is_active = true;

-- 1.3 Вивести ціну найдешевшого та найдорожчого товару в категорії Смартфони (categorie.id = 2)
SELECT MIN(price) AS min_price, MAX(price) AS max_price
FROM products
WHERE category_id = 2;

-- 1.4 Вивести кількість товарів у кожній категорії
SELECT category_id, COUNT(*)
FROM products
GROUP BY category_id;

-- 1.5 Вивести кількість замовлень в кожному статусі
SELECT status, COUNT(*)
FROM orders
GROUP BY status;

-- 1.6 Вивести загальну кількість одиниць товару кожного продавця
SELECT seller_id, SUM(stock_quantity)
FROM products
GROUP BY seller_id;

-- 1.7 Вивести популярні категорії(фті що мають більше 2 продуктів)
SELECT category_id, COUNT(*)
FROM products
GROUP BY category_id
HAVING COUNT(*) > 2;

-- 1.8 Показати скільки користувачів реєструвалися кожного дня
SELECT created_at::DATE, COUNT(*) AS users_signed_up
FROM users
GROUP BY created_at::DATE;

--2) 6 запитів з JOIN

--2.1 Вибрати всі товари і для кожного вивести його категорію(назву категорії, а не id)
SELECT p.name AS naming, c.name AS category
FROM products p
       JOIN categories c
            ON p.category_id = c.id;

--2.2 Виводимо всіх юзерів, у продавців з них вказуємо назву магазину
SELECT u.email AS email, s.store_name AS shop
FROM users u
       LEFT JOIN sellers s
                 ON u.id = s.user_id;

--2.3 Вивести 3 товари з найбільшим середнім рейтингом
SELECT p.name, AVG(rating) AS rate
FROM products p
       JOIN reviews r
            ON p.id = r.product_id
GROUP BY p.name
ORDER BY AVG(rating) DESC
LIMIT 3;

-- 2.4 Вивести сумарну вартість товару кожного магазину на складі
SELECT s.store_name, SUM(p.price * p.stock_quantity)
FROM sellers s
       JOIN products p
            ON p.seller_id = s.id
GROUP BY s.store_name;

-- 2.5 Вивести 4 товари з найменшою кількістю продаж
SELECT p.id, p.name AS name, COALESCE(SUM(oi.quantity), 0) AS selling
FROM products p
       LEFT JOIN order_items oi
                 ON p.id = oi.product_id
GROUP BY p.id
ORDER BY selling
LIMIT 4;

--2.6 Виводить деталі замовлення(ім'я покупця, номер замовлення, назва продукту, кількість та ціну)
SELECT o.id         AS order_id,
       b.first_name AS buyer_name,
       p.name       AS product_name,
       oi.quantity,
       oi.price_at_purchase
FROM orders o
       JOIN buyers b ON o.buyer_id = b.id
       JOIN order_items oi ON o.id = oi.order_id
       JOIN products p ON oi.product_id = p.id;

--3) 6 запитів з під запитами

--3.1 Знаходимо всі замовлення, сума яких більше за середню вартість замовлення
SELECT id, total_amount FROM orders
       WHERE total_amount > (SELECT AVG(total_amount) FROM orders);

--3.2 Знаходимо email покупців що купували категорію "Smartphones"
SELECT email FROM users
      WHERE id IN (
      SELECT b.user_id
      FROM buyers b
      JOIN orders o ON b.id = o.buyer_id
      JOIN order_items oi ON o.id = oi.order_id
      JOIN products p ON oi.product_id = p.id
      JOIN categories c ON p.category_id = c.id
      WHERE c.name = 'Smartphones');

--3.3 Знаходимо всі товари яких не зробили жодного замовлення
SELECT id, name FROM products
    WHERE id NOT IN (SELECT product_id FROM order_items);

--3.4 Для кожного клієнта знаходимо дату його останнього замовлення
SELECT id, first_name,
       (SELECT MAX(created_at)
        FROM orders
        WHERE orders.buyer_id = buyers.id) AS Last_date
FROM buyers;

--3.5 Знаходимо найдорожчий товар у кожній категорії
SELECT id, price, name, category_id FROM products p1
WHERE price = (
    SELECT MAX(price)
    FROM products p2
    WHERE p2.category_id = p1.category_id)
ORDER BY price DESC;

--3.6 Знаходимо середню кількість одиниць товарів у замовленні
SELECT AVG(num_units)AS avg_quantity
FROM ( SELECT SUM(quantity) AS num_units
       FROM order_items
       GROUP BY order_id) AS data;
