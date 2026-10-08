import csv
import sqlite3
from pathlib import Path
from datetime import datetime

BASE_DIR = Path(__file__).resolve().parent
DB_PATH = BASE_DIR / "healthcare.db"
DATA_PATH = BASE_DIR / "06_sample_public_like_patients.csv"


def normalize_name(name):
    return " ".join(part.capitalize() for part in name.strip().split())


def normalize_phone(phone):
    return phone.strip().replace(" ", "").replace("-", "")


def normalize_date(date_text):
    date_text = date_text.strip()
    formats = ["%Y-%m-%d", "%d/%m/%Y", "%m-%d-%Y"]

    for fmt in formats:
        try:
            return datetime.strptime(date_text, fmt).strftime("%Y-%m-%d")
        except ValueError:
            continue

    return None


def normalize_marital_status(status):
    value = status.strip().lower()

    mapping = {
        "single": "Single",
        "s": "Single",
        "married": "Married",
        "m": "Married",
        "divorced": "Divorced"
    }

    return mapping.get(value, "Unknown")


def row_is_valid(row):
    required_fields = ["Patient_ID", "Name", "Date_of_Birth"]

    for field in required_fields:
        if not row.get(field) or not row[field].strip():
            return False

    return True


def load_data():
    conn = sqlite3.connect(DB_PATH)
    conn.execute("PRAGMA foreign_keys = ON;")
    cursor = conn.cursor()

    with open(DATA_PATH, "r", encoding="utf-8") as file:
        reader = csv.DictReader(file, skipinitialspace=True)

        for row in reader:
            if not row_is_valid(row):
                continue

            patient_id = int(row["Patient_ID"])

            name = normalize_name(row["Name"])

            date_of_birth = normalize_date(row["Date_of_Birth"])

            height = (
                float(row["Height"])
                if row["Height"].strip()
                else None
            )

            weight = (
                float(row["Weight"])
                if row["Weight"].strip()
                else None
            )

            phone_number = normalize_phone(row["Phone_Number"])

            address = row["Address"].strip().title()

            marital_status = normalize_marital_status(
                row["Marital_Status"]
            )

            insurance_id = (
                int(row["Insurance_ID"])
                if row["Insurance_ID"].strip()
                else None
            )

            if not date_of_birth:
                continue

            # Check for duplicate patient
            cursor.execute(
                """
                SELECT 1
                FROM Patients
                WHERE Name = ?
                  AND Date_of_Birth = ?
                  AND Phone_Number = ?
                """,
                (
                    name,
                    date_of_birth,
                    phone_number
                )
            )

            if cursor.fetchone():
                continue

            cursor.execute(
                """
                INSERT OR REPLACE INTO Patients
                (
                    Patient_ID,
                    Name,
                    Date_of_Birth,
                    Height,
                    Weight,
                    Phone_Number,
                    Address,
                    Marital_Status,
                    Insurance_ID
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                """,
                (
                    patient_id,
                    name,
                    date_of_birth,
                    height,
                    weight,
                    phone_number,
                    address,
                    marital_status,
                    insurance_id
                )
            )

    conn.commit()
    conn.close()


if __name__ == "__main__":
    load_data()
    print("Pipeline finished successfully.")