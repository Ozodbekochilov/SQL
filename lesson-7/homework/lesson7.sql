--Easy-Level Tasks (10)
--TASK-1
--Write a query to find the minimum (MIN) price of a product in the Products table.
SELECT MIN(Price) AS MinProductPrice
FROM Products


--TASK-2
--Write a query to find the maximum (MAX) Salary from the Employees table.
SELECT MAX(Salary) MaxEmployeeSalary
FROM Employees


--TASK-3
--Write a query to count the number of rows in the Customers table.
SELECT COUNT(*)
FROM Customers


--TASK-4
--Write a query to count the number of unique product categories from the Products table.
SELECT COUNT(DISTINCT Category)
FROM Products


--TASK-5
--Write a query to find the total sales amount for the product with id 7 in the Sales table.
SELECT ProductID, SUM(SaleAmount) AS ProductSaleAmount
FROM Sales
WHERE ProductID = 7
GROUP BY ProductID


--TASK-6
--Write a query to calculate the average age of employees in the Employees table.
SELECT AVG(Age) AS AVG_AGE
FROM Employees


--TASK-7
--Write a query to count the number of employees in each department.
SELECT DepartmentName, COUNT(*)
FROM Employees
GROUP BY DepartmentName
select * from Employees

--TASK-8
--Write a query to show the minimum and maximum Price of products grouped by Category. Use products table.
SELECT Category, MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice
FROM Products
GROUP BY category


--TASK-9
--Write a query to calculate the total sales per Customer in the Sales table.
SELECT CustomerID, SUM(SaleAmount) AS CustomerSaleAmount
FROM Sales 
GROUP BY CustomerID


--TASK-10
--Write a query to filter departments having more than 5 employees from the Employees table.(DeptID is enough, if you don't have DeptName).
SELECT DepartmentName, COUNT(*) AS DepartmentCount
FROM Employees
GROUP BY DepartmentName
HAVING COUNT(*) > 5




--Medium-Level Tasks (9)
--TASK-1
--Write a query to calculate the total sales and average sales for each product category from the Sales table.
SELECT ProductID, SUM(SaleAmount) AS ProductSUM, AVG(SaleAmount) AS ProductAVG 
FROM Sales
GROUP BY ProductID


--TASK-2
--Write a query to count the number of employees from the Department HR.
SELECT DepartmentName, COUNT(*) AS DepartmentCount
FROM Employees
WHERE DepartmentName = 'HR'
GROUP BY DepartmentName


--TASK-3
--Write a query that finds the highest and lowest Salary by department in the Employees table.(DeptID is enough, if you don't have DeptName).
SELECT DepartmentName, MAX(Salary) AS MaxSalary, MIN(Salary) AS MinSalary
FROM Employees	
GROUP BY DepartmentName


--TASK-4
--Write a query to calculate the average salary per Department.(DeptID is enough, if you don't have DeptName).
SELECT DepartmentName, AVG(Salary) AS AvgSalary
FROM Employees	
GROUP BY DepartmentName


--TASK-5
--Write a query to show the AVG salary and COUNT(*) of employees working in each department.(DeptID is enough, if you don't have DeptName).
SELECT DepartmentName, AVG(Salary) AS AvgSalary
FROM Employees	
GROUP BY DepartmentName


--TASK-6
--Write a query to filter product categories with an average price greater than 400.
SELECT Category, AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 400;


--TASK-7
--Write a query that calculates the total sales for each year in the Sales table.
SELECT YEAR(SaleDate) AS YearSaleDate, SUM(SaleAmount) AS YearSaleAmount
FROM Sales
GROUP BY YEAR(SaleDate)


--TASK-8
--Write a query to show the list of customers who placed at least 3 orders.
SELECT CustomerID, COUNT(*) AS CustomerOrderCount
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*)> 3


--TASK-9
--Write a query to filter out Departments with average salary expenses greater than 60000.(DeptID is enough, if you don't have DeptName).
SELECT DepartmentName, AVG(Salary) AS DepartmentAvgSalary
FROM Employees
GROUP BY DepartmentName 
HAVING AVG(Salary) > 60000




--Hard-Level Tasks (6)
--TASK-1
--Write a query that shows the average price for each product category, and then filter categories with an average price greater than 150.
SELECT Category, AVG(Price) AS CategoryAvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 150


--TASK-2
--Write a query to calculate the total sales for each Customer, then filter the results to include only Customers with total sales over 1500.
SELECT CustomerID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID
HAVING SUM(SaleAmount) > 1500


--TASK-3
--Write a query to find the total and average salary of employees in each department, and filter the output to include only departments with an average salary greater than 65000.
SELECT DepartmentName, SUM(Salary) AS DepartmentSumSalary, AVG(Salary) AS DepartmentAvgSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 65000


--TASK-4
--Write a query to find total amount for the orders which weights more than $50 for each customer along with their least purchases.(least amount might be lower than 50, use tsql2012.sales.orders table,freight col, ask ur assistant to give the TSQL2012 database).


--TASK-5
--Write a query that calculates the total sales and counts unique products sold in each month of each year, and then filter the months with at least 2 products sold.(Orders)
SELECT 
    YEAR(OrderDate) AS Year,
    MONTH(OrderDate) AS Month,
    SUM(TotalAmount) AS TotalSales,
    COUNT(DISTINCT ProductID) AS UniqueProductCount
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
HAVING COUNT(DISTINCT ProductID) >= 2;


--TASK-6
--Write a query to find the MIN and MAX order quantity per Year. From orders table. Necessary tables:
SELECT YEAR(OrderDate) AS YearAmount, MIN(TotalAmount), MAX(TotalAmount)
FROM Orders 
GROUP BY YEAR(OrderDate)
