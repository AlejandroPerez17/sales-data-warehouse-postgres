-- =====================================================
-- Schema inicial: BD Practice
-- Tareas 5-8 del lab
-- =====================================================

-- Tarea 5: Dimensión MyDimDate
CREATE TABLE MyDimDate (
    dateid      INT PRIMARY KEY,
    year        INT,
    month       INT,
    monthname   VARCHAR(20),
    day         INT,
    weekday     INT,
    weekdayname VARCHAR(20)
);

-- Tarea 6: Dimensión MyDimProduct
CREATE TABLE MyDimProduct (
    productid   INT PRIMARY KEY,
    productname VARCHAR(255)
);

-- Tarea 7: Dimensión MyDimCustomerSegment
CREATE TABLE MyDimCustomerSegment (
    segmentid   INT PRIMARY KEY,
    segmentname VARCHAR(255)
);

-- Tarea 8: Hechos MyFactSales
CREATE TABLE MyFactSales (
    salesid       INT PRIMARY KEY,
    productid     INT,
    quantitysold  INT,
    priceperunit  DECIMAL(10, 2),
    segmentid     INT,
    dateid        INT
);