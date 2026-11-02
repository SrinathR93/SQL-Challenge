


USE Sql7Challenge;



-- Q1. Order Status Distribution
-- How many orders belong to each order status?


SELECT
    status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY status
ORDER BY total_orders DESC;


-- Q2. Delivery Status Distribution
-- How many deliveries belong to each delivery status?

SELECT
    delivery_status,
    COUNT(*) AS total_deliveries
FROM deliveries
GROUP BY delivery_status
ORDER BY total_deliveries DESC;



-- Q3. Average Delivery Time
-- Average days taken for completed deliveries


SELECT
    AVG(DATEDIFF(delivery_date, dispatch_date))
        AS average_delivery_days
FROM deliveries
WHERE LOWER(delivery_status) IN ('delivered', 'completed')
  AND delivery_date IS NOT NULL
  AND dispatch_date IS NOT NULL;



-- Q4. Top 10 Longest Deliveries
-- Which 10 delivered orders took the longest to arrive?


SELECT
    delivery_id,
    order_id,
    dispatch_date,
    delivery_date,
    DATEDIFF(delivery_date, dispatch_date)
        AS delivery_days
FROM deliveries
WHERE LOWER(delivery_status) IN ('delivered', 'completed')
  AND delivery_date IS NOT NULL
  AND dispatch_date IS NOT NULL
ORDER BY delivery_days DESC
LIMIT 10;



-- Q5. Monthly Order Volumes
-- How does order volume change month by month?


SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month ASC;



-- Q6. Payment Status Distribution
-- How are payment records distributed across statuses?


SELECT
payment_status,
COUNT(*) AS total_payments
FROM payments
GROUP BY payment_status
ORDER BY total_payments DESC;



-- Q7. Identify Delayed Deliveries (> 5 Days)
-- Which completed deliveries took longer than five days?


SELECT
    delivery_id,
    order_id,
    dispatch_date,
    delivery_date,
    DATEDIFF(delivery_date, dispatch_date)
        AS delivery_days
FROM deliveries
WHERE LOWER(delivery_status) IN ('delivered', 'completed')
  AND delivery_date IS NOT NULL
  AND dispatch_date IS NOT NULL
  AND DATEDIFF(delivery_date, dispatch_date) > 5
ORDER BY delivery_days DESC;



-- Q8. Compare Delivery Performance by City
-- Which customer cities have the longest average delivery times?


SELECT
c.city,
    AVG(DATEDIFF(d.delivery_date, d.dispatch_date))
        AS average_delivery_days,
    COUNT(d.delivery_id) AS total_deliveries
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN deliveries d
    ON o.order_id = d.order_id
WHERE LOWER(d.delivery_status) IN ('delivered', 'completed')
  AND d.delivery_date IS NOT NULL
  AND d.dispatch_date IS NOT NULL
GROUP BY c.city
ORDER BY average_delivery_days DESC;



