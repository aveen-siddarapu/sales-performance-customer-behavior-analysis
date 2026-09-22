USE DataWarehouseAnalytics;

---------------------------------------------------------------------------------------
				--Customers--

	CREATE OR ALTER VIEW gold.vw_customers
	AS 
	SELECT 
		customer_key,
		first_name,
		last_name,
		CONCAT(first_name,' ',last_name) AS full_name,
		country AS Country,
		marital_status,
		gender,
		birthdate,
		create_date
	FROM gold.dim_customers;


SELECT *
FROM gold.vw_customers;
---------------------------------------------------------------------------------------------------
				--Products--

	CREATE OR ALTER VIEW gold.vw_products
	AS 
	SELECT 
		product_key,
		product_name,
		category,
		subcategory,
		cost,
		product_line,
		start_date
	FROM gold.dim_products;

SELECT *
FROM gold.vw_products;
-----------------------------------------------------------------------------------------------------
	                  --Orders--
	
	CREATE OR ALTER VIEW gold.vw_sales AS 
	SELECT 
		order_number,
		customer_key,
		gold.fact_sales.product_key AS product_key,
		order_date,
		shipping_date,
		due_date,
		quantity,
		price,
		sales_amount,
		cost
	FROM gold.fact_sales
	INNER JOIN gold.dim_products
	ON gold.fact_sales.product_key = gold.dim_products.product_key
	WHERE  
		YEAR(order_date) IN ('2011','2012','2013');

SELECT *
FROM gold.vw_sales