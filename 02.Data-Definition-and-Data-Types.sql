-- Exercises: Data Definition and Data Types

--Problem 1.
CREATE DATABASE Minions

USE Minions
GO

--Problem 2.
CREATE TABLE Minions
(
Id int IDENTITY(1,1) PRIMARY KEY,
Name varchar(50) NOT NULL,
Age int
)

CREATE TABLE Towns
(
Id int IDENTITY(1,1) PRIMARY KEY,
Name varchar(50)
)

--Problem 3. Alter Minions Table
ALTER TABLE Minions
ADD TownID int

ALTER TABLE Minions
ADD FOREIGN KEY (TownID)
REFERENCES Towns(Id)

--Problem 4. Insert Records in Both Tables
INSERT INTO Towns(Id,Name)
VALUES 
(1,'Sofia'),
(2,'Plovdiv'),
(3,'Varna')

INSERT INTO Minions(Id,Name,Age,TownID)
VALUES
(1,'Kevin',22,1),
(2,'Bob',15,3),
(3,'Steward',NULL,2)

--Problem 5.	Truncate Table Minions
TRUNCATE TABLE Minions

--Problem 6. Drop All Tables
EXEC sp_MSforeachtable @command1 = "DROP TABLE ?"

--Problem 7. Create Table People
CREATE TABLE People
(
Id int IDENTITY(1,1) PRIMARY KEY,
Name varchar(200) NOT NULL,
Picture varbinary(max),
Height decimal(10,2),
Weight decimal(10,2),
Gender varchar(1) NOT NULL,
Birthdate date NOT NULL,
Biography varchar(max)
)

INSERT INTO People( Name,Picture,Height ,Weight ,Gender ,Birthdate ,Biography)
VALUES
( 'Gosho',NULL,1.89,78.65,'m','1977-10-25', 'Tova e biografiyata na Goshko'),
( 'Mariyka',NULL,1.89,78.65,'f','1982-06-15', 'Tova e biografiyata na Marika'),
( 'Pesho',NULL,1.89,78.65,'m','1967-10-25', 'Tova e biografiyata na Pesho'),
( 'Zdravka',NULL,1.89,78.65,'f','1982-06-15', 'Tova e biografiyata na Zdravka'),
( 'Ivan',NULL,1.89,78.65,'m','1982-06-15', 'Tova e biografiyata na Ivan')

--Problem 8. Create Table Users


--Problem 13. Movies Database
 
CREATE DATABASE [Movies] 

 
CREATE TABLE Directors
(
  Id int IDENTITY(1,1) PRIMARY KEY, 
  DirectorName  varchar(50) NOT NULL,
  Notes varchar(max)
)

CREATE TABLE Genres 
(
 Id int IDENTITY(1,1) PRIMARY KEY,
 GenreName varchar(50) NOT NULL,
 Notes varchar(max)
)

CREATE TABLE Categories 
(
 Id int IDENTITY(1,1) PRIMARY KEY,
 CategoryName varchar(50) NOT NULL,
 Notes varchar(max)
)

CREATE TABLE Movies 
(
  Id int IDENTITY(1,1) PRIMARY KEY,
  Title varchar(50) NOT NULL,
  DirectorId int NOT NULL, 
  CopyrightYear int NOT NULL,
  Length time NOT NULL,
  GenreId int NOT NULL, 
  CategoryId int NOT NULL, 
  Rating int NOT nULL,
  Notes varchar(max)
)

ALTER TABLE Movies
ADD FOREIGN KEY (DirectorId)
REFERENCES Directors(Id)

ALTER TABLE Movies
ADD FOREIGN KEY (GenreId)
REFERENCES Genres(Id)

ALTER TABLE Movies
ADD FOREIGN KEY (CategoryId)
REFERENCES Categories(Id)

INSERT INTO Directors (DirectorName, Notes)
VALUES
 ('Steven Allan Spielberg','American director, producer, screenwriter, and editor.'),
 ('Martin Charles Scorsese','American director, producer, screenwriter, actor, and film historian, whose career spans more than 53 years'),
 ('Quentin Jerome Tarantino','American filmmaker, screenwriter, and actor'),
 ('Sir Alfred Joseph Hitchcock','English film director and producer, at times referred to as "The Master of Suspense"'),
 ('James Francis Cameron','Canadian filmmaker, director, producer, screenwriter, inventor, engineer, philanthropist, and deep-sea explorer')

 INSERT INTO Genres(GenreName,Notes)
 VALUES
 ('Action',NULL),
 ('Horror',NULL),
 ('Western',NULL),
 ('Comedy',NULL),
 ('Crime',NULL)
 
 INSERT INTO Categories(CategoryName, Notes)
 VALUES
 ('Category1', NULL),
 ('Category2', NULL),
 ('Category3', NULL),
 ('Category4', NULL),
 ('Category5', NULL)

 INSERT INTO Movies(Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Rating, Notes)
 VALUES
  ('Jurassic Park',1,1993,'1:45:00',2,3,8,NULL),
  ('War Horse',1,1993,'2:26:00',3,2,7,NULL),
  ('Aliens',5,1986,'2:17:00',1,4,8,NULL),
  ('Psycho',4,1960,'1:49:00',4,1,9,'A Phoenix secretary embezzles $40,000 from her employer''s client, goes on the run, and checks into a remote motel run by a young man under the domination of his mother.'),
  ('Django Unchained',3,2012,'2:45:00',5,5,9,'With the help of a German bounty hunter, a freed slave sets out to rescue his wife from a brutal Mississippi plantation owner.')

--Problem 14.
CREATE DATABASE CarRental

CREATE TABLE Categories 
(
 Id int IDENTITY(1,1) Primary Key,
 Category varchar(50),
 DailyRate int,
 WeeklyRate int,
 MonthlyRate int,
 WeekendRate int
 )

CREATE TABLE Cars 
(
  Id int IDENTITY(1,1) Primary Key, 
  PlateNumber varchar(50),
  Make varchar(50), 
  Model varchar(50), 
  CarYear int, 
  CategoryId int NOT NULL, 
  Doors int,
  Picture  varbinary(max), 
  Condition bit,
  Available bit
  )

CREATE TABLE Employees 
(
 Id int IDENTITY(1,1) Primary Key, 
 FirstName varchar(50),
 LastName varchar(50),
 Title varchar(50),
 Notes varchar(50)
 )

CREATE TABLE Customers 
(
 Id int IDENTITY(1,1) Primary Key, 
 DriverLicenceNumber varchar(50) , 
 FullName varchar(50), 
 Address varchar(50), 
 City varchar(50), 
 ZIPCode varchar(50), 
 Notes varchar(50)
 )


CREATE TABLE RentalOrders 
(
Id int IDENTITY(1,1) PRIMARY KEY,
EmployeeId int, 
CustomerId int, 
CarId int, 
CarCondition bit, 
TankLevel int,
KilometrageStart int NOT NULL,
KilometrageEnd int NOT NULL,
TotalKilometrage AS (KilometrageEnd-KilometrageStart),
StartDate date, 
EndDate date, 
TotalDays AS  DATEDIFF(DAY, StartDate, EndDate), 
RateApplied int, 
TaxRate int, 
OrderStatus bit, 
Notes varchar(max)
)

ALTER TABLE Cars
ADD FOREIGN KEY (CategoryId)
REFERENCES Categories(Id)

ALTER TABLE RentalOrders
ADD FOREIGN KEY (EmployeeId)
REFERENCES Employees(Id)

ALTER TABLE RentalOrders
ADD FOREIGN KEY (CustomerId)
REFERENCES Customers(Id)

ALTER TABLE RentalOrders
ADD FOREIGN KEY (CarId)
REFERENCES Cars(Id)

INSERT INTO Categories (Category )
VALUES
  ('Category1'),
  ('Category2'),
  ('Category3')

INSERT INTO Cars (PlateNumber,CategoryId)
VALUES
  ('Car1',1),
  ('Car2',2),
  ('Car3',3)

INSERT INTO Employees (FirstName)
VALUES
 ('Empl1'),
 ('Empl2'),
 ('Empl3')
 
INSERT INTO Customers (DriverLicenceNumber)
VALUES
('Cust1'),
('Cust2'),
('Cust3')


INSERT INTO RentalOrders (EmployeeId, CustomerId, CarId, KilometrageStart, KilometrageEnd, StartDate, EndDate)
VALUES
(1,1,1,100,150,'2016-01-01','2016-01-06'),
(2,2,2,200,350,'2016-01-10','2016-02-06'),
(3,3,3,125100,5698150,'2016-01-01','2018-01-06')

--Problem 15.	Hotel Database
CREATE DATABASE Hotel 

CREATE TABLE Employees 
(
 Id int IDENTITY(1,1) Primary Key, 
 FirstName varchar(50), 
 LastName varchar(50),  
 Title varchar(50), 
 Notes varchar(max)
 )

CREATE TABLE Customers 
(
 Id int IDENTITY(1,1) Primary Key, 
 AccountNumber varchar(50), 
 FirstName varchar(50), 
 LastName varchar(50), 
 PhoneNumber varchar(50), 
 EmergencyName varchar(50), 
 EmergencyNumber varchar(50), 
 Notes varchar(max) 
 )

CREATE TABLE RoomStatus 
(
 Id int  IDENTITY(1,1) Primary Key, 
 RoomStatus bit,
 Notes varchar(max) 
 )

CREATE TABLE RoomTypes 
(
 Id int IDENTITY(1,1) Primary Key, 
 RoomType varchar(50), 
 Notes varchar(max) 
 )

CREATE TABLE BedTypes 
( Id int IDENTITY(1,1) Primary Key, 
 BedType varchar(50), 
 Notes varchar(max) 
 )

CREATE TABLE Rooms 
(
 Id int IDENTITY(1,1) Primary Key, 
 RoomNumber varchar(50),
 RoomType int, 
 BedType int, 
 Rate int, 
 RoomStatus int, 
 Notes varchar(max) 
 )

CREATE TABLE Payments 
(
 Id int IDENTITY(1,1) Primary Key,  
 EmployeeId int, 
 PaymentDate date,
 AccountNumber int , 
 FirstDateOccupied date, 
 LastDateOccupied date, 
 TotalDays  AS  DATEDIFF(DAY, FirstDateOccupied, LastDateOccupied), 
 AmountCharged float , 
 TaxRate float , 
 TaxAmount float , 
 PaymentTotal  AS (AmountCharged+TaxRate+TaxAmount), 
 Notes varchar(max) 
 )

CREATE TABLE Occupancies 
(
 Id int IDENTITY(1,1) Primary Key,
 EmployeeId int, 
 DateOccupied date, 
 AccountNumber int,  
 RoomNumber int, 
 RateApplied int, 
 PhoneCharge int, 
 Notes varchar(50)
 )

 ALTER TABLE Rooms
ADD FOREIGN KEY (RoomType)
REFERENCES RoomTypes(Id)

 ALTER TABLE Rooms
ADD FOREIGN KEY (BedType)
REFERENCES BedTypes(Id)

 ALTER TABLE Rooms
ADD FOREIGN KEY (RoomStatus)
REFERENCES RoomStatus(Id)

 ALTER TABLE Payments
ADD FOREIGN KEY (EmployeeId)
REFERENCES Employees(Id)

 ALTER TABLE Payments
ADD FOREIGN KEY (AccountNumber)
REFERENCES Customers(Id)

 ALTER TABLE Occupancies
ADD FOREIGN KEY (EmployeeId)
REFERENCES Employees(Id)

 ALTER TABLE Occupancies
ADD FOREIGN KEY (AccountNumber)
REFERENCES Customers(Id)

 ALTER TABLE Occupancies
ADD FOREIGN KEY (RoomNumber)
REFERENCES Rooms(Id)


INSERT INTO Employees (FirstName)
VALUES
('Eml1'),
('Eml2'),
('Eml3')


INSERT INTO Customers (AccountNumber)
VALUES
('AccNum1'),
('AccNum2'),
('AccNum3')

INSERT INTO RoomStatus (RoomStatus)
VALUES
(1),
(0),
(1)

INSERT INTO RoomTypes (RoomType)
VALUES
('RoomType1'),
('RoomType2'),
('RoomType3')

INSERT INTO BedTypes (BedType)
VALUES
('BedType1'),
('BEdType2'),
('BedType3')

INSERT INTO Rooms (RoomNumber, RoomType, BedType, RoomStatus,Rate)
VALUES
('RoomNumb1',1,1,2,4),
('RoomNumb2',2,2,3,3),
('RoomNumb13',3,1,2,5)

INSERT INTO Payments ( EmployeeId,  AccountNumber)
VALUES
(1,1),
(2,2),
(3,3)

INSERT INTO Occupancies ( EmployeeId, AccountNumber, RoomNumber )
VALUES
(1,1,1),
(2,2,2),
(3,3,3)

--Problrm 16.

CREATE DATABASE SoftUni
Use SoftUni
Go

CREATE TABLE Towns 
(
Id int IDENTITY(1,1) Primary Key,
Name varchar(50) NOT NULL
)

CREATE TABLE Addresses
(
Id int IDENTITY Primary Key,
AddressText nvarchar(50) NOT NULL,
TownId int NOT NULL FOREIGN KEY REFERENCES Towns(Id)
)

CREATE TABLE Departments
(
Id int IDENTITY Primary Key,
Name varchar(50) NOT NULL
)

CREATE TABLE Employees
(
Id int IDENTITY Primary Key , 
FirstName varchar(50), 
MiddleName varchar(50),
LastName varchar(50),
JobTitle varchar(50),
DepartmentId int NOT NULL FOREIGN KEY REFERENCES Departments(Id), 
HireDate date NOT NULL,
Salary money NOT NULL, 
AddressId  int   FOREIGN KEY REFERENCES Addresses(Id)
)

--Problem 18. Basic Insert

INSERT INTO Towns(Name)
VALUES ('Sofia'), ('Plovdiv'), ('Varna'), ('Burgas')

INSERT INTO Departments
VALUES ('Engineering'), ('Sales'), ('Marketing'), ('Software Development'), ('Quality Assurance')

INSERT INTO Employees 
VALUES
('Ivan', 'Ivanov', 'Ivanov','.NET Developer',4,'01/02/2013',3500,NULL),
('Petar', 'Petrov', 'Petrov ','Senior Engineer',1,'02/03/2004',4000,NULL),
('Maria','Petrova', 'Ivanova','Intern', 5, '20160828',525.25,NULL),
('Georgi','Teziev', 'Ivanov','CEO', 2, '20071209',3500.00,NULL),
('Peter','Pan', 'Pan','Intern', 3, '20160828',599.88,NULL)

--Problem 19. Basic Select All Fields
SELECT * FROM Towns 
SELECT * FROM Departments 
SELECT * FROM Employees 

--Problem 20. Basic Select All Fields and Order Them
SELECT * FROM Towns 
ORDER BY Name

SELECT * FROM Departments 
ORDER BY Name

SELECT * FROM Employees 
ORDER BY Salary DESC

--Problem 21. Basic Select Some Fields
SELECT Name FROM Towns 
ORDER BY Name

SELECT Name FROM Departments 
ORDER BY Name

SELECT FirstName,LastName,JobTitle,Salary FROM Employees 
ORDER BY Salary DESC

--Problem 22. Increase Employees Salary
UPDATE Employees
SET Salary=Salary*1.1

Select Salary FROM Employees

--Problem 23. Decrease Tax Rate
UPDATE Payments
SET TaxRate = TaxRate - TaxRate*0.03

SELECT TaxRate FROM Payments

--Problem 24. Delete All Records
TRUNCATE TABLE Occupancies