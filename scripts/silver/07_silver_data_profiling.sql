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