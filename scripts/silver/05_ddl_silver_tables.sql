/* =======================================================
   Script: 05_ddl_silver_tables.sql
   Purpose: Create cleaned and standardized Silver layer tables
   Layer: Silver (Refined Data)
   Author: Jatin Srivastava
   Created On: 25-11-2025
   Notes:
       - Silver layer applies data cleansing & standardization
       - Structures are refined for analytical readiness
       - No business logic; only cleaning, formatting, and validation
========================================================== */


/*
   Table: silver.crm_cust_info
   Purpose: Store cleansed and standardized customer data 
            refined from the Bronze CRM raw table.
   Notes:
       - Includes data quality fixes and formatting
       - Standardized column values (dates, casing, data types)
*/


-- Drop table if it already exists.
IF OBJECT_ID('silver.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_cust_info;
GO

-- Create Table
CREATE TABLE silver.crm_cust_info (
    cst_id              INT,
    cst_key             NVARCHAR(50),
    cst_firstname       NVARCHAR(50),
    cst_lastname        NVARCHAR(50),
    cst_marital_status  NVARCHAR(50),
    cst_gndr            NVARCHAR(50),
    cst_create_date     DATE,
	dw_create_date		DATETIME2 DEFAULT GETDATE()
);
GO



/*
   Table: silver.crm_prd_info
   Purpose: Store cleansed and standardized products data refined from the Bronze CRM raw table.
   Notes:
       - Includes data quality fixes and formatting
       - Standardized column values (dates, casing, data types)
*/


-- Drop table if it already exists.
IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_prd_info;
GO

-- Create Table
CREATE TABLE silver.crm_prd_info (
    prd_id         INT,
    prd_key        NVARCHAR(50),
    prd_nm         NVARCHAR(50),
    prd_cost       INT,
    prd_line       NVARCHAR(50),
    prd_start_dt   DATETIME,
    prd_end_dt     DATETIME,
	dw_create_date DATETIME2 DEFAULT GETDATE()
);
GO



/*
   Table: silver.crm_sales_details
   Purpose: Store cleansed and standardized Sales data refined from the Bronze CRM raw table.
   Notes:
       - Includes data quality fixes and formatting
       - Standardized column values (dates, casing, data types)
*/


-- Drop table if it already exists.
IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE silver.crm_sales_details;
GO


-- Create Table
CREATE TABLE silver.crm_sales_details (
    sls_ord_num    NVARCHAR(50),
    sls_prd_key    NVARCHAR(50),
    sls_cust_id    INT,
    sls_order_dt   INT,
    sls_ship_dt    INT,
    sls_due_dt     INT,
    sls_sales      INT,
    sls_quantity   INT,
    sls_price      INT,
	dw_create_date DATETIME2 DEFAULT GETDATE()
);
GO


/*
   Table: silver.erp_cust_az12
   Purpose: Store cleansed and standardized customer information data refined from the Bronze CRM raw table.
   Notes:
       - Includes data quality fixes and formatting
       - Standardized column values (dates, casing, data types)
*/


-- Drop table if it already exists.
IF OBJECT_ID('silver.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE silver.erp_cust_az12;
GO

-- Create Table
CREATE TABLE silver.erp_cust_az12 (
	cid   			NVARCHAR(50),
	bdate 			DATE,
	gen   			NVARCHAR(50),
	dw_create_date  DATETIME2 DEFAULT GETDATE()
);
GO



/*
   Table: silver.erp_loc_a101
   Purpose: Store cleansed and standardized location data refined from the Bronze CRM raw table.
   Notes:
       - Includes data quality fixes and formatting
       - Standardized column values (dates, casing, data types)
*/

-- Drop table if it already exists.
IF OBJECT_ID('silver.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE silver.erp_loc_a101;
GO

-- Create Table
CREATE TABLE silver.erp_loc_a101 (
    cid   			NVARCHAR(50),
    cntry 			NVARCHAR(50),
	dw_create_date  DATETIME2 DEFAULT GETDATE()
);
GO



/*
   Table: silver.erp_px_cat_g1v2
   Purpose: Store cleansed and standardized categories information data refined from the Bronze CRM raw table.
   Notes:
       - Includes data quality fixes and formatting
       - Standardized column values (dates, casing, data types)
*/


-- Drop table if it already exists.
IF OBJECT_ID('silver.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE silver.erp_px_cat_g1v2;
GO

-- Create Table
CREATE TABLE silver.erp_px_cat_g1v2 (
    id          	NVARCHAR(50),
    cat         	NVARCHAR(50),
    subcat      	NVARCHAR(50),
    maintenance 	NVARCHAR(50),
	dw_create_date  DATETIME2 DEFAULT GETDATE()
);
GO