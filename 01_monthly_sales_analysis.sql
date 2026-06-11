-- ==========================================================
-- Project: Sales Analysis Using SQL
-- File: 01_monthly_sales_analysis.sql
-- Author: Camila Aguero
--
-- Purpose:
-- Analyze monthly sales activity for the year 2012 by
-- extracting year and month information from the OrderDateKey.
--
-- Dataset:
-- AdventureWorksDW2019
-- ==========================================================

SELECT

    -- Format the order date as YYYY/MM
    FORMAT(
        CONVERT(
            DATETIME,
            SUBSTRING(CAST(OrderDateKey AS CHAR),1,4)
            + '-'
            + SUBSTRING(CAST(OrderDateKey AS CHAR),5,2)
            + '-01'
        ),
        'yyyy/MM'
    ) AS MonthYear,

    -- Unique sales order identifier
    SalesOrderNumber AS OrderNumber,

    -- Remove timestamp from order date
    CAST(OrderDate AS DATE) AS OrderDate

FROM AdventureWorksDW2019.dbo.FactInternetSales

-- Filter for sales placed during 2012

WHERE SUBSTRING(CAST(OrderDateKey AS CHAR),1,4)='2012'

ORDER BY MonthYear;
