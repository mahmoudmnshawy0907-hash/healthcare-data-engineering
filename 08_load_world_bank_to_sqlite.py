import sqlite3
import pandas as pd

# Step 1: Load the cleaned CSV file
input_file = "world_bank_diabetes_countries.csv"
df = pd.read_csv(input_file, encoding="utf-8-sig")

# Step 1.5: Validate data before loading it into SQLite

# Check that the file contains data
if df.empty:
    raise ValueError("The CSV file is empty.")

# Check that all required columns exist
required_columns = [
    "Country",
    "Year",
    "Indicator_Code",
    "Indicator_Name",
    "Value",
    "Source_URL"
]

missing_columns = [
    column for column in required_columns
    if column not in df.columns
]

if missing_columns:
    raise ValueError(f"Missing required columns: {missing_columns}")

# Check for missing values
if df[required_columns].isna().any().any():
    raise ValueError("Data quality check failed: missing values found.")

# Make sure Year and Value are numeric
df["Year"] = pd.to_numeric(df["Year"], errors="raise").astype(int)
df["Value"] = pd.to_numeric(df["Value"], errors="raise")

# Check that the percentage is between 0 and 100
if not df["Value"].between(0, 100).all():
    raise ValueError("Data quality check failed: invalid percentage value.")

# Check for duplicate statistics
duplicate_count = df.duplicated(
    subset=["Country", "Year", "Indicator_Code"]
).sum()

if duplicate_count > 0:
    raise ValueError(
        f"Data quality check failed: {duplicate_count} duplicate records found."
    )

print("CSV data quality checks passed.")

# Step 2: Connect to SQLite database
db_file = "health_data.db"
conn = sqlite3.connect(db_file)

# Step 3: Store the data in a new table
table_name = "health_statistics"
df.to_sql(table_name, conn, if_exists="replace", index=False)

# Step 4: Verify the load
query = f"SELECT * FROM {table_name} LIMIT 5"
loaded_df = pd.read_sql_query(query, conn)

print("\nData loaded successfully into SQLite.")
print(f"Database file: {db_file}")
print(f"Table name: {table_name}")
print("\nPreview of loaded data:")
print(loaded_df)

# Step 5: Close the connection
conn.close()