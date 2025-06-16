--TASK-1
--You must provide a report of all distributors and their sales by region. If a distributor did not have any sales for a region, rovide a zero-dollar value for that day. Assume there is at least one sale for each region
;WITH cte AS (
    SELECT DISTINCT R.Region, D.Distributor
    FROM (SELECT DISTINCT Region FROM #RegionSales) as R
    CROSS JOIN (SELECT DISTINCT Distributor FROM #RegionSales) as D
)

SELECT
    A.Region,
    A.Distributor,
    ISNULL(RS.Sales, 0) AS Sales
FROM
    cte as A
LEFT JOIN
    #RegionSales RS
    ON A.Region = RS.Region AND A.Distributor = RS.Distributor


--TASK-2
--Find managers with at least five direct reports
select a.name as manager_name, a.id, b.num_of_names 
from Employee as a
join  (
select managerId, count(name) as num_of_names 
from Employee 
group by managerId
) as b
on a.id=b.managerId
where b.num_of_names>=5


--TASK-3
--Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
select pro.product_id, pro.product_name, pro.product_category, ord.total_unit from Products as pro
join (
select product_id, sum(unit) as total_unit from Orders
where YEAR(order_date)=2020 and MONTH(order_date)=2
group by product_id
) as ord
on pro.product_id=ord.product_id
where ord.total_unit>=100


--TASK-4
--Write an SQL statement that returns the vendor from which each customer has placed the most orders
;with cte as(
select *, (select sum([COUNT]) from Orders as ord2 where ord1.CustomerID=ord2.CustomerID and ord1.Vendor=ord2.Vendor) as Total
from Orders as ord1
)
select distinct CustomerID,Vendor from cte
where Total=(select Max(Total) from cte as cte1 where cte.CustomerID=cte1.CustomerID)


--TASK-5
--You will be given a number as a variable called @Check_Prime check if this number is prime then return 'This number is prime' else eturn 'This number is not prime'
DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2;
DECLARE @IsPrime BIT = 1; 

IF @Check_Prime < 2
BEGIN
    SET @IsPrime = 0;
END
ELSE
BEGIN
    WHILE @i * @i <= @Check_Prime
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @IsPrime = 0; 
            BREAK;
        END
        SET @i = @i + 1;
    END
END

IF @IsPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';


--TASK-6
--Write an SQL query to return the number of locations,in which location most signals sent, and total number of signal for each device from the given table.
;with cte as(
select *, 
(Select count(locations) 
from device as dev 
where dev.Device_id=device.Device_id and dev.Locations=device.Locations) as cnt_loc
from Device
)
select distinct cte.Device_id,cte.Locations, aggregated.cnt_locs,aggregated.cnt_distc_loc from cte

JOIN (select Device_id, count(Locations) as cnt_locs, count(distinct locations) as cnt_distc_loc  from Device group by Device_id) as aggregated
on cte.Device_id=aggregated.Device_id

where cnt_loc=(select max(cnt_loc) from cte as cte1 where cte.Device_id=cte1.Device_id)


--TASK-7
--Write a SQL to find all Employees who earn more than the average salary in their corresponding department. Return EmpID, EmpName,Salary in your output
select EmpName, Salary, (select avg(Salary) from Employee as emp2 where emp2.DeptID=emp1.DeptID) as avg_salary from Employee as emp1
where Salary>(select avg(Salary) from Employee as emp2 where emp2.DeptID=emp1.DeptID)


--TASK-8
--You are part of an office lottery pool where you keep a table of the winning lottery numbers along with a table of each ticket’s chosen numbers. If a ticket has some but not all the winning numbers, you win $10. If a ticket has all the winning numbers, you win $100. Calculate the total winnings for today’s drawing.
WITH MatchCount AS (
  SELECT TicketID, COUNT(*) AS MatchCount
  FROM Tickets
  WHERE Number IN (SELECT Number FROM WinningNumbers)
  GROUP BY TicketID
),
TicketCount AS (
  SELECT TicketID, COUNT(*) AS Total
  FROM Tickets
  GROUP BY TicketID
)
SELECT SUM(
  CASE
    WHEN m.MatchCount = t.Total THEN 100
    WHEN m.MatchCount > 0 THEN 10
    ELSE 0
  END
) AS TotalWinnings
FROM TicketCount t
LEFT JOIN MatchCount m ON t.TicketID = m.TicketID;


--TASK-9
--Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only and both mobile and desktop together for each date.
SELECT
  Spend_date,
  SUM(CASE WHEN Platform = 'Mobile' THEN Total_users ELSE 0 END) AS Mobile_Users,
  SUM(CASE WHEN Platform = 'Mobile' THEN Total_Amount ELSE 0 END) AS Mobile_Amount,
  SUM(CASE WHEN Platform = 'Desktop' THEN Total_users ELSE 0 END) AS Desktop_Users,
  SUM(CASE WHEN Platform = 'Desktop' THEN Total_Amount ELSE 0 END) AS Desktop_Amount,
  SUM(CASE WHEN Platform = 'Both' THEN Total_users ELSE 0 END) AS Both_Users,
  SUM(CASE WHEN Platform = 'Both' THEN Total_Amount ELSE 0 END) AS Both_Amount
FROM Spending
GROUP BY Spend_date
ORDER BY Spend_date;


--TASK-10
--Write an SQL Statement to de-group the following data.
WITH Repeater AS (
  SELECT Product, Quantity, 1 AS n
  FROM Products
  WHERE Quantity > 0
  UNION ALL
  SELECT Product, Quantity, n + 1
  FROM Repeater
  WHERE n + 1 <= Quantity
)
SELECT Product, 1 AS Quantity
FROM Repeater
ORDER BY Product
OPTION (MAXRECURSION 1000);
