
-- Категории
create table categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(255) not null,
    parent_id INTEGER references categories(category_id) ON DELETE cascade
);

-- Номенклатура товаров
create table products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(255) not null,
    quantity INTEGER not null check (quantity >= 0),
    price DECIMAL(10,2) not null check (price >= 0),
    category_id INTEGER not null references categories(category_id)
);

-- Клиенты
CREATE table clients (
    client_id SERIAL PRIMARY KEY,
    name VARCHAR(255) not null,
    address TEXT not null
);

-- Заказы
CREATE table orders (
    order_id SERIAL PRIMARY KEY,
    client_id INTEGER not null references clients(client_id),
    order_date TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP
);

-- Связующая таблица (из-за связи многие ко многим)
create table order_products (
    order_id INTEGER references orders(order_id) on delete cascade,
    product_id INTEGER references products(product_id),
    quantity INTEGER not null check (quantity > 0),
    PRIMARY KEY (order_id, product_id)
);

-- Индексы для улучшения производительности
create index idx_categories_parent_id ON categories(parent_id);
create index idx_products_category_id ON products(category_id);
create index idx_orders_client_id ON orders(client_id);
create index idx_order_items_order_id ON order_products(order_id);
create index idx_order_items_product_id ON order_products(product_id);


-- Удаление таблиц

/*
	drop table order_products;
	drop table orders;
	drop table clients;
	drop table products;
	drop table categories;
*/
