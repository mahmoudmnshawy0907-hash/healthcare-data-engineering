PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS Insurance (
    Insurance_ID INTEGER PRIMARY KEY,
    Provider_Name TEXT NOT NULL,
    Plan_Name TEXT,
    Coverage_Type TEXT,
    Phone_Number TEXT
);

CREATE TABLE IF NOT EXISTS Patients (
    Patient_ID INTEGER PRIMARY KEY,
    Name TEXT NOT NULL,
    Date_of_Birth TEXT NOT NULL,
    Height REAL,
    Weight REAL,
    Phone_Number TEXT,
    Address TEXT,
    Marital_Status TEXT,
    Insurance_ID INTEGER,
    FOREIGN KEY (Insurance_ID) REFERENCES Insurance(Insurance_ID)
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_patients_unique_identity
ON Patients(Name, Date_of_Birth, Phone_Number);

CREATE TABLE IF NOT EXISTS Doctors (
    Doctor_ID INTEGER PRIMARY KEY,
    Doctor_Name TEXT NOT NULL,
    Specialty TEXT NOT NULL,
    Phone_Number TEXT,
    Email TEXT
);

CREATE TABLE IF NOT EXISTS Diseases (
    Disease_ID INTEGER PRIMARY KEY,
    Disease_Name TEXT NOT NULL UNIQUE,
    Category TEXT,
    ICD_Code TEXT
);

CREATE TABLE IF NOT EXISTS Patient_Diseases (
    Patient_Disease_ID INTEGER PRIMARY KEY,
    Patient_ID INTEGER NOT NULL,
    Disease_ID INTEGER NOT NULL,
    Diagnosis_Date TEXT,
    Status TEXT,
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID),
    FOREIGN KEY (Disease_ID) REFERENCES Diseases(Disease_ID),
    UNIQUE (Patient_ID, Disease_ID, Diagnosis_Date)
);

CREATE TABLE IF NOT EXISTS Appointments (
    Appointment_ID INTEGER PRIMARY KEY,
    Patient_ID INTEGER NOT NULL,
    Doctor_ID INTEGER NOT NULL,
    Appointment_Date TEXT NOT NULL,
    Appointment_Time TEXT NOT NULL,
    Status TEXT NOT NULL,
    Reason TEXT,
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctors(Doctor_ID)
);

CREATE TABLE IF NOT EXISTS Visit_Log (
    Visit_ID INTEGER PRIMARY KEY,
    Appointment_ID INTEGER NOT NULL,
    Visit_Notes TEXT,
    Blood_Pressure TEXT,
    Temperature REAL,
    Visit_Status TEXT,
    FOREIGN KEY (Appointment_ID) REFERENCES Appointments(Appointment_ID)
);

CREATE TABLE IF NOT EXISTS Medical_Tests (
    Test_ID INTEGER PRIMARY KEY,
    Patient_ID INTEGER NOT NULL,
    Test_Name TEXT NOT NULL,
    Result TEXT,
    Test_Date TEXT NOT NULL,
    Ordered_By_Doctor_ID INTEGER,
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID),
    FOREIGN KEY (Ordered_By_Doctor_ID) REFERENCES Doctors(Doctor_ID)
);

CREATE TABLE IF NOT EXISTS Family_Medical_History (
    Family_History_ID INTEGER PRIMARY KEY,
    Patient_ID INTEGER NOT NULL,
    Relative_Type TEXT NOT NULL,
    Disease_Name TEXT NOT NULL,
    Notes TEXT,
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID)
);
SELECT name
FROM sqlite_master
WHERE type = 'index'
ORDER BY name;