-- Core KPIs
SELECT
  COUNT(DISTINCT order_id) AS orders_count,
  SUM(net_revenue) AS total_revenue,
  AVG(net_revenue) AS avg_order_value,
  COUNT(DISTINCT customer_id) AS unique_customers
FROM orders_active;

-- Monthly trend
SELECT order_month,
       SUM(net_revenue) AS revenue,
       COUNT(DISTINCT order_id) AS orders,
       AVG(net_revenue) AS aov
FROM orders_active
GROUP BY order_month
ORDER BY order_month;

-- Top customers
SELECT c.customer_id, c.customer_name,
       COUNT(DISTINCT o.order_id) AS order_count,
       SUM(o.net_revenue) AS revenue,
       AVG(o.net_revenue) AS avg_order_value,
       MAX(o.order_date)::date AS last_order_date
FROM orders_active o
JOIN customers c USING (customer_id)
GROUP BY c.customer_id, c.customer_name
ORDER BY revenue DESC
LIMIT 50;

-- Channel performance
SELECT channel,
       COUNT(DISTINCT order_id) AS orders,
       SUM(net_revenue) AS revenue,
       AVG(net_revenue) AS aov
FROM orders_active
GROUP BY channel
ORDER BY revenue DESC;

-- Top products
SELECT p.category,
       p.product_id,
       p.product_name,
       SUM(o.quantity) AS units_sold,
       SUM(o.net_revenue) AS revenue
FROM orders_active o
JOIN products p USING (product_id)
GROUP BY p.category, p.product_id, p.product_name
ORDER BY revenue DESC
LIMIT 100;

-- Cohort starter
WITH cohorts AS (
  SELECT c.customer_id,
         to_char(c.signup_date,'YYYY-MM') AS signup_month,
         to_char(o.order_date,'YYYY-MM') AS order_month,
         SUM(o.net_revenue) AS revenue
  FROM customers c
  LEFT JOIN orders_active o ON c.customer_id = o.customer_id
  GROUP BY c.customer_id, signup_month, order_month
)
SELECT signup_month, order_month,
       COUNT(DISTINCT customer_id) AS customers_with_orders,
       SUM(revenue) AS cohort_revenue
FROM cohorts
GROUP BY signup_month, order_month
ORDER BY signup_month, order_month;
