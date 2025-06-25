--TASK-1
--Write a query to assign a row number to each sale based on the SaleDate.
SELECT *,
	ROW_NUMBER() OVER (ORDER BY SaleDate) AS RowNum
FROM ProductSales


--TASK-2
--Write a query to rank products based on the total quantity sold. give the same rank for the same amounts without skipping numbers.
SELECT ProductName,
       SUM(Quantity) AS TotalSold,
       DENSE_RANK() OVER (ORDER BY SUM(Quantity) DESC) AS SalesRank
FROM ProductSales
GROUP BY ProductName;


--TASK-3
--Write a query to identify the top sale for each customer based on the SaleAmount.
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rn
    FROM ProductSales
) AS T
WHERE rn = 1;



--TASK-4
--Write a query to display each sale's amount along with the next sale amount in the order of SaleDate.
SELECT SaleID, CustomerID, ProductName, SaleAmount,
    LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount
FROM ProductSales;



--TASK-5
--Write a query to display each sale's amount along with the previous sale amount in the order of SaleDate.
SELECT *,
	LAG(SaleAMount) OVER (ORDER BY SaleDate) AS PrevSaleAmount
FROM ProductSales



--TASK-6
--Write a query to identify sales amounts that are greater than the previous sale's amount
SELECT *
FROM (
    SELECT *, LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevAmount
    FROM ProductSales
) AS T
WHERE SaleAmount > PrevAmount;



--TASK-7
--Write a query to calculate the difference in sale amount from the previous sale for every product
SELECT *,
       SaleAmount - LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS Difference
FROM ProductSales;



--TASK-8
--Write a query to compare the current sale amount with the next sale amount in terms of percentage change.
SELECT *,
       100.0 * (LEAD(SaleAmount) OVER (ORDER BY SaleDate) - SaleAmount) / SaleAmount AS PercentChange
FROM ProductSales;



--TASK-9
--Write a query to calculate the ratio of the current sale amount to the previous sale amount within the same product.
SELECT *,
       1.0 * SaleAmount / NULLIF(LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate), 0) AS Ratio
FROM ProductSales;



--TASK-10
--Write a query to calculate the difference in sale amount from the very first sale of that product.
SELECT *,
       SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromFirst
FROM ProductSales;



--TASK-11
--Write a query to find sales that have been increasing continuously for a product (i.e., each sale amount is greater than the previous sale amount for that product).
SELECT *
FROM (
    SELECT *,
           LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevAmount
    FROM ProductSales
) AS T
WHERE SaleAmount > PrevAmount;



--TASK-12
--Write a query to calculate a "closing balance"(running total) for sales amounts which adds the current sale amount to a running total of previous sales.
SELECT *,
       SUM(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM ProductSales;



--TASK-13
--Write a query to calculate the moving average of sales amounts over the last 3 sales.
SELECT *,
       AVG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg3
FROM ProductSales;



--TASK-14
--Write a query to show the difference between each sale amount and the average sale amount.
SELECT *,
       SaleAmount - AVG(SaleAmount) OVER (PARTITION BY ProductName) AS DiffFromAvg
FROM ProductSales;



--TASK-15
--Find Employees Who Have the Same Salary Rank
SELECT *,
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees1;



--TASK-16
--Identify the Top 2 Highest Salaries in Each Department
SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS RankInDept
    FROM Employees1
) AS T
WHERE RankInDept <= 2;



--TASK-17
--Find the Lowest-Paid Employee in Each Department
SELECT *
FROM (
    SELECT *,
           RANK() OVER (PARTITION BY Department ORDER BY Salary ASC) AS RankLow
    FROM Employees1
) AS T
WHERE RankLow = 1;



--TASK-18
--Calculate the Running Total of Salaries in Each Department
SELECT *,
       SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate) AS SalaryRunningTotal
FROM Employees1;



--TASK_19
--Find the Total Salary of Each Department Without GROUP BY
SELECT *,
       SUM(Salary) OVER (PARTITION BY Department) AS DeptTotalSalary
FROM Employees1;



--TASK-20
--Calculate the Average Salary in Each Department Without GROUP BY
SELECT *,
       AVG(Salary) OVER (PARTITION BY Department) AS DeptAvgSalary
FROM Employees1;



--TASK-21
--Find the Difference Between an Employee’s Salary and Their Department’s Average
SELECT *,
       Salary - AVG(Salary) OVER (PARTITION BY Department) AS DiffFromDeptAvg
FROM Employees1;



--TASK-22
--Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)
SELECT *,
       AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvg3
FROM Employees1;



--TASK-23
--Find the Sum of Salaries for the Last 3 Hired Employees
SELECT *
FROM (
    SELECT *,
           SUM(Salary) OVER (ORDER BY HireDate DESC ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS Last3Total
    FROM Employees1
) AS T;
