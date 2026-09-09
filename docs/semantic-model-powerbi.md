# Fabric Sales Analytics — Semantic Model & Power BI

## Purpose

The semantic model provides the business-facing analytical layer between the Gold Lakehouse and Power BI.

It defines:

- Relationships between fact and dimension tables
- Business measures
- Analytical calculations
- Fields available to report developers
- A simplified structure for business users

Semantic model:

`SM_Sales_Analytics`

## Architecture

```text
LH_Sales_Gold
      |
      v
SM_Sales_Analytics
      |
      +----------------------+
      |                      |
      v                      v
Relationships             DAX Measures
      |                      |
      +----------+-----------+
                 |
                 v
              Power BI
Gold Tables Used

The semantic model is based on the following Gold tables:

gold_fact_sales
gold_dim_customer
gold_dim_product
gold_dim_date
Data Model

The model follows a star-schema design.

                 gold_dim_customer
                         |
                         |
                         v
gold_dim_date ---> gold_fact_sales <--- gold_dim_product

The fact table contains measurable sales transactions.

The dimension tables provide descriptive attributes used for filtering, grouping, and slicing the sales data.

Relationships

The semantic model contains active relationships between the fact and dimension tables.

DimensionFactKeyCardinality
gold_dim_customergold_fact_salesCustomerIDOne-to-Many
gold_dim_productgold_fact_salesProductIDOne-to-Many
gold_dim_dategold_fact_salesDateOne-to-Many
Customer Relationship
gold_dim_customer[CustomerID]
              |
              | 1 : *
              v
gold_fact_sales[CustomerID]
Product Relationship
gold_dim_product[ProductID]
              |
              | 1 : *
              v
gold_fact_sales[ProductID]
Date Relationship
gold_dim_date[Date]
              |
              | 1 : *
              v
gold_fact_sales[OrderDate]

The dimension tables provide filtering context to the fact table.

DAX Measures

Business calculations are implemented as reusable DAX measures rather than calculated individually inside report visuals.

Total Sales
Total Sales =
SUM(gold_fact_sales[NetSales])

This measure calculates the total value of sales.

Total Quantity
Total Quantity =
SUM(gold_fact_sales[Quantity])

This measure calculates the total number of units sold.

Order Count
Order Count =
DISTINCTCOUNT(gold_fact_sales[OrderID])

This measure counts unique sales orders.

Average Order Value
Average Order Value =
DIVIDE(
    [Total Sales],
    [Order Count]
)

This measure calculates the average sales value per order.

Why Measures Are Used

Measures allow calculations to respond dynamically to report filters and slicers.

For example:

Total Sales
     |
     +--> All Customers
     |
     +--> Selected Customer
     |
     +--> Selected Product
     |
     +--> Selected Category
     |
     +--> Selected Month

The same measure can therefore be reused across multiple report visuals.

Power BI Report

The semantic model is consumed by a Power BI report for sales analysis.

The report is designed to provide a high-level overview of sales performance and allow users to drill into different business dimensions.

Dashboard KPIs

The main KPI cards include:

Total Sales
Total Orders
Total Quantity
Average Order Value

These provide an immediate overview of overall sales performance.

Sales Trend

A sales trend visual shows how sales change over time.

The Date dimension provides the time attributes required for:

Daily analysis
Monthly analysis
Quarterly analysis
Yearly analysis

Conceptually:

Date Dimension
      |
      v
OrderDate
      |
      v
Sales Trend
Sales by Category

The Product dimension provides category information.

This allows the report to analyze:

Sales by product category
Sales by individual product
Category contribution to total sales

Example analytical path:

Product
   |
   +--> Category
   |
   +--> Product Name
   |
   v
Sales
Sales Analysis by Customer

The Customer dimension allows sales to be analyzed by customer attributes.

Possible analysis includes:

Sales by customer
Sales by city
Sales by country
Customer order count
Report Filtering

The star schema allows report users to filter sales using dimension attributes.

Examples:

Customer
    |
    v
Sales

Product
    |
    v
Sales

Date
    |
    v
Sales

This provides consistent filtering behavior across the report.

Analytical Flow

The complete analytical path is:

SQL Server
    |
    v
Bronze
Raw Data
    |
    v
Silver
Cleaned Data
    |
    v
Gold
Business Model
    |
    v
Semantic Model
Relationships + Measures
    |
    v
Power BI
Reports & Dashboards
Design Principles

The semantic model follows these principles:

Star Schema

Fact and dimension tables are separated to simplify analytical queries and reporting.

Reusable Measures

Business calculations are defined once as DAX measures and reused throughout the report.

Clear Relationships

Relationships are defined between dimensions and the central sales fact table.

Business-Friendly Model

Technical source-system complexity is hidden from report users.

Centralized Business Logic

Important analytical calculations are maintained in the semantic model rather than duplicated across individual visuals.

Project Outcome

The final Power BI analytical layer provides a business-friendly view of the sales data.

Users can analyze:

Total sales
Order volume
Quantity sold
Average order value
Sales trends
Product performance
Category performance
Customer performance
Time-based sales performance
Related Components
LH_Sales_Gold
gold_fact_sales
gold_dim_customer
gold_dim_product
gold_dim_date
SM_Sales_Analytics
Power BI
