import sqlite3
from pathlib import Path

import pandas as pd
import matplotlib.pyplot as plt


# Step 1: Locate the project files
PROJECT_DIR = Path(__file__).resolve().parent

DB_PATH = PROJECT_DIR / "health_data.db"
OUTPUT_FILE = PROJECT_DIR / "diabetes_prevalence_2024.png"


# Step 2: Check that the database file exists
if not DB_PATH.is_file():
    raise FileNotFoundError(
        f"Database file not found: {DB_PATH}\n"
        "Run 11_run_health_pipeline.py first."
    )


# Step 3: Write an SQL query to get 2024 data
query = """
SELECT Country, Year, Value
FROM health_statistics
WHERE Year = 2024
ORDER BY Value DESC;
"""


# Step 4: Connect to SQLite and read the data
conn = sqlite3.connect(DB_PATH)

try:
    df = pd.read_sql_query(query, conn)
finally:
    conn.close()


# Step 5: Check that data was found
if df.empty:
    raise ValueError(
        "No data found for 2024 in the health_statistics table."
    )


# Step 6: Validate the data types and values
df["Year"] = pd.to_numeric(
    df["Year"], errors="raise"
).astype(int)

df["Value"] = pd.to_numeric(
    df["Value"], errors="raise"
)

if df["Value"].isna().any():
    raise ValueError("Missing values found in the Value column.")

if not df["Value"].between(0, 100).all():
    raise ValueError("Invalid percentage value found.")


# Step 7: Create the bar chart
fig, ax = plt.subplots(figsize=(10, 6))

bars = ax.bar(
    df["Country"],
    df["Value"]
)

ax.set_title(
    "Diabetes Prevalence (% of Population Ages 20–79), 2024\n"
    "Source: World Bank | Indicator: SH.STA.DIAB.ZS"
)

ax.set_xlabel("Country")
ax.set_ylabel("Diabetes Prevalence (%)")

ax.set_ylim(0, df["Value"].max() * 1.15)

# Display the value above each bar
ax.bar_label(bars, fmt="%.1f", padding=3)

# Improve the appearance of country names
ax.tick_params(
    axis="x",
    labelrotation=15
)

fig.tight_layout()


# Step 8: Save the chart as an image
fig.savefig(
    OUTPUT_FILE,
    dpi=200,
    bbox_inches="tight"
)


# Step 9: Display the data used in the chart
print("Data used for the chart:")
print(
    df[["Country", "Year", "Value"]].to_string(index=False)
)

print(f"\nChart saved to: {OUTPUT_FILE}")


# Step 10: Display the chart
plt.show()