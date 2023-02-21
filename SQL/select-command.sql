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

--DATE

SELECT CURRENT_DATE,CURDATE();
SELECT NOW(),CURRENT_TIMESTAMP,SYSDATE();

SELECT DATE(NOW()),TIME(CURRENT_TIMESTAMP);

SELECT YEAR(CURDATE()),DAYNAME(NOW()), DAY(CURRENT_DATE);

desc emp;

SELECT ename FROM emp WHERE DAYNAME(hiredate) = 'Tuesday';

SELECT ename FROM emp WHERE MONTHNAME(hiredate) = 'December';

SELECT ename FROM emp WHERE YEAR(`HIREDATE`)='1981' AND ename NOT LIKE '%s%';

--quarter
SELECT QUARTER(CURRENT_DATE);

SELECT ename from emp WHERE MOD(year(`HIREDATE`),4)=0;

SELECT DATE_FORMAT(CONCAT(YEAR(SYSDATE()),'-12-31'),'%j');

select * from emp order by comm;

SELECT hiredate, DATE_FORMAT(hiredate,'%D') FROM EMP;

SELECT hiredate, DATE_FORMAT(hiredate,'%d') FROM EMP;

SELECT ename,`HIREDATE`  FROM emp WHERE DAYNAME(hiredate) = 'Thursday' AND DATE_FORMAT(hiredate,'%d') <7;

--SHOW: ename joined on 17th, Wednesday December 1980
SELECT CONCAT(ename, ' joined on ', DATE_FORMAT(hiredate,'%D'),', ', DAYNAME(hiredate),' ',MONTHNAME(`HIREDATE`),' ', YEAR(`HIREDATE`))
FROM emp;


--extract

select hiredate,extract(day from hiredate) from emp;

--Return Date Difference 
SELECT DATEDIFF(CURDATE(),`HIREDATE`) FROM emp;
SELECT TIMESTAMPDIFF(YEAR,hiredate,CURDATE()) FROM emp;

--Display years, months and days from your DOB  
SET @dob='1999-12-29';
SELECT CONCAT(TIMESTAMPDIFF(YEAR,@dob,CURDATE())," Years, ", MOD(TIMESTAMPDIFF(MONTH,@dob,CURDATE()),12),' Months, ',DAY(CURDATE())-DATE_FORMAT(@dob,'%d'),' Days' );

SELECT DAY(CURDATE())-(DATE_FORMAT(@dob,'%d'));


-- Modifying Dates  

SELECT DATE_ADD(CURDATE(), INTERVAL '1' YEAR) 'ADD1YEAR',
        DATE_SUB(CURDATE(), INTERVAL '2' MONTH) 'Deduct 2 Months';

SELECT LAST_DAY(CURDATE());

SELECT LAST_DAY(hiredate) FROM emp;

SELECT MAKEDATE(2020,61);

-- IF CONDITION

SELECT ENAME, SAL, IF(SAL>2500,'GOOD SAL','LOW SAL') 'COMMENTS' FROM emp; 

-- CASE

SELECT ename, sal, job,
    (CASE WHEN JOB='CLERK' THEN 1.75*Sal 
            WHEN JOB='SALESMAN' THEN 2*SAL
            WHEN JOB='Analyst' THEN 1.75*SAL
            ELSE SAL 
            END) 'BONUS'

    FROM emp ORDER BY 3;

    SELECT ename, sal, job,
    (CASE JOB WHEN 'CLERK' THEN 1.5*Sal 
            WHEN 'SALESMAN' THEN 2*SAL
            WHEN 'Analyst' THEN 1.75*SAL
            ELSE SAL 
            END) 'BONUS'

    FROM emp ORDER BY 3;

-- Question
SELECT CASE DAY(curdate()) 
    WHEN 28 THEN REPEAT('HappyBirthday ',5)
    WHEN 27 THEN REPEAT('BelatedBirthday',2)
    ELSE 'Advance Happy Birthday' 
    END;

--NULLIF
SELECT ename,LENGTH(ename), SAL, LENGTH(SAL), NULLIF(LENGTH(ename),LENGTH(sal)) 'NULLIF'
FROM emp ORDER by 2;

--IFNULL
SELECT ename,sal,comm, sal+comm,IFNULL(sal+comm,Sal) 'IFNULL' FROM emp ORDER BY comm;

-- STR to DATE

SELECT STR_TO_DATE('10th-june-20','%D-%M-%y'),STR_TO_DATE('10-05-2002','%d-%m-%Y');



--Aggregate FUNCTION

SET @@sql_mode="only_full_group_by";

-- COUNT

SELECT COUNT(*) FROM emp;
SELECT COUNT(comm) FROM emp;

--Find How many are working as CLERK
SELECT COUNT(empno) FROM emp WHERE job='clerk';

SELECT max(sal), max(hiredate), max(ename) FROM emp;

SELECT , SUM(sal) FROM emp GROUP BY `DEPTNO`;

-- Find out no of employess joined each YEAR
SELECT YEAR(hiredate),COUNT(empno) FROM emp
GROUP BY YEAR(hiredate);

-- Find out no of employess joined each YEAR
SELECT YEAR(hiredate),QUARTER(hiredate),COUNT(empno) FROM emp
GROUP BY YEAR(hiredate), QUARTER(`HIREDATE`);

--find out no of employess joined in each month ans sort by MONTH

SELECT MONTHNAME(hiredate) AS month, COUNT(empno) 'SUM of EMP' FROM emp
GROUP BY MONTHNAME(hiredate), DATE_FORMAT(`HIREDATE`,'%m')
ORDER BY DATE_FORMAT(`HIREDATE`,'%m');

SELECT DATE_FORMAT(CURDATE(),'%m');

--Question

SELECT JOB, 
    CASE Job WHEN 'CLERK' THEN COUNT(empno)
            WHEN 'SALESMAN' THEN MAX(sal)
            WHEN 'ANALYST' THEN SUM(sal)
            ELSE ROUND(AVG(sal))
            END
            FROM emp
            GROUP BY job;


--find out no of employees who are taking same salaries

SELECT SAL,COUNT(empno) FROM emp 
GROUP BY sal
HAVING COUNT(empno)>1;


--List average salary for all departments employing more than five people
SELECT deptno, ROUND(AVG(sal)), COUNT(*) FROM emp
Group BY deptno
HAVING COUNT(*)>5;

--8. List Jobs of all the employees where maximum salary is greater than or equal to 3000
SELECT JOB,MAX(sal) FROM emp GROUP by `JOB`
HAVING max(sal)>=3000;

--9. List the total salar
SELECT JOB, SUM(Sal) 'Total SAL', MAX(sal), min(Sal), AVG(sal)
FROM emp
WHERE `DEPTNO`=20
GROUP BY `JOB`
HAVING avg(sal)>1000;

SELECT SIGN(5);

