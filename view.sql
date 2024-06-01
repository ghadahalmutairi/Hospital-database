
-- “How many patients received a low satisfaction rating?” 
CREATE VIEW bad_feedback AS
SELECT patient.FirstName, patient.LastName
FROM Patient NATURAL JOIN patientfeedback
WHERE SatisfactionRate <=2;

--“How many uninsured patients are there by gender?”
 
CREATE VIEW no_insurance AS
SELECT  p.Gender, COUNT(p.Gender) AS Number_Gender
FROM Patient p
WHERE p.INSURANCENUMBER = 'No Insurance'
GROUP BY p.Gender



--"How many clinical laboratory results are available for patients, including names, contact information, result dates, and files?"
 
CREATE VIEW patients_ClinicalLaboratory  AS
SELECT Patient.PatientID, Patient.FirstName, Patient.LastName, Patient.PhoneNumber, ClinicalLaboratory.RESULTFILE, ClinicalLaboratory.RESULTDATE
FROM Patient INNER JOIN ClinicalLaboratory  ON Patient.PatientID = ClinicalLaboratory .PatientID;


-- “What is the information of the specialized doctors in the Department of Cardiology?
 
CREATE VIEW Cardiology_department AS
SELECT *
FROM Doctor
WHERE DEPT_ID = 58
with check option;

INSERT INTO Cardiology_department VALUES (2250,'Mona','Geisser','F','American',45000,'MD,ABIM','Cardiologist',00058);
INSERT INTO Cardiology_department VALUES (2245,'Saad','Turki','M','Saudi',33000,'MD,ABA','Consultant Anaesthetist',03208);

-- “How many prescriptions and details are available for uninsured patients?”
 
CREATE VIEW prescription_noinsurance AS
SELECT Pharmacy.BillNumber, Patient.PatientID, Patient.FirstName, Pharmacy.prescription
FROM Patient JOIN Pharmacy on Patient.PatientID = Pharmacy.PatientID
WHERE Patient.InsuranceNumber  = 'No Insurance';