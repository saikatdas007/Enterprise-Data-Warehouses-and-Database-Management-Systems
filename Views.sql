-- TASK 2: VIEW CREATION

-- View 1: Summary View (Doctor Workload)
-- Purpose: Shows how many appointments each doctor has handled and total revenue generated from procedures.
CREATE OR REPLACE VIEW v_Doctor_Performance_Summary AS
SELECT 
    d.doctor_id,
    d.last_name,
    dept.name AS department,
    COUNT(a.appointment_id) AS total_appointments,
    COALESCE(SUM(ap.billed_amount), 0) AS total_revenue_generated
FROM Doctors d
JOIN Departments dept ON d.department_id = dept.department_id
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
LEFT JOIN Appointment_Procedures ap ON a.appointment_id = ap.appointment_id
GROUP BY d.doctor_id, d.last_name, dept.name;

-- View 2: Trend View (Monthly Appointments)
-- Purpose: Helps analyze patient traffic trends over time.
CREATE OR REPLACE VIEW v_Monthly_Appointment_Trends AS
SELECT 
    TO_CHAR(appointment_date, 'YYYY-MM') AS month_year,
    status,
    COUNT(*) AS appointment_count
FROM Appointments
GROUP BY TO_CHAR(appointment_date, 'YYYY-MM'), status
ORDER BY month_year DESC;