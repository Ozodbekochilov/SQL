--Task 1:
--Create a stored procedure that:
--Creates a temp table #EmployeeBonus
--Inserts EmployeeID, FullName (FirstName + LastName), Department, Salary, and BonusAmount into it
--(BonusAmount = Salary * BonusPercentage / 100)
--Then, selects all data from the temp table.

CREATE PROCEDURE sp_CalculateEmployeeBonus
AS
BEGIN
    CREATE TABLE #EmployeeBonus (
        EmployeeID INT,
        FullName NVARCHAR(101),
        Department NVARCHAR(50),
        Salary DECIMAL(10,2),
        BonusAmount DECIMAL(10,2)
    );

    INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)
    SELECT 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS FullName,
        e.Department,
        e.Salary,
        e.Salary * db.BonusPercentage / 100 AS BonusAmount
    FROM Employees e
    JOIN DepartmentBonus db ON e.Department = db.Department;

    SELECT * FROM #EmployeeBonus;
END;
EXEC sp_CalculateEmployeeBonus;



--TASK-2
--Create a stored procedure that:
--Accepts a department name and an increase percentage as parameters
--Update salary of all employees in the given department by the given percentage
--Returns updated employees from that department.

CREATE PROCEDURE IncreaseSalaryByDepartment
    @DeptName NVARCHAR(50),
    @IncreasePercent DECIMAL(5,2)
AS
BEGIN
    -- 1. Maoshlarni yangilash
    UPDATE Employees
    SET Salary = Salary + (Salary * @IncreasePercent / 100)
    WHERE Department = @DeptName;

    -- 2. Yangilangan xodimlarni chiqarish
    SELECT EmployeeID,
           FirstName,
           LastName,
           Department,
           Salary
    FROM Employees
    WHERE Department = @DeptName;
END;

EXEC IncreaseSalaryByDepartment 'IT', 10;


--Part 2: MERGE Tasks
--TASK-3
--Perform a MERGE operation that:
--Updates ProductName and Price if ProductID matches
--Inserts new products if ProductID does not exist
--Deletes products from Products_Current if they are missing in Products_New
--Return the final state of Products_Current after the MERGE.

MERGE Products_Current AS Target
USING Products_New AS Source
ON Target.ProductID = Source.ProductID

WHEN MATCHED THEN
    UPDATE SET 
        Target.ProductName = Source.ProductName,
        Target.Price = Source.Price

WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (Source.ProductID, Source.ProductName, Source.Price)

WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

SELECT * FROM Products_Current;



--TASK-4
--Tree Node
--Each node in the tree can be one of three types:
--"Leaf": if the node is a leaf node.
--"Root": if the node is the root of the tree.
--"Inner": If the node is neither a leaf node nor a root node.
--Write a solution to report the type of each node in the tree.

SELECT
    t.ID,
    CASE
        WHEN t.ParentID IS NULL THEN 'Root'
        WHEN t.ID NOT IN (SELECT DISTINCT ParentID FROM Tree WHERE ParentID IS NOT NULL) THEN 'Leaf'
        ELSE 'Inner'
    END AS NodeType
FROM Tree t;



--TASK-5
-- Confirmation Rate
SELECT 
    s.user_id,
    COUNT(CASE WHEN c.action = 'confirmed' THEN 1 END) * 1.0 / 
    NULLIF(COUNT(c.user_id), 0) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id;



--TASK-6
--Find employees with the lowest salary
SELECT *
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);



--TASK-7
--Get Product Sales Summary
SELECT 
    p.ProductID,
    p.ProductName,
    SUM(s.Quantity) AS TotalQuantitySold,
    SUM(s.Quantity * p.Price) AS TotalRevenue
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName;

