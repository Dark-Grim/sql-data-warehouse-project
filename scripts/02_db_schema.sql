-- =============================================================================================
-- Script: 02_db_schema.sql
-- Purpose: This script sets up three schemas within the database: 'bronze', 'silver' and 'gold'.
-- Author: Jatin Srivastava
-- =============================================================================================


USE DW_Analytics;
GO

-- Create Schemas 
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO