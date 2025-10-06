CREATE DATABASE MyDatabase;

USE MyDatabase

--ASSIGNMENT;- 02

-----------------------------------------------------------------------
-----------------------------START-------------------------------------
------------------------------------------------------------------------

--1. Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘Quick
--Chicken Bites’.


SELECT * FROM Jomato;

CREATE FUNCTION dbo.InsertChicken (@RestaurantType VARCHAR(100))
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @Result VARCHAR(100);
    -- If RestaurantType is 'Quick Bites', insert 'Chicken ' before 'Bites'
    IF @RestaurantType LIKE 'Quick Bites'
        SET @Result = STUFF(@RestaurantType, 7, 0, 'Chicken ');
    RETURN @Result;
END;
----Call the user defined function with a Single column
SELECT dbo.InsertChicken('Quick Bites') AS Updated_Restaurant_Type
FROM Jomato;

----Call the user defined function with three columns and RestaurantType
SELECT OrderId,
RestaurantName,
dbo.InsertChicken('Quick Bites ') As RestaurantType
FROM Jomato;

------------------------

--2. Use the function to display the restaurant name and cuisine type which has the
--maximum number of rating.

SELECT 
    RestaurantName,
    dbo.InsertChicken(RestaurantType) AS RestaurantType, 
    CuisinesType,
    No_of_rating
FROM Jomato
WHERE No_of_Rating = (SELECT MAX(No_of_Rating) FROM Jomato);---Sub-String


--------------------------------------------------------------------

--Q;-3) --Create a Rating Status column to display the rating as ‘Excellent’ if it has more the 4
       --start rating, ‘Good’ if it has above 3.5 and below 5 star rating, ‘Average’ if it is above 3
       --and below 3.5 and ‘Bad’ if it is below 3 star rating.

SELECT  ----Without Adding Function (dbo.InsertChicken)
    RestaurantName,
    CuisinesType,
    Rating,
    No_of_Rating,
    CASE 
        WHEN Rating > 4 THEN 'Excellent'
        WHEN Rating > 3.5 AND Rating <= 4 THEN 'Good'
        WHEN Rating > 3 AND Rating <= 3.5 THEN 'Average'
        WHEN Rating <= 3 THEN 'Bad'
    END AS Rating_Status
FROM Jomato;

----  ADDED the Function Below
SELECT  
    RestaurantName,
    dbo.InsertChicken('Quick Bites') AS RestauranrType,--Adding Function (dbo.InsertChicken)
    CuisinesType,
    Rating,
    No_of_Rating,
    CASE 
        WHEN Rating > 4 THEN 'Excellent'
        WHEN Rating > 3.5 AND Rating <= 4 THEN 'Good'
        WHEN Rating > 3 AND Rating <= 3.5 THEN 'Average'
        WHEN Rating <= 3 THEN 'Bad'
    END AS Rating_Status
FROM Jomato;

---------------------------------------------------------------------------------------------\

--Q;-4. Find the Ceil, floor and absolute values of the rating column and display the current date
--and separately display the year, month_name and day.

SELECT RestaurantName,
       Rating,
       CEILING(Rating) as CeilValue,
       FLOOR(Rating) AS FloorValue,
       ABS(Rating) AS AbsValue,
       GETDATE() AS CurrentDAte,
       YEAR(GETDATE()),
       DATENAME(MONTH,GETDATE())
FROM Jomato;

--5. Display restaurant type and total average cost using rollup.

SELECT ISNULL(RestaurantType, 'Grand Total average cost'),--Not to leave the last row blank(NULL)
        SUM(AverageCost) as GrandTotal
        FROM Jomato
        Group by ROLLUP (RestaurantType); 

   SELECT ----Leaving the last row Blank(NULL)
    RestaurantType,
    SUM(AverageCost) AS TotalAverageCost
FROM Jomato
GROUP BY ROLLUP(RestaurantType);

---------------------------------------------------
----------------------END--------------------------
---------------------------------------------------
