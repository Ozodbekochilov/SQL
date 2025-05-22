--EASY
--TASK-1
--Question: Explain at least two ways to find distinct values based on two columns.

--DISTINCT + CASE
SELECT DISTINCT
  CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
  CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl;

--GROUP BY + CASE
SELECT
  CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
  CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl
GROUP BY
  CASE WHEN col1 < col2 THEN col1 ELSE col2 END,
  CASE WHEN col1 < col2 THEN col2 ELSE col1 END;


--TASK-2
--Question: If all the columns have zero values, then don’t show that row. In this case, we have to remove the 5th row while selecting data.
SELECT *
FROM TestMultipleZero
WHERE A <> 0 OR B <> 0 OR C <> 0 OR D <> 0


--TASK-3
--Find those with odd ids
SELECT *
FROM section1
WHERE id % 2 = 1


--TASK-4
--Person with the smallest id (use the table in puzzle 3)
SELECT TOP 1 *
FROM section1
ORDER BY id ASC


--TASK-5
--Person with the highest id (use the table in puzzle 3)
SELECT TOP 1 *
FROM section1
ORDER BY id DESC


--TASK-6
--People whose name starts with b (use the table in puzzle 3)
SELECT *
FROM section1
WHERE name LIKE 'b%'


--TASK-7
--Write a query to return only the rows where the code contains the literal underscore _ (not as a wildcard).
SELECT *
FROM ProductCodes
WHERE Code NOT LIKE '%\_%' ESCAPE '\';
