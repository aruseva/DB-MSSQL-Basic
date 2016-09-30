--Problem 2.	Find All Information About Departments
SELECT  DepartmentID, Name, ManagerID
FROM  Departments

--Problem 3. Find all Department Names
SELECT Name
FROM Departments

--Problem 4. Find Salary of Each Employee
SELECT FirstName, LastName, Salary
FROM Employees

--Problem 5. Find Full Name of Each Employee
SELECT  FirstName, MiddleName, LastName
FROM Employees

--Problem 6. Find Email Address of Each Employee
SELECT FirstName + '.' + LastName + '@softuni.bg' AS Expr1
FROM Employees

--Problem 7. Find All Different Employee’s Salaries
SELECT DISTINCT Salary
FROM Employees

--Problem 8. Find all Information About Employees
SELECT * FROM Employees
WHERE (JobTitle = 'Sales Representative')
 
 --Problem 9. Find Names of All Employees by Salary in Range
SELECT FirstName, LastName, JobTitle
FROM Employees
WHERE (Salary BETWEEN 20000 AND 30000)

--Problem 10. Find Names of All Employees 
SELECT FirstName +' ' + MiddleName + ' ' + LastName AS 'Full Name' 
FROM Employees
WHERE Salary IN (25000, 14000, 12500, 23600) 

--Problem 11. Find All Employees Without Manager
SELECT  FirstName, LastName
FROM Employees
WHERE ManagerID IS NULL 

--Problem 12. Find All Employees with Salary More Than 50000
SELECT FirstName, LastName, Salary
FROM  Employees
WHERE (Salary > 50000)
ORDER BY Salary DESC

--Problem 13. Find 5 Best Paid Employees.
SELECT TOP (5) FirstName, LastName 
FROM Employees
ORDER BY Salary DESC

--Problem 14. Find All Employees Except Marketing
SELECT FirstName, LastName
FROM Employees
WHERE (DepartmentID <> 4)

--Problem 15. Sort Employees Table
SELECT EmployeeID, FirstName, LastName, MiddleName, JobTitle, DepartmentID, ManagerID, HireDate, Salary, AddressID
FROM Employees
ORDER BY 
  Salary DESC, 
  FirstName, 
  LastName DESC, 
  MiddleName
--Problem 16. Create View Employees with Salaries
CREATE VIEW V_EmployeesSalaries AS
SELECT FirstName, LastName, Salary
FROM Employees

--Problem 17. Create View Employees with Job Titles
CREATE VIEW V_EmployeeNameJobTitle  AS
SELECT FirstName + ' ' + ISNULL(MiddleName, '') + ' ' + LastName AS 'Full Name', JobTitle AS 'Job Title'
FROM Employees

--Problem 18. Distinct Job Titles
SELECT DISTINCT JobTitle
FROM Employees

--Problem 19. Find First 10 Started Projects
SELECT TOP (10) ProjectID, Name, Description, StartDate, EndDate
FROM Projects
ORDER BY StartDate, Name

--Problem 20. Last 7 Hired Employees
SELECT TOP (7) FirstName, LastName, HireDate
FROM Employees
ORDER BY HireDate DESC

--Problem 21. Increase Salaries
--I вариант
UPDATE Employees
SET Salary = Salary + (12 * Salary) / 100
WHERE DepartmentId = 1 OR DepartmentId = 2 OR DepartmentId = 4 OR DepartmentId = 11

SELECT E.Salary
FROM Employees AS E

-- II вариант чрез INNER JOIN
UPDATE Employees
SET Employees.Salary = Employees.Salary + (12 * Employees.Salary) / 100
FROM Employees INNER JOIN
Departments 
ON  Employees.DepartmentID =  Departments.DepartmentID
WHERE ( Departments.Name = 'Engineering') OR
      ( Departments.Name = 'Tool Design') OR
      ( Departments.Name = 'Marketing') OR
      ( Departments.Name = 'Information Services')

SELECT E.Salary
FROM dbo.Employees AS E

--Problem 22. All Mountain Peaks
SELECT PeakName
FROM Peaks
ORDER BY PeakName

--Problem 23. Biggest Countries by Population
SELECT TOP (30) CountryName, Population
FROM Countries
WHERE (ContinentCode = 'EU')
ORDER BY Population DESC, CountryName

--Problem 24. Countries and Currency (Euro / Not Euro)
SELECT CountryName, CountryCode, 
  CASE WHEN C.CurrencyCode = 'EUR' THEN 'Euro'
       WHEN C.CurrencyCode != 'EUR' OR
            C.CurrencyCode IS NULL THEN 'Not Euro' 
  END AS Currency
FROM Countries AS C
ORDER BY CountryName

--Problem 25. All Diablo Characters
SELECT Name
FROM Characters
ORDER BY Name
