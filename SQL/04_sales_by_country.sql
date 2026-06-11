-- ==========================================================
-- Purpose:
-- Analyze total sales by country to identify geographic
-- sales performance across customer regions.
--
-- Dataset:
-- AdventureWorksDW2019
-- ==========================================================

-- Create a CTE to combine sales, customer, and geography data

WITH CTE_Sales AS (

    SELECT
        G.EnglishCountryRegionName AS Country,
        S.SalesOrderNumber AS OrderNumber,
        CAST(S.OrderDate AS DATE) AS OrderDate

    FROM AdventureWorksDW2019.dbo.FactInternetSales AS S

    INNER JOIN AdventureWorksDW2019.dbo.DimCustomer AS C
        ON S.CustomerKey = C.CustomerKey

    INNER JOIN AdventureWorksDW2019.dbo.DimGeography AS G
        ON C.GeographyKey = G.GeographyKey

    WHERE SUBSTRING(CAST(S.OrderDateKey AS CHAR), 1, 4) = '2013'
)

-- Count total sales by country

SELECT
    Country,
    COUNT(OrderNumber) AS TotalSales

FROM CTE_Sales

GROUP BY Country

ORDER BY TotalSales DESC;
