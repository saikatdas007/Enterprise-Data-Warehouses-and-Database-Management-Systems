-- TASK 1: CREATE TABLE SCRIPTS (Normalized 3NF)

-- 1. Departments
CREATE TABLE Departments (
    department_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100) NOT NULL
);

-- 2. Specialties (Lookup table for M:N relationship)
CREATE TABLE Specialties (
    specialty_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- 3. Doctors
CREATE TABLE Doctors (
    doctor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    hire_date DATE DEFAULT CURRENT_DATE,
    department_id INT REFERENCES Departments(department_id) ON DELETE SET NULL
);

-- 4. Patients
CREATE TABLE Patients (
    patient_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dob DATE NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F', 'O')),
    phone VARCHAR(20) NOT NULL,
    address TEXT
);

-- 5. Medications
CREATE TABLE Medications (
    medication_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    brand VARCHAR(100),
    stock_quantity INT CHECK (stock_quantity >= 0),
    unit_price DECIMAL(10, 2) NOT NULL
);

-- 6. Procedures (Standard Medical Procedures)
CREATE TABLE Procedures (
    procedure_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    base_cost DECIMAL(10, 2) CHECK (base_cost >= 0)
);

-- 7. Allergies (Lookup table)
CREATE TABLE Allergies (
    allergy_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- 8. Appointments
CREATE TABLE Appointments (
    appointment_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES Patients(patient_id) ON DELETE CASCADE,
    doctor_id INT REFERENCES Doctors(doctor_id) ON DELETE SET NULL,
    appointment_date TIMESTAMP NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Scheduled', 'Completed', 'Cancelled', 'No-Show')) DEFAULT 'Scheduled',
    reason_for_visit TEXT
);

-- 9. Prescriptions
CREATE TABLE Prescriptions (
    prescription_id SERIAL PRIMARY KEY,
    appointment_id INT REFERENCES Appointments(appointment_id) ON DELETE CASCADE,
    issue_date DATE DEFAULT CURRENT_DATE,
    notes TEXT
);

-- JUNCTION TABLES (Resolving M:N Relationships)

-- 10. Doctor_Specialties (Resolves Doctors <-> Specialties)
CREATE TABLE Doctor_Specialties (
    doctor_id INT REFERENCES Doctors(doctor_id),
    specialty_id INT REFERENCES Specialties(specialty_id),
    PRIMARY KEY (doctor_id, specialty_id)
);

-- 11. Patient_Allergies (Resolves Patients <-> Allergies)
CREATE TABLE Patient_Allergies (
    patient_id INT REFERENCES Patients(patient_id),
    allergy_id INT REFERENCES Allergies(allergy_id),
    severity VARCHAR(20) CHECK (severity IN ('Mild', 'Moderate', 'Severe')),
    PRIMARY KEY (patient_id, allergy_id)
);

-- 12. Prescription_Items (Resolves Prescriptions <-> Medications)
CREATE TABLE Prescription_Items (
    prescription_id INT REFERENCES Prescriptions(prescription_id),
    medication_id INT REFERENCES Medications(medication_id),
    dosage VARCHAR(50) NOT NULL, -- e.g. "500mg"
    frequency VARCHAR(50) NOT NULL, -- e.g. "Twice a day"
    PRIMARY KEY (prescription_id, medication_id)
);

-- 13. Appointment_Procedures (Resolves Appointments <-> Procedures)
CREATE TABLE Appointment_Procedures (
    appointment_id INT REFERENCES Appointments(appointment_id),
    procedure_id INT REFERENCES Procedures(procedure_id),
    notes TEXT,
    billed_amount DECIMAL(10, 2),
    PRIMARY KEY (appointment_id, procedure_id)
);

