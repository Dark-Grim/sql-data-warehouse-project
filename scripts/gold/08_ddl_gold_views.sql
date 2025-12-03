/* ======================================================
   Script: 08_ddl_gold_views.sql
   Purpose: Create business-ready Gold Layer Views.
   Description: 
		Builds Fact and Dimension Views using Silver
		Layer data to form a Star Schema Model optimized
		for analytics, reporting and BI.
   Author: Jatin Srivastava
   =====================================================
*/

-- =============================================================================
-- Create Dimension: gold.dim_customers
-- =============================================================================

IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
	DROP VIEW gold.dim_customers;
GO

CREATE VIEW gold.dim_customers AS (
	SELECT 
		ROW_NUMBER() OVER(ORDER BY ci.cst_id)   AS customer_key, -- Surrogate Key
		ci.cst_id								AS customer_id,
		ci.cst_key								AS customer_number,
		ci.cst_firstname						AS firstname,
		ci.cst_lastname							AS lastname,
		ca.bdate								AS birthdate,
		la.cntry								AS country,
		CASE	
			WHEN ci.cst_gndr != 'Unknown' THEN ci.cst_gndr -- CRM is the master of gender info
			ELSE COALESCE(ca.gen, 'Unknown')
		END										AS gender,
		ci.cst_marital_status					AS marital_status,
		ci.cst_create_date						AS create_date
	FROM silver.crm_cust_info AS ci
	LEFT JOIN silver.erp_cust_az12 AS ca
		ON ci.cst_key = ca.cid
	LEFT JOIN silver.erp_loc_a101 AS la
		ON ci.cst_key = la.cid
)


-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================

IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
	DROP VIEW gold.dim_products;
GO

CREATE VIEW gold.dim_products AS (
	SELECT 
		ROW_NUMBER() OVER(ORDER BY pin.prd_start_dt, pin.prd_key) AS product_key,
		pin.prd_id			 AS product_id,
		pin.prd_key			 AS product_number,
		pin.prd_nm			 AS product_name,
		pin.cat_id			 AS category_id,
		pc.cat				 AS category,
		pc.subcat			 AS subcategory,
		pc.maintenance,
		pin.prd_cost		 AS cost,
		pin.prd_line		 AS product_line,
		pin.prd_start_dt	 AS start_date
	FROM silver.crm_prd_info AS pin
	LEFT JOIN silver.erp_px_cat_g1v2 AS pc
		ON pin.cat_id = pc.id
	WHERE pin.prd_end_dt IS NULL -- Filter out all historical data
)
