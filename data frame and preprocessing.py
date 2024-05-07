import pandas as pd
# Read data from CSV file into a data frame
csv_file_path = 'prac.csv'
df_csv = pd.read_csv(csv_file_path)
# Read data from JSON file into a data frame
json_file_path = 'ds.json'
df_json = pd.read_json(json_file_path)
# Display the first few rows of each data frame to inspect the data
print("CSV Data:")
print(df_csv.head())
print("\nJSON Data:")
print(df_json.head())
# Handling missing values
# Drop rows with missing values
df_csv_cleaned = df_csv.dropna()
# Fill missing values with a specific value (e.g., 0)
df_json_filled = df_json.fillna(0)
# Handling outliers
# Assume 'Sales' is the column with outliers
# Replace outliers with the median
median_value = df_csv['Sales'].median()
upper_threshold = df_csv['Sales'].mean() + 2 * df_csv['Sales'].std()
lower_threshold = df_csv['Sales'].mean() - 2 * df_csv['Sales'].std()
df_csv['Sales'] = df_csv['Sales'].apply(lambda x: median_value if x > upper_threshold or x <
lower_threshold else x)
# Manipulate and transform data
# Filtering
filtered_data = df_csv[df_csv['Sales'] > 10]
# Sorting
sorted_data = df_csv.sort_values(by='Sales', ascending=False)
# Grouping and calculating mean for numeric columns
numeric_columns = ['Sales', 'Cost', 'Profit']
grouped_data = df_csv.groupby('Category')[numeric_columns].mean()
# Display the results
print("\nCleaned CSV Data:")
print(df_csv_cleaned.head())
print("\nFilled JSON Data:")
print(df_json_filled.head())
print("\nFiltered Data:")
print(filtered_data.head())
print("\nSorted Data:")
print(sorted_data.head())
print("\nGrouped Data:")
print(grouped_data.head())