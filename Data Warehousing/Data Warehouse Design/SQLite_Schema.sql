-- SQLite schema for retail data warehouse

-- Time Dimension Table
CREATE TABLE IF NOT EXISTS Time_TB (
    TimeID INTEGER PRIMARY KEY,
    Date TEXT,
    FullDateDescription TEXT,
    Day INTEGER,
    Month INTEGER,
    Quarter INTEGER,
    Year INTEGER
);

-- Product Dimension Table
CREATE TABLE IF NOT EXISTS Product_TB (
    ProductID INTEGER PRIMARY KEY,
    ProductName TEXT,
    ProductCategory TEXT,
    ProductSubcategory TEXT,
    Brand TEXT
);

-- Customer Dimension Table
CREATE TABLE IF NOT EXISTS Customer_TB (
    CustomerID INTEGER PRIMARY KEY,
    CustomerName TEXT,
    City TEXT,
    State TEXT,
    Country TEXT,
    AgeGroup TEXT
);

-- Store Dimension Table
CREATE TABLE IF NOT EXISTS Store_TB (
    StoreID INTEGER PRIMARY KEY,
    StoreName TEXT,
    StoreCity TEXT,
    StoreRegion TEXT
);

-- Fact Sales Table
CREATE TABLE IF NOT EXISTS FactSales_TB (
    SaleID INTEGER PRIMARY KEY AUTOINCREMENT,
    TimeID INTEGER,
    ProductID INTEGER,
    CustomerID INTEGER,
    StoreID INTEGER,
    SalesAmount REAL,
    QuantitySold INTEGER,
    DiscountAmount REAL,
    FOREIGN KEY (TimeID) REFERENCES Time_TB (TimeID),
    FOREIGN KEY (ProductID) REFERENCES Product_TB (ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customer_TB (CustomerID),
    FOREIGN KEY (StoreID) REFERENCES Store_TB (StoreID)
);
