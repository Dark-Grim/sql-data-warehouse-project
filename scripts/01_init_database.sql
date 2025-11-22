-- ======================================================
-- Script: 01_init_database.sql
-- Purpose: Create the Data Database 'DW_Analytics'
-- Author: Jatin Srivastava
-- ======================================================


USE MASTER;
GO

-- Check if Database exists or not.

IF NOT EXISTS (
	SELECT name
	FROM sys.databases 
	WHERE name = 'DW_Analytics'
)
BEGIN 
	CREATE DATABASE DW_Analytics;
	PRINT 'Database DW_Analytics created successfully.';
END
ELSE
BEGIN
	PRINT 'Database DW_Analytics already exists.';
END