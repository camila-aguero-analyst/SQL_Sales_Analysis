-- ==========================================================
-- Purpose:
-- Compare bike sales between customers with children and
-- customers without children to support customer segmentation.
--
-- Dataset:
-- AdventureWorksDW2019
-- ==========================================================

-- Create a CTE to isolate bike-related sales records

WITH bike_sales AS (

    SELECT
        T1.OrderDateKey,
        T1.OrderDate,
        T1.CustomerKey,
        T2.BirthDate,
        T2.YearlyIncome,
        T2.TotalChildren,
        T2.CommuteDistance,
        T3.EnglishCountryRegionName AS Country,
        T1.SalesAmount,
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

-- Analyze monthly bike sales by customer children status

SELECT
    SUBSTRING(CAST(OrderDateKey AS CHAR), 1, 6) AS MonthKey,

    CASE
        WHEN TotalChildren = 0 THEN 'No Children'
        ELSE 'Has Children'
    END AS ChildrenStatus,

    COUNT(SalesOrderNumber) AS TotalSales

FROM bike_sales

WHERE SUBSTRING(CAST(OrderDateKey AS CHAR), 1, 4) = '2012'

GROUP BY
    SUBSTRING(CAST(OrderDateKey AS CHAR), 1, 6),
    CASE
        WHEN TotalChildren = 0 THEN 'No Children'
        ELSE 'Has Children'
    END

ORDER BY
    MonthKey,
    ChildrenStatus;
