--TASK-1
--Create a temporary table named MonthlySales to store the total quantity sold and total revenue for each product in the current month
INSERT INTO #MonthlySales (ProductID, ProductName, TotalQuantity, TotalRevenue) 
SELECT p.ProductID, p.ProductName, SUM(Quantity) AS TotalQuantity, SUM(Price * Quantity) AS TotalRevenue
FROM Products p 
JOIN Sales s ON p.ProductID = s.ProductID
where month(SaleDate)=4
GROUP BY p.ProductID, p.ProductName

SELECT * FROM #MonthlySales



--TASK-2
--Create a view named vw_ProductSalesSummary that returns product info along with total sales quantity across all time.
CREATE VIEW vw_ProductSalesSummary AS
SELECT p.ProductID, p.ProductName, p.Category, s.SaleDate, SUM(Quantity) AS TotalQuantitySold
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName, p.Category, s.SaleDate

SELECT * FROM vw_ProductSalesSummary



--TASK-3
--Create a function named fn_GetTotalRevenueForProduct(@ProductID INT)
CREATE FUNCTION fn_GetTotalRevenueForProduct (@ProductID INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(18,2)

    SELECT @TotalRevenue = SUM(s.Quantity * p.Price)
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    WHERE s.ProductID = @ProductID

    RETURN ISNULL(@TotalRevenue, 0)
END

SELECT dbo.fn_GetTotalRevenueForProduct(5) AS TotalRevenue;



--TASK-4
--Create an function fn_GetSalesByCategory(@Category VARCHAR(50))
CREATE FUNCTION fn_GetSalesByCategory (
    @Category VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT p.ProductName, SUM(s.Quantity) AS TotalQuantity, SUM(s.Quantity * p.Price) AS TotalRevenue
    FROM Products p
    JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.Category = @Category
    GROUP BY p.ProductName
);

SELECT * 
FROM dbo.fn_GetSalesByCategory('Electronics'); 



--TASK-5
--You have to create a function that get one argument as input from user and the function should return 'Yes' if the input number is a prime number and 'No' otherwise. You can start it like this:
CREATE FUNCTION Tub (@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    DECLARE @i INT = 2;
    DECLARE @IsPrime BIT = 1;
    DECLARE @Result VARCHAR(3);

    IF @Number < 2
        SET @IsPrime = 0;
    ELSE
    BEGIN
        WHILE @i < @Number
        BEGIN
            IF @Number % @i = 0
            BEGIN
                SET @IsPrime = 0;
                BREAK;
            END
            SET @i = @i + 1;
        END
    END

    IF @IsPrime = 1
        SET @Result = 'Yes';
    ELSE
        SET @Result = 'No';

    RETURN @Result;
END

SELECT dbo.Tub(2)



--TASK-6
--Create a table-valued function named fn_GetNumbersBetween that accepts two integers as input:
CREATE FUNCTION fn_GetNumbersBetween (
    @Start INT,
    @End INT
)
RETURNS @Result TABLE (
    Number INT
)
AS
BEGIN
    DECLARE @i INT = @Start;

    WHILE @i <= @End
    BEGIN
        INSERT INTO @Result (Number)
        VALUES (@i);

        SET @i = @i + 1;
    END

    RETURN;
END

SELECT * FROM dbo.fn_GetNumbersBetween(3, 7);



--TASK-7
--Write a SQL query to return the Nth highest distinct salary from the Employee table. If there are fewer than N distinct salaries, return NULL.
CREATE FUNCTION getNthHighestSalary (@N INT)
RETURNS TABLE
AS
RETURN (
    SELECT 
        (SELECT DISTINCT TOP 1 salary
         FROM (
            SELECT DISTINCT TOP (@N) salary
            FROM Employee
            ORDER BY salary DESC
         ) AS Temp
         ORDER BY salary ASC) AS HighestNSalary
);

SELECT * FROM getNthHighestSalary(2);



--TASK-8
--Write a SQL query to find the person who has the most friends.
SELECT TOP 1
    id,
    COUNT(*) AS num
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id FROM RequestAccepted
) AS AllFriends
GROUP BY id
ORDER BY COUNT(*) DESC;



--TASK-9
--Create a view called vw_CustomerOrderSummary that returns a summary of customer orders. The view must contain the following columns:
CREATE VIEW vw_CustomerOrderSummary AS
SELECT
    c.customer_id,
    c.name AS customer_name,
    c.city,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_amount
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.city;

SELECT * FROM vw_CustomerOrderSummary;



--TASK-10
--Write an SQL statement to fill in the missing gaps. You have to write only select statement, no need to modify the table.
SELECT RowNumber, (SELECT TOP 1 TestCase
FROM Gaps g2
WHERE g2.RowNumber <= g1.Rownumber AND g2.TestCase IS NOT NULL
ORDER BY g2.RowNumber  DESC) AS TestCase
FROM Gaps g1
ORDER BY g1.RowNumber;
