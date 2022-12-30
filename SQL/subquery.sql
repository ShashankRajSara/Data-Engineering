-- Active: 1671688949427@@127.0.0.1@3308@hr
USE HR;
SELECT * FROM employees;

--Find out employees who joined after Lisa
SELECT hire_date from employees
WHERE first_name='Lisa';


