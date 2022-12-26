-- Active: 1671688949427@@127.0.0.1@3308@db_optimised
CREATE TABLE `student` (ID INT,NAME Varchar(20), DOB date);
CREATE TABLE `Student_phone`(ID INT, phone_number varchar(20));

INSERT INTO `student` values (101,"Rahul",'1999-4-3'),(102,'Mukul','2000-3-6');
INSERT INTO `student_phone` VALUES (101,'64364545'),(101,'345543533');
SELECT * FROM `student`;

-- Age
SELECT *, TIMESTAMPDIFF(YEAR, DOB,CURDATE()) 'AGE' FROM student;
CREATE VIEW Student_age AS SELECT ID,NAME, TIMESTAMPDIFF(YEAR, DOB,CURDATE()) 'AGE' FROM student;

Show tables;

desc student_age;
alter table student ADD (Street Varchar(20), CITY VARCHAR(20), Pincode Numeric(6));
UPDATE student SET street="1st main", city='Bangalore', PINCODE= 565415 WHERE id=101;

SELECT Name, CONCAT(STREET,',', CITY,',', PINCODE) 'ADDRESS' FROM student;
CREATE VIEW student_address_view AS SELECT id,name, CONCAT(STREET,',', CITY,',', PINCODE) 'ADDRESS' FROM student;

SELECT * FROM student_address_view;





