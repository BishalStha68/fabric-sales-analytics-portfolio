USE SalesDB;
GO

-- =============================================
-- Incremental Load Testing
-- =============================================

-- 1. Check current watermark values
SELECT *
FROM dbo.Ingestion_Watermark
ORDER BY TableName;
GO

-- 2. Check records newer than the current watermark
--    Example: Orders
SELECT *
FROM dbo.Orders
WHERE LastModifiedDate >
(
    SELECT WatermarkValue
    FROM dbo.Ingestion_Watermark
    WHERE TableName = 'Orders'
);
GO

-- 3. Simulate a new/updated record
--    Uncomment only when intentionally testing.
--
-- UPDATE dbo.Orders
-- SET Status = 'Completed',
--     LastModifiedDate = SYSDATETIME()
-- WHERE OrderID = 1001;
-- GO

-- 4. After running the Fabric pipeline,
--    verify the watermark has advanced.
SELECT *
FROM dbo.Ingestion_Watermark
ORDER BY TableName;
GO

-- 5. Verify source row counts
SELECT 'Customers' AS TableName, COUNT(*) AS RowCount
FROM dbo.Customers
UNION ALL
SELECT 'Products', COUNT(*)
FROM dbo.Products
UNION ALL
SELECT 'Orders', COUNT(*)
FROM dbo.Orders
UNION ALL
SELECT 'OrderDetails', COUNT(*)
FROM dbo.OrderDetails;
GO
