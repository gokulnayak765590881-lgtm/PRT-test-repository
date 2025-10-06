USE CASESTUDY_1
SELECT SUM(Sales) AS Total_Sales,-----normal plain query
       SUM(Profit) AS Total_Profit
    FROM fact;
-------------------------------------------------------------------

CREATE PROCEDURE sp_TotalSalesProfit ----STORED PROCEDURE Without paramitre
AS
BEGIN
    SELECT SUM(Sales) AS Total_Sales,
           SUM(Profit) AS Total_Profit
    FROM fact;
END;

EXEC sp_TotalSalesProfit;
---------------------------------

--Question: Create a stored procedure to get total sales and profit for a given ProductId.
CREATE PROCEDURE sp_SalesProfit_ByProduct
    @ProductId INT
AS
BEGIN
    SELECT ProductId,
           SUM(Sales) AS Total_Sales,
           SUM(Profit) AS Total_Profit
    FROM fact
    WHERE ProductId = @ProductId
    GROUP BY ProductId;
END;

EXEC sp_SalesProfit_ByProduct 3;  -- For ProductId = 3

----------------------------
--Question: Create a stored procedure to return sales and profit between two dates.
CREATE PROCEDURE sp_SalesProfit_ByDate
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT SUM(Sales) AS Total_Sales,
           SUM(Profit) AS Total_Profit
    FROM fact
    WHERE Date BETWEEN @StartDate AND @EndDate;
END;

EXEC sp_SalesProfit_ByDate '2010-01-01', '2010-12-31';
-----------------------------------------------------
--Create a stored procedure to display the total Profit, Sales, and Margin from the fact table.
--Basic Stored Procedure
CREATE PROCEDURE Total_Profit_sales_margin
AS BEGIN
 SELECT SUM(Profit) as Totalt_Profit,
        SUM(Sales) AS Total_Sales,
        SUM(Margin) AS Total_margin
        FROm fact;
END;

EXEC Total_Profit_sales_margin;
-------------------------------------------------
--Stored Procedure with One Parameter
--Create a stored procedure that takes a ProductId as input and returns the Profit, Sales, and Budget_COGS for that product.

CREATE PROCEDURE Profit_sales_COGS
@ProductId INT
AS
BEGIN
    SELECT Profit, Sales, Budget_COGS
    FROM fact
    WHERE ProductId = @productId
END

EXEC Profit_sales_COGS 3;
SELECt * FROM fact
--------------------------------------------------
--Stored Procedure with Date Filter
--Create a stored procedure that accepts a start date and end date and returns the Total Sales and Marketing 
--Expenses between those dates.

CREATE PROCEDURE Total_Sales_marketing_expenses
@Start_Date DATE,
@End_Date DATE
AS
BEGIN
SELECT SUM(Sales) AS Total_Sales,
       SUM(Marketing) AS Marketing_Expemces
       FROM fact
       WHERE DATE BETWEEN @Start_Date AND @End_Date
END;

-- Example call with dates
EXEC Total_Sales_marketing_expenses @Start_Date = '2010-01-01', @End_Date = '2010-01-14';
--------------------------------------------------------------------------------------------------

CREATE PROCEDURE usp_GetMonthlyPerformance
    @TargetYear INT,
    @TargetMonth INT,
    @TargetProductId INT,
    @TargetAreaCode INT
AS
BEGIN
    SELECT
        [Date],
        [ProductId],
        [Sales] AS ActualSales,
        [Budget_Sales] AS BudgetedSales,
        [Profit] AS ActualProfit,
        [Budget_Profit] AS BudgetedProfit,
        ([Sales] - [Budget_Sales]) AS Sales_Variance,
        ([Profit] - [Budget_Profit]) AS Profit_Variance
    FROM
        [CASESTUDY_1].[dbo].[fact]
    WHERE
        YEAR([Date]) = @TargetYear
        AND MONTH([Date]) = @TargetMonth
        AND [ProductId] = @TargetProductId
        AND [Area_Code] = @TargetAreaCode
    ORDER BY
        [Date];
END;
GO
SELECT * FROM fact
EXEC usp_GetMonthlyPerformance @TargetYear=2010, @TargetMonth=3, @TargetProductId=10, @TargetAreaCode=970;
-------------------------------------------
CREATE PROCEDURE FindLowMarginProducts
AS
BEGIN
    SELECT ProductId, SUM(Margin) AS TotalMargin
    FROM [dbo].[fact]
    WHERE Margin < 0
    GROUP BY ProductId;
END;

EXEC FindLowMarginProducts;
--------------------------------------------------------
--Stored Procedure with Grouping
--Create a stored procedure that shows the Total Sales by Area_Code (grouped by Area_Code).
CREATE PROCEDURE Total_sales
@Area_Code int
AS BEGIN
SELECT SUM(Sales) AS Total_Sales
       FROm fact
       WHERE Area_Code = @Area_Code
END;

EXEC Total_sales 719;
---------------------------------------------------
CREATE PROCEDURE sp_ProfitComparison
AS
BEGIN
    SELECT 
        ProductId,
        SUM(Profit) AS Actual_Profit,
        SUM(Budget_Profit) AS Budget_Profit
    FROM fact
    GROUP BY ProductId;
END;

EXEC sp_ProfitComparison

--------------------------------------------------------
-----------------------------VIEW-----------------------
--------------------------------------------------------

CREATE VIEW MyView AS --Simple View statement
SELECT * 
FROM fact WHERE Profit < 0;

SELECT ProductId, Profit FROM MyView;
---------------------------------------
--A sales manager wants a View to see only ProductId, Date, and Sales for products
--with sales over $10,000. Create a View for this.

CREATE VIEW Product_Sales as
SELECT ProductId, Date, Sales
From fact
WHERE Sales > 840;
DROP VIEW Product_Sales
SELECT ProductId, Date, Sales FROM Product_Sales;

SELECt * FROM fact;
-------------------------------------------------
--The finance team needs a View showing Date, ProductId, and Profit for products in 
--Area_Code 456. Write the View.

CREATE VIEW Dade_Product AS
SELECT Date, ProductId, Profit
FROM fact
WHERE Area_Code =719;

SELECT Date, ProductID, Profit
From Dade_Product

SELECT * FROM fact
-------------------------------------------------------

--A report needs a View that sums Sales and COGS by ProductId for data after 
--January 1, 2025. Write the View.

CREATE VIEW Sales_COGS AS
SELECT ProductId, SUM(Sales) AS Tota_sales,
                  SUM(Budget_COGS) AS Total_COSG
            FROM fact
            WHERE Date >= '2011-01-01'
            group by ProductId;

SELECT * FROm Sales_COGS;
-------------------------------------------------------------------
--The inventory team wants a View with ProductId, Date, and Inventory for products
--with inventory below 50. Create it.


CREATE VIEW Details_Inv_Below_50 AS
SELECT ProductId, Date, Inventory
FROM dbo.fact
WHERE Inventory < 50;

SELECT * FROM Details_Inv_Below_50;

SELECT * FROM dbo.fact