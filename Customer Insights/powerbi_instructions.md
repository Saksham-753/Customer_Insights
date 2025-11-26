# Power BI Instructions — Customer Orders Insights

## Data model
- Tables: orders_active, customers, products
- Relationships:
  - orders_active.customer_id -> customers.customer_id
  - orders_active.product_id -> products.product_id
- Create a Date (Calendar) table. Relate Date[Date] -> orders_active[order_date].

## Important Power Query steps
- Import CSVs and set data types (date, numeric, text).
- Filter `order_status` to Completed (if not pre-cleaned).
- Merge with products to ensure unit_price is correct.
- Add calculated column: NetRevenue = Quantity * UnitPrice * (1 - DiscountPct/100)
- Add OrderMonth column (format yyyy-mm).

## Suggested visuals
1. KPI cards: Total Revenue, Orders, AOV, Unique Customers
2. Line chart: Monthly Revenue (OrderMonth)
3. Bar chart: Revenue by Channel
4. Treemap/Bar: Revenue by Category
5. Table: Top 10 Customers (Revenue, Orders, Last Order)
6. Matrix/Cohort heatmap: Signup Month vs Order Month
7. Map: Revenue by City or State (if geodata present)

## Key DAX measures (paste into new measures)
Total Revenue = SUM(orders_active[net_revenue])

Orders Count = DISTINCTCOUNT(orders_active[order_id])

Avg Order Value = DIVIDE([Total Revenue], [Orders Count], 0)

Unique Customers = DISTINCTCOUNT(orders_active[customer_id])

Gross Sales = SUM(orders_active[gross_sales])

Discount Amount = SUM(orders_active[discount_amount])

Return Rate = 
VAR total_orders = [Orders Count]
VAR returned = CALCULATE(DISTINCTCOUNT(orders_active[order_id]), orders_active[order_status] = "Returned")
RETURN DIVIDE(returned, total_orders, 0)
