USE MyDatabase;

SELECt * FROM dbo.Jomato;

SELECT Restauranttype FROM dbo.Jomato
WHERE Restauranttype = 'Quick Bites';


--Scaler Function

CREATE FUNCTION fn_GetRestaurantName(@OrderId INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @RestaurantName VARCHAR(100);

    -- Fetch RestaurantName based on OrderId
    SELECT @RestaurantName = RestaurantName
    FROM dbo.Jomato
    WHERE OrderId = @OrderId;

    RETURN @RestaurantName;
END;
GO

DROP FUNCTION dbo.fn_GetRestaurantName;
SELECt * FROM dbo.Jomato;
SELECT DBO.fn_GetRestaurantName(34) AS RestaurantName;

CREATE FUNCTION fn_GetData(@RestaurantType NVARCHAR(100))
RETURNS TABLE
AS
RETURN
(
SELECT * FROM Jomato 
WHERE RestaurantType = @RestaurantType
)
SELECT *  FROM DBO.fn_GetData('bar, Casual Dining') AS MAnes

SELECt Averagecost, RestaurantName, RestaurantType
FROM dbo.Jomato (nolock)
where AverageCost < 2000;

USE MyDatabase

USE UniversityDB
SELECT * FrOM dbo.Courses

--CAST (expression AS Target_DataType)

SELECT CAST(123.789 as INT) AS Convertated_value

SELECT OrderId, AverageCost, CAST(AverageCost AS VARCHAR(10)) AS bisgth
FROM dbo.Jomato WITH (NOLOCK)
SELECT * FROM dbo.Jomato --Chronological, lexicographical