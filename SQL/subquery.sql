-- Active: 1671688949427@@127.0.0.1@3308@hr
USE HR;
SELECT * FROM employees;

--Find out employees who joined after Lisa
SELECT hire_date from employees
WHERE first_name='Lisa';

SELECT first_name,hire_date
FROM employees
WHERE hire_date>(SELECT hire_date from employees
WHERE first_name='Lisa');

--Find out department_name in which steven king is working

--UsingJoins
SELECT department_name
FROM departments d
JOIN employees e
USING(department_id)
WHERE CONCAT(first_name,' ',last_name) = 'Steven King';

--Sub QUERY
SELECT department_name
FROM departments 
WHERE department_id IN (SELECT department_id from employees 
WHERE CONCAT(first_name,' ',last_name) = 'Steven King');

--Find out the employees reporting to Neena Kochhar

--Sub Query
SELECT first_name FROM employees WHERE manager_id = 
(SELECT employee_id FROM employees 
WHERE CONCAT(first_name,' ',last_name) = 'Neena Kochhar');

--Joins
SELECT e1.first_name FROM employees e1
JOIN employees e2
ON e1.manager_id=e2.employee_id
AND CONCAT(e2.first_name,' ',e2.last_name) = 'Neena Kochhar';

SELECT * FROM job_grades;

SELECT CONCAT(e.first_name,' ',e.last_name) 'Full Name',e.salary,j.grade_level
FROM employees e JOIN job_grades j
ON e.salary BETWEEN j.lowest_sal AND j.high_sal
AND e.department_id=90;

--Find out grade of Lex De Haan using SUBQUERY

SELECT grade_level
FROM job_grades
WHERE (SELECT salary FROM employees WHERE CONCAT(first_name,' ',last_name)='Lex De Haan'
AND salary BETWEEN lowest_sal AND high_sal);


--FIND OUT employees working in the same department as Hermann Baer. exclude hermann

SELECT * from employees
WHERE department_id =
(SELECT department_id FROM employees 
 WHERE CONCAT(first_name,' ',last_name)='Neena Kochhar')
 AND first_name != 'Neena';


--Find out employees who are working in the same department as 'Valli' and 'Lex'

SELECT * from employees
WHERE department_id IN 
(SELECT department_id FROM employees WHERE first_name IN ('Valli','Lex'));

