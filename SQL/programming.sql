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