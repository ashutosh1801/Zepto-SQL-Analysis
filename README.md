  # Zepto SQL Data Analysis Project

## Project Overview

This project analyzes product data from Zepto using PostgreSQL. The objective is to explore pricing, discounts, inventory management, and product value through SQL queries.

The project demonstrates practical SQL skills used in Data Analytics, including filtering, sorting, aggregations, calculated fields, and business analysis.

---

## Database Information

**Database:** PostgreSQL

**Table Name:** `zepto`

---

## Dataset Information

The dataset contains information about products available on Zepto.

### Table Structure

| Column Name            | Data Description                         |
| ---------------------- | ---------------------------------------- |
| name                   | Product Name                             |
| mrp                    | Maximum Retail Price                     |
| discountPercent        | Discount Percentage                      |
| availableQuantity      | Available Stock Quantity                 |
| discountedSellingPrice | Selling Price After Discount             |
| weightInGms            | Product Weight in Grams                  |
| outOfStock             | Product Availability Status (True/False) |
| quantity               | Product Quantity                         |

---

## Business Problems Solved

--1. Find the top 10 best-value products based on the discount percentage.

SELECT name,
       mrp,
       discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

--2. What are the products with high MRP but out of stock?

SELECT distinct name,
       mrp
FROM zepto
WHERE outOfStock = TRUE and mrp>300
ORDER BY mrp DESC;

--3. Calculate estimated revenue for each category.

SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
group by category
order by total_revenue;

--4. Find all products where MRP is greater than ₹500 and discount is less than 10%.

SELECT distinct name,mrp, discountPercent
FROM zepto
WHERE mrp > 500
  AND discountPercent < 10
  order by mrp desc;


--5. Identify the top 5 categories offering the highest average discount percentage.

SELECT category,
round(avg(discountPercent),2) as avg_discount
from zepto
group by category
order by avg_discount desc
limit 5;

--6. Find the price per gram for products above 100g and sort by best value.

SELECT distinct name,
       weightInGms,
       discountedSellingPrice,
       ROUND(discountedSellingPrice / weightInGms, 2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram ASC;


--7. Group the products into categories like Low, Medium, and Bulk.

SELECT distinct  name,
       weightInGms,
       CASE
           WHEN weightInGms <= 1000 THEN 'Low'
           WHEN weightInGms <= 5000 THEN 'Medium'
           ELSE 'Bulk'
       END AS weight_category
FROM zepto;


--8. What is the total inventory weight per category?

select category,
sum (weightInGms * availableQuantity) as total_weight
from zepto
group by category
order by total_weight;


---

## SQL Concepts Used

* SELECT
* WHERE
* ORDER BY
* LIMIT
* Aggregate Functions
* SUM()
* AVG()
* CASE Statement
* Calculated Columns
* Boolean Conditions

---



## Key Insights

* Several products offer discounts above average.
* High-value products are frequently out of stock.
* Revenue potential can be estimated through inventory analysis.
* Price-per-gram calculation helps identify the best-value products.
* Inventory metrics can support stock planning and decision-making.

---

## Tools Used

* PostgreSQL
* pgAdmin 4
* GitHub

---

## Project Structure

```text
Zepto-SQL-Analysis
│
├── README.md
├── zepto_project.sql
└── zepto_dataset.csv
```
---

## Author

### Ashutosh Kr. Tiwari

Skills:

* SQL
* Excel
* Power BI
* Statistics for Data Analysis

---

### Project Outcome

This project helped strengthen practical SQL skills by solving real-world business problems related to pricing, discounts, inventory management, and revenue analysis using PostgreSQL.
  