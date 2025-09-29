-- ==============================================
-- Step 1: Create Dimension Tables
-- ==============================================

-- Shipment Mode Dimension
SELECT DISTINCT Mode_of_Shipment
INTO Dim_ShipmentMode
FROM [dbo].[Ecommerce Shipping Data];

ALTER TABLE Dim_ShipmentMode
ADD Mode_of_Shipment_ID INT IDENTITY(1,1) PRIMARY KEY;

-- Warehouse Dimension
SELECT DISTINCT Warehouse_block
INTO Dim_Warehouse
FROM [dbo].[Ecommerce Shipping Data];

ALTER TABLE Dim_Warehouse
ADD Warehouse_block_ID INT IDENTITY(1,1) PRIMARY KEY;

-- Product Importance Dimension
SELECT DISTINCT Product_importance
INTO Dim_ProductImportance
FROM [dbo].[Ecommerce Shipping Data];

ALTER TABLE Dim_ProductImportance
ADD Product_importance_ID INT IDENTITY(1,1) PRIMARY KEY;

-- Customer Dimension (Gender only)
SELECT DISTINCT Gender
INTO Dim_Customer
FROM [dbo].[Ecommerce Shipping Data];

ALTER TABLE Dim_Customer
ADD Customer_ID INT IDENTITY(1,1) PRIMARY KEY;


-- ==============================================
-- Step 2: Create Fact Table (without Reached_on_Time_Y_N)
-- ==============================================

SELECT 
    e.ID,
    s.Mode_of_Shipment_ID,
    w.Warehouse_block_ID,
    p.Product_importance_ID,
    c.Customer_ID,
    e.Customer_care_calls,
    e.Customer_rating,
    e.Prior_purchases,
    e.Cost_of_the_Product,
    e.Discount_offered,
    e.Weight_in_gms
INTO Fact_Shipping
FROM [dbo].[Ecommerce Shipping Data] e
JOIN Dim_ShipmentMode s ON e.Mode_of_Shipment = s.Mode_of_Shipment
JOIN Dim_Warehouse w ON e.Warehouse_block = w.Warehouse_block
JOIN Dim_ProductImportance p ON e.Product_importance = p.Product_importance
JOIN Dim_Customer c ON e.Gender = c.Gender;


-- ==============================================
-- Step 3: Validation Checks
-- ==============================================

-- Row count check
SELECT COUNT(*) AS SourceRows FROM [dbo].[Ecommerce Shipping Data];
SELECT COUNT(*) AS FactRows FROM Fact_Shipping;

-- Spot check dimension integrity
SELECT TOP 10 * FROM Dim_ShipmentMode;
SELECT TOP 10 * FROM Dim_Warehouse;
SELECT TOP 10 * FROM Dim_ProductImportance;
SELECT TOP 10 * FROM Dim_Customer;

-- Check fact table
SELECT TOP 10 * FROM Fact_Shipping;
