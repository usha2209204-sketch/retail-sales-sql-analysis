# Retail Sales & Customer Analytics using SQL

## Objective
Analyze retail transactions to identify revenue trends, high-value customers, product performance, channel performance, and discount patterns using SQL.

## Dataset
The project contains four relational tables:
- `customers.csv` – customer and location information
- `products.csv` – product, category and unit-price information
- `orders.csv` – order date and sales channel
- `order_items.csv` – products, quantities and discounts within each order

> The included dataset is a generated practice dataset designed for demonstrating SQL analytics. It is not company-confidential data.

## Tools
- SQL
- SQLite / DB Browser for SQLite
- GitHub

## SQL Skills Demonstrated
- SELECT, WHERE, GROUP BY, HAVING, ORDER BY
- INNER JOIN
- Aggregate functions
- CASE statements
- CTEs
- Subqueries
- Window functions (`DENSE_RANK`)
- Customer segmentation
- Revenue and KPI analysis

## Key Business Questions
1. What is total revenue?
2. Which product categories generate the most revenue?
3. How does revenue change month to month?
4. Who are the top customers?
5. What is the average order value?
6. Which sales channel generates more revenue?
7. How can customers be segmented by value?
8. Which products rank highest within each category?
9. How many repeat customers are there?
10. How are discounts distributed across categories?

## How to Run
1. Open SQLite / DB Browser for SQLite.
2. Create a new database.
3. Run `sql/01_schema.sql`.
4. Import the four CSV files into their corresponding tables.
5. Run queries from `sql/02_analysis_queries.sql`.

## Resume-ready project
**Retail Sales & Customer Analytics | SQL, SQLite, Excel**
- Analyzed 500+ retail orders using SQL joins, CTEs, CASE statements, aggregations, and window functions to identify revenue trends and customer segments.
- Built KPI queries for category revenue, average order value, channel performance, repeat customers, and top-product ranking.
- Transformed transactional data into actionable pricing, product, and customer insights.
