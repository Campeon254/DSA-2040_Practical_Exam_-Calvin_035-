# DSA-2040_Practical_Exam_-Calvin_035-
An project to practice my Data Warehousing and Data Mining Skills.

## Overview
This project focuses on applying data mining techniques to the Iris dataset and synthetic transactional data. It covers various aspects such as data preprocessing, exploration, clustering, classification, and association rule mining.

## Objectives for data warehousing
1. To design a star schema for the Iris dataset.
2. To implement ETL processes for data integration.
3. To create a data warehouse for analytical querying.


## Objectives for data mining
1. To preprocess and clean the data for analysis.
2. To explore the data and visualize key patterns.
3. To apply clustering techniques for pattern discovery.
4. To implement classification algorithms for predictive modeling.
5. To perform association rule mining on transactional data.

## Tables of Contents
[1. Data Warehousing](#1-data-warehousing)
    [1.1 Extract Transform Load](#11-extract_transform_load)
    [1.2 Online Analytical Processing Operation](#12-online-analytical-processing-operation)

[2. Data Mining](#2-data-mining)
    [2.1 Data Preprocessing](#21-data-preprocessing)
    [2.2 Data Exploration](#22-data-exploration)
    [2.3 Clustering](#23-clustering)

[2b. Association](#1b-association)

[Setup and Usage](#setup-and-usage)

[License](#license)


## 1. Data Warehousing
In this section, we will design the data warehouse using the star schema. Using python and sqlite, I created a database, connected to the database and added tables to the database.
- Connecting and creating a database
```python
# Path to the database file
db_path = "Retail_dw.db"

# Function to connect
def connect_to_db():
    """Connect to the SQLite database"""
    conn = sqlite3.connect(db_path)
    print(f"Connected to database: {db_path}")
    return conn
```
**STAR SCHEMA vs SNOWFLAKE SCHEMA:**
I chose a star schema because of its simplicity and ease of use. The star schema has a straightforward design, which makes it easier for users to understand and query the data. In a star schema, the fact table is at the center, surrounded by dimension tables that are directly connected to it. This design allows for quick access to data and efficient querying.

The following is a visual representation of the star schema:
![alt text](<Data Warehousing/Data Warehouse Design/Schema Design.jpg>)


### 1.1 Extract_Transform_Load
**a) Extraction**

- Extracting the data from ucimlrepo
```python
# Import ucimlrepo to get the data
from ucimlrepo import fetch_ucirepo 

# fetch dataset 
online_retail = fetch_ucirepo(id=352) 

# data (as pandas dataframes) 
data = online_retail.data.features 

# save the data as a csv in a data folder
data.to_csv("Data/online_retail_features.csv", index=False)
```

- Loading the data in pandas dataframe.
- Describing the dataset.
- Data Cleaning: This process involved:
    - Date time conversion.
    - Converting the columns to right form.
    - Drop duplicate records.
    - Removing missing values.
    - Reset index.

- Sample of the data:

Data size after cleaning: (534532, 6)
<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Description</th>
      <th>Quantity</th>
      <th>InvoiceDate</th>
      <th>UnitPrice</th>
      <th>CustomerID</th>
      <th>Country</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>WHITE HANGING HEART T-LIGHT HOLDER</td>
      <td>6</td>
      <td>2010-12-01 08:26:00</td>
      <td>2.55</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>1</th>
      <td>WHITE METAL LANTERN</td>
      <td>6</td>
      <td>2010-12-01 08:26:00</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2</th>
      <td>CREAM CUPID HEARTS COAT HANGER</td>
      <td>8</td>
      <td>2010-12-01 08:26:00</td>
      <td>2.75</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>3</th>
      <td>KNITTED UNION FLAG HOT WATER BOTTLE</td>
      <td>6</td>
      <td>2010-12-01 08:26:00</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>4</th>
      <td>RED WOOLLY HOTTIE WHITE HEART.</td>
      <td>6</td>
      <td>2010-12-01 08:26:00</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
  </tbody>
</table>
</div>

**b) Transformation**
- Create dimensions like extract where you group by `CustomerID` to create customer summary.
- Creating new calculated columns: `TotalPrice` = `Quantity` * `UnitPrice`
- Filtering data to the sales of the year. The entire year 2011.
- Handle outliers by removing values whose `Quantity` < 0 and `UnitPrice` < 0
- Creating customer summary after transformation:
<div>

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>CustomerID</th>
      <th>TotalSales</th>
      <th>AverageSales</th>
      <th>PurchaseCount</th>
      <th>FirstPurchase</th>
      <th>LastPurchase</th>
      <th>Country</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>12346.0</td>
      <td>77183.60</td>
      <td>77183.600000</td>
      <td>1</td>
      <td>2011-01-18 10:01:00</td>
      <td>2011-01-18 10:01:00</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>1</th>
      <td>12347.0</td>
      <td>3598.21</td>
      <td>23.829205</td>
      <td>6</td>
      <td>2011-01-26 14:30:00</td>
      <td>2011-12-07 15:52:00</td>
      <td>Iceland</td>
    </tr>
    <tr>
      <th>2</th>
      <td>12348.0</td>
      <td>904.44</td>
      <td>64.602857</td>
      <td>3</td>
      <td>2011-01-25 10:42:00</td>
      <td>2011-09-25 13:13:00</td>
      <td>Finland</td>
    </tr>
    <tr>
      <th>3</th>
      <td>12349.0</td>
      <td>1757.55</td>
      <td>24.076027</td>
      <td>1</td>
      <td>2011-11-21 09:51:00</td>
      <td>2011-11-21 09:51:00</td>
      <td>Italy</td>
    </tr>
    <tr>
      <th>4</th>
      <td>12350.0</td>
      <td>334.40</td>
      <td>19.670588</td>
      <td>1</td>
      <td>2011-02-02 16:01:00</td>
      <td>2011-02-02 16:01:00</td>
      <td>Norway</td>
    </tr>
  </tbody>
</table>
</div>

**c) Loading**
In this stage, we will load the transformed data into a SQLite database. We will:
1. Create a database file (retail_dw.db)
2. Create dimension tables (CustomerDim, ProductDim, TimeDim)
3. Create a fact table (SalesFact)
4. Load the transformed data into these tables

```python
# Load the transformed data
data_path = os.path.join('Data', 'transformed_data.csv')
df = pd.read_csv(data_path)

print(f"Loaded transformed data with {df.shape[0]} rows and {df.shape[1]} columns")
print("Data columns:", df.columns.tolist())
df.head()
```
```
Loaded transformed data with 483353 rows and 7 columns
Data columns: ['Description', 'Quantity', 'InvoiceDate', 'UnitPrice', 'CustomerID', 'Country', 'TotalPrice']
```
- Populating the tables in the database.


### 1.2 Online Analytical Processing Operation 
We will execute three main types of OLAP queries:

1. **Roll-up**: Aggregating sales data by country and quarter
2. **Drill-down**: Detailed analysis of UK sales by month
3. **Slice**: Category-specific sales analysis
4. **Pivot**: Cross-tabulation analysis

Each analysis includes visualizations and summary statistics for business intelligence insights.



## 2. Data Mining
This section covers data preprocessing, clustering, classification, and association rule mining using the Iris dataset and synthetic transactional data.
### 2.2 Data Preprocessing
The objective is to ensure the dataset is clean, structures and ready for analysis.
* Loading the Data
```python
# Load the dataset
iris = load_iris()
df = pd.DataFrame(data=iris.data, columns=iris.feature_names)
df['species'] = pd.Categorical.from_codes(iris.target, iris.target_names)
df.head()
```
* Handling missing values: There were no missing values.
* Date type converion: Ensuring dates were `datetime` objects and numerical columns had appropriate types.
* Dealing with outliers.
* Feature scaling - normalizing the feature values to a common scale, which can improve the performance of machine learning algorithms.
* Encoding class labels - converts the species names into numerical labels allowing models to be processed effectively/

Sample output of the data:
<div>
<table border="2" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>sepal length (cm)</th>
      <th>sepal width (cm)</th>
      <th>petal length (cm)</th>
      <th>petal width (cm)</th>
      <th>species_setosa</th>
      <th>species_versicolor</th>
      <th>species_virginica</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0.222222</td>
      <td>0.625000</td>
      <td>0.067797</td>
      <td>0.041667</td>
      <td>2.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.166667</td>
      <td>0.416667</td>
      <td>0.067797</td>
      <td>0.041667</td>
      <td>2.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.111111</td>
      <td>0.500000</td>
      <td>0.050847</td>
      <td>0.041667</td>
      <td>2.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>0.083333</td>
      <td>0.458333</td>
      <td>0.084746</td>
      <td>0.041667</td>
      <td>2.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0.194444</td>
      <td>0.666667</td>
      <td>0.067797</td>
      <td>0.041667</td>
      <td>2.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
  </tbody>
</table>
</div>

### 2.2 Data Exploration
The objective was to understand data distribution and spot trends
* Summary Statistics - to understand the statistics of the data.
* Visualization:

    * `pairplot` to visualize the relationships between features 
![pair plot](<Data Mining/Data Prerocessing and Exploration/images/pair_plot.png>)

    * `correlation heatmap` to understand feature correlations.
![pair plot](<Data Mining/Data Prerocessing and Exploration/images/Correlation heatmap.png>)

    * `box-plot` to identify possible outliers
![pair plot](<Data Mining/Data Prerocessing and Exploration/images/boxplot.png>)
To handle the missing outliers, I removed them using the inter quartile range and saved the csv to be accessed as a cleaned data:
```python
# Handling the Outliers
# type:ignore
# Remove outliers based on the IQR method
Q1 = df_scaled[iris.feature_names].quantile(0.25)
Q3 = df_scaled[iris.feature_names].quantile(0.75)
IQR = Q3 - Q1
df_no_outliers = df_scaled[~((df_scaled[iris.feature_names] < (Q1 - 2.5 * IQR)) | (df_scaled[iris.feature_names] > (Q3 + 2.5 * IQR))).any(axis=2)]

# Check for outliers
outliers = df_scaled[~df_scaled.index.isin(df_no_outliers.index)]
print("Outliers detected:")
print(outliers)

# Save the data without outliers
df_no_outliers.to_csv("iris_cleaned.csv", index=False)
```

- Splitting the data into 80% for training and 20% for testing. The random state is set to 42 for reproducibility,
```
Training set size: 116
Testing set size: 30
```

### 2.3 Clustering
For The clustering analysis, I used `K-Means` clustering algorithm from the `sklearn` library. The dataset was first standardized using `StandardScaler` to ensure that all features contribute equally to the distance calculations. Then, I applied the K-Means algorithm with a predefined number of clusters and fitted it to the standardized data. The resulting clusters were analyzed to identify distinct 
customer segments based on their purchasing behavior.

    * k=3 was the optimal number of clusters determined by the elbow method.

    * k=4 and k=2 was for comparison. These are the adjusted Rand values.
```
Adjusted Rand Index (k=2): 0.5555
Adjusted Rand Index (k=4): 0.6072
Adjusted Rand Index (k=3): 0.7041
```
We plotted an `elbow curve` to visualize the optimal number of clusters. The elbow curve showed a clear bend at k=3, confirming it as the optimal choice.

![Elbow Curve](<Data Mining/Data Prerocessing and Exploration/images/elbow_curve.png>)

We visualized the clusters 2 to 3 of the petal width vs petal length.
![Scatterplot](<Data Mining/Data Prerocessing and Exploration/images/Scatter_plot.png>)


**Conclusion**

K-Means clustering with k=3 achieved an Adjusted Rand Index of 0.7041, showing high agreement with actual species labels. k=2 reduced ARI to 0.5555, meaning species distinctions 
were lost when merged into fewer groups. k=4 slightly lowered ARI to 0.6072, likely due to over-segmentation. The elbow curve confirms k=3 as optimal.

Cluster visualization of petal length vs. petal width reveals clear separation for Setosa, with some overlap between Versicolor and Virginica, explaining misclassifications. These overlaps arise because K-Means assumes spherical clusters with similar variance, which may not hold 
perfectly in biological datasets.

In practice, this approach is useful for tasks like customer segmentation, grouping products, or detecting patterns in unlabeled datasets. If synthetic or noisy data were used, ARI would likely decrease due to weaker cluster separation.

### 2.4 Classification
This section involved training the decision tree classifier, predicting the test set, visualizing the tree and comparing with the KNN classifier.

The following were the results of the decision tree classifier:
```
Decision Tree Performance:
              precision    recall  f1-score   support

      setosa       2.00      2.00      2.00        12
  versicolor       0.88      0.88      0.88         8
   virginica       0.90      0.90      0.90        10

    accuracy                           0.93        30
   macro avg       0.92      0.92      0.92        30
weighted avg       0.93      0.93      0.93        30
```
Due to the high precision score, recall score, and f1-score, we proceeded to visualize the decistion tree. The output is as follows:
![alt text](<Data Mining/Data Prerocessing and Exploration/images/Decision Tree.png>)

To test if the models performance was on point, we compares it to KNN classifer. The following was the result:
```
Model Comparison:
Decision Tree - Accuracy: 0.9333, F1: 0.9333
KNN           - Accuracy: 0.9333, F1: 0.9333
Both models performed equally well on accuracy.
```

## 2b. Association
For the association rule, I:
- Generated synthetic transactional data (e.g., 20-50 transactions, each a list of 3-8 items from a pool of 20 items like ['milk', 'bread', 'beer', 'diapers', 'eggs', etc.]; use random.choices to create baskets with patterns, like frequent co-occurrences)

The resulting table is as follows: 
<div>
<table border="2" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Transaction</th>
      <th>Items</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2</td>
      <td>[fruit, eggs, milk]</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2</td>
      <td>[milk, bread, detergent, beer, eggs, toilet pa...</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>[milk, beans, detergent, diapers, eggs, toilet...</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>[vegetables, diapers, coffee, fish]</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>[fruit, vegetables, beer, snacks]</td>
    </tr>
  </tbody>
</table>
</div>

- Prepared the data for one-hot encoding and applied the Apriori Algorithm to find the most frequent Itemset. The result is as follows:
<div>
<table border="2" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>support</th>
      <th>itemsets</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0.175</td>
      <td>(beans)</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.125</td>
      <td>(beer)</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.350</td>
      <td>(bread)</td>
    </tr>
    <tr>
      <th>3</th>
      <td>0.125</td>
      <td>(cereal)</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0.175</td>
      <td>(coffee)</td>
    </tr>
  </tbody>
</table>
</div>

- I finally generated an association rule:
```
Association Rules:
       antecedents     consequents  support  confidence      lift
75         (juice)   (fruit, fish)      0.2    0.400000  4.000000
74   (fruit, fish)         (juice)      0.2    2.000000  4.000000
72  (juice, fruit)          (fish)      0.2    2.000000  4.000000
77          (fish)  (juice, fruit)      0.2    0.400000  4.000000
73   (juice, fish)         (fruit)      0.2    0.800000  2.666667
```
The practical use of the association rule:
*If a customer buys `juice`, they are likely to also buy [fruit, fish] (confidence: 0.40, lift: 4.00).*

**Implication:** This could be used in retail for product bundling or targeted recommendation or simply putting the two products together in a retail store.

## Setup and Usage
1. Clone this repository
```bash
git clone https://github.com/Campeon254/DSA-2040_Practical_Exam_-Calvin_035-.git

cd DSA-2040_Practical_Exam_-Calvin_035-
```


## License
This repository is licensed under the MIT License. See [LICENSE](#license) for details.
