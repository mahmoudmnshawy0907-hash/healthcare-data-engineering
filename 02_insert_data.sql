PRAGMA foreign_keys = ON;

INSERT INTO Insurance (Insurance_ID, Provider_Name, Plan_Name, Coverage_Type, Phone_Number) VALUES
(1, 'Misr Insurance', 'Silver Care', 'Individual', '0223456789'),
(2, 'Nile Health', 'Family Plus', 'Family', '0223987654'),
(3, 'SafeLife', 'Corporate Basic', 'Corporate', '0223123456');

INSERT INTO Patients (Patient_ID, Name, Date_of_Birth, Height, Weight, Phone_Number, Address, Marital_Status, Insurance_ID) VALUES
(1, 'Ahmed Hassan', '1999-05-10', 175.5, 70.2, '01012345678', 'Hurghada', 'Single', 1),
(2, 'Sara Ali', '2001-11-22', 162.0, 58.4, '01098765432', 'Cairo', 'Married', 2),
(3, 'Omar Mostafa', '1995-03-15', 180.3, 85.0, '01122334455', 'Alexandria', 'Single', 3),
(4, 'Mona Adel', '1988-07-30', 158.2, 67.8, '01233445566', 'Giza', 'Married', 2),
(5, 'Youssef Tarek', '2003-01-12', 172.4, 74.1, '01555666777', 'Mansoura', 'Single', 1);

INSERT INTO Doctors (Doctor_ID, Doctor_Name, Specialty, Phone_Number, Email) VALUES
(1, 'Dr. Hany Ibrahim', 'Cardiology', '01020030040', 'hany.ibrahim@hospital.com'),
(2, 'Dr. Salma Nabil', 'Endocrinology', '01020030050', 'salma.nabil@hospital.com'),
(3, 'Dr. Karim Fathy', 'General Medicine', '01020030060', 'karim.fathy@hospital.com');

INSERT INTO Diseases (Disease_ID, Disease_Name, Category, ICD_Code) VALUES
(1, 'Diabetes', 'Chronic', 'E11'),
(2, 'Hypertension', 'Chronic', 'I10'),
(3, 'Asthma', 'Respiratory', 'J45'),
(4, 'Migraine', 'Neurological', 'G43');

INSERT INTO Patient_Diseases (Patient_Disease_ID, Patient_ID, Disease_ID, Diagnosis_Date, Status) VALUES
(1, 1, 2, '2024-01-15', 'Active'),
(2, 2, 1, '2023-09-10', 'Active'),
(3, 3, 3, '2022-06-21', 'Controlled'),
(4, 4, 4, '2021-12-05', 'Recurring'),
(5, 5, 2, '2024-03-01', 'Under Observation');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Time, Status, Reason) VALUES
(1, 1, 1, '2026-10-01', '10:00', 'Completed', 'Routine blood pressure follow-up'),
(2, 2, 2, '2026-10-02', '12:30', 'Completed', 'Diabetes management review'),
(3, 3, 3, '2026-10-04', '09:15', 'Scheduled', 'Asthma symptoms check'),
(4, 4, 1, '2026-10-05', '02:00', 'Scheduled', 'Headache and dizziness'),
(5, 5, 3, '2026-10-06', '11:45', 'Scheduled', 'General health consultation');

INSERT INTO Visit_Log (Visit_ID, Appointment_ID, Visit_Notes, Blood_Pressure, Temperature, Visit_Status) VALUES
(1, 1, 'Patient condition stable. Continue current medication.', '130/85', 36.8, 'Closed'),
(2, 2, 'Advised dietary control and follow-up HbA1c.', '120/80', 36.7, 'Closed');

INSERT INTO Medical_Tests (Test_ID, Patient_ID, Test_Name, Result, Test_Date, Ordered_By_Doctor_ID) VALUES
(1, 1, 'CBC', 'Normal', '2026-09-29', 3),
(2, 2, 'HbA1c', '7.2%', '2026-09-30', 2),
(3, 3, 'Chest X-Ray', 'Mild hyperinflation', '2026-10-01', 3),
(4, 4, 'MRI Brain', 'No acute findings', '2026-10-02', 1),
(5, 5, 'Vitamin D', 'Low', '2026-10-02', 3);

INSERT INTO Family_Medical_History (Family_History_ID, Patient_ID, Relative_Type, Disease_Name, Notes) VALUES
(1, 1, 'Father', 'Hypertension', 'Diagnosed in his 50s'),
(2, 2, 'Mother', 'Diabetes', 'On insulin therapy'),
(3, 3, 'Brother', 'Asthma', 'Childhood onset'),
(4, 4, 'Mother', 'Migraine', 'Frequent attacks'),
(5, 5, 'Father', 'Heart Disease', 'History of coronary artery disease');