-- DATA POPULATION 

-- 1. Departments
INSERT INTO Departments (name, location) VALUES
('Cardiology', 'Building A, Floor 3'),
('Pediatrics', 'Building B, Floor 1'),
('Orthopedics', 'Building A, Floor 2'),
('Emergency', 'Building C, Ground'),
('Neurology', 'Building A, Floor 4');

-- 2. Specialties
INSERT INTO Specialties (name) VALUES 
('Surgery'), 
('Internal Medicine'), 
('Pediatrics'), 
('Neurology'), 
('Cardiology');

-- 3. Doctors
INSERT INTO Doctors (first_name, last_name, email, phone, department_id, hire_date) VALUES
('Arjun', 'Mehta', 'a.mehta@hospital.com', '555-0101', 5, '2015-06-15'),
('Priya', 'Sharma', 'p.sharma@hospital.com', '555-0102', 2, '2010-01-20'),
('Rohan', 'Khanna', 'r.khanna@hospital.com', '555-0103', 1, '2012-03-11'),
('Ananya', 'Iyer', 'a.iyer@hospital.com', '555-0104', 4, '2018-07-22'),
('Vikram', 'Singh', 'v.singh@hospital.com', '555-0105', 1, '2019-11-05');

-- 4. Doctor_Specialties (Junction Table)
INSERT INTO Doctor_Specialties (doctor_id, specialty_id) VALUES
(1, 4), (1, 2), -- Dr. Mehta is Neuro + Internal
(2, 3),         -- Dr. Sharma is Peds
(3, 5),         -- Dr. Khanna is Cardio
(5, 1);         -- Dr. Singh is Surgery

-- 5. Patients 
INSERT INTO Patients (first_name, last_name, dob, gender, phone, address) VALUES
('Aarav', 'Verma', '1985-05-15', 'M', '555-1001', 'Flat 402, Sunrise Apartments, Mumbai'),
('Ishani', 'Gupta', '1992-08-22', 'F', '555-1002', '12 MG Road, Sector 4, Delhi'),
('Sunita', 'Kulkarni', '1954-12-01', 'F', '555-1003', '789 Lotus Lane, Pune'),
('Kabir', 'Malhotra', '2015-03-10', 'M', '555-1004', 'Block C, Green Park, Bangalore'),
('Rahul', 'Nair', '1978-11-30', 'M', '555-1005', '45 Orchid Residency, Kochi');

-- 6. Allergies
INSERT INTO Allergies (name, description) VALUES
('Penicillin', 'Antibiotic allergy'),
('Peanuts', 'Nut allergy'),
('Latex', 'Contact dermatitis'),
('Dust Mites', 'Respiratory'),
('Pollen', 'Seasonal hay fever');

-- 7. Patient_Allergies (Junction Table)
INSERT INTO Patient_Allergies (patient_id, allergy_id, severity) VALUES
(1, 1, 'Severe'),
(2, 3, 'Mild'),
(4, 2, 'Severe');

-- 8. Medications
INSERT INTO Medications (name, brand, stock_quantity, unit_price) VALUES
('Amoxicillin', 'Amoxil', 100, 15.50),
('Ibuprofen', 'Advil', 500, 8.00),
('Lisinopril', 'Prinivil', 200, 22.00),
('Metformin', 'Glucophage', 150, 18.00),
('Atorvastatin', 'Lipitor', 120, 25.00);

-- 9. Procedures
INSERT INTO Procedures (name, base_cost) VALUES
('General Checkup', 50.00),
('X-Ray', 120.00),
('MRI Scan', 500.00),
('Blood Test', 80.00),
('Heart Surgery', 5000.00);

-- 10. Appointments
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status, reason_for_visit) VALUES
(1, 1, '2023-10-01 09:00:00', 'Completed', 'Severe headaches'),
(2, 2, '2023-10-02 10:30:00', 'Completed', 'Routine child checkup'),
(3, 3, '2023-10-02 14:00:00', 'Completed', 'High blood pressure'),
(4, 2, '2023-10-03 11:00:00', 'No-Show', 'Flu symptoms'),
(1, 5, '2023-10-05 08:00:00', 'Scheduled', 'Follow up on surgery'),
(5, 4, '2023-10-06 12:00:00', 'Scheduled', 'Emergency injury');

-- 11. Appointment_Procedures (Junction Table)
INSERT INTO Appointment_Procedures (appointment_id, procedure_id, billed_amount) VALUES
(1, 3, 500.00), -- MRI for Aarav
(2, 1, 50.00),  -- Checkup for Ishani
(3, 4, 80.00);  -- Blood Test for Sunita

-- 12. Prescriptions
INSERT INTO Prescriptions (appointment_id, issue_date, notes) VALUES
(1, '2023-10-01', 'Take with food'),
(3, '2023-10-02', 'Monitor BP daily');

-- 13. Prescription_Items (Junction Table)
INSERT INTO Prescription_Items (prescription_id, medication_id, dosage, frequency) VALUES
(1, 2, '400mg', 'Every 6 hours'),
(2, 3, '10mg', 'Once daily'),
(2, 5, '20mg', 'Once daily');