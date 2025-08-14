-- OLAP Queries for Retail Data Warehouse (DWHS.db)
-- These queries demonstrate OLAP operations: Roll-up, Drill-down, and Slice

-- 1. ROLL-UP: Total sales by country and quarter
-- Groups data at a higher level of aggregation (country and quarter)
SELECT
    c.Country,
    t.Quarter,
    t.Year,
    SUM(fs.SalesAmount) AS TotalSales,
    COUNT(DISTINCT fs.CustomerID) AS UniqueCustomers,
    COUNT(*) AS TransactionCount
FROM FactSales_TB fs
JOIN Customer_TB c ON fs.CustomerID = c.CustomerID
JOIN Time_TB t ON fs.TimeID = t.TimeID
GROUP BY c.Country, t.Quarter, t.Year
ORDER BY t.Year, t.Quarter, TotalSales DESC;

-- 2. DRILL-DOWN: Sales details for United Kingdom by month
-- Breaks down data to a more detailed level (monthly breakdown for a specific country)
SELECT
    t.Year,
    t.Month,
    CASE t.Month
        WHEN 1 THEN 'January'
        WHEN 2 THEN 'February'
        WHEN 3 THEN 'March'
        WHEN 4 THEN 'April'
        WHEN 5 THEN 'May'
        WHEN 6 THEN 'June'
        WHEN 7 THEN 'July'
        WHEN 8 THEN 'August'
        WHEN 9 THEN 'September'
        WHEN 10 THEN 'October'
        WHEN 11 THEN 'November'
        WHEN 12 THEN 'December'
    END AS MonthName,
    SUM(fs.SalesAmount) AS MonthlySales,
    AVG(fs.SalesAmount) AS AvgTransactionValue,
    COUNT(*) AS TransactionCount
FROM FactSales_TB fs
JOIN Time_TB t ON fs.TimeID = t.TimeID
JOIN Customer_TB c ON fs.CustomerID = c.CustomerID
WHERE c.Country = 'United Kingdom'
GROUP BY t.Year, t.Month
ORDER BY t.Year, t.Month;

-- 3. SLICE: Total sales for specific product categories
-- Filters data to show only specific dimensions (product categories)
SELECT
    p.ProductCategory,
    SUM(fs.SalesAmount) AS TotalSales,
    SUM(fs.QuantitySold) AS TotalQuantity,
    COUNT(DISTINCT p.ProductID) AS ProductCount,
    AVG(fs.SalesAmount) AS AvgSalesPerTransaction
FROM FactSales_TB fs
JOIN Product_TB p ON fs.ProductID = p.ProductID
WHERE p.ProductCategory IN ('Home Decor', 'Vintage', 'Sets')  -- Focus on specific categories
GROUP BY p.ProductCategory
ORDER BY TotalSales DESC;

-- 4. ADDITIONAL OLAP QUERY: Pivot-style analysis
-- Sales by country and product category (cross-tabulation)
SELECT
    c.Country,
    p.ProductCategory,
    SUM(fs.SalesAmount) AS TotalSales,
    COUNT(*) AS TransactionCount
FROM FactSales_TB fs
JOIN Customer_TB c ON fs.CustomerID = c.CustomerID
JOIN Product_TB p ON fs.ProductID = p.ProductID
WHERE c.Country IN ('United Kingdom', 'Germany', 'France', 'Netherlands', 'EIRE')  -- Top countries
GROUP BY c.Country, p.ProductCategory
ORDER BY c.Country, TotalSales DESC;