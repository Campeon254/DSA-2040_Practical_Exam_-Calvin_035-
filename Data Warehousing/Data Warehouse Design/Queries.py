"""
This file contains SQLite queries for the retail data warehouse.
These queries are designed to work with the DWHS.db SQLite database.
"""

import sqlite3
import os

# Path to the database file - now using DWHS.db in the current directory
db_path = "DWHS.db"

def connect_to_db():
    """Connect to the SQLite database"""
    conn = sqlite3.connect(db_path)
    print(f"Connected to database: {db_path}")
    return conn

def execute_query(query, params=None, fetch=True, commit=False):
    """Execute a query and optionally return results"""
    conn = connect_to_db()
    
    try:
        cursor = conn.cursor()
        if params:
            cursor.execute(query, params)
        else:
            cursor.execute(query)
            
        if commit:
            conn.commit()
            
        if fetch and cursor.description:
            results = cursor.fetchall()
            column_names = [description[0] for description in cursor.description]
            return results, column_names
    finally:
        conn.close()
        
    return None, None

def create_database_schema():
    """Create the database tables according to the schema"""
    conn = connect_to_db()
    cursor = conn.cursor()
    
    try:
        # Time Dimension Table
        cursor.execute('''
        CREATE TABLE IF NOT EXISTS Time_TB (
            TimeID INTEGER PRIMARY KEY,
            Date TEXT,
            FullDateDescription TEXT,
            Day INTEGER,
            Month INTEGER,
            Quarter INTEGER,
            Year INTEGER
        )
        ''')
        
        # Product Dimension Table
        cursor.execute('''
        CREATE TABLE IF NOT EXISTS Product_TB (
            ProductID INTEGER PRIMARY KEY,
            ProductName TEXT,
            ProductCategory TEXT,
            ProductSubcategory TEXT,
            Brand TEXT
        )
        ''')
        
        # Customer Dimension Table
        cursor.execute('''
        CREATE TABLE IF NOT EXISTS Customer_TB (
            CustomerID INTEGER PRIMARY KEY,
            CustomerName TEXT,
            City TEXT,
            State TEXT,
            Country TEXT,
            AgeGroup TEXT
        )
        ''')
        
        # Store Dimension Table
        cursor.execute('''
        CREATE TABLE IF NOT EXISTS Store_TB (
            StoreID INTEGER PRIMARY KEY,
            StoreName TEXT,
            StoreCity TEXT,
            StoreRegion TEXT
        )
        ''')
        
        # Fact Sales Table
        cursor.execute('''
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
        )
        ''')
        
        conn.commit()
        print("Database schema created successfully!")
        
    except sqlite3.Error as e:
        print(f"Error creating database schema: {e}")
    finally:
        conn.close()
