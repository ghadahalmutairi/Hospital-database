CREATE TABLE Patient (
    PatientID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    age INT,
    Gender CHAR(1) NOT NULL,
    PhoneNumber VARCHAR(15) not null,
    EmergencyContactName VARCHAR(100),
    Allergies VARCHAR(255),
    InsuranceNumber VARCHAR(50) ,
    BloodType CHAR(3) NOT NULL
);

CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender CHAR(1) NOT NULL,
    Nationality VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    Dept_ID INT NOT NULL,
    FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
);

CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender CHAR(1) NOT NULL,
    Nationality VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    Certification VARCHAR(100) NOT NULL,
    Qualification VARCHAR(100) NOT NULL,
    Dept_ID INT NOT NULL,
    FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
);

CREATE TABLE Nurse (
    NurseID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender CHAR(1) NOT NULL,
    Nationality VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    Certification VARCHAR(100) NOT NULL,
    Dept_ID INT NOT NULL,
    FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
);

CREATE TABLE MedicalRecord (
    MedicalRecordID INT PRIMARY KEY,
    Diagnosis VARCHAR(255) NOT NULL,
    TreatmentDescription VARCHAR(255) NOT NULL,
    PatientID INT NOT NULL,
    doctorID INT NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (doctorID) REFERENCES Doctor(DoctorID)
);

CREATE TABLE Appointments (
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    DoctorID INT NOT NULL,
    PatientID INT NOT NULL,
    Dept_ID INT NOT NULL,
    PRIMARY KEY (AppointmentDate, AppointmentTime, DoctorID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
);

CREATE TABLE Department (
    Dept_ID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL,
   creationdate date not null,
    Dept_Location VARCHAR(50),
    Dept_Floor INT,

);

CREATE TABLE Radiology (
    ResultID INT PRIMARY KEY,
    MedicalRecordID INT NOT NULL,
    PatientID INT NOT NULL,
    ResultFile VARCHAR(255) NOT NULL,
    ResultDate DATE NOT NULL,
    FOREIGN KEY (MedicalRecordID) REFERENCES MedicalRecord(MedicalRecordID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE TABLE ClinicalLaboratory (
    ResultID INT PRIMARY KEY,
    MedicalRecordID INT NOT NULL,
    PatientID INT NOT NULL,
    ResultFile VARCHAR(255) NOT NULL,
    ResultDate DATE NOT NULL,
    FOREIGN KEY (MedicalRecordID) REFERENCES MedicalRecord(MedicalRecordID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE TABLE PatientFeedback (
    FeedbackID INT PRIMARY KEY,
    PatientID INT NOT NULL,
    SatisfactionRate INT NOT NULL,
    Suggestions VARCHAR(255),
    FeedbackDate DATE NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE TABLE Pharmacy (
    BillNumber INT PRIMARY KEY,
    PatientID INT NOT NULL,
    Cost DECIMAL(10, 2),
    DoctorID INT NOT NULL,
    Prescription VARCHAR(255) NOT NULL,
    PrescriptionDate DATE NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

insert into Patient
values (110101,'Lana','Ahmead',28,'F','0505587433','Ahmead Nasser','Peanut','111-021-001','O+'),
       (110102,'Lamar','Fahad',18,'F','0504599344','Waleed Fahad','No Allergies','112-022-221','O+'),
       (110103,'Naif','Saleh',12,'M','0505170444','Saleh Ali','Soya','111-221,920','A+'),
       (110104,'Leen','Sultan',17,'F','0405735728','Kadi Ali','Fish','No Insurance','O+'),
       (110105,'Sultan','Mohammed',45,'M','0405735728','Asma Khalid','No Allergies','No Insurance','B+'),
       (110106,'Dana','Mohamed',13,'F','0505464952','Nehad Abdullah','Eggs','112-989-030','AB+'),
       (110107,'Hussam','Ali',34,'M','0500630222','Btool Ali','Fish','115-595-001','A+'),
       (110108,'Arwa','Hamed',22,'F','0506146434','Nora Azzam','No Allergies','No Insurance','B-'),
       (110109,'Rand','Fasial',5,'F','0506646433','Fasial Saud','Peanut','221-221-921','O+'),
       (110110,'Bayan','Salman',32,'F','0505446443','Nawaf Fasial','No Allergies','224-443-343','O+'),
       (110111,'Firas','Fasial',0,'M','0505446443','Bayan Salman','No Allergies','224-443-343','O+'),
       (110112,'Abdullah','Rsheed',25,'M','0568850625','Rsheed Talal','Melon','No Insurance','B+'),
       (110113,'Saleh','Ahemad',65,'M','0504894258','Noor Saleh','No Allergies','992-232-040','A+'),
       (110114,'Luluah','Ibrahiam',85,'F','0539440445','Bedoor Saleh','No Allergies','119-083-321','AB+'),
       (110115,'Nasser','Saleh',44,'M','0503023203','Nada Fahad','Shellfish','119-083-321','AB+'),
       (110116,'Leena','Ahemad',8,'F','0538815577','Ahemad Khalid','No Allergies','No Insurance','B+'),
       (110117,'Yousef','Zaid',52,'M','0501804638','Maha Naif','No Milk','662-910-123','O+'),
       (110118,'Manar','Rayan',20,'F','0556794717','Rayan Abdulaziz','Milk','No Insurance','A-'),
       (110119,'Omar','Osamah',15,'M','0537665745','Osamah Turki','No Allergies','506-911-128','B+'),
       (110120,'Marah','Saad',17,'F','0505834258','Mona Jamal','Fish','No Insurance','A+');

-- The hospital was opened in 2021-11-9
INSERT INTO Department
VALUES
       (03208,'Anesthetics','2021-11-9','Building F32',4),
       (08873,'Admissions','2021-11-9','Building F88',1),
       (18842,'General Services','2021-11-9','Building F88',2),
       (28848,'Finance Department','2021-11-9','Building F88',3),
       (38809,'Human Resources','2021-11-9','Building F88',4),
       (00058,'Cardiology','2021-11-9','Building F5',1),
       (02055,'Hematology','2021-11-9','Building F5',3),
       (04057,'Urology','2022-1-5','Building F5',5),
       (00130,'Gynecology','2022-5-3','Building F13',1),
       (03137,'Dermatology','2023-7-24','Building F13',4),
       (00046,'Ophthalmology','2023-10-11','Building F4',1),
       (01048,'Gastroenterology','2022-2-5','Building F4',2),
       (02042,'Otolaryngology','2024-2-1','Building F4',3),
       (03045,'Oncology','2021-12-21','Building F4',4),
       (06044,'Neurology','2023-4-3','Building F4',7),
       (00203,'Nutrition and Dietetics','2022-10-9','Building F20',1),
       (01202,'Psychiatry','2022-6-6','Building F20',2),
       (00119,'Physiotherapy','2022-1-5','Building F11',1),
       (03111,'Dentistry','2023-7-24','Building F11',4);
       INSERT INTO Department
VALUES (00661,'Pharmacy','2021-11-9','Building F66',0);

       

INSERT INTO Staff
VALUES (311901,'Nora','Abdullah','F','Saudi',11000,'Social Work',08873),
       (311902,'Zain','Ibrahiam','M','Saudi',10000,'Social Work',08873),
       (311903,'Bader','Rakan','M','Jordanian',10000,'Social Work',08873),
       (311904,'Braa','Jad','M','Jordanian',11000,'Social Work',08873),
       (311905,'Eyad','Fars','M','Saudi',7800,'Receptionist',08873),
       (311906,'Aryam','Abdulkareem','F','Saudi',8000,'Receptionist',08873),
       (311907,'Zayd','Mohammed','M','Saudi',8100,'Receptionist',08873),
       (311908,'Kadi','Saud','F','Saudi',7500,'Receptionist',08873),
       (311909,'Rana','Majad','F','Saudi',7800,'Receptionist',08873),
       (311910,'Rahaf','Salem','F','Saudi',8500,'Receptionist',08873),
       (311911,'Raghad','Yousef','F','Saudi',7600,'Receptionist',08873),
       (311912,'Majed','Saleh','M','Saudi',8300,'Receptionist',08873),
       (311913,'Isa','Ahemad','M','Egyptian',7800,'Receptionist',08873),
       (311914,'Malik','Abdullah','M','Saudi',7500,'Receptionist',08873),
       (311915,'Alanoud','Abdulaziz','F','Saudi',8000,'Receptionist',08873),
       (311916,'Musa','Firas','M','Saudi',8100,'Receptionist',08873),
       (311917,'Abdulrahman','Saad','M','Saudi',7700,'Receptionist',08873),
       (311918,'Refal','Tamim','F','Saudi',8000,'Receptionist',08873),
       (311919,'Nawaf','Fasial','M','Saudi',7800,'Receptionist',08873),
       (311920,'Turki','Fahad','M','Saudi',18000,'administrative assistant',08873),
       (311921,'Thamer','Khalid','M','Saudi',16000,'administrative assistant',08873),
       (311922,'Aiman','Hussam','M','Saudi',12000,'Maintenance Technician',18842),
       (311923,'Bander','Eyad','M','Saudi',6000,'Security Officer',18842),
       (311924,'Abdullah','Yousef','M','Saudi',6000,'Security Officer',18842),
       (311925,'Bader','Rakan','M','Saudi',6000,'Security Officer',18842),
       (311926,'Yasmeen','Hani','F','Egyptian',9000,'Patient Services Assistants',18842),
       (311927,'Farah','Mohannad','F','Jordanin',9000,'Patient Services Assistants',18842),
       (311928,'Deem','Bassam','F','Saudi',91000,'Patient Services Assistants',18842),
       (311929,'Rami','Mohammed','M','Egyptian',8900,'Patient Services Assistants',18842),
       (311930, 'Sarah', 'Johnson', 'F', 'American', 23000, 'HR Manager', 38809),
       (311931, 'Jaber', 'Fahad', 'M', 'Saudi', 20000, 'HR Coordinator', 38809),
       (311932, 'Fatema', 'Hatem', 'F', 'Saudi', 17000, 'Recruitment Specialist', 38809),
       (311933, 'Saud', 'Adeel', 'M', 'Saudi', 16000, 'Training and Development Officer', 38809),
       (311934, 'Dona', 'Tamim', 'F', 'Saudi', 20000, 'Financial Analyst', 28848),
       (311935, 'Malk', 'Ibrahiam', 'F', 'Saudi', 25000, 'Accountant', 28848),
       (311936, 'Marwan', 'Majed', 'M', 'Saudi', 23000, 'Budget Analyst', 28848);
       
INSERT INTO Staff
VALUES
       (311937, 'Wasan', 'Adeeb', 'F', 'Saudi', 35000, 'Pharmacist', 00661),
        (311938, 'Remaz', 'Amar', 'F', 'Saudi', 33000, 'Pharmacist', 00661),
       (311939, 'Sultan', 'Hatem', 'M', 'Saudi', 36000, 'Pharmacist', 00661);

       
INSERT INTO Doctor 
VALUES (2201,'Diana','Geisser','F','American',40000,'MD,ABIM','Cardiologist',00058),
       (2202,'Majed','Yaseer','M','Saudi',38000,'MD','Paediatric Cardiologist',00058),
       (2203,'Tala','Ahemad','F','Saudi',30000,'MD','Cardiologist',00058),
       (2204,'George', 'Chalkiadis','M','Saudi',60000,'MD,BLS','Anesthesiologist',03208),
       (2205,'Saud','Turki','M','Saudi',56000,'MD,ABA','Consultant Anaesthetist',03208),
       (2206,'Marwa','Osamah','F','Saudi',35000,'MD','Haematologist',02055),
       (2207,'Layan','Sami','F','Syrian',40000,'MD','Consultant Haematologist',02055),
       (2208,'Marah','Abdulkarim','F','Saudi',60000,'MD,ABD','Dermatologists',03137),
       (2209,'Paul', 'Curnow','M','American',50000,'MD','Dermatologists',03137),
       (2210,'Kathleen', 'McGrath','F','American',28000,'DO','Gastroenterology',01048),
       (2211,'Naif', 'Faisal','M','Saudi',32000,'MD,ABIM','Gastroenterology',01048), 
       (2212,'Sarah', 'Curnow','F','British',34000,'MD','Neurologists',06044),
       (2213,' Michael', 'Hayman','F','British',34000,'MD','Neurologists',06044),
       (2214,'Rania','Rasheed','F','Saudi',25000,'CNS,RDN','Nutrition Consultant',00203),
       (2215,'Rayoof','Khalid','F','Saudi',25000,'CNS','Nutrition Consultant',00203),
       (2216,'Saleh','Naif','M','Saudi',28000,'MBBS, FRANZCO','Ophthalmologist',00046),
       (2217,'Wendy ','Marshman','F','American',32000,' MBBS, MD, FRANZCO, FRACS','Ophthalmologist',00046),
       (2218,'Baseel','Tariq','M','Saudi',29000,'MBBS, FRANZCO','Ophthalmologist',00046),
       (2219,'Mariam','Shaker','F','Pakstani',31000,'ENT,MD','Otolaryngologist',02042),
       (2220,'Sam','Davies','M','American',36000,'ENT,MD','Otolaryngologist',02042),
       (2221,'Rada','Saleh','F','Saudi',30000,'DPT','Doctor Of Physical Therapy',00119),
       (2222,'Maha','Ali','F','Saudi',30000,'DPT','Doctor Of Physical Therapy',00119),
       (2223,'Adeel','Rakan','M','Saudi',34000,' Bachelors degree in Psychology,MSP ','Therpaist',01202),
       (2224,'Zaid','Marwan','M','Saudi',34000,'Bachelors degree in Psychology,MAP','Therpaist',01202),
       (2225,'John','Hutson' ,'M','British',45000,'MD','Surgeon',00058),
       (2226,'Juan','Bortagaray' ,'M','British',45000,'MD','Surgeon',00058),
       (2227,'Taraf','Abdelmohsen','F','Saudi',50000,'MD,FRACS','Surgeon',03137),
       (2228,'Dalal','Abdalmajeed','F','Saudi',48000,'MD,FAAP','Surgeon',03137),
       (2229,' David','Francis','M','American',53000,'BS,MD,DSc,FRACS, FAAP','Surgeon',04057),
       (2230,'Shahad','Waleed','F','Egyptian',43000,'MD,ABU','Urologist',04057),
       (2231,'Saber','Ramadan','M','Pakstani',33000,'MD','Urologist',04057),
       (2232,'Azurah','Sami','F','Egyptian',45000,'MD,GYN,REI','Gynaecologist',00130),
       (2233,'Mariam','Hussen','F','Saudi',44000,'MD,MIGS','Gynaecologist',00130),
       (2234,'Kayne','Cornelis','M','American',40000,'DDS,MSc,PHD','Orthodontists',03111),
       (2235,'Mashal','Abdulkarim','M','Saudi',40000,'BDSc, MDSc, MRACDS (Ortho), FRACDS','Orthodontists',03111),
       (2236,'Jumanah','Mohammed','F','Saudi',44000,'BDSc, MRACDS (GDP)','Dental',03111),
       (2237,'Ashraf','Hamad','M','Saudi',30000,' BHSc, MDent','Dental',03111),
       (2238,'Mohammed', 'Abdelrahman', 'M', 'Saudi',54000, 'MD', 'Nephrologist',06044),
       (2239,'Ling', 'Chen', 'F', 'Chinese',54000, 'MD', 'Nephrologist',06044),
       (2240,'Rashed','Zyad','M','Saudi',51000,'MD','Oncologist',03045),
       (2241,'Reem','Yousef','F','Saudi',50000,'MD','Oncologist',03045);

    
INSERT INTO Nurse
VALUES
    (123201, 'Emily', 'Johnson', 'F', 'American', 20000, 'Certified Registered Nurse Anesthetist', 03208),-- Anesthetics department
    (123202, 'Michael', 'Garcia', 'M', 'American', 22000, 'Certified Registered Nurse Anesthetist', 03208),
    (125801, 'Sophia', 'Jad', 'F', 'Egyptian', 22000, 'Certified Cardiac Nurse', 00058), -- Cardiology department
    (125802, 'Nada', 'Osamah', 'F', 'Saudi', 21000, 'Certified Cardiac Nurse', 00058),
    (125501, 'Loui', 'Abdelkader', 'M', 'Saudi', 25000, 'Certified Hematology Nurse', 02055), -- Hematology department
    (125502, 'Husham', 'Fars', 'M', 'Saudi', 26000, 'Certified Hematology Nurse', 02055),
    (125701, 'Amal', 'Ameer', 'F', 'Saudi', 24000, 'Certified Urology Nurse', 04057), -- Urology department
    (125702, 'Hazm', 'Adeeb', 'M', 'Saudi', 22000, 'Certified Urology Nurse', 04057),
    (123001, 'Rama', 'Ali', 'F', 'Egyptian', 26000, 'Certified Gynecology Nurse', 00130),-- Gynecology department
    (123002, 'Joury', 'Hani', 'F', 'Saudi', 24000, 'Certified Gynecology Nurse', 00130),
    (123701, 'Ahad', 'Yousef', 'F', 'Saudi', 24000, 'Certified Dermatology Nurse', 03137),  -- Dermatology department
    (123702, 'Maria', 'Mazn', 'F', 'Saudi', 21000, 'Certified Dermatology Nurse', 03137),
    (124601, 'Mazn', 'Hmood', 'M', 'Saudi', 23000, 'Certified Ophthalmic Nurse', 00046), -- Ophthalmology department
    (124602, 'Aram', 'Abdulaziz', 'F', 'Saudi', 22000, 'Certified Ophthalmic Nurse', 00046),
    (124801, 'Draa', 'Talal', 'F', 'Saudi', 22000, 'Certified Gastroenterology Nurse', 01048),    -- Gastroenterology department
    (124802, 'Abdelkader', 'Aimen', 'M','Saudi', 25000, 'Certified Gastroenterology Nurse', 01048),
    (124201, 'Mashal', 'Hussen', 'M', 'Saudi', 23000, 'Certified Otolaryngology Nurse', 02042),-- Otolaryngology department
    (124202, 'Sarah', 'Saleh', 'F', 'Saudi', 23000, 'Certified Otolaryngology Nurse', 02042),
    (124501, 'Ghadi', 'Ahmed', 'F', 'Saudi', 20000, 'Certified Oncology Nurse', 03045),-- Oncology department
    (124502, 'Albtool', 'Eyad', 'F', 'Saudi', 21000, 'Certified Oncology Nurse', 03045),
    (124401, 'Fouz', 'Ibrahiam', 'F', 'Saudi', 22000, 'Certified Neurology Nurse', 06044),-- Neurology department
    (124402, 'Selena', 'Smith', 'F', 'American', 20000, 'Certified Neurology Nurse', 06044),
    (120301, 'Emma', 'Gomez', 'F', 'American', 21000, 'Certified Nutrition and Dietetics Nurse', 00203),-- Nutrition and Dietetics department
    (120302, 'Emily', 'Johnson', 'F','American', 23000, 'Certified Nutrition and Dietetics Nurse', 00203),
    (120201, 'Sophia', 'Khan', 'F', 'Pakistani', 23000, 'Certified Psychiatric Nurse', 01202),-- Psychiatry department
    (120202, 'Ariana', 'Smith', 'F', 'American', 21000, 'Certified Psychiatric Nurse', 01202),
    (121101, 'Maria', 'Chang', 'F', 'Chinese', 22000, 'Certified Dental Nurse', 03111),-- Dentistry department
    (121102, 'Michael', 'Nguyen', 'M', 'Vietnamese', 23000, 'Certified Dental Nurse', 03111),
    (121901,'Hazza','Faisal','M','Saudi',22000,'Certified Physiotherapy Nurse',00119),
    (121902,'Husham','Hussen','M','Saudi',22000,'Certified Physiotherapy Nurse',00119);

    

    
INSERT INTO MedicalRecord 
VALUES
    (9901, 'Fractured arm', 'Apply cast for 6 weeks', 110101, 2221),
    (9902, 'Acne', 'Positive progress.Needs Blood Test for Checkup', 110102, 2208),
    (9903, 'Anemia', 'Iron supplements and dietary changes', 110103, 2206),
    (9904, 'Depression', 'Increase the number of sessions due to negative progress', 110104, 2223),
    (9905, 'Hypertension', 'Prescribe antihypertensive medication', 110105, 2207),
    (9906,'Appendicitis', 'Surgical removal of appendix', 110106, 2210),
    (9907, 'Chronic sinusitis', 'he patient presents with symptoms of chronic sinusitis. Treatment includes antibiotics, nasal corticosteroids, and saline nasal irrigation. Follow up in weeks for reassessment', 110107, 2220),
    (9908, 'Minor burn', 'Clean and dress wound, prescribe pain relief', 110108, 2209),
    (9909, 'LASIK', 'Rest and avoid the light',110118, 2217), 
    (9910, 'Birth', ' Prenatal vitamins for breastfeeding support, Pain medication for postpartum discomfort,Iron supplements to replenish iron levels after childbirth.', 110110, 2233),
    (9911, 'Cows milk allergyp', 'More Blood test', 110111, 2211), 
    (9912, 'Fractured leg', 'Surgery followed by physical therapy', 110112, 2222),
    (9913, 'Heart attack', 'Emergency angioplasty and medication', 110113, 2201),
    (9914, 'Arthritis', 'Pain management and physical therapy', 110114, 2221),
    (9915, 'Kidney stones', 'Pain relief and hydration therapy', 110115, 2238),
    (9916, 'Dental checkup', 'Removal of a baby tooth', 110116, 2236),
    (9917, 'Overwieght', 'Sleeve gastrectomy', 110117, 2214),
    (9918, 'Dental checkup', 'Routine examination and cleaning', 110109, 2237),
    (9919, 'Alopecia ', ' 3 Cortisone Sessions', 110119, 2208),
    (9920, 'Gastroenteritis', 'Fluid replacement and symptomatic treatment', 110120, 2210);

INSERT INTO Radiology
VALUES
    (1, 9901, 110101, 'X-ray_fractured_arm.jpg', '2024-01-16'),
    (2, 9912, 110112, 'X-ray_fractured_leg.jpg', '2024-01-15'),
    (3, 9905, 110105, 'CT_scan_head.jpg', '2024-02-20'),
    (4, 9906, 110106, 'X-ray_appendicitis.jpg', '2024-03-10'),
    (5, 9907, 110107, 'CT_Scan_Paranasal_Sinuses.pdf', '2024-03-05'),
    (6, 9915, 110115, 'Ultrasound_kidney_stones.jpg', '2024-04-05');


INSERT INTO ClinicalLaboratory 
VALUES
    (4401, 9902, 110102, 'Blood_test_acne.jpg', '2024-01-20'),
    (4402, 9911, 110111, 'Blood_test_infant.jpg', '2024-02-25'),
    (4403, 9917, 110117, 'Blood_test_surgery.jpg', '2024-03-05'),
    (4404,9910,110110,'Blood_Test_Results.pdf','2024-5-6');


INSERT INTO Appointments 
VALUES
    ('2024-01-16', '08:00:00', 2221, 110101, 00119), 
    ('2024-10-20', '10:30:00', 2208, 110102, 03137), 
    ('2024-09-05', '14:00:00', 2237, 110109, 03111), 
    ('2024-04-10', '09:15:00', 2236, 110116, 03111), 
    ('2024-05-15', '11:30:00', 2214, 110117, 00203), 
    ('2024-11-25', '13:45:00', 2208, 110119, 03137), 
    ('2024-12-15', '15:00:00', 2217, 110118, 00046),
    ('2024-08-30', '08:30:00', 2238, 110115, 06044),
    ('2024-06-20', '11:00:00', 2211, 110111, 01048),
    ('2024-5-13', '14:30:00', 2233, 110110, 00130),
    ('2024-11-15', '10:00:00', 2210, 110120, 01048); 


INSERT INTO Pharmacy
VALUES 
    (1001, 110101, 000.00, 2221, 'Painkillers and antibiotics', '2024-01-16'),
    (1002, 110102, 000.00, 2208, 'Accutane', '2024-10-20'),
    (1003, 110103, 000.00, 2206, 'Iron supplements', '2024-03-05'),
    (1004, 110114, 000.00, 2221, 'Pain relief ointment and medication', '2024-04-10'),
    (1005, 110118, 50.00, 2217, 'Eyes drop', '2024-12-15'),
    (1006, 110111, 00.00, 2211, 'Neocate LCP', '2024-06-20'),
    (1007, 110119, 00.00, 2208, 'Regaine', '2024-11-25'),
    (1008, 110104, 100.00, 2223, 'antidepressants', '2024-08-30'),
    (1009, 110109, 000.00, 2237, 'Dental hygiene products', '2024-09-05'),
    (1010, 110106, 00.00, 2210, 'Pain relief cream ', '2024-10-10'),
    (1011, 110112, 90.00, 2222, 'Pain medicationn', '2024-11-15');


INSERT INTO PatientFeedback 
VALUES
    (7701, 110101, 5, 'No Suggestions', '2024-01-18'),
    (7702, 110102, 5, 'No Suggestions.', '2024-10-25'),
    (7703, 110107, 3, 'Waiting time was a bit long, but overall satisfied with treatment.', '2024-03-08'),
    (7704, 110114, 4, 'No Suggestions.', '2024-04-10'),
    (7705, 110118, 2, 'Would appreciate more detailed explanations from the doctor.', '2024-12-16'),
    (7706, 110119, 5, 'No Suggestions', '2024-11-29'),
    (7707, 110113, 4, 'Improved signage needed within the hospital.', '2024-07-27'),
    (7708, 110115, 3, 'Would like more comfortable waiting areas.', '2024-09-3'),
    (7719, 110106, 4, 'No Suggestions', '2024-10-12'),
    (7710, 110120, 2, 'Suggest providing more amenities for chemotherapy patients.', '2024-11-17');



-------------NEW INSERT---------------
       update Patient
       set Allergies ='Milk'
       where PatientID = 110117;

       
insert into Patient
values(110121,'Haya','Rasheed',45,'F','050743296834','Talal Turki','No Allergies','No Insurance','A+'),
  (110122,'Nawaf','Rakan',12,'M','0501693371','Rakan Naif','Fish','222-934-848','B+'),
       (110123,'Luna','Sultan',5,'F','0505587433','Lana Ahemed','No Allergies','111-021-001','B+'),
       (110124,'Yahya','Bader',20,'M','0505624354','Bader Zaid','Sesame Seeds','757-983-003','AB+'),
       (110125,'Sattam','Salman',34,'M','0505395532','Muneraah Salman','Sesame Seeds','No Insurance','A-'),
       (110126,'Huda','Tamim',18,'F','0508974693','Tamim Nasser','Bananas','No Insurance','B+'),
       (110127,'Osamah','Husham',35,'M','0505983665','Drra Husham','Eggs','No Insurance','A+'),
       (110128,'Fahad','Abdulaziz',18,'M','0505564422','Abdulaziz Saleh','Kiwis','637-098-092','AB+'),
       (110129,'Asmaa','Omar',49,'F','0553893275','Kadi Ibrahiam','No Allergies','983-993-001','AB+'),
       (110130,'Hussam','Ibrahiam',10,'M','0553893275','Asmaa Omar','Kiwis','983-993-001','B+'),
       (110131,'Yousef','Majed',49,'M','0509712764','Majed Yousef','No Allergies','No Insurance','A+'),
       (110132,'Maha','Ibrahiam',25,'F','0557632211','Ibrahiam Nawaf','Peanut','No Insurance','O+'),
       (110133,'Khalid','Abdelrahman',29,'M','0505067433','Abdelrahman Saud','Peanut','999-878-444','O+'),
       (110134,'Saud','Fars',75,'M','0505058988','Farah Fars','No Allergies','No Insurance','B+'),
       (110135,'Farah', 'Isa',18,'F','0505999887','Isa Mohammed','Peanut','999-000-123','O+'),
       (110136,'Marwan','Malk',32,'M','0509871234','Malk Mohammed','No Allergies','No Insurance','B+'),
       (110137,'Lama','Abdullah',17,'F','0508932278','Abdullah Saud','Strawberries','876-999-003','AB+'),
       (110138,'Hussa','Tariq',53,'F','0508974666','Dania Fars','No Allergies','No Insurance','O+'),
       (110139,'Suleiman','Hamed',27,'M','0500057489','Hamed Rakan','Strawberries','No Insurance','B-'),
       (110140,'Saad','Malk',16,'M','0509876432','Malk Khalid','Peanut','No Insurance','A+');



INSERT INTO MedicalRecord 
VALUES(9921,'Cavity', 'Tooth filling procedure scheduled for next week.',110132,2237),
    (9922,'Dental checkup', 'Routine examination and cleaning',110128,2237),
    (9923,'Fractured arm', 'Apply cast for 6 weeks',110139,2221),
    (9924,'Dental checkup', 'Routine examination and cleaning',110130,2237),
    (9925,'LASIK', 'Rest and avoid the light',110126,2218),
    (9926,'LASIK', 'Rest and avoid the light',110124,2217),
    (9927,'Anemia', 'Iron supplements and dietary changes',110122,2206),
    (9928,'Alopecia ', ' 3 Cortisone Sessions',110137,2208),
    (9929,'Eczema', 'Topical corticosteroids and moisturizers.',110136,2208),
    (9930,'Celiac Disease', 'Gluten-free diet and nutritional supplements.',110125,2211),
    (9931,'Celiac Disease', 'Gluten-free diet and nutritional supplements.',110127,2210),
(9932,'Celiac Disease', 'Gluten-free diet and nutritional supplements.',110138,2210);



-----------NEW DATABASE--------------

DELETE PatientFeedback;
delete Pharmacy;
delete Appointments;
DELETE ClinicalLaboratory;
DELETE Radiology;


 INSERT INTO Radiology 
 VALUES
(1, 9901, 110101, 'X-ray_fractured_arm.jpg', '2024-01-16'),
 (2, 9912, 110112, 'X-ray_fractured_leg.jpg', '2024-01-15'),
 (3, 9905, 110105, 'CT_scan_head.jpg', '2024-02-20'),
 (4, 9906, 110106, 'X-ray_appendicitis.jpg', '2024-03-10'),
(5, 9907, 110107, 'CT_Scan_Paranasal_Sinuses.pdf', '2024-03-05'),
(6, 9915, 110115, 'Ultrasound_kidney_stones.jpg', '2024-03-30'),
 (7 ,9923, 110139, 'X-ray_fractured_arm.jpg', '2024-03-16');


INSERT INTO Appointments
 VALUES
('2024-01-16', '08:00:00', 2221, 110101, 00119),
('2024-1-20', '10:30:00', 2208, 110102, 03137),
('2024-03-30', '14:00:00', 2237, 110109, 03111), 
('2024-01-10', '09:15:00', 2236, 110116, 03111), 
('2024-02-29', '11:30:00', 2214, 110117, 00203), 
('2024-1-20', '13:45:00', 2208, 110119, 03137),
('2024-02-29', '15:00:00', 2217, 110118, 00046),
('2024-03-30', '08:30:00', 2238, 110115, 06044),
('2024-01-20', '11:00:00', 2211, 110111, 01048),
('2024-2-22', '14:30:00', 2233, 110110, 00130),
('2024-03-15', '10:00:00', 2210, 110120, 01048), 
('2024-03-16','10:00:00',2221,110139,00119),
('2024-06-27','08:30:00',2224,110140,01202),--
('2024-06-27','9:30:00',2224,110119,01202),
('2024-06-27','11:00:00',2224,110136,01202),
('2024-06-27','9:30:00',2208,110133,03137),---
('2024-06-27','9:30:00',2201,110116,00058),
('2024-05-17','13:00:00',2237,110132,03111),
('2024-05-17','13:00:00',2222,110134,00119),--
('2024-05-17','14:30:00',2222,110131,00119),--
('2024-05-17','17:00:00',2209,110121,03137),---
('2024-05-17','14:30:00',2212,110129,06044),---
('2024-06-06','9:00:00',2212,110135,06044),
('2024-06-06','17:00:00',2209,110123,03137),---
('2024-06-06','16:00:00',2209,110110,03137),
('2024-06-06','9:00:00',2226,110113,00058),
('2024-03-30','15:30:00',2237,110132,03111),--------------------------------
('2024-03-30','12:30:00',2237,110128,03111),
('2024-03-30','17:00:00',2237,110130,03111),
('2024-03-30','12:30:00',2221,110114,00119),
('2024-02-29','12:00:00',2217,110124,00046),
('2024-02-29','12:00:00',2208,110137,03137),
('2024-02-29','11:30:00',2218,110126,00046),
('2024-02-29','11:30:00',2210,110138,01048),
('2024-3-15','11:30:00',2210,110127,01048),
('2024-3-15','10:30:00',2211,110125,01048);



INSERT INTO ClinicalLaboratory 
VALUES
 (4401, 9902, 110102, 'Blood_test_acne.jpg', '2024-01-20'),
(4402, 9911, 110111, 'Blood_test_infant.jpg', '2024-01-20'),
(4403, 9917, 110117, 'Blood_test_surgery.jpg', '2024-02-29'),
(4404,9910,110110,'Blood_Test_Results.pdf','2024-2-22');



INSERT INTO Pharmacy 
VALUES
 (1001, 110101, 000.00, 2221, 'Painkillers and antibiotics', '2024-01-16'),
 (1002, 110102, 000.00, 2208, 'Accutane', '2024-1-20'),
 (1003, 110103, 000.00, 2206, 'Iron supplements', '2024-03-05'),
 (1004, 110114, 000.00, 2221, 'Pain relief ointment and medication', '2024-04-10'),
 (1005, 110118, 50.00, 2217, 'Eyes drop', '2024-02-29'),
 (1006, 110111, 00.00, 2211, 'Neocate LCP', '2024-01-20'),
 (1007, 110119, 00.00, 2208, 'Regaine', '2024-1-20'),
 (1008, 110104, 100.00, 2223, 'antidepressants', '2024-08-30'),
 (1009, 110109, 000.00, 2237, 'Dental hygiene products', '2024-03-30'),
 (1010, 110106, 00.00, 2210, 'Pain relief cream ', '2024-03-10'),
 (1011, 110112, 90.00, 2222, 'Pain medicationn', '2024-11-15');



INSERT INTO PatientFeedback 
VALUES
 (7701, 110101, 5, 'No Suggestions', '2024-01-18'),
(7702, 110102, 5, 'No Suggestions.', '2024-1-25'),
(7703, 110107, 3, 'Waiting time was a bit long, but overall satisfied with treatment.', '2024-03-08'),
(7704, 110114, 4, 'No Suggestions.', '2024-04-10'),
(7705, 110118, 2, 'Would appreciate more detailed explanations from the doctor.', '2024-02-29'),
(7706, 110119, 5, 'No Suggestions', '2024-01-20'),
(7707, 110113, 4, 'Improved signage needed within the hospital.', '2024-01-27'),
(7708, 110115, 3, 'Would like more comfortable waiting areas.', '2024-03-30'),
(7719, 110106, 4, 'No Suggestions', '2024-03-10'),
(7710, 110120, 2, 'Suggest providing more amenities for chemotherapy patients.', '2024-01-17');
       
       
       
        

