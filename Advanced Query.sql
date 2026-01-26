SELECT 
    p.first_name || ' ' || p.last_name AS patient_name,
    d.last_name AS doctor_name,
    m.name AS medication_name,
    pi.dosage,
    pr.issue_date
FROM Patients p
JOIN Appointments a ON p.patient_id = a.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
JOIN Prescriptions pr ON a.appointment_id = pr.appointment_id
JOIN Prescription_Items pi ON pr.prescription_id = pi.prescription_id
JOIN Medications m ON pi.medication_id = m.medication_id;



SELECT 
    m.name AS medication_name,
    COUNT(pi.prescription_id) AS times_prescribed,
    SUM(m.unit_price) AS potential_revenue
FROM Medications m
JOIN Prescription_Items pi ON m.medication_id = pi.medication_id
GROUP BY m.name
HAVING COUNT(pi.prescription_id) > 1
ORDER BY times_prescribed DESC;



SELECT 
    first_name,
    last_name,
    dob,
    CASE 
        WHEN EXTRACT(YEAR FROM AGE(dob)) < 18 THEN 'Pediatric'
        WHEN EXTRACT(YEAR FROM AGE(dob)) BETWEEN 18 AND 65 THEN 'Adult'
        ELSE 'Senior'
    END AS age_category
FROM Patients;



SELECT 
    first_name, 
    last_name, 
    (SELECT COUNT(*) FROM Appointments a WHERE a.doctor_id = d.doctor_id) as my_count
FROM Doctors d
WHERE (SELECT COUNT(*) FROM Appointments a WHERE a.doctor_id = d.doctor_id) > 
      (SELECT AVG(appt_count) 
       FROM (SELECT COUNT(*) as appt_count FROM Appointments GROUP BY doctor_id) as avg_table);



SELECT 
    d.first_name,
    d.last_name,
    dept.name AS department,
    d.hire_date,
    RANK() OVER (PARTITION BY d.department_id ORDER BY d.hire_date ASC) as seniority_rank
FROM Doctors d
JOIN Departments dept ON d.department_id = dept.department_id;



CREATE OR REPLACE FUNCTION fn_GetTotalAppointmentCost(appt_id INT) 
RETURNS DECIMAL AS $$
DECLARE
    total_cost DECIMAL(10, 2);
BEGIN
    SELECT COALESCE(SUM(billed_amount), 0) INTO total_cost
    FROM Appointment_Procedures
    WHERE appointment_id = appt_id;
    RETURN total_cost;
END;
$$ LANGUAGE plpgsql;