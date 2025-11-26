-- customers
CREATE TABLE customers (
  customer_id   VARCHAR PRIMARY KEY,
  customer_name VARCHAR,
  city          VARCHAR,
  state         VARCHAR,
  signup_date   DATE
);

-- products
CREATE TABLE products (
  product_id   VARCHAR PRIMARY KEY,
  product_name VARCHAR,
  category     VARCHAR,
  price        NUMERIC(12,2)
);

-- orders_raw
CREATE TABLE orders_raw (
  order_id       VARCHAR PRIMARY KEY,
  order_date     DATE,
  customer_id    VARCHAR,
  product_id     VARCHAR,
  quantity       INTEGER,
  unit_price     NUMERIC(12,2),
  discount_pct   NUMERIC(5,2),
  channel        VARCHAR,
  order_status   VARCHAR,
  city           VARCHAR,
  state          VARCHAR,
  gross_sales    NUMERIC(14,2),
  discount_amount NUMERIC(14,2),
  net_revenue    NUMERIC(14,2)
);

-- Indexes (optional)
CREATE INDEX idx_orders_date ON orders_raw(order_date);
CREATE INDEX idx_orders_customer ON orders_raw(customer_id);
CREATE INDEX idx_orders_product ON orders_raw(product_id);
