/* =======================================================
   Script: 03_ddl_bronze_tables.sql
   Purpose: Create raw Bronze layer tables for CRM & ERP
   Layer: Bronze (Raw Ingestion)
   Author: Jatin Srivastava
   Created On: 23-11-2025
   Notes:
       - Bronze stores raw, untransformed data
       - Structures match incoming CSV files exactly
========================================================== */

-----------------------------------------------------------
-- bronze.crm_cust_info (Raw)
-----------------------------------------------------------

/*
   Table: bronze.crm_cust_info
   Purpose: Store raw customer data extracted directly
            from the CRM source system.
   Notes:
       - Loaded as-is from CSV
       - No cleaning or transformations in this layer
*/

-- Use 'DB_Analytics'
USE DW_Analytics;
GO

-- Drop table if it already exists.
IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
GO

-- Create Table
CREATE TABLE bronze.crm_cust_info (
    cst_id              INT,
    cst_key             NVARCHAR(50),
    cst_firstname       NVARCHAR(50),
    cst_lastname        NVARCHAR(50),
    cst_marital_status  NVARCHAR(50),
    cst_gndr            NVARCHAR(50),
    cst_create_date     DATE
);
GO


-----------------------------------------------------------
-- bronze.crm_prd_info (Raw)
-----------------------------------------------------------

/*
   Table: bronze.crm_prd_info
   Purpose: Store raw products data extracted directly
            from the CRM source system.
   Notes:
       - Loaded as-is from CSV
       - No cleaning or transformations in this layer
*/

-- Drop table if it already exists.
IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;
GO

-- Create Table
CREATE TABLE bronze.crm_prd_info (
    prd_id        INT,
    prd_key       NVARCHAR(50),
    prd_nm        NVARCHAR(50),
    prd_cost      INT,
    prd_line      NVARCHAR(50),
    prd_start_dt  DATETIME,
    prd_end_dt    DATETIME
);
GO


-----------------------------------------------------------
-- bronze.crm_sales_details (Raw)
-----------------------------------------------------------

/*
   Table: bronze.crm_sales_details
   Purpose: Store raw Sales data extracted directly
            from the CRM source system.
   Notes:
       - Loaded as-is from CSV
       - No cleaning or transformations in this layer
*/

-- Drop table if it already exists.
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
GO

-- Create Table
CREATE TABLE bronze.crm_sales_details (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt INT,
    sls_ship_dt  INT,
    sls_due_dt   INT,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT
);
GO


-----------------------------------------------------------
-- bronze.erp_cust_az12 (Raw)
-----------------------------------------------------------

/*
   Table: bronze.erp_cust_az12
   Purpose: Store raw customer information data extracted directly
            from the CRM source system.
   Notes:
       - Loaded as-is from CSV
       - No cleaning or transformations in this layer
*/

-- Drop table if it already exists.
IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;
GO

-- Create Table
CREATE TABLE bronze.erp_cust_az12 (
    cid   NVARCHAR(50),
    bdate DATE,
    gen   NVARCHAR(50)
);
GO


-----------------------------------------------------------
-- bronze.erp_loc_a101 (Raw)
-----------------------------------------------------------

/*
   Table: bronze.erp_loc_a101
   Purpose: Store raw location data extracted directly
            from the CRM source system.
   Notes:
       - Loaded as-is from CSV
       - No cleaning or transformations in this layer
*/

-- Drop table if it already exists.
IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;
GO

-- Create Table
CREATE TABLE bronze.erp_loc_a101 (
    cid   NVARCHAR(50),
    cntry NVARCHAR(50)
);
GO


-----------------------------------------------------------
-- bronze.erp_px_cat_g1v2 (Raw)
-----------------------------------------------------------

/*
   Table: bronze.erp_px_cat_g1v2
   Purpose: Store raw categories information data extracted directly
            from the CRM source system.
   Notes:
       - Loaded as-is from CSV
       - No cleaning or transformations in this layer
*/

-- Drop table if it already exists.
IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;
GO

-- Create Table
CREATE TABLE bronze.erp_px_cat_g1v2 (
    id          NVARCHAR(50),
    cat         NVARCHAR(50),
    subcat      NVARCHAR(50),
    maintenance NVARCHAR(50)
);
GO