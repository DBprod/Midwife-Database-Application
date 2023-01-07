-- Include your INSERT SQL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.

-- Remember to put the INSERT statements for the tables with foreign key references
--    ONLY AFTER the parent tables!

-- Include your INSERT SQL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the INSERT statements for the tables with foreign key references
--    ONLY AFTER the parent tables!

INSERT INTO FATHERS (father_id, name, email, bday, blood_type, address, phonenumb, hcardid, c_profession) VALUES
 (1, 'dad1', 'dad1@gmail.com', '2000-11-11', 'O+', '123 street', '5141234321', 'DAD1HCARDQC', 'student')
,(2, 'dad2', 'dad2@gmail.com', '1995-11-11', 'B+', '12 street', '5141256321', 'DAD2HCARDQC', 'engineer')
,(3, 'dad3', 'dad3@gmail.com', '1988-11-11', 'A+', '1234 street', '5156234321', 'DAD3HCARDQC', 'teacher')
,(4, 'dad4', 'dad4@gmail.com', '1999-11-11', 'A+', '1 street', '5141256321', 'DAD4HCARDQC', 'finance')
,(5, 'dad5', 'dad5@gmail.com', '1979-11-11', 'B+', '13 street', '5141784321', 'DAD5HCARDQC', 'zoo keeper')
;


INSERT INTO MOTHERS (mother_id, name, email, bday, blood_type, address, phonenumb, hcardid, c_profession, last_menstrual_period) VALUES
 (1, 'Victoria Gutierrez', 'mom1@gmail.com', '2000-11-11', 'O+', '123 street', '5149876543', 'MOM1HCARDQC', 'student', '2022-01-29')
,(2, 'mom two', 'mom2@gmail.com', '1988-11-11', 'A+', '13 street', '5141236543', 'MOM2HCARDQC', 'teacher', '2022-01-28')
,(3, 'mom three', 'mom3@gmail.com', '1996-11-11', 'B+', '1233 street', '5143456543', 'MOM3HCARDQC', 'CEO', '2022-01-27')
,(4, 'mom four', 'mom4@gmail.com', '1984-11-11', 'A+', '1244 street', '5145676543', 'MOM4HCARDQC', 'CFO', '2022-02-14')
,(5, 'mom five', 'mom5@gmail.com', '2001-11-11', 'B+', '1234 street', '5148766543', 'MOM5HCARDQC', 'zoo keeper', '2022-02-07')
;

INSERT INTO PARENTS(parents_id, mother_id, father_id, num_of_pregnancies) VALUES
  (1, 1, 1, 3)
, (2, 2, 1, 1)
, (3, 3, 4, 1)
, (4, 4, 3, 2)
, (5, 5, 5, 9)
;

INSERT INTO HEALTHCAREINSTITUTION(institution_id, name, phone, email, address, website, type_of_institution) VALUES
 (1, 'St-Joseph', '5148766523', 'stj@gmail.com', '123 strait', 'stj.com', 'CC')
,(2, 'Pier Elliot', '5148766523', 'pe@gmail.com', '1234 strait', 'pe.com', 'BC')
,(3, 'CC2', '5148767523', 'cc2@gmail.com', '1434 strait', 'cc2.com', 'CC')
,(4, 'Lac-Saint-Louis', '5148767526', 'cc3@gmail.com', '1464 strait', 'cc3.com', 'CC')
,(5, 'BC2', '5148768523', 'bc2@gmail.com', '1334 strait', 'bc2.com', 'BC')
;

INSERT INTO MIDWIFE(wife_id, name, email, phone, institution_id) VALUES
(1, 'Marion Girard', 'w1@gmqil.com', 5148768588, 4)
,(2, 'wife2', 'w2@gmqil.com', '5148768558', 1)
,(3, 'wife3', 'w3@gmqil.com', '5148768538', 2)
,(4, 'wife4', 'w4@gmqil.com', '5148768528', 3)
,(5, 'wife5', 'w5@gmqil.com', '5148768518', 5)
,(6, 'wife6', 'w6@gmail.com', '5142367545', 4)
;

INSERT INTO INFOSESSION(session_id, sdate, stime, slang, wife_id) VALUES
(1, '2021-01-20','2021-01-20 13:23:44','english', 1)
,(2, '2021-01-10','2021-01-10 13:23:44','french', 2)
,(3, '2021-01-03','2021-01-03 13:23:44', 'french',3)
,(4, '2021-01-23','2021-01-23 13:23:44', 'french',4)
,(5, '2021-01-22','2021-01-22 13:23:44', 'french',4)
;

INSERT INTO PREGNANCY(pregnancy_id, parents_id, numBabies, numMotherPriorPreg) VALUES
(1, 1, 1, 0)
,(2, 2, 1, 0)
,(3, 3, 1, 0)
,(4, 4, 1, 0)
,(5, 5, 1, 0)
,(6, 1, 2, 1)
;

INSERT INTO CHILD(child_id, name, gender, blood_type, date_time_of_birth,expected_time_frame, pregnancy_id) VALUES
(1, 'c1','boy','O+','2021-01-22 10:10:00','2021-01',1)
,(2, 'c2',NULL,NULL,NULL,'2022-09',2)
,(3, 'c3',NULL,NULL,NULL,'2022-07',3)
,(4, 'c4',NULL,NULL,NULL,'2022-06',4)
,(5, 'c1','boy','O+','2021-04-22 10:10:00','2021-04',5)
,(6, 'c6',NULL,NULL,NULL,'2022-07',6)
,(7,'c7', NULL,NULL,NULL,'2022-07',6)
;


INSERT INTO DUEDATE(dueDateId, dueDate, isExpectedDate, child_id) VALUES
(1, '2021-01-22', true, 1)
, (2, '2022-07-22', true, 2)
, (3, '2022-07-22', false, 3)
, (4, '2022-09-22', true, 4)
, (5, '2022-04-22', true, 5)
, (6, '2022-08-10', false, 6)
, (7, '2022-08-10', false, 6)
;


INSERT INTO ASSIGNEDWIVES(wife_id, pregnancy_id, isPrimary) VALUES
(1,1, true)
,(1,6, true)
,(2,2, true)
,(2,1, false)
,(2,6, false)
,(1,3, true)
,(4,4, true)
,(5,5, true)
;


INSERT INTO APPOINTMENTS(appt_id,adate,time,wife_id,pregnancy_id) VALUES
(1,'2022-03-22', '2022-03-22 10:00:00', 1, 1)
,(2,'2022-03-24', '2022-03-22 10:00:00', 1, 6)
,(3,'2022-03-24', '2022-03-22 10:00:00', 2, 2)
,(4,'2022-03-24', '2022-03-22 10:00:00', 3, 3)
,(5,'2022-03-24', '2022-03-22 10:00:00', 4, 4)
,(6,'2022-06-24', '2022-06-22 10:00:00', 1, 6)
;


INSERT INTO TEST(test_id, appt_id, test_date, sample_date, testType, testResult, blood_work_date, isForBaby, tec_num, tec_id, tec_name) VALUES
(1,2,'2022-03-28','2022-03-28', 'blood iron', 'All good', '2022-03-28', false, 123, 32, 'Josh')
,(2,6,'2022-05-28','2022-08-28', 'blood iron', 'All good', '2022-08-28', false, 123, 32, 'Josh')
,(3,3,'2022-05-28','2022-08-28', 'blood work', 'All good', '2022-08-28', false, 123, 32, 'Josh')
,(4,4,'2022-05-28','2022-08-28', 'blood work', 'All good', '2022-08-28', false, 123, 32, 'Josh')
,(5,5,'2022-05-28','2022-08-28', 'blood work', 'All good', '2022-08-28', false, 123, 32, 'Josh')
;


INSERT INTO NOTES(note_id, appt_id, time, description) VALUES
(1,1,'2022-05-22 10:00:00', 'keep an eye on baby blood')
,(2,6,'2022-05-22 10:00:00', 'keep an eye on baby blood')
,(3,6,'2022-05-22 10:30:00', 'keep an eye on mom blood')
,(4,4,'2022-05-22 10:30:00', 'keep an eye on mom blood')
,(5,5,'2022-05-22 10:30:00', 'keep an eye on dad blood')
;







