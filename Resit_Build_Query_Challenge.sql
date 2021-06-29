/*
TASK 1:

SUBJECT (SubjCode, Description)
PK (SubjCode)

TEACHER (StaffID, Surname, GivenName)
PK (StaffID)

STUDENT (StudentID, Surname, GivenName, Gender)
PK (StudentID)

SUBJECTOFFERING (SubjCode, Year, Semester, Fee, StaffID)
PK (SubjCode, Year, Semester)
FK (SubjCode) REF SUBJECT
FK (StaffID) REF TEACHER

ENROLMENT (SubjCode, Year, Semester, StudentID, DateEnrolled, Grade)
PK (SubjCode, Year, Semester, StudentID)
FK (SubjCode, Year, Semester) REF SUBJECTOFFERING
FK (StudentID) REF STUDENT
*/

-- TASK 2:

CREATE TABLE SUBJECT (
    SubjCode    NVARCHAR(100)
   ,Description NVARCHAR(500)
   ,PRIMARY KEY (SubjCode)
)

CREATE TABLE TEACHER (
    StaffID     INT CHECK(LEN(StaffID)=8)
   ,Surname     NVARCHAR(100) NOT NULL
   ,GivenName   NVARCHAR(100) NOT NULL
   ,PRIMARY KEY (StaffID) 
);

CREATE TABLE STUDENT (
    StudentID   NVARCHAR(10)
   ,Surname     NVARCHAR(100) NOT NULL
   ,GivenName   NVARCHAR(100) NOT NULL
   ,Gender      NVARCHAR(1) CHECK (GENDER IN ('M', 'F', 'I'))
   ,PRIMARY KEY (StudentID)
)

CREATE TABLE SUBJECTOFFERING (
    SubjCode    NVARCHAR(100)
   ,Year        INT CHECK(LEN(Year)=4)
   ,Semester    INT CHECK (Semester IN (1,2))
   ,Fee         MONEY CHECK (Fee > 0) NOT NULL
   ,StaffID     INT CHECK(LEN(StaffID)=8)
   ,PRIMARY KEY (SubjCode, Year, Semester)
   ,FOREIGN KEY (SubjCode) REFERENCES SUBJECT
) 

CREATE TABLE ENROLMENT (
    StudentID   NVARCHAR(10)
   ,SubjCode    NVARCHAR(100)
   ,Year        INT CHECK(LEN(Year)=4)
   ,Semester    INT CHECK (Semester IN (1,2))
   ,Grade       NVARCHAR(2) CHECK (Grade IN ('N', 'P', 'C', 'D', 'HD'))
   ,DateEnrolled    DATE
   ,PRIMARY KEY (SubjCode, Year, Semester, StudentID)
   ,FOREIGN KEY (SubjCode, Year, Semester) REFERENCES SUBJECTOFFERING
   ,FOREIGN KEY (StudentID) REFERENCES STUDENT  
)

-- SELECT * FROM Subject
-- SELECT * FROM TEACHER
-- SELECT * FROM STUDENT
-- SELECT * FROM SUBJECTOFFERING
-- SELECT * FROM ENROLMENT

-- TASK 3:
INSERT INTO SUBJECT (SubjCode, Description) VALUES 
    ('ICTPRG418', 'Apply SQL to extract & manipulate data'),
    ('ICTBSB430', 'Create Basic Databases'),
    ('ICTDBS205', 'Design a Database');

INSERT INTO TEACHER (StaffID, Surname, GivenName) VALUES
    (98776655, 'Young', 'Angus'),
    (87665544, 'Scott', 'Bon'),
    (76554433, 'Slade', 'Chris');

INSERT INTO STUDENT (StudentID, Surname, GivenName, Gender) VALUES
    ('s12233445', 'Baird', 'Tim', 'M'),
    ('s23344556', 'Nguyen', 'Anh', 'M'),
    ('s34455667', 'Hallinan', 'James', 'M'),
    ('s103547416', 'Diaz', 'Daniel', 'M');


INSERT INTO SUBJECTOFFERING (SubjCode, Year, Semester, Fee, StaffID) VALUES
    ('ICTPRG418', 2019, 1, 200, 98776655),
    ('ICTPRG418', 2020, 1, 225, 98776655),
    ('ICTBSB430', 2020, 1, 200, 87665544),
    ('ICTBSB430', 2020, 2, 200, 76554433),
    ('ICTDBS205', 2019, 2, 225, 87665544);

INSERT INTO ENROLMENT (StudentID, SubjCode, Year, Semester, Grade, DateEnrolled) VALUES
    ('s12233445', 'ICTPRG418', 2019, 1, 'D', '02/25/2019'),
    ('s23344556', 'ICTPRG418', 2019, 1, 'P', '02/15/2019'),
    ('s12233445', 'ICTPRG418', 2020, 1, 'C', '01/30/2020'),
    ('s23344556', 'ICTPRG418', 2020, 1, 'HD', '02/26/2020'),
    ('s34455667', 'ICTPRG418', 2020, 1, 'P', '01/28/2020'),
    ('s12233445', 'ICTBSB430', 2020, 1, 'C', '02/08/2020'),
    ('s23344556', 'ICTBSB430', 2020, 2, NULL, '06/30/2020'),
    ('s34455667', 'ICTBSB430', 2020, 2, NULL, '07/03/2020'),
    ('s23344556', 'ICTDBS205', 2019, 2, 'P', '07/01/2019'),
    ('s34455667', 'ICTDBS205', 2019, 2,	'N', '07/13/2019');

