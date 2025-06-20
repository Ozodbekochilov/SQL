--EASY LEVEL 
--TASK-1
--Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns)
SELECT 
    Id,
    LTRIM(RTRIM(LEFT(Name, CHARINDEX(',', Name) - 1))) AS Name,
    LTRIM(RTRIM(SUBSTRING(Name, CHARINDEX(',', Name) + 1, LEN(Name)))) AS Surname
FROM TestMultipleColumns;


--TASK-2
--Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent)
SELECT * 
FROM TestPercent
WHERE Strs LIKE '%[%]%';


--TASK-3
--In this puzzle you will have to split a string based on dot(.).(Splitter)
SELECT 
    Id,
    PARSENAME(REPLACE(Vals, '.', '.'), 3) AS Part1,
    PARSENAME(REPLACE(Vals, '.', '.'), 2) AS Part2,
    PARSENAME(REPLACE(Vals, '.', '.'), 1) AS Part3
FROM Splitter;


--TASK-4
--Write a SQL query to replace all integers (digits) in the string with 'X'.(1234ABC123456XYZ1234567890ADS)
DECLARE @str VARCHAR(100) = '1234ABC123456XYZ1234567890ADS';

WHILE PATINDEX('%[0-9]%', @str) > 0
    SET @str = STUFF(@str, PATINDEX('%[0-9]%', @str), 1, 'X');

SELECT @str AS Result;


--TASK-5
--Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots)
SELECT * 
FROM testDots
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;


--TASK-6
--Write a SQL query to count the spaces present in the string.(CountSpaces)
SELECT 
    texts,
    LEN(texts) - LEN(REPLACE(texts, ' ', '')) AS SpaceCount
FROM CountSpaces;


--TASK-7
--write a SQL query that finds out employees who earn more than their managers.(Employee)
SELECT e.Name AS Employee, e.Salary, m.Name AS Manager, m.Salary AS ManagerSalary
FROM Employee e
JOIN Employee m ON e.ManagerId = m.Id
WHERE e.Salary > m.Salary;


--TASK-8
--Find the employees who have been with the company for more than 10 years, but less than 15 years. Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service (calculated as the number of years between the current date and the hire date).(Employees)
SELECT 
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    HIRE_DATE,
    DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS YearsOfService
FROM Employees
WHERE DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 15;



--MEDIUM LEVEL
--TASK-1
--Write a SQL query to separate the integer values and the character values into two different columns.(rtcfvty34redt)
SELECT 
    LEFT(Value, PATINDEX('%[0-9]%', Value) - 1) AS Characters,
    SUBSTRING(Value, PATINDEX('%[0-9]%', Value), LEN(Value)) AS Integers
FROM (
    SELECT 'rtcfvty34redt' AS Value
) AS A;


--TASK-2
--write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.(weather)
SELECT w1.Id
FROM weather w1
JOIN weather w2 ON DATEDIFF(DAY, w2.RecordDate, w1.RecordDate) = 1
WHERE w1.Temperature > w2.Temperature;


--TASK-3
--Write an SQL query that reports the first login date for each player.(Activity)
SELECT PlayerID, MIN(LoginDate) AS FirstLogin
FROM Activity
GROUP BY PlayerID;


--TASK-4
--Your task is to return the third item from that list.(fruits)
SELECT Name
FROM (
    SELECT Name, ROW_NUMBER() OVER (ORDER BY Name) AS rn
    FROM fruits
) AS Ranked
WHERE rn = 3;


--TASK-5
--Write a SQL query to create a table where each character from the string will be converted into a row.(sdgfhsdgfhs@121313131)
WITH chars AS (
    SELECT 'sdgfhsdgfhs@121313131' AS str
), numbers AS (
    SELECT TOP (LEN('sdgfhsdgfhs@121313131'))
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM master..spt_values
)
SELECT SUBSTRING(str, n, 1) AS Char
FROM chars
JOIN numbers ON n <= LEN(str);


--TASK-6
--You are given two tables: p1 and p2. Join these tables on the id column. The catch is: when the value of p1.code is 0, replace it with the value of p2.code.(p1,p2)
SELECT 
    p1.id,
    CASE 
        WHEN p1.code = 0 THEN p2.code 
        ELSE p1.code 
    END AS FinalCode
FROM p1
JOIN p2 ON p1.id = p2.id;


--TASK-7
--Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    HIRE_DATE,
    CASE
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 1 THEN 'New Hire'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 1 AND 5 THEN 'Junior'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 6 AND 10 THEN 'Mid-Level'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 11 AND 20 THEN 'Senior'
        ELSE 'Veteran'
    END AS EmploymentStage
FROM Employees;


--TASK-8
--Write a SQL query to extract the integer value that appears at the start of the string in a column named Vals.(GetIntegers)
SELECT 
    Vals,
    LEFT(Vals, PATINDEX('%[^0-9]%', Vals + 'X') - 1) AS StartingInteger
FROM GetIntegers
WHERE Vals LIKE '[0-9]%';



--HARD LEVEL 
--TASK-1
--In this puzzle you have to swap the first two letters of the comma separated string.(MultipleVals)
SELECT 
  STUFF(Val, 1, 2, REVERSE(LEFT(Val, 2))) AS Swapped
FROM MultipleVals;


--TASK-2
--Write a SQL query that reports the device that is first logged in for each player.(Activity)
SELECT PlayerID, Device
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY PlayerID ORDER BY LoginDate) AS rn
    FROM Activity
) AS ranked
WHERE rn = 1;


--TASK-3
--You are given a sales table. Calculate the week-on-week percentage of sales per area for each financial week. For each week, the total sales will be considered 100%, and the percentage sales for each day of the week should be calculated based on the area sales for that week.(WeekPercentagePuzzle)
WITH SalesWithWeek AS (
    SELECT 
        DATEPART(WEEK, SaleDate) AS WeekNumber,
        Area,
        Amount,
        DATENAME(WEEKDAY, SaleDate) AS WeekDay
    FROM WeekPercentagePuzzle
),
TotalPerWeek AS (
    SELECT WeekNumber, SUM(Amount) AS TotalSales
    FROM SalesWithWeek
    GROUP BY WeekNumber
),
FinalCalc AS (
    SELECT 
        s.WeekNumber,
        s.Area,
        s.WeekDay,
        s.Amount,
        t.TotalSales,
        ROUND((s.Amount * 100.0) / t.Tot*

