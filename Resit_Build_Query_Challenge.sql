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
    StaffID             INT CHECK(LEN(StaffID)=8)
   ,TeacherSurname     NVARCHAR(100) NOT NULL
   ,TeacherGivenName   NVARCHAR(100) NOT NULL
   ,PRIMARY KEY (StaffID) 
);

CREATE TABLE STUDENT (
    StudentID          NVARCHAR(10)
   ,StudentSurname     NVARCHAR(100) NOT NULL
   ,StudentGivenName   NVARCHAR(100) NOT NULL
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
SELECT * FROM STUDENT
-- SELECT * FROM SUBJECTOFFERING
-- SELECT * FROM ENROLMENT

-- TASK 3:
INSERT INTO SUBJECT (SubjCode, Description) VALUES 
    ('ICTPRG418', 'Apply SQL to extract & manipulate data'),
    ('ICTBSB430', 'Create Basic Databases'),
    ('ICTDBS205', 'Design a Database');

INSERT INTO TEACHER (StaffID, TeacherSurname, TeacherGivenName) VALUES
    (98776655, 'Young', 'Angus'),
    (87665544, 'Scott', 'Bon'),
    (76554433, 'Slade', 'Chris');

INSERT INTO STUDENT (StudentID, StudentSurname, StudentGivenName, Gender) VALUES
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

-- TASK 4:

-- Query 1:
SELECT stu.StudentGivenName, stu.StudentSurname, e.SubjCode, sub.Description, e.Year, e.Semester, so.Fee, T.TeacherGivenName, T.TeacherSurname
FROM ENROLMENT e 
INNER JOIN SUBJECTOFFERING so 
ON e.SubjCode = so.SubjCode AND e.Year = so.Year AND e.Semester = so.Semester
INNER JOIN TEACHER T 
ON so.StaffID = T.StaffID
INNER JOIN STUDENT stu
ON e.StudentID = stu.StudentID
INNER JOIN SUBJECT sub
ON so.SubjCode = sub.SubjCode

-- Query 2:
SELECT Year, Semester, Count(*) AS 'Num Enrollments'
FROM ENROLMENT
GROUP BY Year, Semester

-- Query 3:
SELECT * FROM ENROLMENT E
INNER JOIN SUBJECTOFFERING S
ON E.SubjCode = S.SubjCode AND E.Year = S.Year AND E.Semester = S.Semester
WHERE S.Fee IN (SELECT MAX(Fee) FROM SUBJECTOFFERING)

-- TASK 5:
CREATE VIEW DETAILS AS 
    SELECT stu.StudentGivenName, stu.StudentSurname, e.SubjCode, sub.Description, e.Year, e.Semester, so.Fee, T.TeacherGivenName, T.TeacherSurname
    FROM ENROLMENT e 
    INNER JOIN SUBJECTOFFERING so 
    ON e.SubjCode = so.SubjCode AND e.Year = so.Year AND e.Semester = so.Semester
    INNER JOIN TEACHER T 
    ON so.StaffID = T.StaffID
    INNER JOIN STUDENT stu
    ON e.StudentID = stu.StudentID
    INNER JOIN SUBJECT sub
    ON so.SubjCode = sub.SubjCode

SELECT * FROM DETAILS

-- TASK 6
-- Task 4 Query 1 Test:
SELECT COUNT(*) FROM ENROLMENT
/* Query 1 shows 10 rows. When the test query is ran, it also returns 10. Therefore,
this verifies that it returns the correct enrolments */

-- Task 4 Query 2 Test:
SELECT COUNT(*) FROM ENROLMENT

/* Again, as there are 10 enrolments, the query displays the amount of enrolments in each
year and semseter. When added all together it sums up to 10. 2+4+2+2. */

-- Task 4 Query 3 Test:
SELECT MAX(Fee) FROM SUBJECTOFFERING
/* When the test query is ran, it retusn 225. This shows the highest fee in SUBJECTOFFERING.
The Fee column that is displayed is all 225, therefore displaying the correct resutls. */
