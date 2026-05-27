# Sales Data Warehouse — Star Schema con PostgreSQL

Implementación de un Data Warehouse para una empresa minorista de electrónica de consumo, siguiendo modelado dimensional (Star Schema) con PostgreSQL 16. Incluye carga de datos, consultas de agregación avanzada (GROUPING SETS, ROLLUP, CUBE) y vistas materializadas para optimización.

> Proyecto desarrollado como parte del programa **IBM Data Engineering Professional Certificate** — Course 9: Introduction to Data Warehousing.

---

## Arquitectura

**Star Schema** con una tabla de hechos (`FactSales`) y tres dimensiones:

```text
                    ┌──────────────┐
                    │   DimDate    │
                    └──────┬───────┘
                           │
┌──────────────┐           ▼            ┌──────────────────────┐
│  DimProduct  ├──────► FactSales ◄─────┤  DimCustomerSegment  │
└──────────────┘                        └──────────────────────┘
```

| Tabla | Tipo | Filas |
|---|---|---|
| `DimDate` | Dimensión | 350 |
| `DimProduct` | Dimensión | 25 |
| `DimCustomerSegment` | Dimensión | 19 |
| `FactSales` | Hechos | 25 |

---

## Stack técnico

- **PostgreSQL 16** (alpine)
- **pgAdmin 4** como cliente
- **Docker Compose** para orquestación
- **SQL** — DDL, DML, agregaciones OLAP

---

## Estructura del repositorio
```text
.
├── docker-compose.yml         # Postgres + pgAdmin
├── .env.example               # Plantilla de variables
├── DESIGN.md                  # Modelado dimensional documentado
├── data/                      # CSVs source (no versionados — ver instrucciones)
├── sql/
│   ├── 01-schema-practice.sql        # Schema inicial conceptual
│   ├── 02-schema-pracproj.sql        # Schema operativo del DW
│   ├── 03-queries.sql                # Agregaciones (grouping sets, rollup, cube)
│   └── 04-materialized-view.sql      # Vista materializada max_sales
└── screenshots/               # Evidencia de ejecución
```
---

## Cómo levantar el proyecto

```bash
# 1. Clonar y configurar
cp .env.example .env
# editar .env con tus credenciales

# 2. Levantar contenedores
docker compose up -d

# 3. Acceder a pgAdmin
# http://localhost:5050
```

### Carga de datos (server-side COPY)

```sql
COPY DimDate            FROM '/data/DimDate.csv'            DELIMITER ',' CSV HEADER;
COPY DimProduct         FROM '/data/DimProduct.csv'         DELIMITER ',' CSV HEADER;
COPY DimCustomerSegment FROM '/data/DimCustomerSegment.csv' DELIMITER ',' CSV HEADER;
COPY FactSales          FROM '/data/FactSales.csv'          DELIMITER ',' CSV HEADER;
```

---

## Reportes implementados

| Reporte | Técnica SQL |
|---|---|
| Total ventas por producto / tipo / global | `GROUPING SETS` |
| Subtotales jerárquicos año → ciudad → producto | `ROLLUP` |
| Todas las combinaciones year × city × product | `CUBE` |
| Máximo de venta por ciudad/producto (cached) | `MATERIALIZED VIEW` |

---

## Decisiones técnicas

- **`COPY` vs Import GUI**: se prefirió `COPY` server-side por ser reproducible y scriptable, en lugar de la importación manual vía pgAdmin.
- **Volumen `./data:/data:ro`**: los CSVs se montan como solo lectura para que Postgres pueda leerlos directamente, sin movimiento adicional de archivos.
- **Materialized view con `WITH DATA`**: se materializa al momento de creación. Para refresh manual: `REFRESH MATERIALIZED VIEW max_sales;`

---

## Autor

**Osiel Alejandro Pérez Barroso**  
Junior Data Analyst | Software Engineering Student @ UAC  
[LinkedIn](https://linkedin.com/in/osiel-alejandro-perez-barroso-77873333a/) · [GitHub](https://github.com/AlejandroPerez17)