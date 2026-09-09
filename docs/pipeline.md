# Fabric Sales Analytics Pipeline

## Pipeline Name

`PL_Daily_Sales_Ingestion`

## Purpose

The pipeline ingests sales data from the on-premises SQL Server `SalesDB` into the Microsoft Fabric Bronze Lakehouse.

The pipeline is designed to be:

- Metadata-driven
- Reusable across multiple source tables
- Incremental using `LastModifiedDate`
- Controlled using a watermark table

## Source

**SQL Server**

Database: `SalesDB`

Source tables:

- Customers
- Products
- Orders
- OrderDetails

Connection: `CONN_Local_SalesDB`

Gateway: `GW-Bishal-LocalSQL`

## Target

**Fabric Lakehouse**

`LH_Sales_Bronze`

The Bronze layer stores the ingested source data before downstream cleaning and transformation.

## Pipeline Flow

```text
SQL Server (SalesDB)
        |
        v
Lookup Metadata
        |
        v
ForEach_Ingestion_Table
        |
        v
Lookup_Current_Watermark
        |
        v
Dynamic Incremental Query
        |
        v
Copy_Dynamic_Table_To_Bronze
        |
        v
Update_Watermark


## Metadata-Driven Ingestion

The pipeline uses metadata to determine which source tables should be processed.

The current source tables are:

* Customers
* Products
* Orders
* OrderDetails

The `ForEach_Ingestion_Table` activity processes each table dynamically using:

`item().SourceTable`

This allows the same pipeline and Copy Data activity to process multiple source tables instead of creating a separate pipeline for each table.

### Metadata Flow

```text
Ingestion Metadata
       |
       +--> Customers
       +--> Products
       +--> Orders
       +--> OrderDetails
                    |
                    v
          ForEach_Ingestion_Table
                    |
                    v
          Process Each Table
```

This makes the ingestion process easier to maintain and extend. A new source table can be added through the metadata configuration without creating a completely new ingestion pipeline.

## Watermark-Based Incremental Loading

The pipeline uses the `LastModifiedDate` column to identify new or modified records.

The current watermark for each source table is stored in:

`dbo.Ingestion_Watermark`

The watermark table contains:

| Column         | Description                         |
| -------------- | ----------------------------------- |
| TableName      | Source table name                   |
| WatermarkValue | Latest processed `LastModifiedDate` |

### Initial Load

When a table does not have a stored watermark, the pipeline performs a full load:

```sql
SELECT *
FROM dbo.<SourceTable>
```

After the data is successfully copied, the pipeline updates the watermark using the maximum `LastModifiedDate`.

### Incremental Load

On subsequent executions, the pipeline reads the stored watermark and loads only records newer than that value:

```sql
SELECT *
FROM dbo.<SourceTable>
WHERE LastModifiedDate > '<WatermarkValue>'
```

This prevents the pipeline from repeatedly loading records that have already been processed.

## Lookup Current Watermark

The `Lookup_Current_Watermark` activity retrieves the watermark for the current source table.

The query is dynamically generated using the current table name:

```text
@concat(
  'SELECT WatermarkValue FROM dbo.Ingestion_Watermark WHERE TableName = ''',
  item().SourceTable,
  ''''
)
```

For example, when the current table is `Orders`, the generated query becomes:

```sql
SELECT WatermarkValue
FROM dbo.Ingestion_Watermark
WHERE TableName = 'Orders'
```

The returned watermark is then passed to the Copy Data activity.

## Dynamic Copy Query

The `Copy_Dynamic_Table_To_Bronze` activity determines whether the current table requires a full load or incremental load.

The expression is:

```text
@if(
    equals(
        activity('Lookup_Current_Watermark').output.value[0].WatermarkValue,
        null
    ),
    concat(
        'SELECT * FROM dbo.',
        item().SourceTable
    ),
    concat(
        'SELECT * FROM dbo.',
        item().SourceTable,
        ' WHERE LastModifiedDate > ''',
        string(activity('Lookup_Current_Watermark').output.value[0].WatermarkValue),
        ''''
    )
)
```

The logic is:

```text
Watermark exists?
       |
   +---+---+
   |       |
  No      Yes
   |       |
   v       v
Full    Incremental
Load      Load
   |       |
   +---+---+
       |
       v
Copy to Bronze
```

## Copy Data to Bronze

Activity:

`Copy_Dynamic_Table_To_Bronze`

The activity copies the selected records from SQL Server into:

`LH_Sales_Bronze`

The source table and SQL query are dynamically determined using the metadata and watermark values.

The Bronze layer is intentionally kept close to the source data. Data cleansing, deduplication, and business transformations are handled in the downstream Silver and Gold layers.

## Update Watermark

After the Copy Data activity completes successfully, the `Update_Watermark` activity updates the watermark for the current table.

Expression:

```text
@concat(
    'UPDATE dbo.Ingestion_Watermark ',
    'SET WatermarkValue = (SELECT MAX(LastModifiedDate) FROM dbo.',
    item().SourceTable,
    ') ',
    'WHERE TableName = ''',
    item().SourceTable,
    ''''
)
```

For example, after processing the `Orders` table, the pipeline updates the `Orders` watermark to the latest `LastModifiedDate` currently present in the source table.

This allows the next pipeline execution to continue from the latest processed timestamp.

## Current Watermark Values

After the initial load, the watermark values were:

| Table        | Watermark  |
| ------------ | ---------- |
| Customers    | 2026-08-10 |
| Products     | 2026-08-06 |
| Orders       | 2026-08-15 |
| OrderDetails | 2026-08-15 |

## Incremental Load Behavior

The complete process can be summarized as:

```text
                 First Run
                    |
                    v
             No Watermark
                    |
                    v
               Full Load
                    |
                    v
          Store MAX(LastModifiedDate)
                    |
                    v
             Subsequent Run
                    |
                    v
             Read Watermark
                    |
                    v
       Load New/Modified Records
                    |
                    v
             Update Watermark
```

## Validation

After the initial ingestion, the pipeline was executed again without making any new changes to the source data.

The pipeline completed successfully.

The Copy Data activities returned:

* `rowsRead: 0`
* `dataRead: 0`
* `dataWritten: 0`
* `errors: []`

This confirmed that the watermark-based incremental filter prevented already-processed records from being copied again.

## Fabric Components

### Gateway

`GW-Bishal-LocalSQL`

Provides connectivity between the on-premises SQL Server environment and Microsoft Fabric.

### Connection

`CONN_Local_SalesDB`

Connects Fabric to:

`localhost\SQLEXPRESS`

Database:

`SalesDB`

### Bronze Lakehouse

`LH_Sales_Bronze`

Stores the raw ingested source data.

### Silver Lakehouse

`LH_Sales_Silver`

Contains cleaned and deduplicated data prepared for further modeling.

### Gold Lakehouse

`LH_Sales_Gold`

Contains business-ready analytical tables.

### Semantic Model

`SM_Sales_Analytics`

Provides the analytical model consumed by Power BI.

## Related Project Components

* SQL Server
* SalesDB
* Ingestion_Watermark
* Fabric Data Factory
* LH_Sales_Bronze
* LH_Sales_Silver
* LH_Sales_Gold
* SM_Sales_Analytics
* Power BI
