/* Quality Check:
	--> A Primary Key must be UNIQUE and NOT NULL
	--> Check for unwanted spaces in string values
	--> Check the consistency of low cardinality columns
*/

-- NOTE: BELOW PROCESS DONE FOR EVERY TABLE IN BRONZE LAYER

-- Check for Duplicates and NULL Values
SELECT 
	prd_id,
	COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

-- Check for Extra Spaces
SELECT prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

SELECT 
	sls_ord_num
FROM bronze.crm_sales_details
WHERE sls_ord_num != TRIM(sls_ord_num)

-- Check for Data Standardization and Consistency
SELECT 
	DISTINCT prd_line
FROM bronze.crm_prd_info

-- Check for NULLS or Negative Numbers
SELECT *
FROM bronze.crm_prd_info
WHERE prd_cost IS NULL OR prd_cost < 0

-- Check for Invalid Date Orders 
SELECT *
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt


/* Check for Invalid Dates
	--> negative values
	--> zeros (0)
	--> length for Dates with the respective format.
*/

SELECT 
	NULLIF(sls_due_dt,0) AS sls_due_dt
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0 OR LEN(sls_due_dt) != 8


-- Check for Invalid Date Orders

SELECT 
	sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt 


/* Check Data Consistency between Sales, Order and Quantity
	--> Sales = Quantity * Price
	--> Values must not be negative, NULL or 0
*/

SELECT
	DISTINCT sls_sales,
	sls_quantity,
	sls_price,
	CASE 
		WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity *  ABS(sls_price) THEN sls_quantity *  ABS(sls_price)
		ELSE sls_sales
	END AS new_sls_sales,
	CASE 
		WHEN sls_price IS NULL OR sls_price <= 0 THEN sls_sales / NULLIF(sls_quantity, 0)
		ELSE sls_price
	END AS new_sls_price
FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price OR
	sls_sales <= 0 OR sls_price <= 0 OR sls_quantity <= 0 OR
	sls_sales IS NULL OR sls_price IS NULL OR sls_quantity IS NULL
ORDER BY sls_sales, sls_quantity, sls_price