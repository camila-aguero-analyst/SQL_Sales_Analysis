-- ==========================================================
-- Project: Sales Analysis Using SQL
-- File: 05_sales_by_commute_distance.sql
-- Author: Camila Aguero
--
-- Purpose:
-- Analyze bike sales by customer commute distance to identify
-- how commuting behavior relates to product demand.
--
-- Dataset:
-- AdventureWorksDW2019
-- ==========================================================

WITH CommuteSales AS (

    SELECT
        T2.CommuteDistance,
        T1.SalesOrderNumber

    FROM AdventureWorksDW2019.dbo.FactInternetSales AS T1

    INNER JOIN AdventureWorksDW2019.dbo.DimCustomer AS T2
        ON T1.CustomerKey = T2.CustomerKey

    INNER JOIN AdventureWorksDW2019.dbo.DimGeography AS T3
        ON T2.GeographyKey = T3.GeographyKey

    INNER JOIN AdventureWorksDW2019.dbo.DimProduct AS T4
        ON T1.ProductKey = T4.ProductKey

    INNER JOIN AdventureWorksDW2019.dbo.DimProductSubcategory AS T5
        ON T4.ProductSubcategoryKey = T5.ProductSubcategoryKey

    WHERE T5.EnglishProductSubcategoryName IN (
        'Mountain Bikes',
        'Touring Bikes',
        'Road Bikes'
    )
)

SELECT
    CommuteDistance,
    COUNT(DISTINCT SalesOrderNumber) AS TotalSales

FROM CommuteSales

GROUP BY CommuteDistance

ORDER BY CommuteDistance;
