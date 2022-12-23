-- Active: 1671688949427@@127.0.0.1@3308@db_optimised
--Use database `db_optimised`
USE `db_optimised`;

--To Show all the tables in the Database
SHOW TABLES;

--To describe the structure of the table
DESC `salgrade`;
--Same as DESC
DESCRIBE `salgrade`;
-- same as DESC
SHOW COLUMNS FROM `salgrade`;

--SELECT Syntax
SELECT *<`COLUMNS`>
FROM <`TABLENAME`>
WHERE <`CONDITION`>;

SELECT * FROM `dept`;

SELECT * 
FROM `DEPT` 
WHERE `DEPTNO`=30; 

select * from emp;

SELECT * FROM `emp`
WHERE `job`='salesman';

--findout employess, who has salary greater than `2975`
select count(*) from emp where sal>2975;

--employees who has salary less than 1250
SELECT ename,sal FROM `emp` WHERE sal<=1250;

--employees who are not clerks
select ename,job from `emp` where job<>'clerk';
select ename,job from `emp` where job!='clerk';

--employees with deptno `20` and job is `clerk`
SELECT ename, deptno,job from emp WHERE deptno=40 AND job='clerk';

--employees with deptno `20` OR job is `clerk`
SELECT ename, deptno,job from emp WHERE deptno=40 OR job='clerk';


--Difference between `=` AND `like`
-- BOTH ARE SAME
select * from emp where ename = 'smith';
select * from emp where ename like 'smith'; 

-- USING the NOT to find clerk
SELECT * FROM `emp` WHERE NOT `job`='clerk';

--employees who are taking salaries not less than 3000 (do not use > operator)
SELECT ename,sal FROM emp WHERE NOT `sal`<3000;

-- deptno 30 and 10
SELECT * FROM `emp` WHERE `deptno`=30 OR `deptno`=10;
SELECT * FROM `emp` WHERE `deptno` IN (10,30);

--`BETWEEN` OPERATOR
--sal between 950 and 2845
SELECT ename,sal FROM `emp` WHERE `sal` BETWEEN 950 and 2845;

--name between james and ternere
SELECT ename,sal FROM `emp` WHERE `ename` BETWEEN 'JAMES' and 'TERNER';


--`PATTERN MATCHING`
--LIKE, NOT LIKE

--ename starting with J
SELECT ename FROM `emp` WHERE ename LIKE 'J%';

--ename ending with D
SELECT ename FROM `emp` WHERE ename LIKE '%D';

--ename Containing T anywhere
SELECT ename FROM `emp` WHERE ename LIKE '%T%';

--ename 3rd character is R
SELECT ename FROM `emp` WHERE ename LIKE '__R%';

--enames having exactly 4 characters
SELECT ename FROM `emp` WHERE ename LIKE '____';

--CREATING A TABLE FROM ORIGINAL TABLE
CREATE TABLE EMP1 AS SELECT * FROM EMP;

--Showing a string which has `UNDERSCORE` in it
UPDATE emp1 SET job='sales_rep' where job='salesman';
UPDATE emp1 SET job='hr_clerk' where job='clerk';

select * from emp1;

--Showing a string which has `UNDERSCORE` in it

select ename,job from emp1 where job like '%\_%';

UPDATE emp1 SET job='sales%rep' where job='sales_rep';

--Showing a string which has `MODULUS` in it
select ename,job from emp1 where job like '%\%%';

--find out employees who have joined in 1981

SELECT ename FROM emp WHERE ename NOT LIKE '%s%' AND hiredate LIKE'1981%';

--NULL VALUES
SELECT ename,comm FROM emp WHERE comm is NOT NULL;
















