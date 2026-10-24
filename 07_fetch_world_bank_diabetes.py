import requests
import pandas as pd

url = "https://api.worldbank.org/v2/country/EGY;SAU;ARE;MAR/indicator/SH.STA.DIAB.ZS?format=json&per_page=500"

# Step 1: Request data from the World Bank
response = requests.get(url, timeout=90)
response.raise_for_status()

# Step 2: Read the JSON response
data = response.json()

# Step 3: Get the actual records
records = data[1]

# Step 4: Prepare the records
clean_records = []

for row in records:
    clean_records.append({
        "Country": row["country"]["value"],
        "Year": row["date"],
        "Indicator_Code": row["indicator"]["id"],
        "Indicator_Name": row["indicator"]["value"],
        "Value": row["value"],
        "Source_URL": url
    })

# Step 5: Convert records into a table
df = pd.DataFrame(clean_records)

# Step 6: Remove rows with missing values
df = df.dropna(subset=["Value"])

# Step 7: Convert the year to an integer
df["Year"] = df["Year"].astype(int)

# Step 8: Sort by year descending
df = df.sort_values(by="Year", ascending=False)

# Step 9: Reset index
df = df.reset_index(drop=True)

# Step 10: Data quality checks
print("\n--- Data Quality Checks ---")
print("Number of records:", len(df))

print("\nMissing values in each column:")
print(df.isna().sum())

duplicate_count = df.duplicated(
    subset=["Country", "Year", "Indicator_Code"]
).sum()

print("\nNumber of duplicate records:", duplicate_count)

if duplicate_count > 0:
    raise ValueError(
        f"Data quality check failed: found {duplicate_count} duplicate records."
    )

print("Duplicate check passed.")
# Check that values are within the valid range

invalid_values = df[
    (df["Value"] < 0) | (df["Value"] > 100)
]

if not invalid_values.empty:
    raise ValueError(
        "Data quality check failed: Value must be between 0 and 100."
    )

print("Value range check passed.")

# Step 11: Save the table to CSV
output_file = "world_bank_diabetes_countries.csv"
df.to_csv(output_file, index=False, encoding="utf-8-sig")

# Step 12: Show final result
print("\nFinal cleaned data:")
print(df[["Country", "Year", "Value"]])

print(f"\nSaved {len(df)} records to {output_file}")