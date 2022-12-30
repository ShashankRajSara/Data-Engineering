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

--find out the department names where no employees are working

SELECT department_name FROM departments
WHERE department_id NOT IN 
(SELECT DISTINCT department_id FROM employees WHERE department_id IS NOT NULL);

-- Find Out department_name where no sa_rep working

select DISTINCT job_id from employees;

SELECT * from departments;
select * from employees;

SELECT department_name FROM departments
WHERE department_id NOT IN 
(SELECT DISTINCT department_id FROM employees WHERE job_id ='SA_REP' AND department_id IS NOT NULL);

SELECT DISTINCT department_id FROM employees WHERE job_id ='SA_REP' AND department_id IS NOT NULL;

--Find out employees who joined on '1999-6-21','1997-08-20'
show tables;

SELECT first_name,hire_date from employees 
WHERE hire_date > ALL (SELECT hire_date FROM employees WHERE first_name IN ('laura','susan'));

--find out the employees who are taking maximum salaries in each job id

SELECT CONCAT(first_name,' ',last_name) 'Full Name',salary,job_id FROM employees
WHERE (salary,job_id) IN (SELECT MAX(salary),job_id from employees 
where job_id IS NOT NULL GROUP BY job_id);

--Find out the job id which is having maximum no of employees

SELECT job_id,MAX(employee_id) FROM employees
WHERE (salary,job_id) IN (SELECT MAX(salary),job_id from employees 
where job_id IS NOT NULL GROUP BY job_id);

SELECT job_id,COUNT(employee_id) FROM employees
GROUP BY job_id;

SELECT job_id, COUNT(job_id)'No of employees'
FROM employees
GROUP BY job_id
HAVING COUNT(job_id) IN (SELECT MAX(a.cnt) FROM (SELECT count(job_id)cnt FROM employees GROUP BY job_id)a);

SELECT CONCAT(first_name,' ',last_name) 'Full Name', job_id
FROM employees
WHERE job_id IN (
SELECT job_id
FROM employees
GROUP BY job_id
HAVING COUNT(job_id) IN (SELECT MAX(a.cnt) FROM (SELECT count(job_id)cnt FROM employees GROUP BY job_id)a));

-- Greater than avg salary from their department
SELECT first_name,salary, department_id
FROM employees e
WHERE salary >(SELECT avg(salary) FROM employees WHERE department_id=e.department_id);

--USING JOINS
SELECT e.first_name,e.salary, e.department_id,ROUND(a.avsal)
FROM employees e INNER JOIN (SELECT department_id,avg(salary) avsal
FROM employees WHERE department_id is NOT NULL GROUP BY department_id)a
ON e.department_id=a.department_id
AND e.salary>a.avsal
ORDER BY 3;

--GROUP CONCAT

SELECT GROUP_CONCAT(first_name), department_id
FROM employees
WHERE department_id=60
GROUP BY department_id;