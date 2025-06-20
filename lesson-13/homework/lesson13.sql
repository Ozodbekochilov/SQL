--Easy Tasks
--TASK-1
--You need to write a query that outputs "100-Steven King", meaning emp_id + first_name + last_name in that format using employees table.
SELECT 
	CONCAT(EMPLOYEE_ID, '-', FIRST_NAME, ' ', LAST_NAME) AS FullName
FROM Employees
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME from Employees


--TASK-2
--Update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'
SELECT
	EMPLOYEE_ID,
	FIRST_NAME,
	REPLACE(PHONE_NUMBER, '124', '999') AS PhoneNumber
FROM Employees
select FIRST_NAME, PHONE_NUMBER from Employees

--TASK-3
--That displays the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'. Give each column an appropriate label. Sort the results by the employees' first names.(Employees)
SELECT 
	EMPLOYEE_ID, 
	First_Name,
	LEN(FIRST_NAME) AS NameLen
FROM Employees 
WHERE 
    FIRST_NAME LIKE 'A%' OR 
    FIRST_NAME LIKE 'J%' OR 
    FIRST_NAME LIKE 'M%'
	AND LEN(FIRST_NAME) > 5
ORDER BY FIRST_NAME DESC


--TASK-4
--Write an SQL query to find the total salary for each manager ID.(Employees table)
SELECT MANAGER_ID, SUM(SALARY) AS ManagerSalary
FROM Employees
GROUP BY MANAGER_ID


--TASK-5
--Write a query to retrieve the year and the highest value from the columns Max1, Max2, and Max3 for each row in the TestMax table
SELECT *,
CASE
	WHEN Max1 >= Max2 AND Max1 >= Max3 THEN Max1
	WHEN Max2 >= Max1 AND Max2 >= Max3 THEN Max2
	ELSE Max3
END MaxNumber
FROM TestMax


--TASK-6
--Find me odd numbered movies and description is not boring.(cinema)
SELECT *
FROM cinema
WHERE ID % 2 = 1 AND description <> 'Boring'


--TASK-7
--You have to sort data based on the Id but Id with 0 should always be the last row. Now the question is can you do that with a single order by column.(SingleOrder)
SELECT *
FROM SingleOrder
ORDER BY (CASE WHEN ID = 0 THEN 1 ELSE 0 END), Id;


--TASK-8
--Write an SQL query to select the first non-null value from a set of columns. If the first column is null, move to the next, and so on. If all columns are null, return null.(person)
SELECT *,
	COALESCE(ssn, passportid, itin) AS ContactInfo
FROM person





--Medium Tasks
--TASK-1
--Split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)
SELECT FullName,
	LEFT(FullName, CHARINDEX(' ', FullName) - 1) AS FirstName,
	SUBSTRING(
		FullName, 
		CHARINDEX(' ', FullName) + 1,
		CHARINDEX(' ', FullName, CHARINDEX(' ', FullName) + 1) - CHARINDEX(' ', FullName) - 1) AS MiddleName
FROM Students

--TASK-2
--For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas. (Orders Table)
SELECT o1.CustomerID, o1.DeliveryState, o2.CustomerID, o2.DeliveryState
FROM Orders o1
JOIN Orders o2 ON o1.CustomerID = o2.CustomerID
WHERE o1.DeliveryState = 'California' AND o2.DeliveryState = 'Texas'


--TASK-3
--Write an SQL statement that can group concatenate the following values.(DMLTable)
SELECT 
	STRING_AGG(String, ' te')
FROM DMLTable


--TASK-4
--Find all employees whose names (concatenated first and last) contain the letter "a" at least 3 times.
SELECT 
	EMPLOYEE_ID, 
	FIRST_NAME + ' ' + LAST_NAME AS FulName
FROM Employees
WHERE LEN(FIRST_NAME + LAST_NAME) - LEN(REPLACE(First_Name + Last_Name, 'a', '')) >= 3


--TASK-5
--The total number of employees in each department and the percentage of those employees who have been with the company for more than 3 years(Employees)
SELECT
    DEPARTMENT_ID,
    COUNT(*) AS TotalEmployees,
    COUNT(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 END) AS EmployeesOver3Years,
    CAST(COUNT(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS PercentageOver3Years
FROM Employees
GROUP BY DEPARTMENT_ID;


--TASK-6
--Write an SQL statement that determines the most and least experienced Spaceman ID by their job description.(Personal)
SELECT JobDescription, 'Max' AS Type, SpacemanID, MissionCount
FROM Personal p
WHERE MissionCount = (
    SELECT MAX(MissionCount)
    FROM Personal
    WHERE JobDescription = p.JobDescription
)

UNION ALL

SELECT JobDescription, 'Min' AS Type, SpacemanID, MissionCount
FROM Personal p
WHERE MissionCount = (
    SELECT MIN(MissionCount)
    FROM Personal
    WHERE JobDescription = p.JobDescription
);



--Difficult Tasks
--TASK-1
--Write an SQL query that separates the uppercase letters, lowercase letters, numbers, and other characters from the given string 'tf56sd#%OqH' into separate columns.
WITH chars AS (
    SELECT value AS ch
    FROM STRING_SPLIT('tf56sd#%OqH', '')
)
SELECT
  STRING_AGG(CASE WHEN ch COLLATE Latin1_General_CS_AS BETWEEN 'A' AND 'Z' THEN ch END, '') AS Uppercase,
  STRING_AGG(CASE WHEN ch COLLATE Latin1_General_CS_AS BETWEEN 'a' AND 'z' THEN ch END, '') AS Lowercase,
  STRING_AGG(CASE WHEN ch BETWEEN '0' AND '9' THEN ch END, '') AS Numbers,
  STRING_AGG(CASE WHEN ch NOT LIKE '[a-zA-Z0-9]' THEN ch END, '') AS Others
FROM chars;


--TASK-2
--Write an SQL query that replaces each row with the sum of its value and the previous rows' value. (Students table)
SELECT 
  StudentID,
  FullName,
  Grade,
  SUM(Grade) OVER (ORDER BY StudentID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeGrade
FROM Students;


--TASK-3
--You are given the following table, which contains a VARCHAR column that contains mathematical equations. Sum the equations and provide the answers in the output.(Equations)
declare @equation varchar(30)='21+2+3'
declare @checker int =1
declare @num varchar(30)=''
declare @Total int=0
declare @spchar varchar(30)=''

while @checker<=len(@equation)------------------------------- birinchi martada checker=1 1<5
begin
if SUBSTRING(@equation,@checker,1) not in ('+','-')
  begin
  set @num=@num+SUBSTRING(@equation,@checker,1)
  end
else if SUBSTRING(@equation,@checker,1) in ('+','-')
  begin
    if @spchar=''
    begin
    set @Total=cast(@num as int)+@Total
    end
    else if @spchar='+'
    begin
    set @Total=cast(@num as int)+@Total
    end
    else if @spchar='-'
    begin
    set @Total=@Total-@num
    end
  set @spchar=SUBSTRING(@equation,@checker,1)
  set @num=''
  end
if @spchar='+' and @checker=len(@equation)
    begin
    set @Total=cast(@num as int)+@Total
    end
else if @spchar='-' and @checker=len(@equation)
    begin
    set @Total=@Total-@num
    end
set @checker=@checker+1
end
print @total


--TASK-4
--Given the following dataset, find the students that share the same birthday.(Student Table)
SELECT Birthday, COUNT(*) AS StudentCount
FROM Student
GROUP BY Birthday
HAVING COUNT(*) > 1;


--TASK-5
--You have a table with two players (Player A and Player B) and their scores. If a pair of players have multiple entries, aggregate their scores into a single row for each unique pair of players. Write an SQL query to calculate the total score for each unique player pair(PlayerScores)
SELECT 
  CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
  CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END AS Player2,
  SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY 
  CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END,
  CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END;
