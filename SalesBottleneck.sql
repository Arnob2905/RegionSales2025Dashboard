CREATE DATABASE SalesAnalysis;
USE SalesAnalysis;

SELECT * FROM RegionalSales2025;


/* 1- Monthly trend of sales across all regions. */
SELECT 
    SUBSTR(Date,1,7) AS Month,
    SUM(TotalAmount) AS TotalSales
FROM RegionalSales2025
WHERE OrderStatus = 'Completed'
GROUP BY SUBSTR(Date,1,7)
ORDER BY Month;

/* 2- Percentage of canceled and returned orders per region. */
SELECT 
    Region,
    COUNT(*) * 100.0 /
    (SELECT COUNT(*) FROM RegionalSales2025 r2 WHERE r2.Region = r1.Region)
    AS CancelReturnPercent
FROM RegionalSales2025 r1
WHERE OrderStatus IN ('Cancelled','Returned')
GROUP BY Region;

/* 3- Identify 3 regions/products with most revenue loss (cancelled/returned). */
SELECT 
    Region,
    ProductName,
    SUM(TotalAmount) AS LossAmount
FROM RegionalSales2025
WHERE OrderStatus IN ('Cancelled','Returned')
GROUP BY Region, ProductName
ORDER BY LossAmount DESC
LIMIT 3;

/*4- Average order value by product category.*/
SELECT 
    Category,
    AVG(TotalAmount) AS AvgOrderValue
FROM RegionalSales2025
WHERE OrderStatus = 'Completed'
GROUP BY Category;

/* 5- Top 5 performing sales agents (by completed revenue)*/
SELECT 
    SalesAgent,
    SUM(TotalAmount) AS TotalRevenue
FROM RegionalSales2025
WHERE OrderStatus = 'Completed'
GROUP BY SalesAgent
ORDER BY TotalRevenue DESC
LIMIT 5;

/* 6- Category-wise total sales and contribution to grand total */
SELECT 
    Category,
    SUM(TotalAmount) AS CategorySales
FROM RegionalSales2025
WHERE OrderStatus = 'Completed'
GROUP BY Category;

/* 7- List customers with highest frequency of returns (≥ 3 times). */
SELECT 
    CustomerID,
    COUNT(*) AS ReturnCount
FROM RegionalSales2025
WHERE OrderStatus = 'Returned'
GROUP BY CustomerID
HAVING COUNT(*) >= 3;





