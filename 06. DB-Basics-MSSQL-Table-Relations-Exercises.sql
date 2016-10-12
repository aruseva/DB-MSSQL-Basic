--Problem 1. One-To-One Relationship
CREATE TABLE Passports
(
  PassportID int PRIMARY KEY,
  PassportNumber varchar(50)
)

CREATE TABLE Persons
(
  PersonID int PRIMARY KEY,
  FirstName varchar(50),
  Salary decimal(10,2),
  PassportID int,
CONSTRAINT FK_Person_Passport FOREIGN KEY(PassportID)
REFERENCES Passports(PassportID)
)

--Problem 2. One-To-Many Relationship
CREATE TABLE Manufacturers
(
  ManufacturerID int IDENTITY PRIMARY KEY,
  Name varchar(50),
  EstablishedOn datetime
)

CREATE TABLE Models
(
  ModelID int IDENTITY PRIMARY KEY,
  Name varchar(50),
  ManufacturerID int,
CONSTRAINT FK_Model_Manufactures FOREIGN KEY(ManufacturerID)
REFERENCES Manufacturers(ManufacturerID)
)

--Problem 3. Many-To-Many Relationship
CREATE TABLE Students
(
  StudentID int IDENTITY PRIMARY KEY,
  Name varchar(50)
)

CREATE TABLE Exams
(
  ExamID int IDENTITY PRIMARY KEY,
  Name varchar(50)
)

CREATE TABLE StudentsExams
(
  StudentID int,
  ExamID int,
  CONSTRAINT PK_StudentExam PRIMARY KEY( StudentID,ExamID),
  CONSTRAINT FK_StudentExam_Student FOREIGN KEY(StudentID)
  REFERENCES Students(StudentID),
   CONSTRAINT FK_StudentExam_Exam FOREIGN KEY(ExamID)
  REFERENCES Exams(ExamID)
)

--Problem 4. Self-Referencing 
CREATE TABLE Teachers
(
  TeacherID int IDENTITY PRIMARY KEY,
  Name varchar(50),
  ManagerID int,
CONSTRAINT FK_Teacher_Manager FOREIGN KEY(ManagerID)
REFERENCES Teachers(TeacherID)
)

--Problem 5. Online Store Database
 




 --Problem 9. Employee Address
SELECT TOP (5) Employees.EmployeeID,
               Employees.JobTitle,
               Addresses.AddressID,
               Addresses.AddressText
FROM Employees
     INNER JOIN Addresses ON Employees.AddressID = Addresses.AddressID
ORDER BY Addresses.AddressID;

--Problem 10. Employee Departments
SELECT TOP ( 5 ) Employees.EmployeeID,
                 Employees.FirstName,
                 Employees.Salary,
                 Departments.Name
FROM Employees
INNER JOIN
Departments
ON Employees.DepartmentID=Departments.DepartmentID
WHERE Employees.Salary>15000
ORDER BY Departments.DepartmentID;

--Problem 11. Employees Without Project
SELECT        TOP (3) Employees.EmployeeID, Employees.FirstName
FROM            Employees LEFT OUTER JOIN
                         EmployeesProjects ON Employees.EmployeeID = EmployeesProjects.EmployeeID
WHERE        (EmployeesProjects.ProjectID IS NULL)
ORDER BY Employees.EmployeeID

--Problem 12.	Employees with Project
SELECT TOP ( 5 ) Employees.EmployeeID,
                 Employees.FirstName,
                 Projects.Name AS ProjectName
FROM Employees
INNER JOIN EmployeesProjects
ON Employees.EmployeeID=EmployeesProjects.EmployeeID
    INNER JOIN Projects
    ON EmployeesProjects.ProjectID=Projects.ProjectID
WHERE Projects.StartDate>CONVERT( DATETIME, '2002-08-13 00:00:00', 102 )
      AND Projects.EndDate IS NULL
ORDER BY Employees.EmployeeID;

--Problem 13. Employee 24
 SELECT Employees.EmployeeID,  Employees.FirstName,
       CASE
         WHEN YEAR( Projects.StartDate )>=2005
         THEN NULL
         ELSE Projects.Name
       END AS ProjectName
FROM Employees
INNER JOIN EmployeesProjects
ON Employees.EmployeeID=EmployeesProjects.EmployeeID
    INNER JOIN Projects
    ON EmployeesProjects.ProjectID=Projects.ProjectID
WHERE Employees.EmployeeID=24;
 
--Problem 14.	Employee Manager
SELECT     Employees.EmployeeID, Employees.FirstName, Employees.ManagerID, Employees_1.FirstName AS Expr1
FROM            Employees INNER JOIN
                         Employees AS Employees_1 ON Employees.ManagerID = Employees_1.EmployeeID
WHERE        (Employees.ManagerID IN (3, 7))
ORDER BY Employees.EmployeeID

--Problem 15. Highest peak in Bulgaria
SELECT Countries.CountryCode,
       Mountains.MountainRange,
       Peaks.PeakName,
       Peaks.Elevation
FROM Countries
     INNER JOIN MountainsCountries ON Countries.CountryCode = MountainsCountries.CountryCode
     INNER JOIN Mountains ON MountainsCountries.MountainId = Mountains.Id
     INNER JOIN Peaks ON Mountains.Id = Peaks.MountainId
WHERE(Countries.CountryCode = 'BG')
     AND (Peaks.Elevation > 2835)
ORDER BY Peaks.Elevation DESC;

--Problem 16. Count Mountain Ranges
SELECT Countries.CountryCode,
       COUNT(Mountains.MountainRange) AS Expr1
FROM Countries
     INNER JOIN MountainsCountries ON Countries.CountryCode = MountainsCountries.CountryCode
     INNER JOIN Mountains ON MountainsCountries.MountainId = Mountains.Id
GROUP BY Countries.CountryCode
HAVING(Countries.CountryCode IN('BG', 'US', 'RU'));

--Problem 17. Countries with rivers
SELECT TOP (5) Countries.CountryName,
               Rivers.RiverName
FROM Continents
     INNER JOIN Countries ON Continents.ContinentCode = Countries.ContinentCode
     LEFT OUTER JOIN Rivers
     INNER JOIN CountriesRivers ON Rivers.Id = CountriesRivers.RiverId ON Countries.CountryCode = CountriesRivers.CountryCode
WHERE(Continents.ContinentCode = 'AF')
ORDER BY Countries.CountryName;

--

--Problem 19. Countries Without any Mountains
SELECT ContinentCode,
  CurrencyCode,
  C.CurrencyUsage
  FROM 
  (SELECT ContinentCode,
    CurrencyCode, 
    COUNT (CurrencyCode) AS CurrencyUsage,
    DENSE_RANK()  OVER (PARTITION BY ContinentCode ORDER BY COUNT (CurrencyCode) DESC) AS RankCurrencyUsage
    FROM [dbo].[Countries] 
  GROUP BY CurrencyCode,ContinentCode) AS C
 WHERE RankCurrencyUsage = 1
    AND c.CurrencyUsage > 1
 GROUP BY c.CurrencyCode,c. ContinentCode, c.CurrencyUsage
 ORDER BY c.ContinentCode
 


 --Problem 20.	Highest Peak and Longest River by Country
 -- 20.	Highest Peak and Longest River by Country
SELECT TOP 5 Countries.CountryName AS CountryCode,
             MAX(Peaks.Elevation) AS HighestPeakElevation,
             MAX(Rivers.Length) AS LongestRiverLength
FROM Rivers
     INNER JOIN CountriesRivers ON Rivers.Id = CountriesRivers.RiverId
     RIGHT OUTER JOIN Mountains
     INNER JOIN MountainsCountries ON Mountains.Id = MountainsCountries.MountainId
     INNER JOIN Peaks ON Mountains.Id = Peaks.MountainId
     RIGHT OUTER JOIN Countries ON MountainsCountries.CountryCode = Countries.CountryCode ON CountriesRivers.CountryCode = Countries.CountryCode
GROUP BY Countries.CountryName
ORDER BY HighestPeakElevation DESC,
         LongestRiverLength DESC;

 --Problem 21.	** Highest Peak Name and Elevation by Country    

 SELECT        dbo.Countries.CountryName, dbo.Mountains.MountainRange, MAX(dbo.Peaks.Elevation) AS Expr1,
 (SELECT dbo.Peaks.PeakName FROM dbo.Peaks p
 GROUP BY dbo.Peaks.PeakName
 HAVING p.MountainId = dbo.Peaks.MountainId AND p.PeakName = dbo.Peaks.PeakName
 
 ) AS peakname1
FROM            dbo.Mountains INNER JOIN
                         dbo.MountainsCountries ON dbo.Mountains.Id = dbo.MountainsCountries.MountainId INNER JOIN
                         dbo.Peaks ON dbo.Mountains.Id = dbo.Peaks.MountainId INNER JOIN
                         dbo.Countries ON dbo.MountainsCountries.CountryCode = dbo.Countries.CountryCode
GROUP BY dbo.Countries.CountryName, dbo.Mountains.MountainRange