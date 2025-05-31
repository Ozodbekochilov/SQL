--TASK-1
--Combine Two Tables
SELECT p.FirstName, p.LastName, d.City, d.State
FROM Person p
LEFT JOIN Address d ON p.personID = d.personID


--TASK-2
SELECT e.Name AS EmpName, e.Salary AS EmpSalary, m.Name ManName, m.Salary AS ManSalary
FROM Employee e
JOIN Employee m ON e.managerID = m.ID
WHERE e.Salary > m.Salary


--TASK-3
SELECT email, COUNT(email) AS EmailCount
FROM Person
GROUP BY email
HAVING COUNT(email) > 1


--TASK-4
SELECT DISTINCT * 
FROM Person 


--TASK-5
SELECT DISTINCT g.ParentName
FROM girls g
LEFT JOIN boys b ON g.parentName = b.parentName 
WHERE b.parentName IS NULL


--TASK-6
--Find total Sales amount for the orders which weights more than 50 for each customer along with their least weight.(from TSQL2012 database, Sales.Orders Table)
select  
ord.custid
,min(ord.freight) as min_weight
--,Orddetail.unitprice
--,Orddetail.qty 
, sum(case when freight>=50 then unitprice*qty
    else 0 end) as Total_Sale
from Sales.Orders as ord
JOIN
[Sales].[OrderDetails] as Orddetail
on ord.orderid=Orddetail.orderid
group by custid
order by custid


--TASK-7
--
SELECT 
	ISNULL(cart1.Item, '') AS [Item Cart 1],
	ISNULL(cart2.Item, '') AS [Item Cart 2] 
FROM cart1
FULL JOIN cart2 ON cart1.Item = cart2.Item
ORDER BY cart1.item DESC

	
--TASK-8
--Write a solution to find all customers who never order anything.  Return the result table in any order.
SELECT c.Name
FROM Customers c
LEFT JOIN Orders o ON c.id = o.CustomerID
WHERE O.CustomerID IS NULL


--TASK-9
--Write a solution to find the number of times each student attended each exam. Return the result table ordered by student_id and subject_name.
SELECT 
  s.student_id,
  s.student_name,
  sub.subject_name,
  COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e
  ON s.student_id = e.student_id
  AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;
