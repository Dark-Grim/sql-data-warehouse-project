/* Quality Check:
	--> A Primary Key must be UNIQUE and NOT NULL
	--> Check for unwanted spaces in string values
	--> Check the consistency of low cardinality columns
*/

-- Check for Duplicates and NULL Values
SELECT 
	cst_id,
	COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL

-- Check for Extra Spaces
SELECT cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

-- Check for Data Standardization and Consistency
SELECT 
	DISTINCT cst_gndr
FROM bronze.crm_cust_info