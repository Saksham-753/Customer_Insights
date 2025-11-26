# Runbook — Reproduce the analysis

1. Place CSVs in `/data` and import to database or Power BI.
2. Run `sql/schema.sql` to create tables (if using DB).
3. Load CSVs into those tables (COPY / bulk import).
4. Run `sql/cleaning.sql` to deduplicate and build `orders_active`.
5. Run `sql/analytics_queries.sql` to produce KPI outputs and export results as CSVs for dashboarding.
6. In Power BI, import cleaned tables and follow `powerbi/powerbi_instructions.md`.
7. Generate visuals and export dashboard screenshots for your portfolio.
