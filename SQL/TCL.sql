-- Active: 1671688949427@@127.0.0.1@3308@hr
START TRANSACTION
DML
ROLLBACK;

SELECT * FROM employees;
CREATE TABLE IF NOT EXISTS emp1 AS 
SELECT employee_id,first_name FROM employees WHERE department_id=100;

SELECT employee_id FROM emp1;

-LOCKING;

