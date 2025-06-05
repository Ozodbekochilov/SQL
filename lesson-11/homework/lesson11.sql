--Easy-Level Tasks (7)
--TASK-1
--Return: OrderID, CustomerName, OrderDate Task: Show all orders placed after 2022 along with the names of the customers who placed them.Tables Used: Orders, Customers
SELECT o.OrderID, c.FirstName + ' ' + c.LastName AS CustomerName, o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate > '2022-12-31'


 --TASK-2
--Return: EmployeeName, DepartmentName Task: Display the names of employees who work in either the Sales or Marketing department. Tables Used: Employees, Departments
SELECT e.Name, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sales' OR d.DepartmentName = 'Marketing'


--TASK-3
--Return: DepartmentName, MaxSalaryTask: Show the highest salary for each department.Tables Used: Departments, Employees
SELECT d.DepartmentName, MAX(Salary) AS MaxSalary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName


--TASK-4
--Return: CustomerName, OrderID, OrderDate Task: List all customers from the USA who placed orders in the year 2023.Tables Used: Customers, Orders
SELECT c.FirstName + ' ' + c.LastName AS CustomerName, o.OrderID, o.OrderDate, c.Country
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 2023 AND c.Country = 'USA'


--TASK-5
--Return: CustomerName, TotalOrders Task: Show how many orders each customer has placed.Tables Used: Orders , Customers
SELECT c.FirstName + ' ' + c.LastName AS CustomerName, COUNT(o.OrderID) AS CustomerCount
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID 
GROUP BY c.FirstName, c.LastName


--TASK-6
--Return: ProductName, SupplierName Task: Display the names of products that are supplied by either Gadget Supplies or Clothing Mart.Tables Used: Products, Suppliers
SELECT p.ProductName, s.SupplierName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID 
WHERE s.SupplierName = 'Gadget Supplies' OR s.SupplierName = 'Clothing Mart'


--TASK-7
--Return: CustomerName, MostRecentOrderDate Task: For each customer, show their most recent order. Include customers who haven't placed any orders. Tables Used: Customers, Orders
SELECT c.FirstName + ' ' + c.LastName AS CustomerName, MAX(o.OrderDate) AS MaxOrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName





--🟠 Medium-Level Tasks (6)
--TASK-1
--Return: CustomerName, OrderTotal Task: Show the customers who have placed an order where the total amount is greater than 500.Tables Used: Orders, Customers
SELECT c.FirstName + ' ' + c.LastName AS CustomerName, SUM(o.TotalAmount) AS OrderTotal
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName
HAVING SUM(o.TotalAmount) > 500


--TASK-2
--Return: ProductName, SaleDate, SaleAmount Task: List product sales where the sale was made in 2022 or the sale amount exceeded 400. Tables Used: Products, Sales
SELECT p.ProductName, s.SaleDate, s.SaleAmount
FROM Products p 
JOIN Sales s ON p.ProductID = s.ProductID
WHERE YEAR(s.SaleDate) = 2022 OR s.SaleAmount > 400


--TASK-3
--Return: ProductName, TotalSalesAmount Task: Display each product along with the total amount it has been sold for.Tables Used: Sales, Products
SELECT p.ProductName, SUM(s.SaleAmount) AS TotalSalesAmount
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName


--TASK-4
--Return: EmployeeName, DepartmentName, Salary Task: Show the employees who work in the HR department and earn a salary greater than 60000.Tables Used: Employees, Departments
SELECT e.Name, d.DepartmentName, e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'HR' AND e.Salary > 60000


--TASK-5
--Return: ProductName, SaleDate, StockQuantity Task: List the products that were sold in 2023 and had more than 100 units in stock at the time.Tables Used: Products, Sales
SELECT p.ProductName, s.SaleDate, p.StockQuantity
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
WHERE YEAR(s.SaleDate) = 2023 AND p.StockQuantity > 100


--TASK-6
--Return: EmployeeName, DepartmentName, HireDate Task: Show employees who either work in the Sales department or were hired after 2020. Tables Used: Employees, Departments
SELECT e.Name, d.DepartmentName, e.HireDate
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID 
WHERE d.DepartmentName = 'Sales' OR YEAR(e.HireDate) > 2020





-- Hard-Level Tasks (7)
--TASK-1
--Return: CustomerName, OrderID, Address, OrderDate Task: List all orders made by customers in the USA whose address starts with 4 digits. Tables Used: Customers, Orders
SELECT c.FirstName + ' ' + c.LastName AS CustomerName, o.OrderID, c.Address, o.OrderDate, c.Country
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA' AND c.Address LIKE '4%'


--TASK-2
--Return: ProductName, Category, SaleAmountTask: Display product sales for items in the Electronics category or where the sale amount exceeded 350. Tables Used: Products, Sales
SELECT p.ProductName, c.CategoryName, s.SaleAmount
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID 
JOIN Categories c ON p.Category = c.CategoryID
WHERE c.CategoryName = 'Electronics' OR s.SaleAmount > 350


--TASK-3
--Return: CategoryName, ProductCount Task: Show the number of products available in each category. Tables Used: Products, Categories
SELECT c.CategoryName, COUNT(p.ProductID) AS ProductCount
FROM Products p 
JOIN Categories c ON p.Category = c.CategoryID
GROUP BY c.CategoryName


--TASK-4
--Return: CustomerName, City, OrderID, Amount Task: List orders where the customer is from Los Angeles and the order amount is greater than 300.Tables Used: Customers, Orders
SELECT c.FirstName + ' ' + c.LastName AS CustomerName, c.City, o.OrderID, o.TotalAmount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID 
WHERE c.City = 'Los Angeles' AND o.TotalAmount > 300


--TASK-5
--Return: EmployeeName, DepartmentName Task: Display employees who are in the HR or Finance department, or whose name contains at least 4 vowels. Tables Used: Employees, Departments
SELECT e.Name, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN('HR', 'Finance') OR
    LEN(e.Name)
  - LEN(REPLACE(LOWER(e.Name), 'a', ''))
  + LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'e', ''))
  + LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'i', ''))
  + LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'o', ''))
  + LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'u', '')) >= 4;


--TASK-6
--Return: EmployeeName, DepartmentName, Salary Task: Show employees who are in the Sales or Marketing department and have a salary above 60000. Tables Used: Employees, Departments
SELECT e.Name, d.DepartmentName, e.Salary		
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID 
WHERE d.DepartmentName IN('Sales', 'Marketing') AND e.Salary > 60000
