Power BI Sales Analytics Report

Overview

This Power BI report presents sales performance from the Gold-layer data model created in Microsoft Fabric. It is designed to provide a clear view of overall sales, order activity, product performance, category performance, customer segments, and sales trends over time.

The report contains two pages:

Sales Analytics

Sales Analysis

Page 1 — Sales Analytics

This page provides a high-level operational view of sales performance.

KPI Cards

The top of the page contains four KPI cards:

Total Sales

Total Orders

Total Quantity

Average Order Value

In the current report view, the KPIs show:

Total Sales: 26.61K

Total Orders: 16

Total Quantity: 104

Average Order Value: 1.66K

Visuals

Total Sales by Date

A line chart shows sales performance over time from January 2026 through August 2026.

This visual helps identify changes in sales activity and periods of stronger or weaker performance.

Total Sales by Category

A column chart compares total sales across product categories.

The report currently includes:

Electronics

Furniture

Electronics contributes the larger share of total sales.

Total Sales by Segment

A column chart compares sales across customer segments.

The report includes:

Enterprise

Corporate

SMB

Enterprise is currently the highest-performing segment.

Filters and Slicers

The page includes interactive filters for:

Date

Category

Segment

These allow users to filter the report and analyze specific periods, product groups, or customer segments.

Page 2 — Sales Analysis

This page focuses more closely on product performance, category performance, and monthly sales trends.

Total Sales by Product Name

A horizontal bar chart compares sales by individual product.

Products visible in the report include:

Laptop Business 15

Laptop Pro 14

Office Chair

27 Inch Monitor

Office Desk

Printer LaserJet

Standing Desk

Headset Pro

Mechanical Keyboard

USB-C Hub

Wireless Mouse

Webcam HD

The strongest-performing products are Laptop Business 15 and Laptop Pro 14.

Total Sales by Month Name

A line chart displays sales by month.

This visual provides another view of sales movement across the reporting period.

Gross Sales and Total Sales by Category

A clustered column chart compares:

Gross Sales

Total Sales

across product categories.

The report currently compares Electronics and Furniture.

Top Products by Total Sales

A second horizontal bar chart highlights the leading products by total sales.

The visible top products are:

Laptop Business 15

Laptop Pro 14

Office Chair

27 Inch Monitor

Office Desk

Data Model

The report is built on the Gold layer created in Microsoft Fabric.

The Gold model includes:

gold_fact_sales

gold_dim_customer

gold_dim_product

gold_dim_date

The fact table contains transactional sales data, while the dimension tables provide customer, product, and date attributes for analysis.

Key Sales Fields

The Gold fact table contains fields used by the report such as:

Order ID

Customer ID

Product ID

Order Date

Quantity

Unit Price

Discount

Gross Sales

Net Sales

Order Status

Order Date Key

Report Metrics

The Power BI report uses business metrics including:

Total Sales

Gross Sales

Total Orders

Total Quantity

Average Order Value

The exact DAX definitions can be documented separately in the semantic model documentation.

Screenshots

Page 1 — Sales Analytics



Page 2 — Sales Analysis



Project Architecture

The Power BI report is the final visualization layer of the project:

Source Data
    |
    v
Bronze Layer
    |
    v
Silver Layer
    |
    v
Gold Layer
    |
    v
Power BI Semantic Model
    |
    v
Power BI Sales Analytics Report

This structure follows the Medallion Architecture approach implemented in Microsoft Fabric.