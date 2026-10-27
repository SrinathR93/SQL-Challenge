create database sql7challenge;
use sql7challenge;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(100) not null,
    email VARCHAR(100) not null,
    city VARCHAR(50) not null,
    signup_date DATE not null ,
    segment VARCHAR(30) not null
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(100),
    price DECIMAL(10,2),
    cost DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT not null,
    order_date DATE not null,
    status VARCHAR(30),
    channel VARCHAR(50),
    FOREIGN KEY (customer_id)
	REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT not null,
    product_id INT not null,
    quantity INT not null,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT not null,
    payment_method VARCHAR(50),
    payment_status VARCHAR(30),
    amount DECIMAL(10,2),
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);


CREATE TABLE deliveries (
    delivery_id INT PRIMARY KEY,
    order_id INT not null,
    dispatch_date DATE not null,
    delivery_date DATE NULL,
    delivery_status VARCHAR(30),
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);



select * from customers;
select * from products;
select * from orders;
select * from order_items;
select * from payments;
select * from deliveries;