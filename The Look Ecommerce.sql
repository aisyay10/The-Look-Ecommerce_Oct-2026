## Session 1: SQL Fundamentals — Filtering, Sorting, and Limiting Data


# Retrieve all columns from the orders table.
SELECT *
FROM bigquery-public-data.thelook_ecommerce.orders;

# Retrieve the first 25 rows from the orders table.
SELECT *
FROM bigquery-public-data.thelook_ecommerce.orders
LIMIT 25;

# Retrieve all orders with a status of "Complete".
SELECT *
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE status = "Complete"

# Retrieve all orders with an order ID greater than 50.
SELECT *
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE order_id > 50

# Retrieve orders where the order ID is less than 50, or where the user ID is less than 60 and the status is "Complete".
SELECT *
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE order_id <50 OR user_id <60 AND status = "Complete"

# Retrieve all orders sorted by order ID in ascending order.
SELECT *
FROM bigquery-public-data.thelook_ecommerce.orders
ORDER BY order_id ASC

# Retrieve orders with an order ID greater than 50 and a user ID less than 60, sort them by order ID in descending order, and return only the first 10 rows.
SELECT *
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE order_id > 50 AND user_id < 60
ORDER BY order_id DESC
LIMIT 10

# Retrieve products with a retail price greater than 100.
SELECT *
FROM bigquery-public-data.thelook_ecommerce.products
WHERE retail_price > 100

# Retrieve the first name, last name, country, and age of users in the United States who are between 20 and 30 years old (exclusive).
SELECT first_name, last_name, country, age
FROM bigquery-public-data.thelook_ecommerce.users
WHERE country = "United States" AND age > 20 AND age < 30

#-------------------------

## Session 2: SQL Fundamentals — DISTINCT, Filtering, Sorting, and Aggregation

# Basic SQL query structure.
# DISTINCT is written after SELECT to retrieve unique values from a column.

SELECT nama_kolom
FROM tabel
WHERE kondisi
ORDER BY nama_kolom ASC/DESC
LIMIT jumlah_baris;


# Display all columns from the users table.
SELECT *
FROM bigquery-public-data.thelook_ecommerce.users;


# Display the first 10 rows from the orders table.
SELECT *
FROM bigquery-public-data.thelook_ecommerce.orders
Limit 10

# Retrieve order details for completed orders with more than 3 items, sorted by order ID in ascending order, limited to 20 rows.
SELECT order_id, status, created_at, num_of_item
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE status = 'Complete' AND num_of_item > 3
ORDER BY order_id ASC
LIMIT 20

# Retrieve unique order statuses to identify the available categories before applying filters.
SELECT DISTINCT status
FROM bigquery-public-data.thelook_ecommerce.orders
ORDER BY status ASC

# Task: Retrieve completed orders with more than one item, sorted by the number of items in descending order, then by creation date in descending order.
SELECT order_id, status, created_at, num_of_item
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE status = 'Complete' AND num_of_item >1
ORDER BY num_of_item DESC, created_at DESC

# Practice 1: Display order ID, status, creation date, and number of items for completed orders. Sort by the most recent creation date and limit the results to 10 rows.
SELECT order_id, status, created_at, num_of_item
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE status = 'Complete'
ORDER BY created_at DESC
LIMIT 10

# Challenge A: Display all unique statuses from the orders table.
SELECT DISTINCT status
FROM bigquery-public-data.thelook_ecommerce.orders
ORDER BY status ASC

# Challenge B: Display 15 orders with more than one item, sorted by the number of items in descending order.
SELECT *
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE num_of_item > 1
ORDER BY num_of_item DESC
LIMIT 15

# Challenge C: Display the order ID, creation date, and status for orders with a "Shipped" status.
SELECT order_id, created_at, status
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE status = 'Shipped'

# Count the number of orders for each status and sort the results from the most common status to the least common.
SELECT status,
  COUNT(*) AS total
FROM bigquery-public-data.thelook_ecommerce.orders
GROUP BY status
ORDER BY total DESC;

#-------------------


## Session 3: SQL Aggregate Functions and GROUP BY

# Aggregate functions are commonly used with aliases to give descriptive names to the resulting columns.
# Aggregate functions such as SUM, COUNT, AVG, MIN, and MAX are followed by the column name to be calculated.

# COUNT: Count the total number of orders.
SELECT COUNT (*) AS total_order
FROM bigquery-public-data.thelook_ecommerce.orders

# AVG: Calculate the average number of items per order.
SELECT AVG (num_of_item) AS avg_items_per_order
FROM bigquery-public-data.thelook_ecommerce.orders

# SUM: Calculate the total number of items across all orders.
SELECT SUM (num_of_item) AS total_item
FROM bigquery-public-data.thelook_ecommerce.orders

# MIN: Find the minimum number of items in a single order.
SELECT MIN (num_of_item) AS min_item_per_order
FROM bigquery-public-data.thelook_ecommerce.orders

# MAX: Find the maximum number of items in a single order.
SELECT MAX (num_of_item) AS max_item_per_order
FROM bigquery-public-data.thelook_ecommerce.orders

# Summary: Combine all aggregate functions in a single query.
SELECT
  COUNT (*) AS total_order,
  AVG (num_of_item) AS avg_items_per_order,
  SUM (num_of_item) AS total_item_terjual,
  MIN (num_of_item) AS min_items_per_order,
  MAX (num_of_item) AS max_items_per_order,
FROM bigquery-public-data.thelook_ecommerce.orders


# GROUP BY: Group measurements by a specific category.
# Columns selected as categories generally need to be included in the GROUP BY clause.


# GROUP BY status and use COUNT to calculate the number of orders for each status.
SELECT
  status,
  count (*) as total_order
FROM bigquery-public-data.thelook_ecommerce.orders
GROUP BY status
ORDER BY total_order

# Display all columns and rows from the orders table.
SELECT *
FROM bigquery-public-data.thelook_ecommerce.orders

# PRACTICE 1: Count all orders using COUNT(*), calculate the total and average number of items, find the minimum and maximum number of items, and display the number of orders for each status. Sort the results by total orders in descending order.

SELECT
  status,
  count (*) as total_order,
  sum (num_of_item) as total_item_terjual,
  avg (num_of_item) as avg_item_per_order,
  min(num_of_item) as min_item_per_order,
  max (num_of_item) max_item_per_order
FROM bigquery-public-data.thelook_ecommerce.orders
GROUP BY status
ORDER BY total_order DESC

# Practice grouping by more than one category: status and gender.
# Aggregate order counts and item statistics for each combination of status and gender.
# ORDER BY 2 sorts the results by the second selected column (gender) in descending order.
SELECT
  status, gender,
  count (*) as total_order,
  sum (num_of_item) as total_item_terjual,
  avg (num_of_item) as avg_item_per_order,
  min(num_of_item) as min_item_per_order,
  max (num_of_item) max_item_per_order
FROM bigquery-public-data.thelook_ecommerce.orders
GROUP BY status, gender
ORDER BY 2 DESC #order by based on the second selected column (gender)

#-------------------


## Session 4: E-commerce Data Analysis — Orders, Products, Customers, and Sales Metrics

# How many orders are recorded for each status?
# The optional WHERE clause can be used to filter orders by a specific status, such as 'Complete'.

SELECT status, 
  COUNT (*) AS total_order
FROM bigquery-public-data.thelook_ecommerce.orders
#WHERE status = 'Complete' #optional: filter to show only completed orders
GROUP BY status;

# Count the number of orders for each status and sort the results from highest to lowest.
SELECT status,
  COUNT (*) AS total_order
FROM bigquery-public-data.thelook_ecommerce.orders
GROUP BY status
ORDER BY total_order DESC;


#-------------------------ORDER_ITEMS TABLE--------

# Identify the most popular products based on the total number of items.
# Order status is not considered in this query. Use WHERE to filter by a specific status if needed.

SELECT 
  product_id,
  COUNT (*) AS total_items
FROM bigquery-public-data.thelook_ecommerce.order_items
GROUP BY 1
ORDER BY 2 DESC;

# Identify the most popular products based on the number of distinct orders they appear in.
# This may differ from the product with the highest total number of units sold.
SELECT 
  product_id,
  count (DISTINCT order_id) as total_order
FROM bigquery-public-data.thelook_ecommerce.order_items
GROUP BY 1
ORDER BY 2 DESC;


# Analyze sales performance metrics by order status.
# Display only statuses with at least 100 items by using HAVING COUNT(*) >= 100 after GROUP BY.

SELECT
  status,
  COUNT(*) AS total_items,
  COUNT(DISTINCT order_id) AS total_orders,
  ROUND(SUM(sale_price),2) AS total_sales,
  ROUND(AVG (sale_price),2) AS avg_sale_price,
FROM bigquery-public-data.thelook_ecommerce.order_items
GROUP BY 1
#HAVING COUNT (*) >= 100
ORDER BY 2 DESC;

#----------------------USERS TABLE-------------

# Count the total number of customers.
SELECT COUNT (*) AS total_customer
FROM bigquery-public-data.thelook_ecommerce.users;

# Count the number of customers in each country and sort from highest to lowest.
SELECT country,
  COUNT (*) AS total_customer
FROM bigquery-public-data.thelook_ecommerce.users
GROUP BY 1
ORDER by 2 DESC;

# Count the number of customers who have placed orders by joining the orders and users tables.
# Expected result: 125,138 customers.
SELECT
  COUNT (*) AS jumlah_customer_yang_order
FROM bigquery-public-data.thelook_ecommerce.orders AS o
INNER JOIN bigquery-public-data.thelook_ecommerce.users AS u
  ON o.user_id = u.id;


# Practice 1: Identify the top 10 countries with the highest number of users.
SELECT 
  country,
  count (*) as total_users
FROM bigquery-public-data.thelook_ecommerce.users
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

#--------------PRODUCTS TABLE---------

# Calculate the average retail price of products in each category.
# Also display the total number of products per category and sort by product count in descending order.
SELECT 
  category,
  COUNT(*) AS total_products,
  ROUND(AVG(retail_price),2) AS avg_price
FROM bigquery-public-data.thelook_ecommerce.products
GROUP BY 1
ORDER BY 2 DESC;

#------------------


## Session 5: SQL JOINs — INNER JOIN, LEFT JOIN, and Identifying Customers Without Orders

######### JOIN ########

# INNER JOIN returns only rows with matching values in both tables.
# In a Venn diagram, this represents the intersection of the two sets.

# INNER JOIN between the users and orders tables.

SELECT # The SELECT clause can be written after deciding which tables to retrieve data from and join.
  o.order_id,
  u.id as user_id,
  u.first_name,
  u.last_name,
  u.country,
  o.status,
  o.num_of_item
FROM bigquery-public-data.thelook_ecommerce.orders AS o # Alias the orders table as 'o' for easier reference.
INNER JOIN bigquery-public-data.thelook_ecommerce.users AS u # Join the users table and alias it as 'u'.
  ON o.user_id = u.id # Define the relationship between the foreign key (orders.user_id) and the primary key (users.id).
WHERE o.status = 'Complete'
ORDER BY o.num_of_item DESC;

# LEFT JOIN returns all rows from the left table.
# If there is no matching row in the right table, the right table's columns contain NULL values.

# LEFT JOIN between the USERS and ORDERS tables.
# Some users may have NULL values in the order-related columns if they have not placed any orders.

SELECT
  u.id AS user_id,
  o.order_id,
  u.first_name,
  u.last_name,
  u.country,
  o.status,
  o.num_of_item
FROM bigquery-public-data.thelook_ecommerce.users AS u
LEFT JOIN bigquery-public-data.thelook_ecommerce.orders AS o
  ON u.id = o.user_id
ORDER BY user_id ASC
LIMIT 20;

# Practice 1.A: INNER JOIN the orders and users tables to display the order ID, order status, and customer's country.
SELECT
  o.order_id,
  o.status,
  u.country
FROM bigquery-public-data.thelook_ecommerce.orders AS o
INNER JOIN bigquery-public-data.thelook_ecommerce.users AS u
  ON o.user_id = u.id;
# Result: 125,138 rows.

# Practice 1.B: Change INNER JOIN to LEFT JOIN, using users as the left table.
# Compare the results and explain why the number of rows may differ.

SELECT
  o.order_id,
  o.status,
  u.country
FROM bigquery-public-data.thelook_ecommerce.users AS u
LEFT JOIN bigquery-public-data.thelook_ecommerce.orders AS o
  ON u.id = o.user_id;
# Result: 145,007 rows.
# The result contains more rows because the LEFT JOIN retains all rows from the users table, including users without orders.

# Challenge 1: Identify customers who have not placed any orders.
SELECT
  u.id AS user_id,
  o.order_id,
  o.status,
  u.country
FROM bigquery-public-data.thelook_ecommerce.users AS u
LEFT JOIN bigquery-public-data.thelook_ecommerce.orders AS o
  ON u.id = o.user_id
WHERE o.order_id IS NULL;





