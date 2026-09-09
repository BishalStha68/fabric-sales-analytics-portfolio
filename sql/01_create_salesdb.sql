CREATE DATABASE SalesDB;
GO

USE SalesDB;
GO

-- =============================================
-- Customers
-- =============================================
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(100) NOT NULL,
    Country NVARCHAR(50),
    City NVARCHAR(50),
    Segment NVARCHAR(50),
    CreatedDate DATETIME2 DEFAULT GETDATE(),
    LastModifiedDate DATETIME2 DEFAULT GETDATE()
);

-- =============================================
-- Products
-- =============================================
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50),
    SubCategory NVARCHAR(50),
    UnitPrice DECIMAL(10,2),
    LastModifiedDate DATETIME2 DEFAULT GETDATE()
);

-- =============================================
-- Orders
-- =============================================
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME2 NOT NULL,
    Status NVARCHAR(30),
    LastModifiedDate DATETIME2 DEFAULT GETDATE(),

    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);

-- =============================================
-- OrderDetails
-- =============================================
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2),
    Discount DECIMAL(5,2) DEFAULT 0,
    LastModifiedDate DATETIME2 DEFAULT GETDATE(),

    CONSTRAINT FK_OrderDetails_Orders
        FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID),

    CONSTRAINT FK_OrderDetails_Products
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
);

-- =============================================
-- Customers Data
-- =============================================
INSERT INTO Customers
(CustomerID, CustomerName, Country, City, Segment, CreatedDate, LastModifiedDate)
VALUES
(1, 'Everest Trading Pvt Ltd', 'Nepal', 'Kathmandu', 'Corporate', '2025-01-10', '2026-08-01'),
(2, 'Himalayan Retail Pvt Ltd', 'Nepal', 'Lalitpur', 'SMB', '2025-02-15', '2026-08-02'),
(3, 'Kathmandu Electronics', 'Nepal', 'Kathmandu', 'SMB', '2025-03-01', '2026-08-03'),
(4, 'Pokhara Supplies', 'Nepal', 'Pokhara', 'Corporate', '2025-04-10', '2026-08-04'),
(5, 'Chitwan Business Group', 'Nepal', 'Bharatpur', 'Enterprise', '2025-05-20', '2026-08-05'),
(6, 'Lumbini Traders', 'Nepal', 'Butwal', 'SMB', '2025-06-15', '2026-08-06'),
(7, 'Sagarmatha Enterprises', 'Nepal', 'Kathmandu', 'Enterprise', '2025-07-01', '2026-08-07'),
(8, 'Janakpur Distribution', 'Nepal', 'Janakpur', 'Corporate', '2025-08-12', '2026-08-08'),
(9, 'Biratnagar Wholesale', 'Nepal', 'Biratnagar', 'SMB', '2025-09-05', '2026-08-09'),
(10, 'Nepal Business Solutions', 'Nepal', 'Kathmandu', 'Enterprise', '2025-10-10', '2026-08-10');
GO

-- =============================================
-- Products Data
-- =============================================
INSERT INTO Products
(ProductID, ProductName, Category, SubCategory, UnitPrice, LastModifiedDate)
VALUES
(1, 'Laptop Pro 14', 'Electronics', 'Laptops', 1200.00, '2026-08-01'),
(2, 'Laptop Business 15', 'Electronics', 'Laptops', 950.00, '2026-08-01'),
(3, 'Wireless Mouse', 'Electronics', 'Accessories', 25.00, '2026-08-02'),
(4, 'Mechanical Keyboard', 'Electronics', 'Accessories', 85.00, '2026-08-02'),
(5, '27 Inch Monitor', 'Electronics', 'Monitors', 350.00, '2026-08-03'),
(6, 'Office Chair', 'Furniture', 'Office Furniture', 220.00, '2026-08-03'),
(7, 'Standing Desk', 'Furniture', 'Office Furniture', 450.00, '2026-08-04'),
(8, 'Office Desk', 'Furniture', 'Office Furniture', 300.00, '2026-08-04'),
(9, 'Printer LaserJet', 'Electronics', 'Printers', 500.00, '2026-08-05'),
(10, 'USB-C Hub', 'Electronics', 'Accessories', 65.00, '2026-08-05'),
(11, 'Webcam HD', 'Electronics', 'Accessories', 80.00, '2026-08-06'),
(12, 'Headset Pro', 'Electronics', 'Accessories', 120.00, '2026-08-06');
GO

-- =============================================
-- Orders Data
-- =============================================
INSERT INTO Orders
(OrderID, CustomerID, OrderDate, Status, LastModifiedDate)
VALUES
(1001, 1, '2026-01-05', 'Completed', '2026-01-05'),
(1002, 2, '2026-01-12', 'Completed', '2026-01-12'),
(1003, 3, '2026-02-03', 'Completed', '2026-02-03'),
(1004, 4, '2026-02-15', 'Completed', '2026-02-15'),
(1005, 5, '2026-03-01', 'Completed', '2026-03-01'),
(1006, 1, '2026-03-12', 'Completed', '2026-03-12'),
(1007, 7, '2026-04-05', 'Completed', '2026-04-05'),
(1008, 8, '2026-04-18', 'Completed', '2026-04-18'),
(1009, 9, '2026-05-02', 'Completed', '2026-05-02'),
(1010, 10, '2026-05-20', 'Completed', '2026-05-20'),
(1011, 2, '2026-06-08', 'Completed', '2026-06-08'),
(1012, 3, '2026-06-25', 'Completed', '2026-06-25'),
(1013, 5, '2026-07-10', 'Completed', '2026-07-10'),
(1014, 7, '2026-07-22', 'Completed', '2026-07-22'),
(1015, 1, '2026-08-05', 'Completed', '2026-08-05'),
(1016, 4, '2026-08-15', 'Completed', '2026-08-15');
GO

-- =============================================
-- OrderDetails Data
-- =============================================
INSERT INTO OrderDetails
(OrderDetailID, OrderID, ProductID, Quantity, UnitPrice, Discount, LastModifiedDate)
VALUES
(1, 1001, 1, 2, 1200.00, 0, '2026-01-05'),
(2, 1001, 3, 5, 25.00, 0, '2026-01-05'),
(3, 1002, 2, 3, 950.00, 50, '2026-01-12'),
(4, 1002, 4, 2, 85.00, 0, '2026-01-12'),
(5, 1003, 5, 1, 350.00, 0, '2026-02-03'),
(6, 1003, 10, 4, 65.00, 0, '2026-02-03'),
(7, 1004, 6, 4, 220.00, 0, '2026-02-15'),
(8, 1004, 8, 2, 300.00, 0, '2026-02-15'),
(9, 1005, 7, 2, 450.00, 0, '2026-03-01'),
(10, 1005, 11, 3, 80.00, 0, '2026-03-01'),
(11, 1006, 9, 1, 500.00, 0, '2026-03-12'),
(12, 1006, 3, 10, 25.00, 10, '2026-03-12'),
(13, 1007, 1, 1, 1200.00, 100, '2026-04-05'),
(14, 1007, 12, 5, 120.00, 0, '2026-04-05'),
(15, 1008, 2, 2, 950.00, 0, '2026-04-18'),
(16, 1008, 4, 3, 85.00, 0, '2026-04-18'),
(17, 1009, 5, 3, 350.00, 0, '2026-05-02'),
(18, 1009, 10, 2, 65.00, 0, '2026-05-02'),
(19, 1010, 6, 5, 220.00, 50, '2026-05-20'),
(20, 1010, 7, 1, 450.00, 0, '2026-05-20'),
(21, 1011, 8, 4, 300.00, 0, '2026-06-08'),
(22, 1011, 11, 2, 80.00, 0, '2026-06-08'),
(23, 1012, 9, 2, 500.00, 0, '2026-06-25'),
(24, 1012, 3, 8, 25.00, 0, '2026-06-25'),
(25, 1013, 1, 2, 1200.00, 0, '2026-07-10'),
(26, 1013, 12, 4, 120.00, 20, '2026-07-10'),
(27, 1014, 2, 3, 950.00, 0, '2026-07-22'),
(28, 1014, 10, 6, 65.00, 0, '2026-07-22'),
(29, 1015, 5, 2, 350.00, 0, '2026-08-05'),
(30, 1015, 4, 5, 85.00, 0, '2026-08-05'),
(31, 1016, 6, 3, 220.00, 0, '2026-08-15'),
(32, 1016, 11, 2, 80.00, 0, '2026-08-15');
GO
