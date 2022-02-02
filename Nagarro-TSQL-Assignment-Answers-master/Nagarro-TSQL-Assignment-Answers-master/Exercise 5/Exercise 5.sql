--Write a Procedure supplying name information from the Person.Person table and accepting a filter for the first name.
--Alter the above Store Procedure to supply Default Values if user does not enter any value.( Use AdventureWorks)

CREATE PROCEDURE person.NameInfo 
@Name varchar(50)
AS
SELECT FirstName,MiddleName,LastName
FROM Person.Person
WHERE FirstName=@Name;
GO



ALTER PROCEDURE person.NameInfo 
  @Name varchar(50) 
AS
IF @Name IS NULL BEGIN;
  SET @Name='Prithwish Dey'
END;
SELECT FirstName,MiddleName,LastName
FROM Person.Person
WHERE FirstName=@Name; 