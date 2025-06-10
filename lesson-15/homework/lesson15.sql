--LEVEL-1
--TASK-1
--Task: Retrieve employees who earn the minimum salary in the company. Tables: employees (columns: id, name, salary)
SELECT * 
FROM Employees
WHERE Salary = (
	SELECT MIN(Salary)
	FROM Employees
)


--TASK-2
SELECT * 
FROM Products
WHERE Price > (
	SELECT AVG(Price)
	FROM Products
)




--LEVEL-2
--TASK-1
--Find Employees in Sales Department Task: Retrieve employees who work in the "Sales" department. Tables: employees (columns: id, name, department_id), departments (columns: id, department_name)
SELECT e.id, e.name,(
	SELECT d.department_name 
	FROM departments d
	WHERE d.id = e.department_id
)
FROM employees e
WHERE e.department_id = (
	SELECT id 
	FROM departments
	WHERE Department_Name = 'Sales'
)


--TASK-2
--Retrieve customers who have not placed any orders. Tables: customers (columns: customer_id, name), orders (columns: order_id, customer_id)
SELECT * FROM Customers
SELECT * FROM Orders

SELECT c.Customer_ID, c.Name, o.Order_ID
FROM Customers c
LEFT JOIN Orders o ON c.Customer_ID = o.Customer_ID
WHERE o.Customer_ID IS NULL




--LEVEL-3
--TASK-1
--Task: Retrieve products with the highest price in each category. Tables: products (columns: id, product_name, price, category_id)
SELECT * 
FROM Products A
WHERE Price = (
	SELECT MAX(price)
	FROM products B
	WHERE A.Category_id = B.Category_id)


--TASK-2
--Task: Retrieve employees working in the department with the highest average salary. Tables: employees (columns: id, name, salary, department_id), departments (columns: id, department_name)
SELECT A.id, A.name, A.Salary, d.Department_Name
FROM employees A
JOIN Departments d ON A.Department_ID = d.ID
WHERE salary > (
	SELECT TOP 1 AVG(salary)
	FROM employees B
	WHERE A.Department_ID = B.Department_ID
) 




--LEVEL-4
--TASK-1
--Task: Retrieve employees earning more than the average salary in their department. Tables: employees (columns: id, name, salary, department_id)
SELECT *
FROM employees A
WHERE Salary > (
	SELECT AVG(salary)
	FROM employees B
	WHERE A.Department_id = B.Department_id
)


--TASK-2
--Task: Retrieve students who received the highest grade in each course. Tables: students (columns: student_id, name), grades (columns: student_id, course_id, grade)
SELECT s.Name, A.Course_id, A.Grade
FROM Grades A
JOIN Students s ON A.Student_id = s.Student_id
WHERE Grade = (
	SELECT MAX(Grade)
	FROM Grades B 
	WHERE A.Course_id = B.Course_id
)




--LEVEL-5
--TASK-1
--Find Third-Highest Price per Category Task: Retrieve products with the third-highest price in each category. Tables: products (columns: id, product_name, price, category_id)
select * 
from products p1
where 3 = (
	select COUNT(DISTINCT price)
	from products p2
	where p1.category_id = p2.category_id AND p1.price <= p2.price
)


--TASK-2
--Task: Retrieve employees with salaries above the company average but below the maximum in their department. Tables: employees (columns: id, name, salary, department_id)
SELECT * from employees

SELECT e.id, e.name, e.salary, e.department_id
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary) FROM employees
)
AND e.salary < (
    SELECT MAX(salary)
    FROM employees d
    WHERE d.department_id = e.department_id
);
