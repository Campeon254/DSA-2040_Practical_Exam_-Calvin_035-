# Import ucimlrepo to get the data
from ucimlrepo import fetch_ucirepo 

# fetch dataset 
online_retail = fetch_ucirepo(id=352) 

# data (as pandas dataframes) 
data = online_retail.data.features 

# save the data as a csv in a data folder
data.to_csv("Data/online_retail_features.csv", index=False)
