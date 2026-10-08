PRAGMA foreign_keys = ON;

UPDATE Patients
SET Marital_Status = 'Single'
WHERE LOWER(TRIM(Marital_Status)) IN ('single', 's');

UPDATE Patients
SET Marital_Status = 'Married'
WHERE LOWER(TRIM(Marital_Status)) IN ('married', 'm');

UPDATE Patient_Diseases
SET Status = 'Active'
WHERE LOWER(TRIM(Status)) IN ('active', 'act');

UPDATE Patient_Diseases
SET Status = 'Controlled'
WHERE LOWER(TRIM(Status)) IN ('controlled', 'control');

UPDATE Doctors
SET Email = LOWER(TRIM(Email));

DELETE FROM Patients
WHERE Name IS NULL
   OR TRIM(Name) = '';

SELECT * FROM Patients;
SELECT Patient_ID, Name, Marital_Status
FROM Patients;
SELECT Doctor_ID, Doctor_Name, Email
FROM Doctors;