--Problem 1.	Find Names of All Employees by First Name
SELECT FirstName, LastName
FROM Employees
WHERE (FirstName LIKE 'Sa%')

--Problem 2. Find Names of All employees by Last Name 
SELECT FirstName, LastName
FROM Employees
WHERE (LastName LIKE '%ei%')

--Problem 3. Find First Names of All Employees
SELECT FirstName
FROM Employees
WHERE (DepartmentID = 3 OR DepartmentID = 10) 
      AND (HireDate BETWEEN '1995-01-01' AND '2005-12-31')

--Problem 4. Find All Employees Except Engineers
SELECT FirstName, LastName
FROM Employees
WHERE NOT (JobTitle LIKE '%engineer%') 

--Problem 5. Find Towns with Name Length
SELECT Name
FROM Towns
WHERE (LEN(Name) = 5) OR (LEN(Name) = 6)
ORDER BY Name

--Problem 6. Find Towns Starting With
SELECT TownID, Name
FROM Towns
WHERE (Name LIKE 'M%') OR
      (Name LIKE 'K%') OR
      (Name LIKE 'B%') OR
      (Name LIKE 'E%')
ORDER BY Name

--Problem 7. Find Towns Not Starting With
SELECT TownID, Name
FROM Towns
WHERE (Name NOT LIKE 'R%') 
  AND (Name NOT LIKE 'B%') 
  AND (Name NOT LIKE 'D%')
ORDER BY Name

--Problem 8. Create View Employees Hired After 2000 Year
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName
FROM Employees
WHERE HireDate > '12/31/2000' 

--Problem 9. Length of Last Name
SELECT FirstName, LastName
FROM Employees
WHERE (LEN(LastName) = 5)

--Problem 10. Countries Holding ‘A’ 3 or More Times
SELECT CountryName, IsoCode
FROM Countries
WHERE (CountryName LIKE '%a%a%a%')
ORDER BY IsoCode

--Problem 11. Mix of Peak and River Names



--Problem 12. Games from 2011 and 2012 year
SELECT TOP 50
	 Name  AS  Game,
	FORMAT(Start, 'yyyy-MM-dd')
FROM Games
WHERE YEAR(Start) IN (2011, 2012)
ORDER BY Start, Name