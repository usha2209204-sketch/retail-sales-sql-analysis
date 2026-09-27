-- Retail Sales & Customer Analytics
-- Core SQL techniques: JOIN, GROUP BY, CASE, CTE, subquery, window functions

-- 1. Total revenue
SELECT ROUND(SUM(oi.quantity * p.unit_price * (1 - oi.discount)), 2) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

-- 2. Revenue by product category
SELECT p.category,
       ROUND(SUM(oi.quantity * p.unit_price * (1 - oi.discount)), 2) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;

-- 3. Monthly revenue trend
SELECT strftime('%Y-%m', o.order_date) AS month,
       ROUND(SUM(oi.quantity * p.unit_price * (1 - oi.discount)), 2) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY month
ORDER BY month;

-- 4. Top 10 customers by revenue
SELECT c.customer_id, c.customer_name,
       ROUND(SUM(oi.quantity * p.unit_price * (1 - oi.discount)), 2) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY revenue DESC
LIMIT 10;

-- 5. Average order value
WITH order_revenue AS (
    SELECT o.order_id,
           SUM(oi.quantity * p.unit_price * (1 - oi.discount)) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY o.order_id
)
SELECT ROUND(AVG(revenue), 2) AS average_order_value
FROM order_revenue;

-- 6. Revenue by sales channel
SELECT o.channel,
       ROUND(SUM(oi.quantity * p.unit_price * (1 - oi.discount)), 2) AS revenue,
       COUNT(DISTINCT o.order_id) AS orders
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY o.channel
ORDER BY revenue DESC;

-- 7. Customer segmentation using CASE
WITH customer_sales AS (
    SELECT c.customer_id, c.customer_name,
           SUM(oi.quantity * p.unit_price * (1 - oi.discount)) AS revenue
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT customer_id, customer_name,
       ROUND(revenue, 2) AS revenue,
       CASE
           WHEN revenue >= 1500 THEN 'High Value'
           WHEN revenue >= 700 THEN 'Medium Value'
           ELSE 'Low Value'
       END AS customer_value_segment
FROM customer_sales
ORDER BY revenue DESC;

-- 8. Rank products within each category using a window function
WITH product_sales AS (
    SELECT p.product_id, p.product_name, p.category,
           SUM(oi.quantity * p.unit_price * (1 - oi.discount)) AS revenue
    FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.product_name, p.category
)
SELECT product_name, category,
       ROUND(revenue, 2) AS revenue,
       DENSE_RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS category_rank
FROM product_sales
ORDER BY category, category_rank;

-- 9. Repeat customers (more than one order)
SELECT c.customer_id, c.customer_name,
       COUNT(DISTINCT o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(DISTINCT o.order_id) > 1
ORDER BY order_count DESC;

-- 10. Discount impact by category
SELECT p.category,
       ROUND(AVG(oi.discount) * 100, 2) AS avg_discount_pct,
       ROUND(SUM(oi.quantity * p.unit_price * (1 - oi.discount)), 2) AS net_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY net_revenue DESC;
