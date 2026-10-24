import subprocess
import sys
from pathlib import Path

# Locate the project folder
PROJECT_DIR = Path(__file__).resolve().parent

# Step 1: Fetch, clean, and validate the data
print("\nStep 1: Fetching World Bank data...", flush=True)

subprocess.run(
    [sys.executable, str(PROJECT_DIR / "07_fetch_world_bank_diabetes.py")],
    cwd=PROJECT_DIR,
    check=True
)

# Step 2: Validate the CSV and load data into SQLite
print("\nStep 2: Loading data into SQLite...", flush=True)

subprocess.run(
    [sys.executable, str(PROJECT_DIR / "08_load_world_bank_to_sqlite.py")],
    cwd=PROJECT_DIR,
    check=True
)
# Step 3: Generate the visualization
print("\nStep 3: Generating diabetes chart...", flush=True)

subprocess.run(
    [
        sys.executable,
        str(PROJECT_DIR / "12_visualize_diabetes_2024.py")
    ],
    cwd=PROJECT_DIR,
    check=True
)
# Final result
print("\nPipeline completed successfully!")