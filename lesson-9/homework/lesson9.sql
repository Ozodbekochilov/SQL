--EASY
--TASK-1
--Using Products, Suppliers table List all combinations of product names and supplier names.
SELECT p.ProductName, s.SupplierName
FROM Products p
CROSS JOIN Suppliers s


--TASK-2
--Using Departments, Employees table Get all combinations of departments and employees.
SELECT e.Name, d.DepartmentName
FROM Departments d
CROSS JOIN Employees e


--TASK-3
--Using Products, Suppliers table List only the combinations where the supplier actually supplies the product. Return supplier name and product name
SELECT p.ProductName, s.SupplierName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID


--TASK-4
--Using Orders, Customers table List customer names and their orders ID.
SELECT c.FirstName, o.OrderID
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID


--TASK-5
--Using Courses, Students table Get all combinations of students and courses.
SELECT s.Name, c.CourseName 
FROM Courses c
CROSS JOIN Students s   


--TASK-6
--Using Products, Orders table Get product names and orders where product IDs match.   
SELECT p.ProductName, o.OrderID
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID


--TASK-7
--Using Departments, Employees table List employees whose DepartmentID matches the department.
SELECT e.Name, d.DepartmentName
FROM Departments d
JOIN Employees e ON d.DepartmentID = e.DepartmentID


--TASK-8
--Using Students, Enrollments table List student names and their enrolled course IDs.
SELECT s.Name, e.CourseID
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID


--TASK-9
--Using Payments, Orders table List all orders that have matching payments.
SELECT p.paymentID, p.OrderID, o.TotalAmount 
FROM Payments p
JOIN Orders o ON p.OrderID = o.OrderID


--TASK-10
--Using Orders, Products table Show orders where product price is more than 100.
SELECT p.ProductName, o.OrderID, p.Price
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
WHERE p.Price > 100





--MEDIUM
--TASK-1
--Using Employees, Departments table List employee names and department names where department IDs are not equal. It means: Show all mismatched employee-department combinations.
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
CROSS JOIN Departments d
WHERE e.DepartmentID <> d.DepartmentID;

 
--TASK-2
--Using Orders, Products table Show orders where ordered quantity is greater than stock quantity.
SELECT 
    o.OrderID, 
    p.ProductName, 
    o.Quantity AS OrderedQuantity, 
    p.StockQuantity
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
WHERE o.Quantity > p.StockQuantity;


--TASK-3
--Using Customers, Sales table List customer names and product IDs where sale amount is 500 or more.
SELECT s.ProductID, c.FirstName, SUM(s.SaleAmount) AS TotalAmount
FROM Customers c
JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY s.ProductID, c.FirstName
HAVING SUM(s.SaleAmount) >= 500


--TASK-4
--Using Courses, Enrollments, Students table List student names and course names they’re enrolled in.
SELECT s.Name, c.CourseName
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID



--TASK-5
--Using Products, Suppliers table List product and supplier names where supplier name contains “Tech”.
SELECT p.ProductName, s.SupplierName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName LIKE '%tech%'


--TASK-6
--Using Orders, Payments table Show orders where payment amount is less than total amount.
SELECT o.OrderID, o.TotalAmount, p.Amount
FROM Orders o
JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.Amount < o.TotalAmount;


--TASK-7
--Using Employees and Departments tables, get the Department Name for each employee.	
SELECT e.Name, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID


--TASK-8
--Using Products, Categories table Show products where category is either 'Electronics' or 'Furniture'.
SELECT p.ProductName, c.CategoryName
FROM Products p
JOIN Categories c ON p.Category = c.CategoryID
WHERE c.CategoryName = 'Electronics' OR c.CategoryName = 'Furniture' 


--TASK-9
--Using Sales, Customers table Show all sales from customers who are from 'USA'.
SELECT s.SaleID, s.ProductID, c.FirstName, c.Country
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
WHERE c.Country = 'USA'


--TASK-10
--Using Orders, Customers table List orders made by customers from 'Germany' and order total > 100.
SELECT c.FirstName, c.Country, o.TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Country = 'Germany' AND o.TotalAmount > 100





--HARD-1
--TASK-1
--Using Employees table List all pairs of employees from different departments.
SELECT e1.Name AS Employee1, e2.Name AS Employee2
FROM Employees e1
JOIN Employees e2 ON e1.EmployeeID <> e2.EmployeeID
WHERE e1.DepartmentID <> e2.DepartmentID


--TASK-2	
--Using Payments, Orders, Products table List payment details where the paid amount is not equal to (Quantity × Product Price).
SELECT  pro.ProductName, pro.Price, o.Quantity, p.Amount
FROM Payments p 
JOIN Orders o ON p.OrderID = o.OrderID
JOIN Products pro ON o.ProductID = pro.ProductID
WHERE p.Amount <> (o.Quantity * pro.Price)


--TASK-3
--Using Students, Enrollments, Courses table Find students who are not enrolled in any course.
SELECT *
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.StudentID IS NULL


--TASK-4
--Using Employees table List employees who are managers of someone, but their salary is less than or equal to the person they manage.
SELECT e1.Name AS EmpName, e1.Salary AS EmpSalary, m1.Name AS ManName, m1.Salary AS ManSalary 
FROM Employees e1
JOIN Employees m1 ON e1.ManagerID = m1.EmployeeID
WHERE m1.Salary <= e1.Salary


--TASK-5
--Using Orders, Payments, Customers table List customers who have made an order, but no payment has been recorded for it.
select *
from Orders o
left join Payments p ON o.OrderID = p.OrderID 
join Customers c ON o.CustomerID = c.CustomerID
where p.PaymentID is null
