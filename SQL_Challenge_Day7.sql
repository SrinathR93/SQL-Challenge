use sql7challenge;

Q1.Total orders and order status Distribution 

SELECT COUNT(*) AS total_orders
FROM orders GROUP BY status;

Q2. Total Sales Value from Non-Cancelled Orders

SELECT SUM(oi.quantity * oi.unit_price) AS total_sales
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
WHERE LOWER(o.status) <> 'cancelled';

Months with the Highest and Lowest Order Volumes

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY total_orders DESC;


SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_month
ORDER BY total_orders DESC
LIMIT 1;

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_month
ORDER BY total_orders DESC
LIMIT 1;

  Q4. Sales Value by Sales Channel

SELECT
    o.channel,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
WHERE LOWER(o.status) <> 'cancelled'
GROUP BY o.channel
ORDER BY total_sales DESC;

Q5. Sales Value by Product Category
SELECT
    p.category,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
JOIN orders o
ON oi.order_id = o.order_id
WHERE LOWER(o.status) <> 'cancelled'
GROUP BY p.category
ORDER BY total_sales DESC;

Q6. Top 10 Products by Sales Value

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
JOIN orders o
ON oi.order_id = o.order_id
WHERE LOWER(o.status) <> 'cancelled'
GROUP BY p.product_id, p.product_name
ORDER BY total_sales DESC
LIMIT 10;

Q7. Products with No Sales from Non-Cancelled Orders

SELECT
    p.product_id,
    p.product_name,
    p.category
FROM products p
LEFT JOIN order_items oi
ON p.product_id = oi.product_id
LEFT JOIN orders o
ON oi.order_id = o.order_id
AND LOWER(o.status) <> 'cancelled'
GROUP BY p.product_id, p.product_name, p.category
HAVING COUNT(o.order_id) = 0;


Q8. Estimated Product Profit by Category

SELECT
    p.category,
    SUM((oi.unit_price - p.cost) * oi.quantity) AS estimated_profit
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
JOIN orders o
ON oi.order_id = o.order_id
WHERE LOWER(o.status) <> 'cancelled'
GROUP BY p.category
ORDER BY estimated_profit DESC;

Q9. Top 10 Customers by Non-Cancelled Order Count

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



Q10. Top 10 Customers by Calculated Spending

SELECT
    c.customer_id,
    c.full_name,
    SUM(oi.quantity * oi.unit_price) AS total_spending
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
WHERE LOWER(o.status) <> 'cancelled'
GROUP BY c.customer_id, c.full_name
ORDER BY total_spending DESC
LIMIT 10;

Q11. Cities with the Largest Customer Base

SELECT
    city,
    COUNT(customer_id) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;

Q12. Average Customer Spending by Segment

SELECT
    c.segment,
    AVG(customer_spending.total_spending) AS avg_spending
FROM customers c
LEFT JOIN (
    SELECT
        o.customer_id,
        SUM(oi.quantity * oi.unit_price) AS total_spending
    FROM orders o
    JOIN order_items oi
    ON o.order_id = oi.order_id
    WHERE LOWER(o.status) <> 'cancelled'
    GROUP BY o.customer_id
) AS customer_spending
ON c.customer_id = customer_spending.customer_id
GROUP BY c.segment;

Q13. Payment Status Distribution

SELECT
    payment_status,
    COUNT(payment_id) AS total_payments,
    SUM(amount) AS total_amount
FROM payments
GROUP BY payment_status;

Q14. Average Delivery Time

SELECT
    AVG(DATEDIFF(delivery_date, dispatch_date)) AS avg_delivery_days
FROM deliveries
WHERE delivery_date IS NOT NULL
AND dispatch_date IS NOT NULL;


Q15. Orders Taking More Than Five Days to Deliver

SELECT
    o.order_id,
    o.customer_id,
    d.dispatch_date,
    d.delivery_date,
    DATEDIFF(d.delivery_date, d.dispatch_date) AS delivery_days
FROM orders o
JOIN deliveries d
ON o.order_id = d.order_id
WHERE DATEDIFF(d.delivery_date, d.dispatch_date) > 5
AND d.delivery_date IS NOT NULL
AND d.dispatch_date IS NOT NULL
ORDER BY delivery_days DESC;