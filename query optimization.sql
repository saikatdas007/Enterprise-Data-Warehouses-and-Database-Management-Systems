-- Slow Query
SELECT * FROM Patients WHERE last_name LIKE '%Ver%';


-- Step 1: Create an Index on the patient last names
CREATE INDEX idx_patient_lastname ON Patients(last_name);

-- Step 2: Optimized query (Utilizes the index)
-- This will quickly find 'Verma' or 'Vyas'
SELECT * FROM Patients 
WHERE last_name LIKE 'Ver%';