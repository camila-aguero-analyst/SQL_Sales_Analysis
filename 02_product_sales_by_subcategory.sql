-- ==========================================================
-- Purpose:
-- Analyze sales performance across product subcategories
-- to identify the highest-selling product groups.
--
-- Dataset:
-- AdventureWorksDW2019
-- ==========================================================

-- Create a Common Table Expression (CTE)
-- to combine sales and product information

WITH CTE_ProductSales AS (

    SELECT

        -- Product name
        P.EnglishProductName AS ProductName,

        -- Product subcategory
        PS.EnglishProductSubcategoryName AS ProductSubcategory,

        -- Unique sales order identifier
        S.SalesOrderNumber

    FROM AdventureWorksDW2019.dbo.FactInternetSales AS S

    INNER JOIN AdventureWorksDW2019.dbo.DimCustomer AS C
        ON S.CustomerKey = C.CustomerKey

    INNER JOIN AdventureWorksDW2019.dbo.DimProduct AS P
        ON S.ProductKey = P.ProductKey

    INNER JOIN AdventureWorksDW2019.dbo.DimProductSubcategory AS PS
        ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey

)

-- Count total sales by product subcategory

SELECT

    ProductSubcategory AS ProductType,

    COUNT(SalesOrderNumber) AS TotalSales

FROM CTE_ProductSales

GROUP BY ProductSubcategory

ORDER BY TotalSales DESC;
