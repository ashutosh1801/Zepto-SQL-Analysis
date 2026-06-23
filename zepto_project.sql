drop table if exists zepto;

create table zepto(
sku_id serial primary key,
category varchar(120),
name varchar(150) not null,
mrp numeric(8,2),
discountPercent numeric(5,2),
availableQuantity integer,
discountedSellingPrice numeric(8,2),
weightInGms integer ,
outOfStock boolean,
quantity integer
);

--sample data
select *from zepto

--count of rows
select count(*) from zepto

--null values
select * from zepto
where sku_id is null
or mrp=0;


--different product category
select distinct category
from zepto
order by category;

--product in stock vs out of stock
select outOfstock, count (sku_id)
from zepto
group by outOfStock;

--product names present multiple times
select name, count(sku_id) as "Number of SKUs"
from zepto
group by name
having count(sku_id)> 1
order by count (sku_id) desc;


--data cleaning

--price with 0
select * from zepto
where mrp=0 or discountedSellingPrice=0;

delete from zepto 
where mrp=0;

--convert paise into rupee
update zepto
set mrp=mrp/100.0,
discountedSellingPrice=discountedSellingPrice/100.0;



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




