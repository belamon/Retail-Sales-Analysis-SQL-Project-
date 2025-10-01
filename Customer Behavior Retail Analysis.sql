
-- SQL retail sales
CREATE DATABASE IF NOT EXISTS sql_project;
USE sql_project;

-- Create Table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales 
(
  transactions_id INT PRIMARY KEY,
  sale_date DATE,
  sale_time TIME,
  customer_id INT,
  gender VARCHAR(10),
  age INT,
  category VARCHAR(35),
  quantiy INT,
  price_per_unit DECIMAL(10,2),
  cogs DECIMAL(10,2),
  total_sale DECIMAL(12,2)
);


SELECT * FROM retail_sales;

-- Data Exploratory and Cleaning 
-- Determine the Number of Record in the Dataset 
-- Record Count 
SELECT COUNT(*) transactions_id
FROM retail_sales;

-- Unique Customer Counts 
SELECT DISTINCT(COUNT(customer_id))
FROM retail_sales;

-- Identify ALL Unique Category 
SELECT DISTINCT(category)
FROM retail_sales;

-- Check if there is any null data 
SELECT * 
FROM retail_sales
WHERE
	transactions_id is NULL
    OR
    sale_date is NULL
    OR 
    sale_time is NULL
    OR 
    gender is NULL
    OR 
	category is NULL
    OR 
    quantiy is NULL
    OR 
    cogs is NULL
    OR 
    total_sale is NULL;

-- How Many Sales We Have?
SELECT COUNT(*) as total_sales 
FROM retail_sales;

-- How many unique customers we have?
SELECT COUNT(DISTINCT customer_id) as total_cust
FROM retail_sales;

-- Data Analysis & Business Key Problems & Answers 
-- Q.1 Write a SQL query to retrieve the total revenue 
-- Q.2 Write a SQL query to retrieve the total cost 
-- Q.3 Write a SQL query to retrieve the total profit 
-- Q.4 Write a SQL query to retrieve  which age groups and gender spend the most
-- Q.5 Write a SQL query to retrieve which category is most popular with each gender
-- Q.6 Write a SQL query to show average basket size (quantity per order) by customer segment 
-- Q.7 Write a SQL query to retrieve the top-spending customers 
-- Q.8 Write a SQL query to retrieve whether customers prefer shopping in the morning,afternoon, or evening 


-- SQL QUERIES

-- Q.1 Write a SQL query to retrieve the total revenue 

SELECT SUM(total_sale) AS total_revenue
FROM retail_sales;

-- Q.2 Write a SQL query to retrieve the total cost 
SELECT SUM(cogs) AS total_cost
FROM retail_sales;

-- Q.3 Write a SQL query to retrieve the total profit 
SELECT (SUM(total_sale) - SUM(cogs)) AS total_profit
FROM retail_sales;

-- Q.4 Write a SQL query to retrieve  which age groups and gender spend the most
SELECT gender, 
	CASE
		WHEN age <20 THEN 'Under 20'
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
	END AS age_group,
    SUM(total_sale) AS total_spent 
FROM retail_sales
GROUP BY gender, age_group
ORDER BY total_spent DESC;

-- Q.5 Write a SQL query to retrieve which category is most popular with each gender

WITH cat_rank AS
(SELECT gender,category, COUNT(*) AS total_orders, RANK() OVER (PARTITION BY gender ORDER BY COUNT(*) DESC) AS rankk
FROM retail_sales
GROUP BY gender, category)
SELECT gender, category, total_orders
FROM cat_rank
WHERE rankk=1;

-- Q.6 Write a SQL query to show average basket size (quantity per order) by customer segment 
SELECT 
	CASE
		WHEN age < 20 THEN 'Under 20'
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
	END AS age_segment,
    ROUND(AVG(quantiy),2) AS avg_basket 
FROM retail_sales
GROUP BY age_segment
ORDER BY avg_basket DESC;

 -- Q.7 Write a SQL query to retrieve the top-spending customers 
 
 SELECT customer_id, SUM(total_sale) AS total_spent 
 FROM retail_sales
 GROUP BY customer_id
 ORDER BY total_spent DESC
 LIMIT 10;

-- Q.8 Write a SQL query to retrieve whether customers prefer shopping in the morning,afternoon, or evening 
SELECT 
	CASE
		WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
	END AS Shopping_time, COUNT(transactions_id) AS total_orders, SUM(total_sale) AS revenue
FROM retail_sales
GROUP BY Shopping_time
ORDER BY revenue DESC;
--

