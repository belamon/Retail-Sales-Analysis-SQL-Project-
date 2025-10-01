=======
# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_project`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, peforming exploratory data analysis (EDA), and answering specific business questions related to KPI and Customer Behaviours through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sql_project`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE IF NOT EXISTS sql_project;
USE sql_project;

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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
-- Record Count 
SELECT COUNT(*) transactions_id
FROM retail_sales;

-- Customer Count
SELECT COUNT(DISTINCT customer_id) as total_cust
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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve the total revenue**:
```sql
SELECT SUM(total_sale) AS total_revenue
FROM retail_sales;
```

2. **Write a SQL query to retrieve the total cost**:
```sql
SELECT SUM(cogs) AS total_cost
FROM retail_sales;
```

3. **Write a SQL query to retrieve the total profit**:
```sql
SELECT (SUM(total_sale) - SUM(cogs)) AS total_profit
FROM retail_sales;
```

4. **Write a SQL query to retrieve  which age groups and gender spend the most**:
```sql
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
```

5. **Write a SQL query to retrieve which category is most popular with each gender**:
```sql
WITH cat_rank AS
(SELECT gender,category, COUNT(*) AS total_orders, RANK() OVER (PARTITION BY gender ORDER BY COUNT(*) DESC) AS rankk
FROM retail_sales
GROUP BY gender, category)
SELECT gender, category, total_orders
FROM cat_rank
WHERE rankk=1;
```

6. **Write a SQL query to show average basket size (quantity per order) by customer segment**:
```sql
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
```

7. **Write a SQL query to retrieve the top-spending customers**:
```sql
 SELECT customer_id, SUM(total_sale) AS total_spent 
 FROM retail_sales
 GROUP BY customer_id
 ORDER BY total_spent DESC
 LIMIT 10;
```

8. **Write a SQL query to retrieve whether customers prefer shopping in the morning,afternoon, or evening**:
```sql
SELECT 
	CASE
		WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
	END AS Shopping_time, COUNT(transactions_id) AS total_orders, SUM(total_sale) AS revenue
FROM retail_sales
GROUP BY Shopping_time
ORDER BY revenue DESC;
```


## Findings

- **Customer Demographics**: The dataset includes customers aged 18 to 64, with the 50-59 age bracket spending the most.
- **High-Value Transactions**: Several transactions exceeded 1,000 in total sales, indicating premium purchases.
- **Sales Trends Time**: Sales trends show that customers mostly purchase products in the evening after 5 PM, followed by the morning and afternoon periods.
- **Customer Insights**: The analysis highlights the top-spending customers, the age bracket with the highest spending and the most popular product categories by gender.
- **Popular Category**: Data reveals that Clothing is the most purchased product category for both female and male customers.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Behaviour Insights**: Reports on top customers and unique customer counts per category.


## Reports

The data visualization is shown here: https://lookerstudio.google.com/s/i3uiBOS6spg

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## Author - Bela Moneta

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

email: belamoneta@gmail.com


>>>>>>> e2de46f (Update README)
