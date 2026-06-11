-- ==========================================================
-- Purpose:
-- Analyze sales by customer age groups across different
-- countries to identify demographic purchasing patterns.
--
-- Dataset:
-- AdventureWorksDW2019
-- ==========================================================

-- Create a CTE to calculate customer age at the time of purchase

WITH CTE_SalesAge AS (

    SELECT

        G.EnglishCountryRegionName AS Country,

        DATEDIFF(
            YEAR,
            C.BirthDate,
            S.OrderDate
        ) AS CustomerAge,

        S.SalesOrderNumber

    FROM AdventureWorksDW2019.dbo.FactInternetSales AS S

    INNER JOIN AdventureWorksDW2019.dbo.DimCustomer AS C
        ON S.CustomerKey = C.CustomerKey

    INNER JOIN AdventureWorksDW2019.dbo.DimGeography AS G
        ON C.GeographyKey = G.GeographyKey

)

-- Group customers into age categories and count sales

SELECT

    Country,

    CASE

        WHEN CustomerAge < 30 THEN 'Under 30'

        WHEN CustomerAge BETWEEN 30 AND 40 THEN '30 - 40'

        WHEN CustomerAge BETWEEN 41 AND 50 THEN '41 - 50'

        WHEN CustomerAge BETWEEN 51 AND 60 THEN '51 - 60'

        ELSE 'Over 60'

    END AS AgeGroup,

    COUNT(SalesOrderNumber) AS TotalSales

FROM CTE_SalesAge

GROUP BY

    Country,

    CASE

        WHEN CustomerAge < 30 THEN 'Under 30'

        WHEN CustomerAge BETWEEN 30 AND 40 THEN '30 - 40'

        WHEN CustomerAge BETWEEN 41 AND 50 THEN '41 - 50'

        WHEN CustomerAge BETWEEN 51 AND 60 THEN '51 - 60'

        ELSE 'Over 60'

    END

ORDER BY

    Country,

    AgeGroup;
