# Fabric Sales Analytics Portfolio

An end-to-end Microsoft Fabric data engineering and analytics project demonstrating metadata-driven ingestion, incremental loading, medallion architecture, dimensional modeling, and Power BI analytics.

## Architecture

SQL Server (SalesDB)
        ↓
Metadata-Driven Pipeline
        ↓
Bronze Lakehouse
        ↓
Silver Lakehouse
        ↓
Gold Lakehouse
        ↓
Semantic Model
        ↓
Power BI

## Technologies

- Microsoft Fabric
- Fabric Data Factory
- Lakehouse
- SQL Server
- T-SQL
- Power BI
- DAX
- Medallion Architecture
- Metadata-Driven Pipelines
- Incremental Loading

## Source Data

The project uses a SQL Server database named `SalesDB` containing:

- Customers
- Products
- Orders
- OrderDetails

## Data Engineering

### Bronze Layer

The Bronze Lakehouse stores raw data ingested from SQL Server.

### Silver Layer

The Silver Lakehouse contains cleaned and transformed data.

### Gold Layer

The Gold Lakehouse contains a dimensional model for analytics.

### Incremental Loading

The ingestion pipeline uses a metadata-driven ForEach pattern and a SQL Server watermark table to load newly created or modified records.

## Pipeline

The main pipeline is:

`PL_Daily_Sales_Ingestion`

It uses:

- Metadata lookup
- ForEach activity
- Dynamic SQL queries
- Watermark lookup
- Copy Data activity
- Watermark update

## Data Model

The Gold layer contains:

- `gold_fact_sales`
- `gold_dim_customer`
- `gold_dim_product`
- `gold_dim_date`

## Analytics

The project includes a Power BI semantic model and sales analytics report.

## Project Status

Core ingestion, transformation, dimensional modeling, and semantic modeling have been implemented.

## Disclaimer

This is a personal learning and portfolio project using demonstration data. No confidential company data or credentials are included.
