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
CROSS JOIN dept d
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

USE db_optimised;
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



SELECT ename,sal from emp ORDER BY sal DESC;

SELECT ename,sal from emp
WHERE sal >= ALL(SELECT sal from emp);

SELECT ename,sal FROM emp e1 WHERE SAL IN ( SELECT sal from emp e2 WHERE e1.`EMPNO`!=e2.`EMPNO`);

SELECT sal from emp e1 JOIN emp e2 ON  WHERE e1.sal=e2.sal;

USE HR;
SELECT region_name, country_name
FROM regions NATURAL JOIN Countries;

desc employees;

--NATURAL JOIN
SELECT first_name,department_name
from employees NATURAL JOIN departments;

--USING one COLUMN
SELECT first_name,department_name
from employees JOIN departments
USING (department_id);

--USING two COLUMNs 
SELECT first_name,department_name
from employees JOIN departments Using (department_id,manager_id);

--SUB QUERY



--EXAM PRACTISE
SELECT e1.ename, e1.sal FROM emp e1
JOIN emp e2
ON e1.empno!=e2.empno
AND
e1.sal=e2.sal;

SELECT DATE_FORMAT(hiredate,'%m') FROM emp;

SELECT dname,hiredate,DATE_FORMAT(hiredate,'%m')
FROM dept
INNER JOIN emp
ON emp.`DEPTNO`=dept.`DEPTNO`
WHERE DAYNAME(hiredate)='Thursday'
AND DATE_FORMAT(hiredate,'%d')<=7;

CREATE TABLE odd_even (id int(4),des varchar(4));

INSERT INTO odd_even (id) VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
select * from odd_even;

UPDATE odd_even SET des = 
 CASE    WHEN MOD(id,2)=0 THEN 'EVEN' ELSE 'ODD' END;
