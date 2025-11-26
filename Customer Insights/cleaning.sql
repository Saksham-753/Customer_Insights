-- 1. Deduplicate (Postgres syntax). For other DBs adapt accordingly.
DROP TABLE IF EXISTS orders_dedup;
CREATE TABLE orders_dedup AS
SELECT DISTINCT ON (order_id) *
FROM orders_raw
ORDER BY order_id, order_date DESC;

-- 2. Filter completed orders to create active set
DROP TABLE IF EXISTS orders_active;
CREATE TABLE orders_active AS
SELECT *
FROM orders_dedup
WHERE order_status = 'Completed';

-- 3. Sanity fixes: ensure quantity >=1
UPDATE orders_active
SET quantity = 1
WHERE quantity IS NULL OR quantity < 1;

-- 4. Fill unit_price from product master when missing or invalid
UPDATE orders_active
SET unit_price = p.price
FROM products p
WHERE orders_active.product_id = p.product_id
  AND (orders_active.unit_price IS NULL OR orders_active.unit_price <= 0);

-- 5. Recompute revenue fields
UPDATE orders_active
SET gross_sales = quantity * unit_price,
    discount_amount = (quantity * unit_price) * (COALESCE(discount_pct,0) / 100.0),
    net_revenue = (quantity * unit_price) - ((quantity * unit_price) * (COALESCE(discount_pct,0)/100.0));

-- 6. Standardize channel
UPDATE orders_active
SET channel = CASE
  WHEN LOWER(channel) LIKE '%web%' THEN 'Web'
  WHEN LOWER(channel) LIKE '%app%' THEN 'Mobile App'
  WHEN LOWER(channel) LIKE '%phone%' THEN 'Phone'
  ELSE initcap(channel)
END;

-- 7. Add derived date columns
ALTER TABLE orders_active ADD COLUMN IF NOT EXISTS order_month VARCHAR;
ALTER TABLE orders_active ADD COLUMN IF NOT EXISTS order_year INTEGER;

UPDATE orders_active
SET order_month = to_char(order_date, 'YYYY-MM'),
    order_year  = EXTRACT(YEAR FROM order_date)::INTEGER;

-- 8. Quick quality checks (example queries to run interactively)
-- Count orders
SELECT COUNT(*) AS orders_count FROM orders_active;
-- Sum revenue
SELECT SUM(net_revenue) AS total_revenue FROM orders_active;
