--Easy-Level Tasks
--TASK-1
--Using Products table, find the total number of products available in each category.
SELECT Category, COUNT(ProductName) AS CategoryCount
FROM Products
GROUP BY Category


--TASK-2
--Using Products table, get the average price of products in the 'Electronics' category.
SELECT Category, AVG(Price) AS CategoryAvg
FROM Products
WHERE Category = 'Electronics'
GROUP BY Category


--TASK-3
--Using Customers table, list all customers from cities that start with 'L'.
SELECT *
FROM Customers
WHERE City LIKE 'L%';


--TASK-4
--Using Products table, get all product names that end with 'er'.
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%er'


--TASK-5
--Using Customers table, list all customers from countries ending in 'A'.
SELECT *
FROM Customers
WHERE Country LIKE '%a'


--TASK-6
--Using Products table, show the highest price among all products.
SELECT MAX(Price) AS HighestPrice 
FROM Products;


--TASK-7
--Using Products table, label stock as 'Low Stock' if quantity < 30, else 'Sufficient'.
SELECT StockQuantity, 
CASE 
	WHEN StockQuantity < 30 THEN 'Low Stock'
	ELSE 'Sufficient'
END AS StockInfo
FROM Products


--TASK-8
--Using Customers table, find the total number of customers in each country.
SELECT Country, COUNT(*) AS CountryCount
FROM Customers 
GROUP BY Country


--TASK-9
--Using Orders table, find the minimum and maximum quantity ordered.
SELECT MIN(Quantity) AS MinAmount, MAX(Quantity) AS MaxAmount
FROM Orders





--Medium-Level Tasks
--TASK-1
--Using Orders and Invoices tables, list customer IDs who placed orders in 2023 January to find those who did not have invoices.
SELECT DISTINCT CustomerID
FROM Orders
WHERE OrderDate >= '2023-01-01' AND OrderDate < '2023-02-01'
  AND CustomerID NOT IN (
    SELECT CustomerID
    FROM Invoices
  );


--TASK-2
--Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted including duplicates.
SELECT ProductName 
FROM Products
UNION ALL
SELECT ProductName 
FROM Products_Discounted;


--TASK-3
--Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted without duplicates.
SELECT ProductName 
FROM Products
UNION 
SELECT ProductName 
FROM Products_Discounted;


--TASK-4
--Using Orders table, find the average order amount by year.
SELECT YEAR(OrderDate) AS YearDate, AVG(TotalAmount) AS AvgOrderAmount
FROM Orders
GROUP BY YEAR(OrderDate)
ORDER BY YearDate


--TASK-5
--Using Products table, group products based on price: 'Low' (<100), 'Mid' (100-500), 'High' (>500). Return productname and pricegroup.
SELECT 
  ProductName,
  Price,
  CASE
    WHEN Price < 100 THEN 'Low'
    WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
    ELSE 'High'
  END AS PriceGroup
FROM Products;


--TASK-6
--Using City_Population table, use Pivot to show values of Year column in seperate columns ([2012], [2013]) and copy results to a new Population_Each_Year table.
SELECT City, [2012], [2013]
INTO Population_Each_Year
FROM (
    SELECT City, Year, Population
    FROM City_Population
) AS SourceTable
PIVOT (
    SUM(Population)
    FOR Year IN ([2012], [2013])
) AS PivotTable;



--TASK-7
--Using Sales table, find total sales per product Id.
SELECT ProductID, SUM(SaleAmount) AS TotalAmount
FROM Sales
GROUP BY ProductID


--TASK-8
--Using Products table, use wildcard to find products that contain 'oo' in the name. Return productname.
SELECT ProductName
FROM Products 
WHERE ProductName LIKE '%oo%'


--TASK-9
--Using City_Population table, use Pivot to show values of City column in seperate columns (Bektemir, Chilonzor, Yakkasaroy) and copy results to a new Population_Each_City table.
SELECT Year, [Bektemir], [Chilonzor], [Yakkasaroy]
INTO Population_Each_City
FROM (
    SELECT City, Year, Population
    FROM City_Population
    WHERE City IN ('Bektemir', 'Chilonzor', 'Yakkasaroy')
) AS SourceTable
PIVOT (
    SUM(Population)
    FOR City IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS PivotTable;





--Hard-Level Tasks
--TASK-1
--Using Invoices table, show top 3 customers with the highest total invoice amount. Return CustomerID and Totalspent.
SELECT TOP 3 CustomerID, SUM(TotalAmount) AS TotalAmount
FROM Invoices 
GROUP BY CustomerID
ORDER BY TotalAmount DESC


--TASK-2
--Transform Population_Each_Year table to its original format (City_Population).
SELECT City, '2012' AS Year, [2012] AS Population FROM Population_Each_Year
UNION ALL
SELECT City, '2013' AS Year, [2013] AS Population FROM Population_Each_Year;


--TASK-3
--Using Products and Sales tables, list product names and the number of times each has been sold. (Research for Joins)
SELECT p.ProductName, COUNT(s.ProductID) AS CountProduct
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName


--TASK-4
--Transform Population_Each_City table to its original format (City_Population).
SELECT 
  City,
  Year,
  Population
FROM (
  SELECT 
    Year,
    [Bektemir],
    [Chilonzor],
    [Yakkasaroy]
  FROM Population_Each_City
) AS PivotedTable
UNPIVOT (
  Population FOR City IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS UnpivotedTable;
