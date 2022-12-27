-- Active: 1671688949427@@127.0.0.1@3308@db_optimised

--SELECT STATEMENT

SELECT (PROJECTION) *
FROM  <TABLENAME>
WHERE restriction

GROUP BY
HAVING
ORDER BY;

--SELECT all the COLUMNS
SELECT * FROM emp;

SELECT deptno,job FROM emp ORDER BY `DEPTNO`;

--DISTINCT => Eliminate duplicates
SELECT DISTINCT deptno, job FROM emp ORDER BY `DEPTNO`;

--Table Aliasing using quotes
select ename,sal,sal+300 "incr sal" from emp;

--Example
SELECT ename, sal, sal*0.4 AS 'HRA', sal*0.3 DA, sal*0.12 PF, sal*0.1 AS TAX,
(sal+sal*0.4+sal*0.3-0.12*sal-0.1*sal) AS TotalSalary
FROM emp;

--SET
SET @v1=1250;
SELECT * FROM emp WHERE sal=@v1;

SET @hra= 0.4, @da=0.3, @pf=0.12, @tax=0.1;

SELECT ename, sal + sal*@hra + sal*@da - @pf*sal - @tax*sal AS TotalSalary FROM emp;

--ORDER BY

SELECT ename,deptno,job FROM emp ORDER BY ename;

SELECT ename,deptno,job FROM emp ORDER BY ename DESC;

SELECT ename,deptno,job FROM emp ORDER BY 2 DESC;

SELECT ename,deptno,job FROM emp ORDER BY 2 DESC,3;

SELECT ename,deptno,job 'PROFESSION' FROM emp ORDER BY PROFESSION desc;

--Not Orderd, when using aliasing
SELECT ename,deptno,job 'PROFESSION' FROM emp ORDER BY "PROFESSION" desc;

-- LIMIT

SELECT * FROM emp LIMIT 5;

--TOP 3 Salaries
SELECT  `sal` FROM emp ORDER BY `SAL`DESC LIMIT 3;

--LIMIT(x,y)  => Skip x and show y records;
SELECT  `sal` FROM emp ORDER BY `SAL`DESC LIMIT 2,5;


--CONCAT

SELECT CONCAT(ename,' is Working as ',job) 'Emp and his job' FROM emp;

SELECT CONCAT(ename,"'s job is ",job) FRoM emp;

--UPPER/LOWER

Select upper('shashank'), lower('dnjUDBS') FROM DUAL;

--SUBSTR

SET @v= 'HelloWorld';

SELECT @v, SUBSTR(@v,5), SUBSTR(@v,5,1);

--last CHARACTER
SELECT ename,SUBSTR(ename,-1), SUBSTR(ename, LENGTH(ename)) FROM emp;

--ename with lastalphabet in UPPER 
SELECT CONCAT(LOWER(SUBSTR(ename,1,LENGTH(ename)-1)), UPPER(SUBSTR(ename,-1))) FROM emp;

--INSTR
SELECT INSTR('chitti chilamma', 't');

SELECT SUBSTR(ename,-1) FROM emp;

SELECT ename, INSTR(ename,SUBSTR(ename,-1)) AS 'lastchar' FROM emp
WHERE INSTR(ename,SUBSTR(ename,-1))<LENGTH(ename);

--LEF/RIGHT
SELECT ename,LEFT(ename,1) 'left', RIGHT(ename,3) 'right' FROM emp;

SELECT CONCAT(LOWER(LEFT(ename,LENGTH(ename)-1)),UPPER(RIGHT(ename,1))) FROM emp;

SET @v='    Ankitha  ';

--TRIM
SELECT TRIM(@v), LTRIM(@v), RTRIM(@v);

SELECT TRIM('h' FROM 'helloh');

--REPLACE
SELECT REPLACE("MARY HAD A LITTILE LAMB", "LAMB", 'BOMB');

--No of A's in the String
SELECT  LENGTH("MARY HAD A LITTILE LAMB")-LENGTH(REPLACE("MARY HAD A LITTILE LAMB",'A',''));

--LPAD

SELECT dname,lpad(dname,15,'*'),rpad(`DNAME`,15,'$') FROM dept;

--REPEAT

SELECT REPEAT('Hello',10);

--REVERSE
SELECT REVERSE('SHASHANK');

=============================================================;

NUMBER FUNCTIONS;

--MOD
SELECT empno FROM emp WHERE MOD(empno,2)=1;

--Find employees who are taking more salary tham commision
Select Ename,sal, comm From emp
WHERE SIGN(`COMM`-`SAL`)=1;

SELECT ABS(-98),ASCII('A'),CHAR(97 USING ASCII);

SELECT ROUND(255.28,-2);
SELECT TRUNCATE(255.28,-2);
SELECT CEIL(91.1), FLOOR(91.9);




