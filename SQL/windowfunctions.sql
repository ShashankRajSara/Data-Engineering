-- Active: 1671688949427@@127.0.0.1@3308@db_optimised

SELECT COUNT(*) OVER(),first_name From employees;

SELECT min(salary) OVER(),first_name FROM employees;

SELECT first_name,salary FROM employees ORDER BY salary;

SELECT first_name,salary,(SELECT SUM(salary) FROM employees WHERE employee_id<=e.employee_id) 
FROM employees e;

--Using OVER
SELECT first_name,salary,SUM(salary) OVER(ORDER BY salary) 'runsal' FROM employees;

--Row Number

SELECT first_name, salary, ROW_NUMBER() OVER() 'rrank' FROM employees;

SELECT first_name, salary, ROW_NUMBER() OVER(ORDER BY salary DESC) 'rrank' FROM employees;

--Rank function
SELECT first_name, salary, ROW_NUMBER() OVER(ORDER BY salary DESC) 'rrank', RANK() OVER(ORDER BY salary DESC) FROM employees;

--dense rank
SELECT first_name, salary, ROW_NUMBER() OVER(ORDER BY salary DESC) 'rrank', 
RANK() OVER(ORDER BY salary DESC), DENSE_RANK() OVER(ORDER BY salary DESC) FROM employees;


--Compare function
SELECT first_name, salary, LAG(salary) OVER() FROM employees;

SELECT first_name, salary, LAG(salary) OVER() 'LAG', LEAD(salary) OVER() 'LEAD'
FROM employees;

SELECT first_name, hire_date, LAG(hire_date) OVER() 'LAG', LEAD(hire_date) OVER() 'LEAD'
FROM employees;


SELECT first_name, salary, LAG(salary) OVER() 'LAG', LAG(salary,2) OVER() 'LEAD'
FROM employees;


SELECT first_name, hire_date, LAG(hire_date) OVER() 'LAG', LAG(hire_date,2) OVER() 'LAG 2'
FROM employees;


SELECT first_name, commission_pct, LAG(commission_pct) OVER() FROM employees;

--Practice

--1.
SELECT hiredate, LAG(`HIREDATE`) OVER() 'lagdate', DATEDIFF(LAG(`HIREDATE`) OVER(),hiredate) 'DATE DIFF'
FROM emp
WHERE job='analyst';


--FIRST_VALUE
SELECT ename,sal,FIRST_VALUE(sal) OVER(ORDER BY sal DESC) '1st_value' FROM emp;

SELECT ename,`HIREDATE`,FIRST_VALUE(`HIREDATE`) OVER(ORDER BY `HIREDATE` DESC) '1st_value' FROM emp;

-- -nth salary

SELECT ename,sal,NTH_VALUE(sal,5) OVER(ORDER BY sal DESC) '2nd highsal'
FROM emp;

--last value

SELECT ename,sal,LAST_VALUE(sal) OVER(range between unbounded preceding and unbounded following)
'last_value' FROM emp;

SELECT ename,sal,LAST_VALUE(sal) OVER(rows between unbounded preceding and current row)
'last_value' FROM emp;

SELECT ename,sal,LAST_VALUE(sal) OVER(range between unbounded preceding and unbounded following)
'last_value' FROM emp;

SELECT ename,sal,LAST_VALUE(sal) OVER()
'last_value' FROM emp;


--partition by
SELECT ename,sal,sum(sal) OVER (PARTITION BY deptno), deptno
FROM emp;

SELECT ename,sal,LAST_VALUE(sal) OVER (PARTITION BY deptno), deptno
FROM emp;

--N Tile

SELECT NTILE(3) OVER(ORDER BY deptno) AS 'nntile',ename,deptno
FROM emp;

SELECT NTILE(3) OVER(ORDER BY department_id) AS 'nntile',first_name,department_id
FROM employees;




--CTE

With cte
AS
    (SELECT * FROM emp)
    SELECT ename FROM cte;


with cte_1
AS
    (SELECT AVG(sal)avsal, deptno FROM emp GROUP BY deptno)
    SELECT e.ename,e.sal,e.deptno,cte_1.avsal
    FROM emp e JOIN cte_1
    ON e.deptno=cte_1.deptno
    AND e.sal>cte_1.avsal;


SELECT e1.ename,COUNT(e1.deptno ) OVER(PARTITION BY e1.deptno), e2.ename,e2.deptno,COUNT(e2.deptno) OVER(PARTITION BY e2.deptno) from emp e1
JOIN emp e2
ON e1.mgr=e2.empno;

with recursive cte_2
AS
(
    SELECT 1 'n'
    UNION ALL
    SELECT n+1 from cte_2 WHERE cte_2.n<=30
)
SELECT * FROM cte_2;

SET @v1='2023-01-01';

--generate calender for current month
with RECURSIVE cte_3
AS
(
    SELECT @v1 'DATE'
    UNION ALL
    SELECT @v1+1 FROM cte_3 WHERE DAY(cte_3.DATE)<=31)
SELECT * FROM cte_3;

