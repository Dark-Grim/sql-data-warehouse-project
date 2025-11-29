/* ==============================
	Table: crm_cust_info
   ==============================
*/


INSERT INTO silver.crm_cust_info(
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date
)
SELECT 
	cst_id,
	cst_key,
	TRIM(cst_firstname) AS cst_firstname,
	TRIM(cst_lastname) AS cst_lastname,
	CASE 
		WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
		WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
		ELSE 'Unknown'
	END AS cst_marital_status,-- Normalize marital status values to readable format
	CASE 
		WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
		WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
		ELSE 'Unknown'
	END AS cst_gndr, -- Normalize gender values to readable format
	cst_create_date
FROM (
	SELECT 
		*,
		ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) AS r_num
	FROM bronze.crm_cust_info
	WHERE cst_id IS NOT NULL
)t
WHERE t.r_num = 1 -- Select the most recent records per customer


-- SELECT * FROM silver.crm_cust_info


/* ==============================
	Table: crm_cust_info
   ==============================
*/


INSERT INTO silver.crm_prd_info(
	prd_id,
	cat_id,
	prd_key,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt
)
SELECT 
	prd_id,
	REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id, -- Extract Category ID
	SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key, -- Extract Product Key
	TRIM(prd_nm) AS prd_nm,
	COALESCE(prd_cost, 0) AS prd_cost,
	CASE UPPER(TRIM(prd_line))
		WHEN 'M' THEN 'Mountain'
		WHEN 'R' THEN 'Roads'
		WHEN 'S' THEN 'Other Sales'
		WHEN 'T' THEN 'Touring'
		ELSE 'Unknown'
	END AS prd_line, -- Map Product Line codes to descriptive values
	CAST(prd_start_dt AS DATE) AS prd_start_dt,
	CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt) - 1 AS DATE) AS prd_end_dt -- Calculate end date as one day before the next start date
FROM bronze.crm_prd_info


-- SELECT * FROM silver.crm_prd_info