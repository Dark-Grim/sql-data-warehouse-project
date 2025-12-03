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