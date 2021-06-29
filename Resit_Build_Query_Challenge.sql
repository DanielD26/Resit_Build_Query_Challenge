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
