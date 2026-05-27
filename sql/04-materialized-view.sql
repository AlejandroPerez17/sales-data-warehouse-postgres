-- =====================================================
-- Tarea 16: Materialized View max_sales
-- Máximo de ventas por ciudad, producto y tipo de producto
-- =====================================================

CREATE MATERIALIZED VIEW max_sales AS
SELECT
    cs.City,
    p.Productid,
    p.Producttype,
    MAX(f.Price_PerUnit * f.QuantitySold) AS MaxSales
FROM FactSales f
JOIN DimProduct         p  ON f.Productid = p.Productid
JOIN DimCustomerSegment cs ON f.Segmentid = cs.Segmentid
GROUP BY
    cs.City,
    p.Productid,
    p.Producttype
WITH DATA;

-- Para actualizar la vista materializada con los datos más recientes:
-- REFRESH MATERIALIZED VIEW max_sales;