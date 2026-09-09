# Microsoft Fabric Artifacts

This directory contains the Microsoft Fabric implementation artifacts for the Sales Analytics project.

## Folder Structure

```text
fabric/
├── bronze/
├── silver/
├── gold/
└── pipelines/
Bronze

The bronze/ directory contains artifacts and documentation related to raw data ingestion into:

LH_Sales_Bronze

Source:

SalesDB

Tables:

Customers
Products
Orders
OrderDetails

The Bronze layer is designed to preserve source data with minimal transformation.

Silver

The silver/ directory contains artifacts related to data cleansing and transformation into:

LH_Sales_Silver

Silver tables:

silver_customers
silver_products
silver_orders
silver_orderdetails

Typical Silver transformations include:

Deduplication
Data type standardization
Null handling
Data validation
Referential integrity checks
Gold

The gold/ directory contains artifacts related to the business-ready analytical model in:

LH_Sales_Gold

Gold tables:

gold_fact_sales
gold_dim_customer
gold_dim_product
gold_dim_date

The Gold layer follows a star-schema design.

Pipelines

The pipelines/ directory contains pipeline-related artifacts and documentation.

Main pipeline:

PL_Daily_Sales_Ingestion

The pipeline implements:

Metadata-driven ingestion
ForEach-based processing
Watermark-based incremental loading
Dynamic SQL generation
Bronze ingestion
Watermark updates
Fabric Workspace

Workspace:

Fabric-Sales-Analytics-Portfolio

Lakehouses
LayerLakehouse
BronzeLH_Sales_Bronze
SilverLH_Sales_Silver
GoldLH_Sales_Gold
Semantic Model

SM_Sales_Analytics

The semantic model consumes the Gold layer and provides:

Fact and dimension relationships
DAX measures
Business-friendly analytical fields
Power BI reporting support
Source Connectivity

The project uses:

GW-Bishal-LocalSQL

Connection:

CONN_Local_SalesDB

SQL Server:

localhost\SQLEXPRESS

Database:

SalesDB

Artifact Management

Fabric artifacts are documented in this repository to make the project easier to understand and reproduce.

The repository does not contain credentials, passwords, access tokens, or other secrets.

Related Documentation
Pipeline Documentation
Silver Layer
Gold Layer
Semantic Model & Power BI
