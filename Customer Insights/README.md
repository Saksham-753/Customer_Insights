# Customer Orders Insights Analysis

**Stack:** SQL (Postgres/SQLite-compatible), Power BI, CSV

**Summary:**
A reproducible analytics project that ingests e-commerce order, customer, and product data to produce executive KPIs, time-series trend analysis, customer segmentation (RFM), top-product performance, and channel insights. Includes SQL cleaning scripts, analysis queries, Power BI guidance and resume-ready bullets.

**Data:** `data/orders.csv`, `data/customers.csv`, `data/products.csv` (synthetic/sample data included in this repo).

**Folder contents:**
- `sql/schema.sql` — CREATE TABLE statements
- `sql/cleaning.sql` — cleaning/transformation SQL
- `sql/analytics_queries.sql` — KPI and analysis queries
- `powerbi/powerbi_instructions.md` — data model, DAX measures, recommended visuals
- `docs/runbook.md` — steps to reproduce and deliverables
- `docs/insights.md` — example insights and narrative text for portfolio
- `resume_bullets.md` — copy-paste bullets for resume

**How to reproduce:**
1. Clone repo and place CSV files in `/data`.
2. Load CSVs into your database (or open in Power BI directly).
3. Run `sql/schema.sql` to create tables, then import CSVs into those tables.
4. Run `sql/cleaning.sql` to produce cleaned table `orders_active`.
5. Run queries from `sql/analytics_queries.sql` to generate KPIs and tables.
6. Open Power BI, load cleaned tables, create Date table, paste DAX in `powerbi/powerbi_instructions.md` and build visuals.

**License:** MIT (see LICENSE file)
