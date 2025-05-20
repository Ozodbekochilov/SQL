--EASY--
--TASK-1
--Write a query to select the top 5 employees from the Employees table.
SELECT TOP 5 Salary 
FROM Employees 
ORDER BY Salary DESC


--TASK-2
--Use SELECT DISTINCT to select unique CategoryName values from the Products table.
SELECT DISTINCT ProductName
FROM Products 


--TASK-3
--Write a query that filters the Products table to show products with Price > 100.
SELECT * 
FROM Products 
WHERE Price > 100


--TASK-4
--Write a query to select all Customers whose FirstName start with 'A' using the LIKE operator.
SELECT * 
FROM Customers
WHERE FirstName LIKE 'A%'


--TASK-5
--Order the results of a Products table by Price in ascending order.
SELECT * 
FROM Products
ORDER BY Price ASC


--TASK-6
--Write a query that uses the WHERE clause to filter for employees with Salary >= 60000 and Department = 'HR'.
SELECT * 
FROM Employees
WHERE Salary > 60000 AND DepartmentName = 'HR'


--TASK-7
--Use ISNULL to replace NULL values in the Email column with the text "noemail@example.com".From Employees table
SELECT 
  ISNULL(Email, 'noemail@example.com') AS Email
  -- boshqa ustunlar
FROM Employees;


--TASK-8
--Write a query that shows all products with Price BETWEEN 50 AND 100.
SELECT *
FROM Products
WHERE Price BETWEEN 50 AND 100 


--TASK-9
--Use SELECT DISTINCT on two columns (Category and ProductName) in the Products table.
SELECT DISTINCT Category, ProductName
FROM Products


--TASK-10
--After SELECT DISTINCT on two columns (Category and ProductName) Order the results by ProductName in descending order
SELECT DISTINCT Category, ProductName
FROM Products
ORDER BY ProductName DESC





--MEDIUM--
--TASK-1
--Write a query to select the top 10 products from the Products table, ordered by Price DESC.
SELECT TOP 10 *
FROM Products 
ORDER BY Price DESC


--TASK-2
--Use COALESCE to return the first non-NULL value from FirstName or LastName in the Employees table.
SELECT COALESCE(FirstName, LastName) AS Name
FROM Employees;


--TASK-3
--Write a query that selects distinct Category and Price from the Products table.
SELECT DISTINCT Category, Price
FROM Products


--TASK-4
-- Write a query that filters the Employees table to show employees whose Age is either between 30 and 40 or Department = 'Marketing'.   
SELECT * 
FROM Employees
WHERE Age BETWEEN 30 AND 50 OR DepartmentName = 'Marketing' 


--TASK-5
--Use OFFSET-FETCH to select rows 11 to 20 from the Employees table, ordered by Salary DESC.
SELECT * FROM Employees
ORDER BY Salary
OFFSET 10 ROWS
FETCH NEXT 20 ROWS ONLY;


--TASK-6
--Write a query to display all products with Price <= 1000 and Stock > 50, sorted by Stock in ascending order.
SELECT *
FROM Products
WHERE Price < 1000 AND StockQuantity > 50


--TASK-7
--Write a query that filters the Products table for ProductName values containing the letter 'e' using LIKE.
SELECT * 
FROM Products
WHERE ProductName LIKE '%e%'


--TASK-8
--Use IN operator to filter for employees who work in either 'HR', 'IT', or 'Finance'.
SELECT *
FROM Employees
WHERE DepartmentName IN('HR', 'IT', 'Finance')


--TASK-9
--Use ORDER BY to display a list of customers ordered by City in ascending and PostalCode in descending order.Use customers table
SELECT * 
FROM Customers
ORDER BY City ASC, PostalCode DESC;





--HARD-
--TASK-1
--Write a query that selects the top 5 products with the highest sales, using TOP(5) and ordered by SalesAmount DESC.
SELECT TOP 5 ProductID, SUM(SaleAmount) AS TotalAmount
FROM Sales
GROUP BY ProductID
ORDER BY TotalAmount DESC

SELECT  *
FROM Sales
--TASK-2
--Combine FirstName and LastName into one column named FullName in the Employees table. (only in select statement)
SELECT
	CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees


--TASK-3
--Write a query to select the distinct Category, ProductName, and Price for products that are priced above $50, using DISTINCT on three columns.
SELECT DISTINCT Category, ProductName, Price 
FROM Products
WHERE Price > 50


--TASK-4
--Write a query that selects products whose Price is less than 10% of the average price in the Products table. (Do some research on how to find average price of all products)
SELECT *
FROM Products
WHERE Price < (
    SELECT AVG(Price) * 0.1
    FROM Products
);


--TASK-5
--Use WHERE clause to filter for employees whose Age is less than 30 and who work in either the 'HR' or 'IT' department.
SELECT *
FROM Employees
WHERE Age < 30 AND DepartmentName IN('HR','IT')


--TASK-6
--Use LIKE with wildcard to select all customers whose Email contains the domain '@gmail.com'.
SELECT * 
FROM Customers
WHERE Email LIKE '%@gmail.com'

--TASK-7
--Write a query that uses the ALL operator to find employees whose salary is greater than all employees in the 'Sales' department.
SELECT ProductName, Price
FROM Products
WHERE Price > ALL (
    SELECT Price
    FROM Products
    WHERE Category = 'Electronics'
);



--TASK-8
--Write a query that filters the Orders table for orders placed in the last 180 days using BETWEEN and LATEST_DATE in the table. (Search how to get the current date and latest date)
SELECT *
FROM Orders
WHERE OrderDate BETWEEN DATEADD(DAY, -180, GETDATE()) AND GETDATE();


