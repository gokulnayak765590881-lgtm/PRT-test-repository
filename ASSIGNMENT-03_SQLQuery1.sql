USE MyDatabase
-------------------------------------------------------------------
----------------------- START ASSIGNMENT-3 --------------------------------------
-------------------------------------------------------------------
SELECT * FROM ASSIGNMENT_3 -----Table name; ASSIGNMENT_3

--Q:-01) Create a stored procedure to display the restaurant name, type and cuisine where the
---------table booking is not zero.

CREATE PROCEDURE Table_Booking_Zero
AS 
BEGIN
		SELECT RestaurantName, RestaurantType, CuisinesType
		FROM ASSIGNMENT_3
		WHERE TableBooking != 0
END;

EXEC Table_Booking_Zero; -------Call the store procedure

-----------------------------------------------------------

--Q:-02) Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result
---------and rollback it.
BEGIN TRAN
UPDATE ASSIGNMENT_3
SET CuisinesType = 'Cafeteria'
WHERE CuisinesType = 'Cafe';
------Check the update
SELECT CuisinesType
FROM ASSIGNMENT_3
WHERE CuisinesType = 'Cafeteria';
ROLLBACK ----Rollback or Undo the update

---------------------------------------------------------------------------------------------

---Q:-03) Generate a row number column and find the top 5 areas with the highest rating of
----------restaurants.

WITH AreaRanking AS (
    SELECT 
        Area,
        Rating,
        ROW_NUMBER() OVER (ORDER BY Rating DESC) AS RowNum
    FROM ASSIGNMENT_3
)
SELECT TOP 5 Area, Rating, RowNum
FROM AreaRanking
ORDER BY RowNum;

--------------------------------------------------------------------------------
---Q:-4) Use the while loop to display the 1 to 50.

DECLARE @counter INT = 1;        --Step 1: Start here
WHILE @counter <= 50            ---Step 2: Check condition
BEGIN                           ---Step 3: Enter the loop
    PRINT @counter;              --Step 4: Do the task
    SET @counter = @counter + 1;-- Step 5: Update to progress
END;                           ----Step 6: End the loop body (it goes back to Step 2)

-----------------------------------------------------------------------------------
--Q:-5) Write a query to Create a Top rating view to store the generated top 5 highest rating of
--------restaurants.
CREATE VIEW Top_FIVE_Highest_rating AS
SELECT TOP 5 *
FROM dbo.ASSIGNMENT_3
ORDER BY Rating DESC;

SELECT * FROM Top_FIVE_Highest_rating;

--------------------------------------------------------
--Q:-6) Create a trigger that give an message whenever a new record is inserted.
CREATE TRIGGER trg_NewRestaurantInserted -----Using Inner begin and inner end
ON dbo.ASSIGNMENT_3
AFTER INSERT
AS
BEGIN
    -- Check if any rows were actually inserted
    IF (SELECT COUNT(*) FROM inserted) > 0
    BEGIN
        -- Print a confirmation message
        PRINT 'A new restaurant record has been successfully inserted.';
    END
END;
------------
--Without using inner begin and inner end
CREATE TRIGGER trg_NewRestaurantInserted -----Using Inner begin and inner end
ON dbo.ASSIGNMENT_3
AFTER INSERT
AS
BEGIN
    -- Check if any rows were actually inserted
    IF (SELECT COUNT(*) FROM inserted) > 0
        -- Print a confirmation message
        PRINT 'A new restaurant record has been successfully inserted.';
END;
---The inner BEGIN...END surrounds the PRINT statement inside the 'IF'.

--New Restaurant Alert
--Create a trigger that runs after a new restaurant is added to [dbo].[ASSIGNMENT_3]. 
--If a row is inserted, it should print a message saying, "New restaurant added:
--[RestaurantName]," where [RestaurantName] is the name of the newly inserted restaurant.

CREATE TRIGGER New_Restaurant_Added
ON [dbo].[ASSIGNMENT_3]
AFTER INSERT
AS
BEGIN
    IF (SELECT COUNT(*) FROM inserted) > 0
    BEGIN
        DECLARE @RestaurantName VARCHAR(100);
        SELECT @RestaurantName = RestaurantName FROM inserted;
        PRINT 'New restaurant added: ' + @RestaurantName;
    END
END;

CREATE TRIGGER trg_RatingValidation
ON [dbo].[ASSIGNMENT_3]
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE Rating < 0 OR Rating > 5)
    BEGIN
        RAISERROR ('Rating must be between 0 and 5.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;