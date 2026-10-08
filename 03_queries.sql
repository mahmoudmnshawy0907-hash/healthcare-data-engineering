PRAGMA foreign_keys = ON;

PRAGMA table_info(Patients);

SELECT name
FROM sqlite_master
WHERE type = 'table'
ORDER BY name;

SELECT *
FROM Patients;

SELECT Patient_ID, Name, Date_of_Birth, Phone_Number
FROM Patients;

SELECT Doctor_Name, Specialty
FROM Doctors;

SELECT
    p.Name AS Patient_Name,
    d.Disease_Name,
    pd.Status
FROM Patient_Diseases pd
JOIN Patients p
    ON pd.Patient_ID = p.Patient_ID
JOIN Diseases d
    ON pd.Disease_ID = d.Disease_ID
ORDER BY p.Name;

SELECT
    a.Appointment_ID,
    p.Name AS Patient_Name,
    doc.Doctor_Name,
    a.Appointment_Date,
    a.Appointment_Time,
    a.Status
FROM Appointments a
JOIN Patients p
    ON a.Patient_ID = p.Patient_ID
JOIN Doctors doc
    ON a.Doctor_ID = doc.Doctor_ID
ORDER BY a.Appointment_Date, a.Appointment_Time;

SELECT
    mt.Test_Name,
    p.Name AS Patient_Name,
    mt.Result,
    mt.Test_Date
FROM Medical_Tests mt
JOIN Patients p
    ON mt.Patient_ID = p.Patient_ID
ORDER BY mt.Test_Date DESC;

SELECT
    p.Name,
    i.Provider_Name,
    i.Plan_Name
FROM Patients p
LEFT JOIN Insurance i
    ON p.Insurance_ID = i.Insurance_ID
ORDER BY p.Name;

SELECT
    p.Name,
    fh.Relative_Type,
    fh.Disease_Name
FROM Family_Medical_History fh
JOIN Patients p
    ON fh.Patient_ID = p.Patient_ID
ORDER BY p.Name;

SELECT
    d.Disease_Name,
    COUNT(*) AS Patient_Count
FROM Patient_Diseases pd
JOIN Diseases d
    ON pd.Disease_ID = d.Disease_ID
GROUP BY d.Disease_Name
ORDER BY Patient_Count DESC, d.Disease_Name;

SELECT
    Status,
    COUNT(*) AS Appointment_Count
FROM Appointments
GROUP BY Status
ORDER BY Appointment_Count DESC;