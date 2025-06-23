--TASK-1
--Find customers who purchased at least one item in March 2024 using EXISTS
SELECT c.CustomerID, c.CustomerName
FROM Customers c
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.CustomerID = c.CustomerID
      AND o.OrderDate >= '2024-03-01'
      AND o.OrderDate < '2024-04-01'
);



--TASK-2
--Find the product with the highest total sales revenue using a subquery.
SELECT Product
FROM #Sales
GROUP BY Product
HAVING SUM(Quantity * Price) = (
    SELECT MAX(SumRevenue)
    FROM (
        SELECT Product, SUM(Quantity * Price) AS SumRevenue
        FROM #Sales
        GROUP BY Product
    ) AS t
);



--TASK-3
--Find the second highest sale amount using a subquery
SELECT MAX(TotalAmount) AS SecondHighest
FROM (
    SELECT DISTINCT Quantity * Price AS TotalAmount
    FROM #Sales
) AS t
WHERE TotalAmount < (
    SELECT MAX(Quantity * Price) FROM #Sales
);




--TASK-4
--Find the total quantity of products sold per month using a subquery
SELECT DATENAME(MONTH, SaleDate) AS MonthName, SUM(Quantity) AS TotalQty
FROM #Sales
GROUP BY DATENAME(MONTH, SaleDate), MONTH(SaleDate)
ORDER BY MONTH(SaleDate);



--TASK-5
--Find customers who bought same products as another customer using EXISTS
SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s1.CustomerName <> s2.CustomerName
      AND s1.Product = s2.Product
);



--TASK-6
--Return how many fruits does each person have in individual fruit level
SELECT 
    Name,
    SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS Apple,
    SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
    SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name;



--TASK-7
--Return older people in the family with younger ones
WITH FamilyTree AS (
    SELECT ParentId AS PID, ChildID AS CHID
    FROM Family
    UNION ALL
    SELECT f.PID, fam.ChildID
    FROM FamilyTree f
    JOIN Family fam ON f.CHID = fam.ParentId
)
SELECT * FROM FamilyTree;



--TASK-8
--Write an SQL statement given the following requirements. For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas
SELECT *
FROM #Orders o
WHERE DeliveryState = 'TX'
  AND EXISTS (
      SELECT 1 FROM #Orders o2
      WHERE o2.CustomerID = o.CustomerID AND o2.DeliveryState = 'CA'
);



--TASK-9
--Insert the names of residents if they are missing
UPDATE #residents
SET fullname = 
    CASE 
        WHEN address LIKE '%name=%' THEN fullname
        ELSE SUBSTRING(address, CHARINDEX('=', address, CHARINDEX('name', address)) + 1, CHARINDEX(' ', address + ' ', CHARINDEX('name', address)) - CHARINDEX('=', address, CHARINDEX('name', address)) - 1)
    END
WHERE address NOT LIKE '%name=%';



--TASK-10
--Write a query to return the route to reach from Tashkent to Khorezm. The result should include the cheapest and the most expensive routes
WITH Paths AS (
    SELECT 'Tashkent - Samarkand - Khorezm' AS Route, 
           (SELECT Cost FROM #Routes WHERE DepartureCity='Tashkent' AND ArrivalCity='Samarkand') +
           (SELECT Cost FROM #Routes WHERE DepartureCity='Samarkand' AND ArrivalCity='Khorezm') AS Cost
    UNION
    SELECT 'Tashkent - Jizzakh - Samarkand - Bukhoro - Khorezm',
           (SELECT Cost FROM #Routes WHERE DepartureCity='Tashkent' AND ArrivalCity='Jizzakh') +
           (SELECT Cost FROM #Routes WHERE DepartureCity='Jizzakh' AND ArrivalCity='Samarkand') +
           (SELECT Cost FROM #Routes WHERE DepartureCity='Samarkand' AND ArrivalCity='Bukhoro') +
           (SELECT Cost FROM #Routes WHERE DepartureCity='Bukhoro' AND ArrivalCity='Khorezm')
)
SELECT * FROM Paths;



--TASK-11
--Rank products based on their order of insertion.
WITH Ranked AS (
    SELECT *, 
        SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END) 
        OVER (ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS GroupID
    FROM #RankingPuzzle
)
SELECT ID, Vals, GroupID
FROM Ranked
WHERE Vals <> 'Product';



--TASK-12
--Find employees whose sales were higher than the average sales in their department
SELECT *
FROM #EmployeeSales e
WHERE SalesAmount > (
    SELECT AVG(SalesAmount)
    FROM #EmployeeSales
    WHERE Department = e.Department
);



--TASK-13
--Find employees who had the highest sales in any given month using EXISTS
SELECT *
FROM #EmployeeSales e
WHERE EXISTS (
    SELECT 1
    FROM #EmployeeSales e2
    WHERE e2.SalesMonth = e.SalesMonth AND e2.SalesYear = e.SalesYear
    GROUP BY e2.SalesMonth, e2.SalesYear
    HAVING MAX(e2.SalesAmount) = e.SalesAmount
);



--TASK-14
--Find employees who made sales in every month using NOT EXISTS
SELECT DISTINCT e1.EmployeeName
FROM #EmployeeSales e1
WHERE NOT EXISTS (
    SELECT DISTINCT SalesMonth FROM #EmployeeSales
    EXCEPT
    SELECT SalesMonth FROM #EmployeeSales e2
    WHERE e2.EmployeeName = e1.EmployeeName
);



--TASK-15
--Retrieve the names of products that are more expensive than the average price of all products.
SELECT Name
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);



--TASK-16
--Find the products that have a stock count lower than the highest stock count.
SELECT Name
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products);



--TASK-17
--Get the names of products that belong to the same category as 'Laptop'.
SELECT Name
FROM Products
WHERE Category = (
    SELECT Category FROM Products WHERE Name = 'Laptop'
);



--TASK-18
--Retrieve products whose price is greater than the lowest price in the Electronics category.
SELECT Name
FROM Products
WHERE Price > (
    SELECT MIN(Price) FROM Products WHERE Category = 'Electronics'
);



--TASK-19
--Find the products that have a higher price than the average price of their respective category.
SELECT Name
FROM Products p
WHERE Price > (
    SELECT AVG(Price)
    FROM Products
    WHERE Category = p.Category
);



--TASK-20
--Find the products that have been ordered at least once.
SELECT DISTINCT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID;



--TASK-21
--Retrieve the names of products that have been ordered more than the average quantity ordered.
SELECT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
HAVING SUM(o.Quantity) > (
    SELECT AVG(TotalQty)
    FROM (
        SELECT SUM(Quantity) AS TotalQty
        FROM Orders
        GROUP BY ProductID
    ) t
);



--TASK-22
--Find the products that have never been ordered.
SELECT Name
FROM Products
WHERE ProductID NOT IN (SELECT DISTINCT ProductID FROM Orders);



--TASK-23
--Retrieve the product with the highest total quantity ordered.
SELECT TOP 1 p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
ORDER BY SUM(o.Quantity) DESC;
