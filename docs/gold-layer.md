# Fabric Sales Analytics — Gold Layer

## Purpose

The Gold layer contains business-ready analytical tables designed for reporting and business intelligence.

The Gold layer transforms the cleaned Silver data into a dimensional model that can be consumed efficiently by the semantic model and Power BI.

The Gold layer is stored in:

`LH_Sales_Gold`

## Source

The Gold layer reads from:

`LH_Sales_Silver`

Source tables:

- `silver_customers`
- `silver_products`
- `silver_orders`
- `silver_orderdetails`

## Target

`LH_Sales_Gold`

Gold tables:

- `gold_fact_sales`
- `gold_dim_customer`
- `gold_dim_product`
- `gold_dim_date`

## Gold Layer Architecture

```text
LH_Sales_Silver
        |
        +------------------+
        |                  |
        v                  v
 Customer Data       Product Data
        |                  |
        v                  v
gold_dim_customer   gold_dim_product
        |                  |
        |                  |
        +--------+---------+
                 |
                 v
        Sales Transactions
                 |
                 v
        gold_fact_sales
                 |
                 v
          Semantic Model
                 |
                 v
              Power BI
Dimensional Model

The Gold layer follows a star-schema approach.

                 gold_dim_customer
                         |
                         |
                         v
gold_dim_date ---> gold_fact_sales <--- gold_dim_product

The central fact table contains sales transactions, while dimension tables provide descriptive attributes used for filtering, grouping, and analysis.

Fact Table
gold_fact_sales

The fact table represents individual sales transaction lines.

It is created from:

silver_orders
silver_orderdetails

The fact table combines order-level and order-detail information to create an analytical sales dataset.

Typical fields include:

FieldPurpose
OrderIDSales order identifier
CustomerIDCustomer reference
ProductIDProduct reference
OrderDateTransaction date
QuantityUnits sold
UnitPricePrice per unit
NetSalesCalculated sales amount
Net Sales Calculation

Net sales are calculated using:

NetSales = Quantity × UnitPrice

This creates a reusable measure for downstream reporting.

Customer Dimension
gold_dim_customer

The customer dimension contains descriptive information about customers.

Source:

silver_customers

The dimension is used to analyze sales by customer attributes.

Typical attributes include:

CustomerID
CustomerName
Email
City
Country

The customer dimension provides descriptive context for the sales fact table.

Product Dimension
gold_dim_product

The product dimension contains descriptive information about products.

Source:

silver_products

The dimension is used to analyze sales by product attributes.

Typical attributes include:

ProductID
ProductName
Category
Price

The product dimension allows Power BI users to analyze sales by product and category.

Date Dimension
gold_dim_date

The date dimension provides a consistent calendar structure for time-based analysis.

It supports reporting such as:

Daily sales
Monthly sales
Yearly sales
Sales trends
Year-over-year analysis

Typical attributes include:

AttributePurpose
DateCalendar date
YearYear-level analysis
MonthMonth-level analysis
MonthNameUser-friendly month name
QuarterQuarterly analysis
Relationships

The Gold model uses relationships between the fact and dimension tables.

Conceptually:

gold_dim_customer
        |
        | CustomerID
        |
        v
gold_fact_sales
        ^
        |
        | ProductID
        |
gold_dim_product


gold_dim_date
        |
        | Date
        v
gold_fact_sales

The expected relationship pattern is:

FromToRelationship
gold_dim_customergold_fact_salesOne-to-Many
gold_dim_productgold_fact_salesOne-to-Many
gold_dim_dategold_fact_salesOne-to-Many

The dimension tables provide the filtering context while the fact table contains the measurable business events.

Star Schema

The resulting analytical model follows this structure:

                     Customer
                        |
                        |
                        v
Date ------------> Sales <------------ Product
Dimension          Fact              Dimension

This structure simplifies analytical queries and provides a clean foundation for the Power BI semantic model.

Business Metrics

The Gold layer provides the foundation for business metrics such as:

Total Sales
Total Sales = SUM(gold_fact_sales[NetSales])
Total Quantity
Total Quantity = SUM(gold_fact_sales[Quantity])
Order Count
Order Count = DISTINCTCOUNT(gold_fact_sales[OrderID])
Average Order Value
Average Order Value =
DIVIDE(
    [Total Sales],
    [Order Count]
)

These metrics can be implemented as DAX measures in the semantic model.

Gold Layer Design Principles

The Gold layer follows these principles:

Business-ready data
Clear fact and dimension separation
Consistent keys
Reusable analytical measures
Simplified reporting structure
Optimized for BI consumption

Complex source-system structures are transformed into a model that is easier for analysts and business users to understand.

Bronze → Silver → Gold

The complete transformation architecture is:

SQL Server
    |
    v
Bronze
Raw Ingestion
    |
    v
Silver
Cleaning & Deduplication
    |
    v
Gold
Business Modeling
    |
    v
Semantic Model
    |
    v
Power BI

Each layer has a distinct responsibility:

LayerResponsibility
BronzeIngest raw source data
SilverClean and standardize data
GoldCreate business-ready analytical model
Semantic ModelDefine relationships and measures
Power BIVisualize and analyze business data
Gold Layer Outcome

The Gold layer provides a stable analytical foundation for the semantic model.

The final model contains:

gold_fact_sales
        |
        +--- gold_dim_customer
        |
        +--- gold_dim_product
        |
        +--- gold_dim_date

This enables analysis of sales by:

Customer
Product
Category
Date
Month
Quarter
Year
Related Components
LH_Sales_Silver
LH_Sales_Gold
gold_fact_sales
gold_dim_customer
gold_dim_product
gold_dim_date
SM_Sales_Analytics
Power BI
