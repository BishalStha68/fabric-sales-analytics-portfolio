USE SalesDB;
GO

-- =============================================
-- Watermark table for incremental ingestion
-- =============================================

CREATE TABLE dbo.Ingestion_Watermark
(
    TableName VARCHAR(100) NOT NULL PRIMARY KEY,
    WatermarkValue DATETIME2 NULL
);
GO

-- Initial watermark records
INSERT INTO dbo.Ingestion_Watermark
    (TableName, WatermarkValue)
VALUES
    ('Customers', NULL),
    ('Products', NULL),
    ('Orders', NULL),
    ('OrderDetails', NULL);
GO

-- =============================================
-- Initialize watermarks after initial full load
-- =============================================

UPDATE dbo.Ingestion_Watermark
SET WatermarkValue = (
    SELECT MAX(LastModifiedDate)
    FROM dbo.Customers
)
WHERE TableName = 'Customers';

UPDATE dbo.Ingestion_Watermark
SET WatermarkValue = (
    SELECT MAX(LastModifiedDate)
    FROM dbo.Products
)
WHERE TableName = 'Products';

UPDATE dbo.Ingestion_Watermark
SET WatermarkValue = (
    SELECT MAX(LastModifiedDate)
    FROM dbo.Orders
)
WHERE TableName = 'Orders';

UPDATE dbo.Ingestion_Watermark
SET WatermarkValue = (
    SELECT MAX(LastModifiedDate)
    FROM dbo.OrderDetails
)
WHERE TableName = 'OrderDetails';
GO

-- Verify watermark values
SELECT *
FROM dbo.Ingestion_Watermark
ORDER BY TableName;
GO
