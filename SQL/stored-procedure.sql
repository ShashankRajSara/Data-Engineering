-- Active: 1671688949427@@127.0.0.1@3308@hr

--SYNTAX
DELIMITER //
CREATE PROCEDURE getAllEmployees()
BEGIN   
    SELECT * FROM employees;

END //

DELIMITER ;

CALL getAllEmployees();

SHOW CREATE PROCEDURE getAllEmployees;

SHOW PROCEDURE STATUS LIKE 'getAllEmployees';

-- IN PARAMETER

DELIMITER //
CREATE PROCEDURE getEmployee(IN empId VARCHAR)
BEGIN   
    SELECT * FROM employees WHERE employee_id = empId;
END //
DELIMITER ;
CALL getEmployee();


-- Create a stored procedure named getEmployees() 
--to display the following employee and their office info: name, city, state, and country.


DELIMITER //

CREATE PROCEDURE getEmployees() 
BEGIN   
    SELECT CONCAT(firstName,' ',lastName) name, city, state, country FROM employees
    INNER JOIN offices USING (officeCode);
END //

DELIMITER;

CALL getEmployees();

--Create a stored procedure named getPayments() that prints the following customer and 
--payment info:customerName, checkNumber, paymentDate, and amount.

desc payments;

DELIMITER $$

CREATE PROCEDURE getPayments(IN custId INT)
BEGIN

    SELECT customerNumber,customerName, checkNumber,paymentDate,amount FROM Customers 
    INNER JOIN payments p USING (customerNumber) WHERE customerNumber=custId;
END $$

DELIMITER;

CALL getPayments(495);
