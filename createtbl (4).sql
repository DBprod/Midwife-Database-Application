-- Include your create table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the create table ddls for the tables with foreign key references
--    ONLY AFTER the parent tables has already been created.

CREATE TABLE FATHERS
(
	father_id INTEGER NOT NULL,
	name VARCHAR(50) NOT NULL,
	email VARCHAR(50),
	bday DATE NOT NULL,
	blood_type VARCHAR(15),
	address VARCHAR(80),
	phonenumb VARCHAR(30) NOT NULL,
	hcardid VARCHAR(50),
	c_profession VARCHAR(100) NOT NULL,
	PRIMARY KEY (father_id)
);

CREATE TABLE MOTHERS
(
	mother_id INTEGER NOT NULL,
        name VARCHAR(50) NOT NULL,
        email VARCHAR(50) NOT NULL,
        bday DATE NOT NULL,
        blood_type VARCHAR(15) NOT NULL,
        address VARCHAR(80) NOT NULL,
        phonenumb VARCHAR(30) NOT NULL,
        hcardid VARCHAR(50) NOT NULL,
        c_profession VARCHAR(100) NOT NULL,
	last_menstrual_period VARCHAR(100) NOT NULL,	
        PRIMARY KEY (mother_id)
);

CREATE TABLE PARENTS
(
	parents_id INTEGER NOT NULL,
	mother_id INTEGER NOT NULL,
	father_id INTEGER,
	num_of_pregnancies INTEGER NOT NULL,
	PRIMARY KEY (parents_id),
	FOREIGN KEY (mother_id) REFERENCES MOTHERS (mother_id) ON DELETE CASCADE,
	FOREIGN KEY (father_id) REFERENCES FATHERS (father_id) ON DELETE CASCADE
);


CREATE TABLE HEALTHCAREINSTITUTION
(
	institution_id INTEGER NOT NULL,
	name VARCHAR(80) NOT NULL,
	phone VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	address VARCHAR(80) NOT NULL,
	website VARCHAR(80) NOT NULL,
	type_of_institution VARCHAR(80) NOT NULL,
	PRIMARY KEY (institution_id)
);

CREATE TABLE MIDWIFE
(
	wife_id INTEGER NOT NULL,
	name VARCHAR(80) NOT NULL,
	email VARCHAR(80) NOT NULL,
	phone VARCHAR(80) NOT NULL,
	institution_id INTEGER NOT NULL,
	PRIMARY KEY (wife_id),
	FOREIGN KEY (institution_id) REFERENCES HEALTHCAREINSTITUTION (institution_id) ON DELETE CASCADE
);

CREATE TABLE INFOSESSION
(
	session_id INTEGER NOT NULL,
	sdate DATE NOT NULL,
	stime DATE NOT NULL,
	wife_id INTEGER NOT NULL,
	slang VARCHAR(20) NOT NULL,
	PRIMARY KEY (session_id),
	FOREIGN KEY (wife_id) REFERENCES MIDWIFE (wife_id)
);

CREATE TABLE InfoSessionRegistration
(
	session_id INTEGER NOT NULL,
	parents_id INTEGER NOT NULL,
	attended BOOLEAN NOT NULL,
	PRIMARY KEY (session_id, parents_id),
       	FOREIGN KEY (session_id) REFERENCES INFOSESSION (session_id) ON DELETE CASCADE,
	FOREIGN KEY (parents_id) REFERENCES PARENTS ON DELETE CASCADE
);

CREATE TABLE PREGNANCY
(
	pregnancy_id INTEGER NOT NULL,
	parents_id INTEGER NOT NULL,
	numBabies INTEGER NOT NULL,
	numMotherPriorPreg INTEGER NOT NULL,
	PRIMARY KEY (pregnancy_id),
	FOREIGN KEY (parents_id) REFERENCES PARENTS (parents_id) ON DELETE CASCADE
);

CREATE TABLE CHILD
(
	child_id INTEGER NOT NULL,
	name VARCHAR(80),
	gender VARCHAR(20),
	blood_type VARCHAR(50),
	date_time_of_birth DATE,
	expected_time_frame VARCHAR(10) NOT NULL,
	pregnancy_id INTEGER NOT NULL,
	PRIMARY KEY (child_id),
	FOREIGN KEY (pregnancy_id) REFERENCES PREGNANCY (pregnancy_id) ON DELETE CASCADE
);

CREATE TABLE DUEDATE
(
	dueDateId INTEGER NOT NULL,
	dueDate DATE NOT NULL,
	isExpectedDate BOOLEAN NOT NULL,
	child_id INTEGER NOT NULL,
	PRIMARY KEY (dueDateId),
	FOREIGN KEY (child_id) REFERENCES CHILD (child_id) ON DELETE CASCADE
);

CREATE TABLE ASSIGNEDWIVES
(
	wife_id INTEGER NOT NULL,
	pregnancy_id INTEGER NOT NULL,
	isPrimary BOOLEAN NOT NULL,
	PRIMARY KEY (wife_id, pregnancy_id),
	FOREIGN KEY (wife_id) REFERENCES MIDWIFE (wife_id) ON DELETE CASCADE,
	FOREIGN KEY (pregnancy_id) REFERENCES PREGNANCY (pregnancy_id) ON DELETE CASCADE
);

CREATE TABLE APPOINTMENTS
(
	appt_id INTEGER NOT NULL,
	adate DATE NOT NULL,
	time DATE NOT NULL,
	wife_id INTEGER NOT NULL,
	pregnancy_id INTEGER NOT NULL,
	PRIMARY KEY (appt_id),
	FOREIGN KEY (wife_id) REFERENCES MIDWIFE (wife_id) ON DELETE CASCADE,
	FOREIGN KEY (pregnancy_id) REFERENCES PREGNANCY (pregnancy_id) ON DELETE CASCADE
);

CREATE TABLE TEST
(
	test_id INTEGER NOT NULL,
	appt_id INTEGER NOT NULL,
	test_date DATE NOT NULL,
	sample_date DATE,
	testType VARCHAR(50) NOT NULL,
	testResult VARCHAR(50),
	blood_work_date DATE,
	isForBaby BOOLEAN NOT NULL,
	tec_num INTEGER,
	tec_id INTEGER,
	tec_name VARCHAR(50),
	PRIMARY KEY (test_id),
	FOREIGN KEY (appt_id) REFERENCES APPOINTMENTS (appt_id) ON DELETE CASCADE,
	CHECK(sample_date >= test_date)
);

CREATE TABLE NOTES
(
	note_id INTEGER NOT NULL,
	appt_id INTEGER NOT NULL,
	time DATE NOT NULL,
	description VARCHAR(100),
	PRIMARY KEY (note_id),
	FOREIGN KEY (appt_id) REFERENCES APPOINTMENTS (appt_id) ON DELETE CASCADE
);
