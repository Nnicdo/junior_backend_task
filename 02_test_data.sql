
-- Категории (Из примера задания)
/* 
	Перевод sequence на значение максимального существующего ID в таблице
	SELECT setval('categories_category_id_seq', (SELECT MAX(category_id) FROM categories));
*/
INSERT INTO categories (name, parent_id) VALUES
('Бытовая техника', NULL),
('Стиральные машины', 1),
('Холодильники', 1),
('однокамерные', 3),
('двухкамерные', 3),
('Телевизоры', 1),
('Компьютеры', NULL),
('Ноутбуки', 7),
('17“', 8),
('19“', 8),
('Моноблоки', 7);

-- Товары
INSERT INTO products (name, quantity, price, category_id) VALUES
('Стиральная машина Samsung', 10, 29999.00, 2),
('Холодильник Atlant', 5, 45999.00, 3),
('Телевизор LG', 8, 59999.00, 6),
('Ноутбук ASUS 17"', 3, 89999.00, 9),
('Моноблок Apple iMac', 2, 129999.00, 11);

-- Клиенты
INSERT INTO clients (name, address) VALUES
('Иванов Иван', 'Москва, ул. Пушкина, д.1'),
('Петров Петр', 'Санкт-Петербург, Невский пр., д.100');

-- Заказы
INSERT INTO orders (client_id) VALUES
(1), (2), (1);

-- Позиции заказов
INSERT INTO order_products (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 3, 1),
(2, 2, 1),
(3, 4, 2);

-- Просмотр данных в таблицах
/*
	select * from categories;
	select * from products;
	select * from clients;
	select * from orders;
	select * from order_products;
 */

SELECT 
    ct.name AS "Категория",
    COUNT(child.id) AS "Количество дочерних"
FROM category_tree ct
LEFT JOIN categories child ON child.parent_id = ct.id
WHERE ct.level = 0  -- Только категории первого уровня
   OR ct.parent_id IS NOT NULL  -- Или все остальные (для демонстрации)
GROUP BY ct.id, ct.name
ORDER BY ct.id;