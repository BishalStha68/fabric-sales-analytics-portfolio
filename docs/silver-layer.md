# Fabric Sales Analytics — Silver Layer

## Purpose

The Silver layer contains cleaned, standardized, and deduplicated data prepared for downstream analytics.

In this project, the Silver layer transforms the raw data ingested into `LH_Sales_Bronze` into structured tables in:

`LH_Sales_Silver`

The main objectives are:

- Remove duplicate records
- Standardize data types
- Handle null or invalid values
- Preserve the latest version of records
- Prepare clean datasets for the Gold layer

## Source

The Silver layer reads data from:

`LH_Sales_Bronze`

Source tables:

- Customers
- Products
- Orders
- OrderDetails

## Target

`LH_Sales_Silver`

Silver tables:

- `silver_customers`
- `silver_products`
- `silver_orders`
- `silver_orderdetails`

## Transformation Flow

```text
LH_Sales_Bronze
        |
        +--> Customers
        |
        +--> Products
        |
        +--> Orders
        |
        +--> OrderDetails
                |
                v
       Cleaning & Deduplication
                |
                v
        LH_Sales_Silver
                |
                +--> silver_customers
                +--> silver_products
                +--> silver_orders
                +--> silver_orderdetails
Customer Transformation

Source:

Customers

Target:

silver_customers

The customer transformation prepares customer records for analytical use.

The transformation includes:

Removing duplicate customer records
Keeping the latest record based on LastModifiedDate
Standardizing customer attributes
Preserving the source CustomerID
Removing unnecessary duplicate versions
Deduplication Logic

When multiple records exist for the same customer, the latest record is retained using LastModifiedDate.

Conceptually:

Customer Records
      |
      v
Partition by CustomerID
      |
      v
Order by LastModifiedDate DESC
      |
      v
Keep Row Number = 1

This ensures that the Silver layer contains the latest known customer record.

Product Transformation

Source:

Products

Target:

silver_products

The product transformation prepares product information for downstream sales analysis.

Transformations include:

Removing duplicate products
Keeping the latest product version
Standardizing product attributes
Preserving the source ProductID
Validating product-related values
Order Transformation

Source:

Orders

Target:

silver_orders

The order transformation prepares order header information.

Transformations include:

Removing duplicate orders
Keeping the latest version of each order
Standardizing date and numeric fields
Preserving OrderID
Preserving customer relationships
Validating order-level values
Order Detail Transformation

Source:

OrderDetails

Target:

silver_orderdetails

The order detail transformation prepares individual sales line items.

Transformations include:

Removing duplicate order detail records
Validating product relationships
Standardizing quantities
Standardizing unit prices
Preserving order and product identifiers
Preparing the data for sales calculations
Data Quality

The Silver layer acts as the primary data-quality boundary between raw ingestion and business-ready analytics.

The following checks are considered:

CheckPurpose
Duplicate recordsPrevent duplicate analytical records
Null identifiersEnsure required keys are populated
Invalid quantitiesPrevent invalid sales calculations
Invalid pricesPrevent incorrect revenue calculations
Date validationEnsure valid transaction dates
Referential integrityValidate customer and product relationships
Bronze vs Silver
LayerPurpose
BronzeRaw source data as ingested
SilverCleaned, standardized, and deduplicated data
GoldBusiness-ready analytical model

The Bronze layer is intentionally kept close to the source system, while the Silver layer applies technical data-quality transformations.

Why Deduplication Is Performed in Silver

The Bronze layer may contain multiple versions of the same record because it represents the ingestion history from the source system.

Instead of modifying or deleting raw Bronze data, the Silver layer determines the latest valid record.

This provides a clear separation between:

Raw Data
   |
   v
Bronze
   |
   v
Data Quality
   |
   v
Silver
   |
   v
Business Logic
   |
   v
Gold
Silver Layer Outcome

After transformation, the Silver layer provides clean datasets that can be consumed by the Gold layer.

The Gold layer then applies business modeling and analytical logic to create:

Fact tables
Dimension tables
Business metrics
Analytical relationships
Related Components
LH_Sales_Bronze
LH_Sales_Silver
silver_customers
silver_products
silver_orders
silver_orderdetails
LH_Sales_Gold
