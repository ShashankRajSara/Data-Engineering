-- Active: 1671688949427@@127.0.0.1@3308@assignments1

-- 1. **Select employees first name, last name, job_id and salary whose first name starts with alphabet S.**
SELECT first_name,last_name,job_id,salary FROM employees
WHERE first_name LIKE 'S%';

-- 2. **Write a query to select employee with the highest salary.**
SELECT employee_id,first_name,salary FROM employees ORDER BY salary DESC LIMIT 1;

SELECT employee_id,first_name,salary FROM employees 
WHERE salary IN (SELECT MAX(salary) FROM employees);

-- 3. **Select employee with the second highest salary**.
SELECT employee_id,first_name,salary FROM employees 
ORDER BY salary DESC LIMIT 1,1;
SELECT employee_id,first_name,salary FROM employees 
WHERE salary = (SELECT DISTINCT salary FROM employees ORDER BY salary DESC LIMIT 1,1);

-- 4. **Fetch employees with 2nd or 3rd highest salary**.
SELECT employee_id,first_name,salary FROM employees 
ORDER BY salary DESC LIMIT 1,3;

SELECT employee_id,first_name,salary FROM employees 
WHERE `SALARY` NOT IN (SELECT MAX(`SALARY`) FROM employees)
ORDER BY salary DESC LIMIT 4;


-- 5. **Write a query to select employees and their corresponding managers and their salaries**.
select e1.employee_id,e1.first_name,e1.manager_id 'Manager ID', e2.first_name 'Manager Name',e2.salary 'Manager Salary' 
FROM employees e1, employees e2
WHERE e1.manager_id=e2.employee_id;

-- 6. **Write a query to show count of employees under each manager in descending order**.
select e1.manager_id 'Manager ID', e2.first_name 'Manager Name',COUNT(e1.employee_id) "No of Employees"
FROM employees e1, employees e2
WHERE e1.manager_id=e2.employee_id
GROUP BY e1.manager_id
ORDER BY COUNT(e1.employee_id) DESC;

-- 7. **Find the count of employees in each department**.
SELECT department_id,department_name,COUNT(employee_id) 'No of Employees' FROM employees
INNER JOIN departments USING (department_id)
GROUP BY department_id
ORDER BY `No of Employees`DESC;

-- 8. **Get the count of employees hired year wise**.
SELECT hire_date,COUNT(*)
FROM employees
GROUP BY hire_date
ORDER BY hire_date;

-- 9. **Find the salary range of employees**.
SELECT MAX(salary),MIN(salary) FROM employees;

-- 10. **Write a query to divide people into three groups based on their salaries**.
select `EMPLOYEE_ID`,`SALARY`,NTILE(3) over(ORDER BY `SALARY`) FROM employees; 

-- 11. **Select the employees whose first_name contains “an”.**
SELECT * FROM employees WHERE first_name LIKE '%an%';

-- 12. **Select employee first name and the corresponding phone number in the format (_ _ _)-(_ _ _)-(_ _ _ _)**.
SELECT first_name, CONCAT('(',REPLACE(phone_number,'.',')-('),')') 'Phone NUMBER' FROM employees;

-- 13. **Find the employees who joined in August, 1994.**
SELECT employee_id,first_name,hire_date FROM employees WHERE YEAR(hire_date)=1994 and MONTH(hire_date)=8;

-- 14. **Write an SQL query to display employees who earn more than the average salary in that company**
SELECT employee_id,first_name,hire_date,salary FROM employees 
WHERE salary > (SELECT avg(salary) from employees) 
ORDER BY salary DESC;

-- 15. **Find the maximum salary from each department.**
SELECT department_id, MAX(salary) FROM employees
GROUP BY department_id;
-- 16. **Write a SQL query to display the 5 least earning employees**.
SELECT * FROM employees
ORDER BY salary
LIMIT 5;

-- 17. **Find the employees hired in the 80s**.
SELECT employee_id,first_name,hire_date,salary FROM employees
WHERE hire_date LIKE '198%';
  
-- 18. **Display the employees first name and the name in reverse order**.
SELECT first_name, REVERSE(first_name) FROM employees; 
-- 19. **Find the employees who joined the company after 15th of the month.**
SELECT employee_id,first_name,hire_date,salary FROM employees
WHERE DAY(hire_date)>15;

-- 20. **Display the managers and the reporting employees who work in different departments**.
SELECT e1.department_id,e1.first_name 'Emp Name',e2.department_id,e2.first_name 'Manager Name',e1.hire_date,e1.salary FROM employees e1
INNER JOIN employees e2
ON e1.manager_id=e2.employee_id
AND e1.department_id <> e2.department_id;

