/*
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

CREATE TABLE SUBJECT (
    SubjCode NVARCHAR(100)
   ,Description NVARCHAR(500)
   ,PRIMARY KEY (SubjCode)
)