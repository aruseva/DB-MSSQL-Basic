--Problem 1. Records’ Count


SELECT COUNT( * )
AS Count
FROM WizzardDeposits;
--Problem 2. Longest Magic Wand


SELECT MAX( MagicWandSize )
AS LongestMagicWand
FROM WizzardDeposits;
--Problem 3. Longest Magic Wand per Deposit Groups


SELECT wd.DepositGroup
AS DepositGroup,
       MAX( wd.MagicWandSize )
AS LongestMagicWand
FROM WizzardDeposits wd
GROUP BY wd.DepositGroup
ORDER BY LongestMagicWand;

--Problem 4. * Smallest Deposit Group per Magic Wand Size
SELECT wd.DepositGroup
FROM WizzardDeposits wd
GROUP BY wd.DepositGroup
HAVING AVG( wd.MagicWandSize )=
(
  SELECT TOP 1 AVG( wd2.MagicWandSize )
  AS avger
  FROM WizzardDeposits wd2
  GROUP BY wd2.DepositGroup
  ORDER BY avger ASC
);

--II вариант
SELECT DepositGroup
FROM
(
  SELECT DepositGroup,
         AVG( MagicWandSize ) AverageMagicWandSize
  FROM WizzardDeposits
  GROUP BY DepositGroup
) AverageMagicWandSizeByDepositGroup
WHERE AverageMagicWandSize=
(
  SELECT MIN( AverageMagicWandSize )
  FROM
  (
    SELECT DepositGroup,
           AVG( MagicWandSize ) AverageMagicWandSize
    FROM WizzardDeposits
    GROUP BY DepositGroup
  ) AverageMagicWandSizeByDepositGroup
);

--Problem 5. Deposits Sum
SELECT wd.DepositGroup,
       SUM( wd.DepositAmount )
AS TotalSum
FROM WizzardDeposits wd
GROUP BY wd.DepositGroup

--Problem 6. Deposits Sum for Ollivander Family
SELECT wd.DepositGroup,
       SUM( wd.DepositAmount )
AS TotalSum
FROM WizzardDeposits wd
WHERE wd.MagicWandCreator = 'Ollivander family'
GROUP BY wd.DepositGroup

--Problem 7. Deposits Filter
SELECT wd.DepositGroup,
       SUM( wd.DepositAmount ) AS TotalSum
FROM WizzardDeposits wd
WHERE wd.MagicWandCreator = 'Ollivander family'
GROUP BY wd.DepositGroup
HAVING SUM( wd.DepositAmount )<150000
ORDER BY TotalSum DESC

--Problem 8. Deposit charge
SELECT wd.DepositGroup,wd.MagicWandCreator,MIN(wd.DepositCharge) AS MinDepositCharge
FROM WizzardDeposits wd
GROUP BY wd.DepositGroup,wd.MagicWandCreator

--Problem 9. Age Groups
SELECT 
	CASE 
		WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
		WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
		WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
		WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
		WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
		WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
		WHEN Age >= 61 THEN '[61+]'
	END AS SizeGroup, 
	 COUNT(*) AS WizardCount
FROM WizzardDeposits
GROUP BY
CASE
		WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
		WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
		WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
		WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
		WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
		WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
		WHEN Age >= 61 THEN '[61+]'
	END

--Problem 10. First Letter
SELECT SUBSTRING(wd.FirstName,1,1) AS first_letter
FROM WizzardDeposits wd
WHERE wd.DepositGroup LIKE 'Troll Chest'
GROUP BY SUBSTRING(wd.FirstName,1,1)

--Problem 11. Average Interest 
SELECT DepositGroup,
       IsDepositExpired,
	   AVG( DepositInterest ) AS AverageInterest
FROM WizzardDeposits
WHERE DepositStartDate>CONVERT( DATETIME, '1985-01-01 00:00:00', 102 )
GROUP BY DepositGroup,
         IsDepositExpired
ORDER BY DepositGroup DESC,
         IsDepositExpired

--Problem 12. * Rich Wizard, Poor Wizard
SELECT SUM(WizzardDeposits.DepositAmount - WizzardDeposits_1.DepositAmount) AS SumDifference
FROM WizzardDeposits INNER JOIN
     WizzardDeposits AS WizzardDeposits_1 ON WizzardDeposits.Id = WizzardDeposits_1.Id - 1

--II вариант Тони


SELECT SUM(diff) AS SumDifference
FROM
( 
  SELECT DepositAmount -
    (
        SELECT DepositAmount
        FROM dbo.WizzardDeposits
        WHERE Id = g.Id + 1
    ) AS diff
    FROM dbo.WizzardDeposits AS g
) AS xx;

--Problem 13. Employees Minimum Salaries
SELECT e.DepartmentID, MIN(e.Salary) AS MinimumSalary
  FROM dbo.Employees e
  WHERE e.DepartmentID IN (2,5,7) AND  e.HireDate>'2000-01-01'
GROUP BY e.DepartmentID

--Problem 14. Employees Average Salaries
 SELECT *
INTO dbo.NewTable
FROM dbo.Employees e
WHERE e.Salary > 30000;

DELETE FROM dbo.NewTable
WHERE dbo.NewTable.ManagerID = 42

UPDATE dbo.NewTable
SET
     dbo.NewTable.Salary +=5000
	WHERE dbo.NewTable.DepartmentID = 1

SELECT n.DepartmentID, AVG(n.Salary) AS AverageSalary
 FROM dbo.NewTable n
 GROUP BY n.DepartmentID

--Problem 15. Employees Maximum Salaries
SELECT e.DepartmentID, MAX(e.Salary) AS MaxSalary 
  FROM dbo.Employees e
  GROUP BY e.DepartmentID
    HAVING NOT  MAX(Salary) BETWEEN 30000 AND 70000 

--Problem 16. Employees Count Salaries
SELECT count(e.EmployeeID) AS Count 
FROM dbo.Employees e
WHERE e.ManagerID IS NULL

--Problem 17. *3rd Highest Salary
 -- Не е мое решение
  SELECT DISTINCT sal.DepartmentId, sal.Salary FROM
(SELECT e.DepartmentId, e.Salary, DENSE_RANK() OVER (PARTITION BY e.DepartmentID ORDER BY e.Salary DESC) AS SalaryRank
   FROM [dbo].[Employees] AS e) AS sal
  WHERE sal.SalaryRank = 3


  --II вариант
  SELECT DepartmentID, 
	(SELECT DISTINCT Salary FROM Employees WHERE DepartmentID = e.DepartmentID ORDER BY Salary DESC OFFSET 2 ROWS FETCH NEXT 1 ROWS ONLY)AS ThirdHighestSalary
FROM Employees e
WHERE (SELECT DISTINCT Salary FROM Employees WHERE DepartmentID = e.DepartmentID ORDER BY Salary DESC OFFSET 2 ROWS FETCH NEXT 1 ROWS ONLY) IS NOT NULL
GROUP BY DepartmentID


  --18.
  --Не е мое решение
  SELECT TOP 10 e1.FirstName, e1.LastName, e1.DepartmentID
FROM Employees AS e1
JOIN (
	SELECT e.DepartmentID, AVG(e.Salary) AS AverageSalary
	FROM Employees AS e
	GROUP BY e.DepartmentID
) AS AvgSalary
ON e1.Salary > AvgSalary.AverageSalary
AND e1.DepartmentID = AvgSalary.DepartmentID


 

 