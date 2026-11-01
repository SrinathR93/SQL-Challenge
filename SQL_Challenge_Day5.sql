


USE sql7challenge;


-- Q1. Total Customers
-- Count total customers registered in database

SELECT COUNT(*) AS total_customers
FROM customers;


-- Q2. Customers by City
-- Count customers in each city

SELECT
    city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;


-- Q3. Top 10 Customers by Order Count
-- Highest number of non-cancelled orders

SELECT
    c.customer_id,
    c.full_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE LOWER(o.status) <> 'cancelled'
GROUP BY c.customer_id, c.full_name
ORDER BY total_orders DESC
LIMIT 10;


-- Q4. Customer Spending
-- Total spending of each customer
-- Excluding cancelled orders

SELECT
    c.customer_id,
    c.full_name,
    COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_spending
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
    AND LOWER(o.status) <> 'cancelled'
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.full_name
ORDER BY total_spending DESC;


-- Q5. Average Spending per Customer
-- Customers with at least one non-cancelled order

SELECT
    AVG(customer_spending) AS average_spending
FROM (
    SELECT
        o.customer_id,
        SUM(oi.quantity * oi.unit_price) AS customer_spending
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE LOWER(o.status) <> 'cancelled'
    GROUP BY o.customer_id
) AS spending;


-- Q6. Customers with More Than 5 Orders
-- Find customers with more than five non-cancelled orders

SELECT
    c.customer_id,
    c.full_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE LOWER(o.status) <> 'cancelled'
GROUP BY c.customer_id, c.full_name
HAVING COUNT(o.order_id) > 5
ORDER BY total_orders DESC;


-- Q7. Customer Segment Analysis
-- Count customers in each segment

SELECT
    segment,
    COUNT(*) AS total_customers
FROM customers
GROUP BY segment
ORDER BY total_customers DESC;


-- Q8. Average Orders per Customer
-- Include customers with zero non-cancelled orders

SELECT
    AVG(order_count) AS average_orders_per_customer
FROM (
    SELECT
        c.customer_id,
        COUNT(o.order_id) AS order_count
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
        AND LOWER(o.status) <> 'cancelled'
    GROUP BY c.customer_id
) AS customer_orders;


-- Q9. Top 10 Customers by Spending
-- Highest item sales value from non-cancelled orders

SELECT
    c.customer_id,
    c.full_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE LOWER(o.status) <> 'cancelled'
GROUP BY c.customer_id, c.full_name
ORDER BY total_sales DESC
LIMIT 10;


-- Q10. Customer Signups by Month
-- Count monthly customer registrations
-- Display results chronologically

SELECT
    DATE_FORMAT(signup_date, '%Y-%m') AS signup_month,
    COUNT(customer_id) AS total_signups
FROM customers
GROUP BY DATE_FORMAT(signup_date, '%Y-%m')
ORDER BY signup_month ASC;


