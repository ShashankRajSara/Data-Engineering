-- Active: 1671688949427@@127.0.0.1@3308@db_optimised

SHOW tables;

-- INNER JOIN => Uses '=' Operator to JOIN
SELECT e.ename,d.dname 
FROM emp e
INNER JOIN dept d
ON e.`DEPTNO`=d.`DEPTNO`;


-- Display above output only for SALES
SELECT e.ename,d.dname 
FROM emp e
INNER JOIN dept d
ON e.`DEPTNO`=d.`DEPTNO`
AND d.`DNAME`='Sales';

SELECT SUM(sal) 'TotalSAL', d.Dname
FROM emp e
INNER JOIN dept d
ON e.deptno=d.`DEPTNO`
GROUP BY d.dname;

--OUTER JOIN
SELECT e.ename,d.dname
FROM emp e 
LEFT OUTER JOIN dept d
ON e.`DEPTNO`=d.`DEPTNO`;


--NON EQUI JOIN
SELECT e.ename,s.grade
FROM emp e
JOIN salgrade s
ON e.`SAL`
BETWEEN s.`LOSAL` AND s.`HISAL`;

SELECT e.ename,d.dname,s.grade
FROM emp e
JOIN salgrade s
ON e.`SAL`
BETWEEN s.`LOSAL` AND s.`HISAL`
INNER JOIN dept d ON e.`DEPTNO`=d.`DEPTNO`;


USE HR;

show tables;

SELECT  CONCAT(e.first_name, ' ', e.last_name) Name,r.region_name, c.country_name, l.city, d.department_name
FROM regions r 
INNER JOIN countries c ON r.region_id=c.region_id
INNER JOIN locations l ON l.country_id = c.country_id
INNER JOIN departments d ON l.location_id=d.location_id
INNER JOIN employees e ON e.department_id=d.department_id; 

--SELF JOIN
--display employee ans his manager NAME
SELECT CONCAT(e.first_name,' ',e.last_name) "Emp Name", CONCAT(m.first_name,' ',m.last_name) 'Man Name'
FROM employees e JOIN employees m
ON e.manager_id=m.employee_id;


--Same salary as other employees
SELECT CONCAT(e.first_name,' ',e.last_name) "Emp Name", e.salary
FROM employees e JOIN employees e2
ON e.salary=e2.salary
AND e.employee_id!=e2.employee_id;

SELECT e1.employee_id, e1.first_name, e1.salary 'emsalary' FROM employees e1
WHERE e1.salary IN
    (SELECT salary
     FROM employees e2
     WHERE e1.employee_id <> e2.employee_id) 
ORDER BY emsalary;


SELECT E1.first_name, E1.Salary
FROM Employees E1, Employees E2
WHERE E1.Salary = E2.Salary
AND E1.employee_id != E2.employee_id;

select COUNT(*) as NumberOfPerson,salary from employees group by salary with ROLLUP having COUNT(*)>1 ;

-- find job ID, which got filled in 2nd half of any YEAR
-- again filled in the 1st half of next YEAR => IMP 

SELECT job_id,hire_date,YEAR(e1.hire_date) 'YEAR', MONTH(e1.hire_date) 'Month'
FROM employees e1 
WHERE QUARTER(e1.hire_date)<3 AND YEAR(e1.hire_date) IN (Select YEAR(e2.hire_date)+1 FROM employees e2 WHERE QUARTER(e2.hire_date)>2);





