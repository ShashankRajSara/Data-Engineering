-- Active: 1671688949427@@127.0.0.1@3308@db_optimised

--1
SET @dob='1999-08-03';

with RECURSIVE mydatecte
AS
(
    SELECT @dob AS 'dobirth', DATE_FORMAT(@dob,'%a') 'Daynam'
    UNION ALL
    SELECT DATE_ADD(dobirth, INTERVAL '1' YEAR),DATE_FORMAT(dobirth,'%a') FROM mydatecte WHERE mydatecte.dobirth<=CURDATE()
)
SELECT * FROM mydatecte;





---2

--a
SELECT ename,sal, RANK() OVER(ORDER BY sal)'Sal RANK', DENSE_RANK() OVER(ORDER BY sal)
FROM emp;

--b
SELECT ename,sal, LEAD(sal) OVER(ORDER BY sal) 'Lead', LAG(sal) OVER(ORDER BY sal) 'Lag'
FROM emp;

--c
SELECT ename, sal, deptno, FIRST_VALUE(sal) OVER(PARTITION BY deptno)
FROM emp;

--d
SELECT ename, LAST_VALUE(hiredate) OVER(ORDER BY hiredate DESC)
FROM emp WHERE JOB="CLERK" LIMIT 1;

a;