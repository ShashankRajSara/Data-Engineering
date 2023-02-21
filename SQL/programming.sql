-- Active: 1671688949427@@127.0.0.1@3308@hr

--Procedures
CREATE PROCEDURE <PROCEDURE-NAME>()--Parameters;

-- BEGIN
--     Statements;
-- END $$

--first Procedure
DELIMITER $$
CREATE PROCEDURE pro_hr1()
BEGIN
    SELECT ('1st Procedure');
END $$

DELIMITER ;

CALL pro_hr1();


-- Parameters
DELIMITER $$
CREATE PROCEDURE pro_hr2(p1 int,p2 int)
BEGIN
    DECLARE vprod NUMERIC(11,2);
    SET vprod=p1*p2;
    SELECT CONCAT('Product of ',p1, ', ',p2, '=',vprod) 'Product';
END $$
DELIMITER ;

CALL pro_hr2(50,100);


--Create a PROCEDURE to pass employee_id as parameter and print salary for him
DELIMITER $$
CREATE PROCEDURE pro_hr3(p_empno INT)
BEGIN
    SELECT salary 'Salary of employee' FROM employees
    WHERE employee_id=p_empno;
END $$

CALL pro_hr3(143);


--Create a PROCEDURE to pass employee_id as parameter and print first_name, last_name, department_name

CREATE PROCEDURE pro_hr4(p_empid INT)
BEGIN   
    SELECT first_name, last_name, department_name
    FROM employees e JOIN departments d USING (department_id)
    WHERE employee_id=p_empid;
END $$

CALL pro_hr4(143);

--create a PROCEDURE to insert more rows in stages using loop and if elseif else
create Table odd_even(slno int PRIMARY KEY, descn ENUM('even','odd')) ;

CREATE PROCEDURE pro_hr5(p1 int,p2 int)
BEGIN
    DECLARE v1 VARCHAR(4);
    WHILE p1<p2 DO
        SET p1=p1+1;
        IF MOD(p1,2)=0 THEN
            SET v1='even';
        ELSE
            SET v1='odd';
        END IF;
    INSERT INTO odd_even VALUES (p1,v1);
    END WHILE;
END $$

DELIMITER ;

CALL pro_hr5(1,100);
CALL pro_hr5(500,10000);

SELECT * FROM odd_even;

-- create PROCEDURE to pass your birthdate as a parameter
-- print day of birth starting from birthdate upto current_date

CREATE TABLE dateday (birthday date, dayname1 VARCHAR(20))
DELIMITER $$
CREATE PROCEDURE pro_hr6(birthdate date)
BEGIN
    DECLARE bday VARCHAR(4);

    WHILE YEAR(birthdate)<YEAR(CURDATE()) DO            
        INSERT INTO dateday VALUES (birthdate,DAYNAME(birthdate));
        SET birthdate= DATE_ADD(birthdate, INTERVAL 1 YEAR);
    END WHILE;
END $$

CALL pro_hr6('1999-08-03');

SELECT * FROM dateday;
DELIMITER ;

--command to see routines
SELECT SPECIFIC_name, ROUTINE_type
FROM INFORMATION_SCHEMA.routines
WHERE routine_schema='hr';

DELIMITER $$
CREATE PROCEDURE pro_hr7(pno int)
BEGIN   
    DECLARE v1 NUMERIC(11,2);
    SELECT salary INTO v1 FROM employees WHERE employee_id = pno;
    IF v1 is NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT="**INVALID EMPNO**";
    END IF;
END $$

CALL pro_hr7(65146);

--procedure with parameters
CREATE PROCEDURE pro_hr6_out(IN p1 INT, OUT p2 VARCHAR(20))
BEGIN
    SELECT first_name INTO p2 FROM employees WHERE employee_id = p1;
END $$

DELIMITER ;

CALL pro_hr6_out(111,@p2);

SELECT @p2;

--inout with parameters
DELIMITER $$
CREATE PROCEDURE pro_hr7_inout(INOUT pname VARCHAR(50))
BEGIN
    SET pname=lpad(pname,40,'*');
END $$

DELIMITER ;

SET @pn='Shashank';
CALL pro_hr7_inout(@pn);
SELECT @pn;


--FUNCTIONs

--create function to pass employeeId as parameter, should return bonus
--SH_CLERK 1.5*salary, SA_REP 1.75*salary, MK_MAN 2.0*salary, others salary
DELIMITER $$
CREATE FUNCTION fun_hr1(p1 INT)
RETURNS NUMERIC(11,2)
DETERMINISTIC
BEGIN
    DECLARE v1 NUMERIC(11,2);
    DECLARE v2 NUMERIC(11,2);
    DECLARE v3 VARCHAR(20);
    SELECT job_id,salary INTO v3, v1 FROM employees WHERE employee_id=p1;
    IF v3='SH_CLERK' THEN
        SET v2=1.5*v1;
    ELSEIF v3='SA_REP' THEN
        SET v2=1.75*v1;
    ELSEIF v3='MK_MAN' THEN
        SET v2=2.0*v1;
    ELSE
        SET v2=v1;
    END IF;
    RETURN v2;
END $$

DELIMITER ;

SELECT job_id,salary, fun_hr1(employee_id) FROM employees;


--return employee, who worked on leap year
CREATE FUNCTION fun_hr3(p1 INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE v1 INT;
    DECLARE vleap VARCHAR(20);
    SELECT DATE_FORMAT(CONCAT(YEAR(hire_date),'-12-31'),'%j') INTO v1 
    FROM employees WHERE employee_id=p1;
    IF v1=366 THEN
        SET vleap='Leap Year';
    ELSE
        SET vleap='Not Leap Year';
    END IF;
    RETURN vleap;
END $$


SELECT hire_date,fun_hr3(employee_id) from employees;


--Employee Joining Bonus
-- On or before 15 of a Month will be paid joining bonus on the last friday after 1 year

-- 2022-01-15 => 2023-01-26 LAST FRIDAY

-- 2022-01-18 => 2023-02-26 LAST Friday




--TRIGGERS

--create a trigger to insert into retired table
--whenever delete happens on the employee table
CREATE TABLE retired( name varchar(30));

DELIMITER $$
CREATE TRIGGER trig_hr_del
BEFORE DELETE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO retired values(old.first_name);
END $$

DELIMITER ;
DELETE FROM employees WHERE employee_id=107;

SELECT * from retired;


----------------------------------------------------------------

CREATE TABLE data_table (slno INT PRIMARY KEY, date1 date );

DELIMITER $$
CREATE TRIGGER trig_hr_checkdate
BEFORE INSERT ON data_table
FOR EACH ROW
BEGIN
    IF new.date1>CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='**date1< CURDATE()**';
    END IF;
END $$

DELIMITER ;

INSERT INTO data_table VALUES (1,'2023-01-31');

SELECT * FROM data_table;

-- create a trigger to restrict the decrease in the salary

DELIMITER $$
CREATE TRIGGER trig_hr_decsal
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    IF new.salary<old.salary THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='**Salary is less**';
    END IF;
END $$

DELIMITER ;

SELECT salary FROM employees WHERE employee_id = 101;

UPDATE employees SET salary=15000 WHERE employee_id = 101;

------------------------------------------------

CREATE TABLE account(accno INTEGER PRIMARY KEY, name VARCHAR(25),balance NUMERIC(11,2));

CREATE TABLE trans (accno INTEGER, wd numeric(11,2), dep numeric(11,2),
    FOREIGN KEY(accno) REFERENCES account(accno));

--create  a TRIGGER to update balance in account table
--whenever wd(withdrawl), dep(deposit) happens on trans TABLE

DELIMITER $$
CREATE TRIGGER trig_hr_trans
AFTER INSERT ON trans
FOR EACH ROW
BEGIN
    IF new.dep IS NOT NULL THEN
        UPDATE `account` SET balance = balance+new.dep WHERE accno = new.accno;
    ELSE 
        UPDATE `account` SET balance = balance-new.wd WHERE accno = new.accno;
    END IF;
END $$

DELIMITER ;

INSERT INTO `trans` VALUES (101,NULL,10000);

SELECT * FROM `account`;



--D
USE `library`;
DROP procedure IF EXISTS `return_book`;

DELIMITER $$
USE `library`$$
CREATE PROCEDURE `return_book` (IN book_id INT,IN copy_id INT)
BEGIN
	
	DECLARE bid INT;
	SELECT bookid INTO bid FROM bres WHERE bookid=book_id;
    UPDATE bloan SET ACT_DATE = curdate() WHERE bookid=book_id AND c_id=copy_id;
	IF book_id=bid  THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='**It is Reserved**';
	else
		UPDATE bcopy SET status='available' WHERE bookid=book_id AND c_id=copy_id;	
        
	END IF;
END$$

DELIMITER ;

