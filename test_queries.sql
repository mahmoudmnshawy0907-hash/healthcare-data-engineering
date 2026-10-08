PRAGMA foreign_keys = ON;

-- 1. Check number of patients
SELECT COUNT(*) AS Patient_Count
FROM Patients;

-- 2. Check for duplicate patients
SELECT Name, Date_of_Birth, Phone_Number, COUNT(*) AS Duplicate_Count
FROM Patients
GROUP BY Name, Date_of_Birth, Phone_Number
HAVING COUNT(*) > 1;

-- 3. Check for missing required patient data
SELECT COUNT(*) AS Missing_Required_Data
FROM Patients
WHERE Name IS NULL
   OR TRIM(Name) = ''
   OR Date_of_Birth IS NULL
   OR TRIM(Date_of_Birth) = '';

-- 4. Check invalid insurance references
SELECT p.Patient_ID, p.Insurance_ID
FROM Patients p
LEFT JOIN Insurance i
    ON p.Insurance_ID = i.Insurance_ID
WHERE p.Insurance_ID IS NOT NULL
  AND i.Insurance_ID IS NULL;

-- 5. Check invalid patient-disease references
SELECT pd.Patient_ID, pd.Disease_ID
FROM Patient_Diseases pd
LEFT JOIN Patients p
    ON pd.Patient_ID = p.Patient_ID
LEFT JOIN Diseases d
    ON pd.Disease_ID = d.Disease_ID
WHERE p.Patient_ID IS NULL
   OR d.Disease_ID IS NULL;

-- 6. Display all patients
SELECT *
FROM Patients;