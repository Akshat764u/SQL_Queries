create database apple_db;
use apple_db;
select * from apple_products;

-- BASIC INSIGHTS
-- 1. To find total no of products

select count(*) as total_products from apple_products;

-- To list all distinct products
SELECT count(DISTINCT `Product Name`) FROM apple_products;

-- Check Total Rows
SELECT COUNT(*) FROM apple_products;

-- Check Unique Product Names
SELECT COUNT(DISTINCT `Product Name`) FROM apple_products;

-- Count by product category:
select `Product Category`, 
count(*) from apple_products
group by `Product Category`;

-- 2. Price & Discount Analysis
-- Products with highest discount:
select `Product Name`, `Sale Price`, Mrp, `Discount Percentage`
from apple_products
order by `Discount Percentage` desc
limit 5;

-- Average sale price by brand:
select Brand, avg(`Sale Price`) as avg_sale_price
from apple_products
group by Brand;

-- Most expensive products:
select `Product Name`, `Sale Price`
from apple_products
order by `Sale Price` desc
limit 5;

-- 3. Ratings and Reviews Analysis
-- Products with most ratings:
select `Product Name`, `Number Of Ratings`
from apple_products
order by `Number Of Ratings` desc
limit 5;
select * from apple_products;
-- Average star rating by RAM:
select Ram, `Star Rating`
from apple_products
order by `Star Rating` desc;