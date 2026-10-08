# Healthcare Data Engineering Project

A sample healthcare data engineering project built as part of my Data Engineering training.

## Project Overview

This project demonstrates a simple healthcare data pipeline that collects, cleans, validates, and stores public-like sample patient data in a relational SQLite database.

The project focuses on preparing structured and reliable data that can later be used by Data Analysts or AI/ML Engineers.

> **Note:** This project uses sample/public-like data only. It does not contain real patient or confidential healthcare data.

## Data Pipeline

```text
CSV Source
   ↓
Python Data Pipeline
   ↓
Data Validation & Cleaning
   ↓
SQLite Database
   ↓
SQL Queries & Data Quality Tests
```

## Database

The SQLite database contains the following tables:

* `Insurance`
* `Patients`
* `Doctors`
* `Diseases`
* `Patient_Diseases`
* `Appointments`
* `Visit_Log`
* `Medical_Tests`
* `Family_Medical_History`

The database uses primary keys, foreign keys, unique constraints, and indexes to maintain data integrity.

## Data Cleaning

The project includes data cleaning examples such as:

* Normalizing patient names
* Normalizing phone numbers
* Standardizing dates
* Standardizing marital status values
* Cleaning doctor email addresses
* Standardizing disease status values
* Ignoring invalid or incomplete records

## Duplicate Prevention

The Python pipeline checks for duplicate patients using:

```text
Name + Date of Birth + Phone Number
```

The database also contains a unique index on these fields to provide an additional layer of duplicate protection.

This allows the pipeline to be safely re-run without creating duplicate patient records from the sample source data.

## SQL Queries

The project includes SQL queries for:

* Inspecting database tables
* Retrieving patient information
* Joining patients with diseases
* Joining appointments with doctors and patients
* Retrieving medical test results
* Retrieving insurance information
* Retrieving family medical history
* Counting patients by disease
* Counting appointments by status

## Data Quality Testing

The `test_queries.sql` file includes checks for:

* Patient record count
* Duplicate patients
* Missing required patient data
* Invalid insurance references
* Invalid patient-disease references

## Project Structure

```text
Healthcare-Data-Engineering/
│
├── 01_create_tables.sql
├── 02_insert_data.sql
├── 03_queries.sql
├── 04_data_cleaning_examples.sql
├── 05_pipeline_load_public_like_data.py
├── 06_sample_public_like_patients.csv
├── healthcare.db
├── test_queries.sql
├── .gitignore
└── README.md
```

## Technologies

* Python
* SQLite
* SQL
* CSV
* VS Code
* Git/GitHub

## Key Data Engineering Concepts Demonstrated

* Data ingestion
* Data validation
* Data cleaning
* Data normalization
* Relational database design
* Primary and foreign keys
* Data integrity
* Duplicate detection
* SQL joins
* Data quality testing
* Re-runnable data pipelines

## Result

The final sample database contains **5 unique patients**, and the pipeline was tested to ensure that re-running it does not create duplicate patient records.

## Author

Mahmoud — Data Engineering Trainee
