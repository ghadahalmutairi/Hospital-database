	-- What patients have upcoming appointments and what is their contact information?

SELECT Patient.PatientID, Patient.FirstName, Patient.LastName, Patient.PhoneNumber, Appointments.AppointmentDate
FROM Patient
INNER JOIN Appointments ON Patient.PatientID = Appointments.PatientID
WHERE Appointments.AppointmentDate >= GETDATE();

-- 	Which patients have upcoming appointments and what are their medical records? 

SELECT Patient.PatientID, Patient.FirstName, Patient.LastName, Patient.PhoneNumber, Appointments.AppointmentDate, MedicalRecord.Diagnosis
FROM Patient INNER JOIN Appointments ON Patient.PatientID = Appointments.PatientID, MedicalRecord 
WHERE Appointments.AppointmentDate >= GETDATE() and  Patient.PatientID = MedicalRecord.PatientID;


	-- 	How many patients with allergies are there in each blood type category?

SELECT BloodType, COUNT(*) AS AllergicPatients
FROM Patient
WHERE Allergies IS NOT NULL
GROUP BY BloodType;

--	What is the department name, gender, and average salary for staff members with salaries greater than or equal to $5000, grouped by department name and gender, and ordered accordingly?

SELECT d.DepartmentName, s.Gender, AVG(s.salary) AS AverageSalary
FROM Staff s
RIGHT JOIN Department d ON s.Dept_ID = d.Dept_ID
WHERE s.salary >= 5000
GROUP BY d.DepartmentName, s.Gender
ORDER BY d.DepartmentName, s.Gender;

-- 	What is the maximum salary for each department among both nurses and staff members?

SELECT DepartmentName, MAX(salary) AS MaxSalary
FROM (
    SELECT Dept_ID, salary FROM Nurse
    UNION ALL
    SELECT Dept_ID, salary FROM Staff
) AS AllSalaries
JOIN Department ON AllSalaries.Dept_ID = Department.Dept_ID
GROUP BY DepartmentName;

-- 		What are the maximum and minimum salaries for each nationality among staff members?

SELECT Nationality, MAX(salary) AS MaxSalary, MIN(salary) AS MinSalary
FROM Staff
GROUP BY Nationality;

--	What are the maximum and minimum salaries for each role among male staff members?

SELECT Role, MAX(salary) AS MaxSalary, MIN(salary) AS MinSalary
FROM Staff
WHERE Gender = 'M' 
GROUP BY Role;

-- 	What is the average cost of prescriptions for each gender?

SELECT pa.Gender, AVG(p.Cost) AS AverageCost
FROM Pharmacy p
JOIN Patient pa ON p.PatientID = pa.PatientID
GROUP BY pa.Gender;


-- 	Which department has the most female staff members, including doctors and nurses?

SELECT d.DepartmentName, COUNT(*) AS FemaleStaffCount
FROM (
    SELECT Dept_ID, Gender FROM Staff
    UNION ALL
    SELECT Dept_ID, Gender FROM Doctor
    UNION ALL
    SELECT Dept_ID, Gender FROM Nurse
) AS CombinedData
JOIN Department d ON CombinedData.Dept_ID = d.Dept_ID 
WHERE CombinedData.Gender = 'F' 
GROUP BY d.DepartmentName
ORDER BY FemaleStaffCount DESC;


--	Which prescriptions are for patients with insurance numbers, ordered by patient ID?

SELECT ph.Prescription, pa.InsuranceNumber,ph.patientID
FROM Pharmacy ph
JOIN Patient pa ON ph.PatientID = pa.PatientID
WHERE pa.InsuranceNumber  not like 'NO Insurance%' 
ORDER BY pa.PatientID;

-- 		What is the average age of people who have allergies, categorized by allergy status?

SELECT 
    CASE WHEN Allergies IS NOT NULL THEN 'With Allergies' ELSE 'Without Allergies' END AS AllergyStatus,
    AVG(Age) AS AverageAge
FROM Patient
GROUP BY CASE WHEN Allergies IS NOT NULL THEN 'With Allergies' ELSE 'Without Allergies' END;

-- What is the percentage of male and female patients in each blood type category?

SELECT BloodType, Gender, 
    COUNT(*) AS TotalPatients,
    (COUNT(*) * 100.0) / SUM(COUNT(*)) OVER(PARTITION BY BloodType) AS PercentageByBloodType
FROM Patient
GROUP BY BloodType, Gender;


-- 		How many staff members, including doctors and nurses, are there in each department categorized by gender, and what are the results ordered by department name?

SELECT d.DepartmentName, AllStaff.Gender, COUNT(*) AS TotalStaff
FROM( SELECT Dept_ID, Gender FROM Staff
    UNION ALL
    SELECT Dept_ID, Gender FROM Doctor
    UNION ALL
    SELECT Dept_ID, Gender FROM Nurse ) as AllStaff
JOIN Department d ON AllStaff.Dept_ID = d.Dept_ID
GROUP BY d.DepartmentName, AllStaff.Gender
ORDER BY d.DepartmentName;

-- 	What is the average age of patients in each gender category?

SELECT Gender, AVG(age) AS AverageAge
FROM Patient
GROUP BY Gender;

-- 	What are the details of nurses who work in the Gynecology department?

SELECT n.NurseID, n.FirstName, n.LastName, n.Certification, d.DepartmentName
FROM Nurse n
INNER JOIN Department d ON n.Dept_ID = d.Dept_ID
WHERE d.DepartmentName = 'Gynecology';

-- 		What is the department name and the number of nurses working in each department?

SELECT d.DepartmentName, COUNT(n.NurseID) AS NumberOfNurses
FROM Nurse n
INNER JOIN Department d ON n.Dept_ID = d.Dept_ID
GROUP BY d.DepartmentName;

-- 	What are the Nurse ID, first name, and last name of male nurses who are of Saudi nationality, ordered by first name? 


select NurseID,FirstName,LastName 
from Nurse
where Nationality ='saudi' and Gender like  'M'
order by FirstName 

--		What is the patient count per doctor, and what is the status of each doctor based on the patient count (labeled as ‘BUSY’ if over 3 patients, ‘INVALIBALE’ otherwise)?
 
SELECT D.FirstName, D.LastName, COUNT(*) AS PatientCount,
    CASE
        WHEN COUNT(*) > 3 THEN 'BUSY'
        ELSE 'INVALIBALE'
    END AS DoctorStatus
FROM Doctor D
INNER JOIN MedicalRecord MR ON D.DoctorID = MR.DoctorID
GROUP BY D.DoctorID, D.FirstName, D.LastName
ORDER BY D.firstName;

--		How should doctors’ salaries be adjusted based on patient feedback ratings: decreased by 10% for ratings <= 2, no change for rating 3, and increased by 10% for ratings > 3?
UCREATE PROCEDURE UpdateDoctorSalaries
AS
BEGIN
    
    SELECT
        d.DoctorID,
        AVG(ISNULL(pf.SatisfactionRate, 0)) AS AvgSatisfactionRate
    INTO
        #DoctorFeedback
    FROM
        Doctor d
    LEFT JOIN
        (SELECT mr.doctorID, pf.SatisfactionRate
         FROM MedicalRecord mr
         LEFT JOIN PatientFeedback pf ON mr.PatientID = pf.PatientID) AS pf ON d.DoctorID = pf.doctorID
    GROUP BY
        d.DoctorID;

   
    UPDATE Doctor
    SET salary = salary * 
        CASE 
            WHEN df.AvgSatisfactionRate <= 2 THEN 0.9  
            WHEN df.AvgSatisfactionRate > 3 THEN 1.1   
            ELSE 1.0  
        END
    FROM Doctor d
    JOIN #DoctorFeedback df ON d.DoctorID = df.DoctorID;

   
    DROP TABLE #DoctorFeedback;
END;




	--	How are staff members categorized into salary categories (“Low-Paid,” “Medium-Paid,” or “High-Paid”) based on their average salaries, grouped by role and gender, and ordered by ascending average salary?
SELECT 
    CASE 
        WHEN AVG(Salary) <= 20000 THEN 'Low-Paid' 
        WHEN AVG(Salary) > 20000 AND AVG(Salary) <= 30000 THEN 'Medium-Paid' 
        ELSE 'High-Paid' 
    END AS SalaryCategory, 
    Role, 
    Gender, 
    ROUND(AVG(Salary), 2) AS AvgSalary
FROM Staff
GROUP BY Role, Gender
ORDER BY AvgSalary ASC;


--How many doctors are there in each department, and what are their respective department names?
SELECT d.DepartmentName, COUNT(DISTINCT doc.DoctorID) AS NumberOfDoctors
FROM Department d
LEFT JOIN Doctor doc ON d.Dept_ID = doc.Dept_ID
HAVING COUNT(*) > 1
GROUP BY d.DepartmentName
ORDER BY NumberOfDoctors DESC ;


--	What is the most needed blood type?
 

SELECT * FROM (
    SELECT BloodType, COUNT(*) AS NumPatients
    FROM Patient
    GROUP BY BloodType
    ORDER BY COUNT(*) DESC
) WHERE ROWNUM = 1;


 
-- 	How many patients have celiac disease, and what are their blood type and age range?

SELECT p.PatientID, p.BloodType,
       CASE WHEN p.BloodType LIKE '%+' THEN '+'
            WHEN p.BloodType LIKE '%-' THEN '-'
            ELSE 'Unknown' END AS BloodTypeRh,
       CASE WHEN p.age < 18 THEN 'Under 18'
            WHEN p.age BETWEEN 18 AND 30 THEN '18-30'
            WHEN p.age BETWEEN 31 AND 50 THEN '31-50'
            ELSE 'Over 50' END AS AgeRange
FROM Patient p
JOIN MedicalRecord mr ON p.PatientID = mr.PatientID
WHERE mr.Diagnosis = 'Celiac Disease';

--  How many families with insurance are registered at the hospital (assuming insurance number uniquely identifies a family)?

SELECT DISTINCT InsuranceNumber, COUNT(*) AS FamilyMembers
FROM Patient
WHERE InsuranceNumber NOT LIKE 'No Insurance'
GROUP BY InsuranceNumber
HAVING COUNT(*) > 1;

--  Which clinic has the most appointments?


SELECT DepartmentName, AppointmentCount
FROM (
    SELECT d.DepartmentName, COUNT(*) AS AppointmentCount
    FROM Appointments a
    JOIN Department d ON a.Dept_ID = d.Dept_ID
    GROUP BY d.DepartmentName
    ORDER BY AppointmentCount DESC
) WHERE ROWNUM = 1;


--		Which time slots have the most appointments in the hospital?

SELECT * FROM (
    SELECT AppointmentTime, COUNT(*) AS AppointmentCount
    FROM Appointments
    GROUP BY AppointmentTime
    ORDER BY AppointmentCount DESC
) WHERE ROWNUM = 1;



	-- 	What appointments are scheduled for the Dentistry department?

SELECT *
FROM Appointments
WHERE Dept_ID = (
    SELECT Dept_ID
    FROM Department
    WHERE DepartmentName LIKE 'Dentistry'
);

--	What is the renewal status of each department based on their creation date?

SELECT DepartmentName,
       CASE
           WHEN creationdate < TO_DATE('2022-06-01', 'YYYY-MM-DD') THEN 'Needs Renewal'
           ELSE 'Does Not Need Renewal'
       END AS RenewalStatus
FROM Department;


--	What is the count of doctors for each certification, grouped by certification?
SELECT CERTIFICATION, COUNT(*) AS DoctorCount 
FROM DOCTOR
GROUP BY CERTIFICATION
ORDER BY CERTIFICATION;


-- 	What are the first names, last names, certifications, and department names of nurses?

SELECT Nurse.FirstName, Nurse.LastName, Nurse.Certification, Department.DepartmentName
FROM Nurse
INNER JOIN Department ON Nurse.Dept_ID = Department.Dept_ID;


-- 		What are the first names, last names, certifications, and department names of doctors?

SELECT Doctor.FirstName, Doctor.LastName, Doctor.Certification, Department.DepartmentName
FROM Doctor
INNER JOIN Department ON Doctor.Dept_ID = Department.Dept_ID; 

	-- 	How many patients have allergies to specific products such as milk or eggs?

SELECT PatientID , FirstName , LastName , Allergies 
FROM Patient WHERE Allergies LIKE '%Milk%' OR Allergies LIKE '%Eggs%';



--	How many patients are there in each department, and what are their respective department names?
SELECT d.DepartmentName, COUNT(a.AppointmentDate) AS NumAppointments
FROM Department d
LEFT JOIN Appointments a ON d.Dept_ID = a.Dept_ID
GROUP BY d.DepartmentName
HAVING COUNT(a.AppointmentDate) > 0
ORDER BY NumAppointments DESC;


--	How many patients had appointments on February 22, 2024, in the Gynecology Department?

SELECT COUNT(*) AS NumberOfPatients
FROM Appointments A JOIN Department Dept ON A.Dept_ID = Dept.Dept_ID
WHERE Dept.DepartmentName = 'Gynecology'
AND A.AppointmentDate =  DATE'2024-2-22';

--		Which patients are diagnosed with Overweight?

SELECT FirstName, LastName
FROM Patient
WHERE PatientID IN (
    SELECT PatientID
    FROM MedicalRecord
    WHERE Diagnosis = 'Overwieght');





--	What are the names of male doctors working on Floor 1 or female nurses working in Building F88?

SELECT FirstName, LastName 
FROM Doctor
WHERE Gender = 'M' AND Dept_ID IN (SELECT Dept_ID FROM Department WHERE Dept_Floor = 1)
UNION
SELECT FirstName, LastName 
FROM Nurse
WHERE Gender = 'F' AND Dept_ID IN (SELECT Dept_ID FROM Department WHERE Dept_Location = 'Building F88');


--		Which patients have a Dental checkup?

SELECT FirstName || ' ' || LastName AS  PatientNAME
FROM Patient
WHERE PatientID IN (
    SELECT PatientID
    FROM MedicalRecord
    WHERE Diagnosis = 'Dental checkup');







--	Which patients have a satisfaction rating of less than 4, and what are their suggestions?

SELECT PF.PatientID, P.FirstName ,SatisfactionRate, PF.Suggestions
FROM PatientFeedback PF
JOIN Patient P ON PF.PatientID = P.PatientID
WHERE PF.SatisfactionRate < 4;


--	How many patients have a Strawberries allergy?

SELECT COUNT(*) AS NumOfPatientsWithPeanutAllergy
FROM Patient
WHERE PatientID IN (
    SELECT PatientID
    FROM Patient
    WHERE Allergies LIKE 'Strawberries'
);




--	Which male patients don’t suffer from allergies?

SELECT  Patient.PatientID, Patient.FirstName, Patient.LastName
FROM Patient 
WHERE Patient.Allergies LIKE 'No Allergies' and Gender = 'M';

-- 	Who are the male receptionists with salaries between $8000 and $9000?

select  FirstName || ' ' || LastName AS Name, salary
from Staff 
where Gender ='M' and salary between 8000 AND 9000 ;

--	Which male patients have appointments with an oncologist?

SELECT DISTINCT P.FirstName || ' ' || P.LastName AS Name
FROM Patient P, Appointments A, Department Dept
WHERE Dept.DepartmentName = 'Oncology'
AND A.PatientID = P.PatientID
AND P.PatientID NOT IN (
    SELECT PatientID
    FROM Patient
    WHERE Gender = 'F'
);





-- What are the radiological reports for patient ID 110107?

SELECT  R.ResultFile, R.ResultDate 
FROM Radiology R JOIN MedicalRecord MR ON R.MedicalRecordID = MR.MedicalRecordID
WHERE MR.PatientID = 110107;

-- 		Who are the female reception staff members with salaries higher than $8000?

SELECT FirstName, LastName , salary
FROM Staff
WHERE Role = 'Receptionist' 
AND Gender = 'F'  AND salary > 8000;

--	Which patients have appointments with neurologists, and who is the nurse assigned to the neurology department?

SELECT  DISTINCT P.FirstName || ' ' || P.LastName AS  PatientNAME,  N.FirstName || ' ' || N.LastName AS  NurseName  
FROM Appointments A , Doctor D , Patient P
, Department Dept, Nurse N 
WHERE  A.DoctorID = D.DoctorID AND A.PatientID = P.PatientID AND
D.Dept_ID = Dept.Dept_ID AND Dept.Dept_ID = N.Dept_ID
AND Dept.DepartmentName = 'Neurology'
ORDER BY PatientNAME ASC ;






-- 	Which patients have only one appointment in the ‘Neurology’ department?
SELECT P.PatientID, P.FirstName, P.LastName
FROM Patient P  , Appointments A , Department Dept 
WHERE  P.PatientID = A.PatientID AND  A.Dept_ID = Dept.Dept_ID
AND Dept.DepartmentName =  'Neurology'
GROUP BY P.PatientID , P.FirstName, P.LastName
HAVING COUNT(*) = 1;


	14.	Which patients rated poorly (below 3)?

SELECT P.PatientID, P.FirstName, P.LastName, PF.SatisfactionRate
FROM Patient P
JOIN PatientFeedback PF ON P.PatientID = PF.PatientID
WHERE PF.SatisfactionRate < 3;

--	What are the top 5 salaries for doctors excluding those in the Urology department?

SELECT *
FROM Doctor
WHERE Dept_ID != ( SELECT Dept_ID
    FROM Department
    WHERE DepartmentName = 'Urology'  ) and ROWNUM <=5 
ORDER BY salary DESC ;

--	How should the salary of administrative assistants be updated if their salary is less than $18,000, by increasing it by $1,000?

UPDATE Staff
SET salary = salary + 1000
WHERE Role = 'administrative assistant' AND salary < 18000;

--		How many female nurses have a salary less than $22,000, and how should their salaries be adjusted by increasing them by $1,000?

UPDATE Nurse
SET salary = salary + 1000
WHERE Gender = 'F' AND salary < 22000;




















