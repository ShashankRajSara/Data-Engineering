-- Active: 1671688949427@@127.0.0.1@3308@db_optimised
Show tables;

SELECT DISTINCT job FROM emp 
WHERE `DEPTNO` IN (10,20);


--UNION
SELECT job from emp WHERE deptno=10
UNION ALL
SELECT job FROM emp WHERE `DEPTNO`=20;

--INTERSECT
SELECT job from emp WHERE deptno=10
INTERSECT
SELECT job FROM emp WHERE `DEPTNO`=20;


SELECT JOB,SUM(sal) FROM emp
GROUP BY JOB
UNION ALL
SELECT NULL ,SUM(Sal) FROM emp;

SELECT ename,null 'Dname' from emp 
UNION 
SELECT null,dname FROM dept;

SELECT job,deptno,sum(sal) FROM emp
GROUP BY job,`DEPTNO` WITH ROLLUP;

SELECT job,deptno,sum(sal) FROM emp
GROUP BY job,`DEPTNO` WITH ROLLUP;

SELECT sum(sal), deptno,job 
FROM emp
GROUP BY deptno,job with ROLLUP
UNION
SELECT sum(sal), deptno,job 
FROM emp
GROUP BY `JOB`,`DEPTNO` with rollup;

--ORDER BY with UNION
SELECT ename from emp 
UNION
SELECT dname from dept
ORDER BY ename;