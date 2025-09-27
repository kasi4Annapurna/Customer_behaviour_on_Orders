-- Drop tables if they exist to avoid conflicts
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customer;

-- Create Customers Table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    City VARCHAR(50)
);

-- Create Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2)
);

-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert Customers
INSERT INTO Customer VALUES
(1, 'Kasi', 'Annapurna', 'kasi.a@example.com', 'Hyderabad'),
(2, 'Ravi', 'Kumar', 'ravi.k@example.com', 'Bangalore'),
(3, 'Anjali', 'Sharma', 'anjali.s@example.com', 'Chennai'),
(4, 'Vikram', 'Singh', 'vikram.s@example.com', 'Delhi'),
(5, 'Neha', 'Patel', 'neha.p@example.com', 'Ahmedabad'),
(6, 'Arjun', 'Das', 'arjun.d@example.com', 'Kolkata'),
(7, 'Sonal', 'Gupta', 'sonal.g@example.com', 'Mumbai'),
(8, 'Aditya', 'Rao', 'aditya.r@example.com', 'Pune'),
(9, 'Maya', 'Iyer', 'maya.i@example.com', 'Chennai'),
(10, 'Rahul', 'Mehta', 'rahul.m@example.com', 'Surat'),
(11, 'Pooja', 'Singh', 'pooja.s@example.com', 'Lucknow'),
(12, 'Amit', 'Shah', 'amit.s@example.com', 'Jaipur'),
(13, 'Rhea', 'Kapoor', 'rhea.k@example.com', 'Delhi'),
(14, 'Karan', 'Verma', 'karan.v@example.com', 'Bangalore'),
(15, 'Simran', 'Malhotra', 'simran.m@example.com', 'Chandigarh'),
(16, 'Tarun', 'Nair', 'tarun.n@example.com', 'Hyderabad'),
(17, 'Deepa', 'Chatterjee', 'deepa.c@example.com', 'Kolkata'),
(18, 'Manish', 'Joshi', 'manish.j@example.com', 'Mumbai'),
(19, 'Sneha', 'Desai', 'sneha.d@example.com', 'Ahmedabad'),
(20, 'Vivek', 'Malik', 'vivek.m@example.com', 'Pune');

-- Insert Products
INSERT INTO Products VALUES
(101, 'Smartphone', 'Electronics', 700.00),
(102, 'Laptop', 'Electronics', 1200.00),
(103, 'Wireless Earbuds', 'Electronics', 150.00),
(104, 'Coffee Maker', 'Appliances', 80.00),
(105, 'Electric Kettle', 'Appliances', 45.00),
(106, 'Bluetooth Speaker', 'Electronics', 60.00),
(107, 'LED TV 42 inch', 'Electronics', 400.00),
(108, 'Microwave Oven', 'Appliances', 150.00),
(109, 'Smartwatch', 'Electronics', 200.00),
(110, 'Gaming Mouse', 'Electronics', 40.00),
(111, 'Refrigerator 250L', 'Appliances', 500.00),
(112, 'Blender', 'Appliances', 90.00),
(113, 'Tablet', 'Electronics', 350.00),
(114, 'Air Purifier', 'Appliances', 120.00),
(115, 'Fitness Band', 'Electronics', 100.00),
(116, 'Hair Dryer', 'Appliances', 30.00),
(117, 'Digital Camera', 'Electronics', 300.00),
(118, 'Dishwasher', 'Appliances', 600.00),
(119, 'Router', 'Electronics', 70.00),
(120, 'Electric Grill', 'Appliances', 60.00);

-- Insert Orders
INSERT INTO Orders VALUES
(5001, 1, 101, 1, '2025-08-01'),
(5002, 2, 102, 1, '2025-08-02'),
(5003, 3, 103, 2, '2025-08-03'),
(5004, 4, 104, 1, '2025-08-04'),
(5005, 5, 105, 1, '2025-08-05'),
(5006, 6, 106, 2, '2025-08-06'),
(5007, 7, 107, 1, '2025-08-07'),
(5008, 8, 108, 1, '2025-08-08'),
(5009, 9, 109, 1, '2025-08-09'),
(5010, 10, 110, 2, '2025-08-10'),
(5011, 11, 111, 1, '2025-08-11'),
(5012, 12, 112, 1, '2025-08-12'),
(5013, 13, 113, 2, '2025-08-13'),
(5014, 14, 114, 1, '2025-08-14'),
(5015, 15, 115, 1, '2025-08-15'),
(5016, 16, 116, 1, '2025-08-16'),
(5017, 17, 117, 1, '2025-08-17'),
(5018, 18, 118, 1, '2025-08-18'),
(5019, 19, 119, 1, '2025-08-19'),
(5020, 20, 120, 1, '2025-08-20');

--a) Get detailed order info (Customer + Product + Order details):
SELECT 
  o.OrderID,
  c.FirstName, c.LastName, c.City,
  p.ProductName, p.Category, p.Price,
  o.Quantity,
  o.OrderDate
FROM Orders o
JOIN Customer c ON o.CustomerID = c.CustomerID
JOIN Products p ON o.ProductID = p.ProductID
ORDER BY o.OrderDate;

--a) Total orders per customer:

SELECT 
  c.CustomerID, c.FirstName, c.LastName,
  COUNT(o.OrderID) AS TotalOrders
FROM Customer c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY TotalOrders DESC;

--b) Total amount spent per customer:

SELECT 
  c.CustomerID, c.FirstName, c.LastName,
  SUM(p.Price * o.Quantity) AS TotalSpent
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY TotalSpent DESC;

--1. Customer purchase frequency
--How often does each customer place orders?
SELECT 
  c.CustomerID, c.FirstName, c.LastName,
  COUNT(o.OrderID) AS NumberOfOrders,
  DATEDIFF(DAY, MIN(o.OrderDate), MAX(o.OrderDate)) AS DaysBetweenFirstAndLastOrder,
  CASE 
    WHEN COUNT(o.OrderID) > 1 THEN 
      DATEDIFF(DAY, MIN(o.OrderDate), MAX(o.OrderDate)) / (COUNT(o.OrderID) - 1)
    ELSE NULL
  END AS AvgDaysBetweenOrders
FROM Customer c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY NumberOfOrders DESC;

--2. Top product categories per customer
--What categories does a customer buy most?


SELECT
  c.CustomerID, c.FirstName, c.LastName,
  p.Category,
  COUNT(*) AS NumberOfPurchases
FROM Orders o
JOIN Customer c ON o.CustomerID = c.CustomerID
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY c.CustomerID, c.FirstName, c.LastName, p.Category
ORDER BY c.CustomerID, NumberOfPurchases DESC;



--3. Average order value per customer
--How much does a customer spend on average per order?


SELECT 
  c.CustomerID, c.FirstName, c.LastName,
  AVG(p.Price * o.Quantity) AS AvgOrderValue
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY AvgOrderValue DESC;


--4. Customers who repeatedly bought same product
--Find customers who purchased the same product more than once.


SELECT
  c.CustomerID, c.FirstName, c.LastName,
  p.ProductID, p.ProductName,
  COUNT(*) AS PurchaseCount
FROM Orders o
JOIN Customer c ON o.CustomerID = c.CustomerID
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY c.CustomerID, c.FirstName, c.LastName, p.ProductID, p.ProductName
HAVING COUNT(*) > 1
ORDER BY PurchaseCount DESC;


--5. Recency of last purchase per customer
--How recent was the last purchase for each customer?


SELECT 
  c.CustomerID, c.FirstName, c.LastName,
  MAX(o.OrderDate) AS LastPurchaseDate,
  DATEDIFF(DAY, MAX(o.OrderDate), GETDATE()) AS DaysSinceLastPurchase
FROM Customer c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY DaysSinceLastPurchase ASC;



--6. Customer purchase by city
--Which cities have customers that buy the most?

SELECT 
  c.City,
  COUNT(o.OrderID) AS TotalOrders,
  SUM(p.Price * o.Quantity) AS TotalSales
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY c.City
ORDER BY TotalSales DESC;


CREATE VIEW  CustomerTotalSpent AS
SELECT 
  c.CustomerID, c.FirstName, c.LastName,
  SUM(p.Price * o.Quantity) AS TotalSpent
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY c.CustomerID, c.FirstName, c.LastName;


CREATE PROCEDURE GetCustomerPurchaseSummary
  @CustomerID INT
AS
BEGIN
  SELECT 
    c.FirstName, c.LastName,
    o.OrderID, p.ProductName, o.Quantity, o.OrderDate,
    p.Price, (p.Price * o.Quantity) AS TotalPrice
  FROM Orders o
  JOIN Customer c ON o.CustomerID = c.CustomerID
  JOIN Products p ON o.ProductID = p.ProductID
  WHERE c.CustomerID = @CustomerID
  ORDER BY o.OrderDate;
END;

--updating custoemrdetails
UPDATE Customer
SET Email = 'kasi.annapurna@example.com'
WHERE CustomerID = 1;
