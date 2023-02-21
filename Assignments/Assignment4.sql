-- Active: 1671688949427@@127.0.0.1@3308@assignments1

CREATE DATABASE IF NOT EXISTS school CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE student 
(
    SID INTEGER(5),
    S_FName VARCHAR(20) NOT NULL,
    S_LName VARCHAR(30) NOT NULL ,
    CONSTRAINT `PK_student` PRIMARY KEY (SID) 
);

CREATE TABLE Course 
(
    CID INTEGER(6),  
    C_Name VARCHAR(30) NOT NULL,
    CONSTRAINT `PK_course` PRIMARY KEY (CID)
);


CREATE TABLE Course_Grades  
(
    CGID INTEGER(7), 
    Semester CHAR(4) NOT NULL, 
    CID INTEGER(6) NOT NULL, 
    SID INTEGER(5) NOT NULL, 
    Grade CHAR(2) NOT NULL, 
    CONSTRAINT `PK_Course` PRIMARY KEY (CGID),
    CONSTRAINT `FK_Course_cg` FOREIGN KEY(CID) REFERENCES course(CID),
    CONSTRAINT `FK_student_cg` FOREIGN KEY(SID) REFERENCES student(SID)
);

-- INSERT
INSERT INTO  student(SID,S_FName,S_LName) VALUES
(12345,"Chris","Rock"),
(23456,"Chris","Farley"),
(34567,"David","Spader"),
(45678,"Liz","Lemon"),
(56789,"Jack","Donaghy");


INSERT INTO  course_grades(CGID,Semester,CID,SID,Grade) VALUES 
(2010101,"SP10",101005,34567,"D+"),
(2010308,"FA10",101005,34567,"A-"),
(2010309,"FA10",101001,45678,"B+"),
(2011308,"FA11",101003,23456,"B-"),
(2012206,"SU12",101002,56789,"A+");


INSERT INTO Course(CID,C_Name) VALUES
(101001,"Intro to Computer"),
(101002,"Programming"),
(101003,"Databases"),
(101004,"Websites"),
(101005,"IS Management");


--3 
ALTER TABLE student 
MODIFY column S_Fname VARCHAR(30);

--4 
ALTER TABLE Course 
ADD column Faculty_LName VARCHAR(30) DEFAULT "TBD" NOT NULL;

--5 
UPDATE course SET CID=101001 where Faculty_LName="Potter" and C_Name = "Intro to Wizadry";

--6 
ALTER TABLE course 
RENAME column C_Name TO Course_Name;

--7 
DELETE FROM course where Course_Name="Websites";

--8  
DROP TABLE student;


--9  
DELETE FROM course;


--10
ALTER TABLE course_grades
DROP FOREIGN KEY `FK_Course_cg`;

ALTER TABLE course_grades
DROP FOREIGN KEY `FK_student_cg`;