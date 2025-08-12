# DSA-2040_Practical_Exam_-Calvin_035-
An project to practice my Data Warehousing and Data Mining Skills.

## Objectives

1. To create a data warehouse for storing and managing the extracted data.
2. To implement the ETL (Extract, Transform, Load) process for data integration.

## Table of Contents

1. [Data Warehouse Design](#data-warehouse-design)
   - 1.1 [Overview](#overview)
   - 1.2 [Design](#design)
   - 1.3 [Implementation](#implementation)
2. [ETL Process](#etl-process)
   - 2.1 [Extract](#extract)
   - 2.2 [Transform](#transform)
   - 2.3 [Load](#load)

## Data Warehouse Design
### Overview
The data warehouse is designed to facilitate the analysis and reporting of sales data across different dimensions such as time, geography, and product categories. I used a star schema because of its `simplicity and ease of use.` The star schema has a `straightforward design`, which makes it easier for users to understand and query the data. In a star schema, the fact table is at the center, surrounded by dimension tables that are directly connected to it. This design allows for `quick access to data and efficient querying`.

The following is a visual representation of the star schema:

![Star Schema Design](/Data%20Warehousing/Data%20Warehouse%20Design/Schema%20Design.jpg)

### Design
The data warehouse consists of the following key components:
- Fact Table: SalesFact
  - Measures: TotalPrice, QuantitySold
  - Foreign Keys: CustomerID, ProductID, TimeID
- Dimension Tables:
  - Customer_TB: CustomerID, Name, Email, Country
  - Product_TB: ProductID, Name, Category, Price
  - Time_TB: TimeID, Date, Month, Quarter, Year

### Implementation
The data warehouse is implemented using SQLite for simplicity. The schema is created using SQL commands, and sample data is loaded into the warehouse for testing and validation.
