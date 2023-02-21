-- Active: 1671688949427@@127.0.0.1@3308@airlinetest

CREATE TABLE IF NOT EXISTS `person` (
    slno INT,
    name VARCHAR(55),
    place VARCHAR(50),
    dob date
);

SELECT GROUP_CONCAT(countryId) FROM countries;



INSERT INTO `person` VALUES(1002,'HITESH','DELHI','2000-05-01'), (1001,'RITESH','MUMBAI','1998-07-12'),(1005,'BALAN','KOCHI','1999-11-05');


--A
SELECT tablespace_name, file_name FROM information_schema.files WHERE tablespace_name LIKE 'hr/p%';

--B
SELECT * FROM person WHERE slno=1001;

--C
EXPLAIN SELECT * FROM person WHERE slno=1001;
EXPLAIN FORMAT=TREE SELECT * FROM person WHERE slno=1001;

--D
CREATE INDEX IX_slno ON person (slno);
EXPLAIN FORMAT=TREE SELECT * FROM person WHERE slno=1001;

--E
ALTER TABLE person ADD PRIMARY KEY (slno);

EXPLAIN FORMAT=TREE SELECT * FROM person WHERE slno=1001;




--2
--a
SELECT l.city,r.region_name,c.country_name, l.location_id
FROM countries c
INNER JOIN locations l USING (country_id)
INNER JOIN regions r USING (region_id)
WHERE country_name = 'INDIA' AND country_name='BRAZIL';

--b
EXPLAIN FORMAT=TREE SELECT l.city,r.region_name,c.country_name, l.location_id
FROM countries c
INNER JOIN locations l USING (country_id)
INNER JOIN regions r USING (region_id)
WHERE country_name IN ('INDIA','BRAZIL');



--c

CREATE TABLE employees_part (employee_id INT,first_name VARCHAR(20), salary INT, Job_id VARCHAR(20))
PARTITION BY RANGE(salary)
(
    PARTITION P_1 VALUES LESS THAN (6000),
    PARTITION P_2 VALUES LESS THAN (12000),
    PARTITION P_3 VALUES LESS THAN (17000),
    PARTITION P_MAX VALUES LESS THAN MAXVALUE
);

--d
INSERT INTO employees_part SELECT employee_id, first_name, salary, `Job_id` FROM employees;

EXPLAIN SELECT * FROM employees_part WHERE salary BETWEEN 12000 AND 17000;

--Partitions Used: P_3, P_Max


--E
EXPLAIN FORMAT=TREE SELECT * FROM employees_part WHERE salary BETWEEN 12000 AND 17000;


--F
EXPLAIN FORMAT=TREE SELECT * FROM employees WHERE salary BETWEEN 12000 AND 17000;


--The difference after creating the Partition table is drastic. The cost on employee table is 10.95, where as for PARTITION Table is
--1.5, which is almost 9x. It is better to create PARTITIONS when we have a range of values to be queried from a large set of data.