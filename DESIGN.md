# Diseño Dimensional — Sales Data Warehouse

## Modelo: Star Schema

Hechos centrales: transacciones de venta.
Dimensiones: fecha, producto, segmento de cliente.

---

## Tarea 1 — Dimensión `MyDimDate`

Granularidad: día. Permite agregación por año, trimestre, mes, día y día de la semana.

| Campo | Tipo | Descripción |
|---|---|---|
| dateid | INT (PK) | Identificador único de la fecha |
| year | INT | Año |
| month | INT | Mes (1-12) |
| monthname | VARCHAR | Nombre del mes |
| day | INT | Día del mes |
| weekday | INT | Día de la semana (1-7) |
| weekdayname | VARCHAR | Nombre del día |

## Tarea 2 — Dimensión `MyDimProduct`

| Campo | Tipo | Descripción |
|---|---|---|
| productid | INT (PK) | Identificador único del producto |
| productname | VARCHAR | Nombre/descripción del producto |

## Tarea 3 — Dimensión `MyDimCustomerSegment`

| Campo | Tipo | Descripción |
|---|---|---|
| segmentid | INT (PK) | Identificador único del segmento |
| segmentname | VARCHAR | Nombre del segmento |

## Tarea 4 — Tabla de hechos `MyFactSales`

| Campo | Tipo | Descripción |
|---|---|---|
| salesid | INT (PK) | Identificador único de la venta |
| productid | INT (FK) | Referencia a MyDimProduct |
| quantitysold | INT | Cantidad vendida |
| priceperunit | DECIMAL(10,2) | Precio por unidad |
| segmentid | INT (FK) | Referencia a MyDimCustomerSegment |
| dateid | INT (FK) | Referencia a MyDimDate |

---

## Nota: evolución del schema

El diseño inicial (Tareas 1-4) refleja el modelo conceptual acordado con stakeholders. Posteriormente, debido a restricciones operativas en la recolección de datos, el schema fue ajustado al modelo final implementado en la BD `PracProj` (ver `sql/02-schema-pracproj.sql`), con los siguientes cambios:

- `MyDimDate` → `DimDate`: se añadieron `date`, `quarter`, `quartername` para soportar reportes trimestrales.
- `MyDimProduct` → `DimProduct`: `productname` se renombró a `producttype` (categoría en lugar de nombre individual).
- `MyDimCustomerSegment` → `DimCustomerSegment`: `segmentname` se renombró a `city` (la segmentación final es geográfica).
- `MyFactSales` → `FactSales`: `salesid` cambió de `INT` a `VARCHAR(255)` para soportar identificadores alfanuméricos; `priceperunit` → `price_perunit`; se agregaron FK constraints explícitas.

Este tipo de iteración entre modelo conceptual y modelo físico es común en proyectos reales de Data Warehousing.