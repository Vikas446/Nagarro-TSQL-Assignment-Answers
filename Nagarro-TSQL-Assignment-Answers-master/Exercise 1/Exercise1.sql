USE AdventureWorks2019
--1.Display the number of records in the [SalesPerson] table. (Schema(s) involved: Sales)

SELECT * FROM Sales.SalesPerson;

--2.Select both the FirstName and LastName of records from the Person table where the FirstName begins with the letter ‘B’. (Schema(s) involved: Person)

SELECT FirstName
, LastName
FROM Person.Person
WHERE FirstName LIKE 'B%'; 

--3.Select a list of FirstName and LastName for employees where Title is one of Design Engineer, 
--Tool Designer or Marketing Assistant. (Schema(s) involved: HumanResources, Person)

SELECT Person.Person.FirstName
, Person.Person.LastName
, HumanResources.Employee.JobTitle
FROM Person.Person
INNER JOIN HumanResources.Employee ON(Person.BusinessEntityID=HumanResources.Employee.BusinessEntityID)
WHERE HumanResources.Employee.JobTitle='Design Engineer' OR 
HumanResources.Employee.JobTitle='Tool Designer' OR 
HumanResources.Employee.JobTitle='Marketing Assistant'
ORDER BY Person.FirstName
	, Person.LastName;


--4.Display the Name and Color of the Product with the maximum weight. (Schema(s) involved: Production)

SELECT Name
, Color
, weight
FROM Production.Product
WHERE Weight=(SELECT MAX(Weight) FROM Production.Product);


--5.Display Description and MaxQty fields from the SpecialOffer table. Some of the MaxQty values are NULL, 
--in this case display the value 0.00 instead. (Schema(s) involved: Sales)

SELECT Description
, ISNULL(MaxQty,0.00) AS MaxQty
FROM Sales.SpecialOffer;


--6.Display the overall Average of the [CurrencyRate].[AverageRate] values for the exchange rate ‘USD’ to ‘GBP’ for the year 2005 i.e. 
--FromCurrencyCode = ‘USD’ and ToCurrencyCode = ‘GBP’. Note: The field [CurrencyRate].[AverageRate] is defined as 
--'Average exchange rate for the day.' (Schema(s) involved: Sales)

SELECT 
AVG(AverageRate) AS 'Average exchange rate for the day'
FROM Sales.CurrencyRate
WHERE FromCurrencyCode='USD' AND ToCurrencyCode='GBP'
--transaction for the year 2005 is not present in the schema


--7.Display the FirstName and LastName of records from the Person table where FirstName contains the letters ‘ss’. 
--Display an additional column with sequential numbers for each row returned beginning at integer 1. (Schema(s) involved: Person)

SELECT ROW_NUMBER() over (order by FirstName asc) As RowNumber,FirstName,LastName
FROM Person.Person
where FirstName like '%ss%';


--8.Sales people receive various commission rates that belong to 1 of 4 bands. (Schema(s) involved: Sales)
--Display the [SalesPersonID] with an additional column entitled ‘Commission Band’ indicating the appropriate band as above.
select BusinessEntityID as SalesPersonID,CommissionPct, 'Commission Band'= CASE WHEN CommissionPct = 0 then 'band 0'
when CommissionPct > 0 and CommissionPct <= 0.01 then 'band 1'
when CommissionPct > 0.01 and CommissionPct <= 0.015 then 'band 2'
when CommissionPct > 0.015 then 'band 3' END
FROM Sales.SalesPerson
order by CommissionPct


--9.Display the managerial hierarchy from Ruth Ellerbrock (person type – EM) up to CEO Ken Sanchez. 
--Hint: use [uspGetEmployeeManagers] (Schema(s) involved: [Person], [HumanResources]) 
SELECT Person.Person.BusinessEntityID, Person.Person.FirstName, Person.Person.MiddleName, 
Person.Person.LastName, HumanResources.EmployeePayHistory.Rate,                      
HumanResources.Employee.OrganizationLevel, HumanResources.Employee.JobTitle 
FROM HumanResources.Employee 
INNER JOIN
HumanResources.EmployeePayHistory ON HumanResources.Employee.BusinessEntityID = HumanResources.EmployeePayHistory.BusinessEntityID 
INNER JOIN
Person.Person ON HumanResources.Employee.BusinessEntityID = Person.Person.BusinessEntityID 
WHERE Person.person.BusinessEntityID<49                      
ORDER BY Person.person.BusinessEntityID ASC;


--10.Display the ProductId of the product with the largest stock level. 
--Hint: Use the Scalar-valued function [dbo]. [UfnGetStock]. (Schema(s) involved: Production)
SELECT ProductID,Quantity
FROM Production.ProductInventory
ORDER BY Quantity DESC;



