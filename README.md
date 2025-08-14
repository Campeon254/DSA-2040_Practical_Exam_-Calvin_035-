# DSA-2040_Practical_Exam_-Calvin_035-
An project to practice my Data Warehousing and Data Mining Skills.

## Tables of Contents
[1. Data Mining](#1-data-mining)
    [1.1 Data Preprocessing](#11-data-preprocessing)
    [1.2 Data Exploration](#12-data-exploration)






## 1. Data Mining
This section covers data preprocessing, clustering, classification, and association rule mining using the Iris dataset and synthetic transactional data.
### 1.1 Data Preprocessing
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
<table border="1" class="dataframe">
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
      <td>1.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0.166667</td>
      <td>0.416667</td>
      <td>0.067797</td>
      <td>0.041667</td>
      <td>1.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.111111</td>
      <td>0.500000</td>
      <td>0.050847</td>
      <td>0.041667</td>
      <td>1.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>0.083333</td>
      <td>0.458333</td>
      <td>0.084746</td>
      <td>0.041667</td>
      <td>1.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0.194444</td>
      <td>0.666667</td>
      <td>0.067797</td>
      <td>0.041667</td>
      <td>1.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
  </tbody>
</table>
</div>

### 1.2 Data Exploration
The objective was to understand data distribution and spot trends
* Summary Statistics - to understand the statistics of the data.
* Visualization:

    * `pairplot` to visualize the relationships between features 
![Pairplot](images/pair_plot.png)

    * `correlation heatmap` to understand feature correlations.
![Correlation Heatmap](images/correlation_heatmap.png)






### 3.1 Clustering
For The clustering analysis, I used `K-Means` clustering algorithm from the `sklearn` library. The dataset was first standardized using `StandardScaler` to ensure that all features contribute equally to the distance calculations. Then, I applied the K-Means algorithm with a predefined number of clusters and fitted it to the standardized data. The resulting clusters were analyzed to identify distinct 
customer segments based on their purchasing behavior.

    * k=3 was the optimal number of clusters determined by the elbow method.

    * k=4 and k=2 was for comparison

We plotted an `elbow curve` to visualize the optimal number of clusters. The elbow curve showed a clear bend at k=3, confirming it as the optimal choice.

