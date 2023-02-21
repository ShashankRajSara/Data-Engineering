
DELIMITER //

CREATE FUNCTION customerLevel(
    credit DECIMAL(10, 2)
)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE customerLevel VARCHAR(20);

    IF credit > 50000 THEN
        SET customerLevel = 'PLATINUM';
    ELSEIF (credit <= 50000 AND credit >= 10000) THEN
        SET customerLevel = 'GOLD';
    ELSE
        SET customerLevel = 'SILVER';
    END IF;

    RETURN customerLevel;
END //

DELIMITER ;

SELECT customerName, creditLimit, customerLevel(creditLimit)
FROM customers
ORDER BY customerName;

SHOW FUNCTION STATUS WHERE db = 'classicmodels';

-- Write a stored function called computeTax that calculates income tax based on the salary for every worker in the Worker 
--table as follows:
-- 10% - salary <= 75000
-- 20% - 75000 < salary <= 150000
-- 30% - salary > 150000
-- Write a query that displays all the details of a worker including their computedTax.

DELIMITER $$
CREATE FUNCTION computeTax(sal DECIMAL(10,2)) RETURNS DECIMAL(9,2)
DETERMINISTIC
BEGIN
    DECLARE tax DECIMAL(9,2);

    IF sal <= 75000 THEN
        SET tax = sal*0.10;
    ELSEIF (sal <= 150000 AND sal > 75000) THEN
        SET tax = sal*0.20;
    ELSE
        SET tax=sal*0.30;
    END IF;

    RETURN tax;
END $$

-- Define a stored procedure that takes a salary as input and returns the calculated income tax amount for the input salary.
--  Print the computed tax for an input salary from a calling program. (Hint - Use the computeTax stored function inside the stored procedure)

CREATE PROCEDURE getTax(IN sal DECIMAL(10,2), OUT tax DECIMAL(10,2))
BEGIN
    SET tax= computeTax(sal);
END $$