-- =====================================================
-- BD: PracProj
-- Tareas 13-15: Agregaciones avanzadas
-- =====================================================

-- =========================================
-- Tarea 13: GROUPING SETS
-- Total de ventas por: (productid+producttype), productid, producttype, gran total
-- =========================================
SELECT
    p.Productid,
    p.Producttype,
    SUM(f.Price_PerUnit * f.QuantitySold) AS TotalSales
FROM FactSales f
INNER JOIN DimProduct p ON f.Productid = p.Productid
GROUP BY GROUPING SETS (
    (p.Productid, p.Producttype),
    p.Productid,
    p.Producttype,
    ()
)
ORDER BY p.Productid, p.Producttype;


-- =========================================
-- Tarea 14: ROLLUP
-- Subtotales jerárquicos: year > city > productid > gran total
-- =========================================
SELECT
    d.Year,
    cs.City,
    p.Productid,
    SUM(f.Price_PerUnit * f.QuantitySold) AS TotalSales
FROM FactSales f
JOIN DimDate              d  ON f.Dateid     = d.Dateid
JOIN DimProduct           p  ON f.Productid  = p.Productid
JOIN DimCustomerSegment   cs ON f.Segmentid  = cs.Segmentid
GROUP BY ROLLUP (d.Year, cs.City, p.Productid)
ORDER BY d.Year DESC, cs.City, p.Productid;


-- =========================================
-- Tarea 15: CUBE
-- Todas las combinaciones posibles entre year, city, productid
-- =========================================
SELECT
    d.Year,
    cs.City,
    p.Productid,
    AVG(f.Price_PerUnit * f.QuantitySold) AS AverageSales
FROM FactSales f
INNER JOIN DimDate            d  ON f.Dateid    = d.Dateid
INNER JOIN DimProduct         p  ON f.Productid = p.Productid
INNER JOIN DimCustomerSegment cs ON f.Segmentid = cs.Segmentid
GROUP BY CUBE (d.Year, cs.City, p.Productid);