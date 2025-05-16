--EASY-
--TASK-1
CREATE TABLE Employees(
	EmpID INT, 
	Name VARCHAR(50),
	Salary DECIMAL(10,2)
)


--TASK-2
INSERT INTO Employees (EmpID, Name, Salary)
VALUES
(1, 'Ozodbek', 1000)

INSERT INTO Employees (EmpID, Name, Salary)
VALUES
(2, 'Otabek', 8000),
(3, 'Oybek', 9000)


--TASK-3
UPDATE Employees
SET Salary = 7000
WHERE EmpID = 1;


--TASK-4
DELETE FROM Employees
WHERE EmpID = 2;


--TASK-5
-- DELETE --- Jadvaldagi ma'lumotlarni o‘chiradi
-- TRUNCATE - Barcha ma'lumotni tozalaydi
-- DROP ----- Butun jadvalni o‘chiradi (strukturasi bilan)


--TASK-6
ALTER TABLE Employees
ALTER COLUMN [Name] VARCHAR(100);
 

--TASK-7
ALTER TABLE Employees
ADD Department VARCHAR(100);


--TASK-8
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;


--TASK-9
CREATE TABLE Departments (
	DepartmentID INT PRIMARY KEY,
	DepartmentName VARCHAR(50)
)


--TASK-10
TRUNCATE TABLE Employees



--MEDIUM--------
--TASK-1
INSERT INTO Departments (DepartmentID, DepartmentName) 
VALUES
(1, 'Human Resources'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Logistics');


--TASK-2
UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;


--TASK-3
DELETE FROM Employees;


--TASK-4
ALTER TABLE Employees
DROP COLUMN Department;


--TASK-5
EXEC sp_rename 'Employees', 'StaffMembers';


--TASK-6
DROP TABLE Departments



--HARD-------
--TASK-1
CREATE TABLE Products (
	ProductID INT PRIMARY KEY,
	ProductName VARCHAR(50),
	Category VARCHAR(50),
	Price DECIMAL(10, 2)
)


--TASK-2
ALTER TABLE Products
ADD CONSTRAINT Price CHECK (Price > 0);


--TASK-3
ALTER TABLE Products
ADD StockQuantity INT DEFAULT(50)


--TASK-4
EXEC sp_rename 'Products.Category.', 'ProductCategory', 'COLUMN';


--TASK-5
INSERT INTO Products (ProductID, ProductName, Category, Price, StockQuantity) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 15),
(2, 'Smartphone', 'Electronics', 800.00, 30),
(3, 'Desk Chair', 'Furniture', 150.00, 20),
(4, 'Notebook', 'Stationery', 3.50, 100),
(5, 'Backpack', 'Accessories', 45.00, 50);


--TASK-6
SELECT * INTO Products_Backup
FROM Products;


--TASK-7
EXEC sp_rename 'Products', 'Inventory';


--TASK-8
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;


--TASK-9
CREATE TABLE Inventory_New (
    ProductCode INT IDENTITY(1000, 5) PRIMARY KEY,
    ProductName VARCHAR(100),
    Price FLOAT,
    StockQuantity INT
);

-- Eski ma’lumotlarni ko‘chiramiz
INSERT INTO Inventory_New (ProductName, Price, StockQuantity)
SELECT ProductName, Price, StockQuantity FROM Inventory;
