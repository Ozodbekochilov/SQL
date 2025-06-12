--Easy Tasks
--TASK-1
--Create a numbers table using a recursive query from 1 to 1000.
;WITH cte AS(
	SELECT 1 AS Num
	UNION ALL 
	SELECT Num + 1 AS Num 
	FROM cte
	WHERE Num < 1000
)
SELECT * FROM cte 
OPTION (MAXRECURSION 0);


--TASK-2
--Write a query to find the total sales per employee using a derived table.(Sales, Employees)
SELECT e.FirstName, e.LastName, SalesMount.TotalAmount
FROM Employees e
JOIN (
    SELECT Employeeid, SUM(SalesAmount) AS TotalAmount
	FROM sales
	GROUP BY Employeeid
) AS SalesMount
ON e.EmployeeId = SalesMount.Employeeid


--TASK-3
--Create a CTE to find the average salary of employees.(Employees)
;WITH cte AS(
	SELECT employeeID, AVG(Salary) AS AvgSalary
	FROM Employees
	GROUP BY EmployeeId
)
SELECT * FROM cte


--TASK-4
--Write a query using a derived table to find the highest sales for each product.(Sales, Products)
SELECT p.ProductName, SalesMount.TotalAmount
FROM Products p
JOIN (
    SELECT ProductID, MAX(SalesAmount) AS TotalAmount
	FROM Sales
	GROUP BY ProductID
) AS SalesMount
ON p.ProductID = SalesMount.ProductID


--TASK-5
--Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.
;WITH cte AS(
	SELECT 1 AS Num
	UNION ALL 
	SELECT Num * 2 AS Num 
	FROM cte
	WHERE Num * 2 < 1000000
)
SELECT * FROM cte 
OPTION (MAXRECURSION 0);


--TASK-6
--Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
;WITH cte AS(
	SELECT EmployeeID, COUNT(*) AS CountSales
	FROM Sales
	GROUP BY EmployeeID
)
SELECT Employees.FirstName, Employees.LastName, cte.CountSales 
FROM cte
JOIN Employees ON cte.EmployeeID = Employees.EmployeeID
WHERE cte.CountSales > 5


--TASK-7
--Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
;WITH cte AS(
	SELECT ProductID, SUM(SalesAmount) AS TotalSum
	FROM Sales 
	GROUP BY ProductID 
)
SELECT p.ProductName, cte.TotalSum
FROM cte
JOIN Products p ON cte.ProductID = p.ProductID
WHERE cte.TotalSum > 500


--TASK-8
--Create a CTE to find employees with salaries above the average salary.(Employees)
;WITH cte AS (
	SELECT AVG(Salary) AvgSalary
	FROM Employees
)
SELECT e.FirstName, e.LastName, e.Salary, cte.AvgSalary
FROM Employees e
JOIN cte ON e.Salary > cte.AvgSalary 


--Medium Tasks
--TASK-1
--Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
SELECT TOP 5 e.FirstName, e.LastName, Sales.EmployeeCount
FROM Employees e
JOIN (
	SELECT EmployeeID, COUNT(*) AS EmployeeCount
	FROM Sales 
	GROUP BY EmployeeID
) AS Sales
ON e.EmployeeID = Sales.EmployeeID
ORDER BY Sales.EmployeeCount DESC


--TASK-2
--Write a query using a derived table to find the sales per product category.(Sales, Products)
SELECT p.CategoryID, SUM(s.TotalSales) AS TotalSales
FROM (
    SELECT ProductID, SalesAmount AS TotalSales
    FROM Sales
) AS s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.CategoryID
ORDER BY p.CategoryID;


--TASK-3
--Write a script to return the factorial of each value next to it.(Numbers1)
DECLARE @max INT;
SELECT @max = MAX(Number) FROM Numbers1;

;WITH Factorials AS (
    SELECT 1 AS Num, 1 AS Factorial
    UNION ALL
    SELECT Num + 1, Factorial * (Num + 1)
    FROM Factorials
    WHERE Num + 1 <= @max
)
SELECT n.Number, f.Factorial
FROM Numbers1 n
JOIN Factorials f ON n.Number = f.Num
ORDER BY n.Number;


--TASK-4
--This script uses recursion to split a string into rows of substrings for each character in the string.(Example)
--QILIB BILMADIM


--TASK-5
--Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
--QILIB BILMADIM


--TASK-6
--Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)



--Difficult Tasks
--TASK-1
--TASKThis script uses recursion to calculate Fibonacci numbers



--TASK-2
--Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
SELECT vals,
	STRING_AGG(Vals, ',') AS sddf
FROM FindSameCharacters
WHERE len(Vals) > 1
GROUP BY vals



--TASK-3
--Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)



--TASK-4
--Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)



--TASK-5
--Write a T-SQL query to remove the duplicate integer values present in the string column. Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)
