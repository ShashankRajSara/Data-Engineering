-- Active: 1671688949427@@127.0.0.1@3308@db_optimised

--create dummy table
CREATE TABLE check_tab(c1 int);

--check table name
--total_extents =>pages
SELECT tablespace_name, file_name, total_extents
FROM information_schema.files
WHERE tablespace_name like 'db_optimised/che%';

SELECT database();

CREATE TABLE check_extent SELECT * from emp;



ALTER TABLE check_extent MODIFY empno INT PRIMARY KEY AUTO_INCREMENT;

INSERT INTO check_extent (ename,job,mgr,hiredate,sal,comm,deptno) 
    SELECT ename,job,mgr,hiredate,sal,comm,deptno FROM emp;


SELECT * from check_extent;

INSERT INTO check_extent (ename,job,mgr,hiredate,sal,comm,deptno) 
    SELECT ename,job,mgr,hiredate,sal,comm,deptno FROM check_extent
    WHERE ename <> 'king';

--Partitioning

CREATE TABLE LIST_JOB(empno INT, ename VARCHAR(20),JOB VARCHAR(20))
PARTITION BY LIST COLUMNS (JOB)
(
    PARTITION P_CLERK VALUES IN ('CLERK'),
    PARTITION P_SALES VALUES IN ('SALESMAN'),
    PARTITION P_ANAL VALUES IN ('ANALYST'),
    PARTITION P_MAN VALUES IN ('MANAGER'),
    PARTITION P_PRES VALUES IN ('PRESIDENT')
);

INSERT INTO LIST_JOB SELECT empno, ename,job FROM check_extent;

EXPLAIN SELECT * FROM list_job;

EXPLAIN SELECT * FROM list_job WHERE job='CLERK';


--range partition

CREATE TABLE RANGE_PART(empno INTEGER, ename VARCHAR(20), sal INT)
PARTITION BY RANGE(sal)
(
    PARTITION p_1000 VALUES LESS THAN (1000),
    PARTITION p_2000 VALUES LESS THAN (2000),
    PARTITION p_3000 VALUES LESS THAN (3000),
    PARTITION p_4000 VALUES LESS THAN (4000),
    PARTITION p_5000 VALUES LESS THAN (5000),
    PARTITION p_6000 VALUES LESS THAN (6000)
);

INSERT INTO range_part SELECT empno,ename,sal FROM check_extent;

EXPLAIN SELECT * FROM range_part WHERE sal<3000;

EXPLAIN SELECT * FROM range_part WHERE sal BETWEEN 2000 AND 3000;



--employee range partition

CREATE TABLE RANGE_hiredate(empno INTEGER, ename VARCHAR(20), hiredate DATE)
PARTITION BY RANGE(YEAR(hiredate))
(
    PARTITION p_1980 VALUES LESS THAN (1980),
    PARTITION p_1981 VALUES LESS THAN (1981),
    PARTITION p_1982 VALUES LESS THAN (1982),
    PARTITION p_1987 VALUES LESS THAN (1988)
);


--year partition
CREATE TABLE RANGE_year(empno INTEGER, ename VARCHAR(20), hiredate DATE, hiredate_year INT)
PARTITION BY RANGE(hiredate_year)
(
    PARTITION p_1980 VALUES LESS THAN (1980),
    PARTITION p_1981 VALUES LESS THAN (1981),
    PARTITION p_1982 VALUES LESS THAN (1982),
    PARTITION p_1987 VALUES LESS THAN (1988)
);

INSERT INTO range_year SELECT empno,ename,hiredate, YEAR(hiredate) 
FROM check_extent;



SELECT DATE_FORMAT(hiredate, "%Y") FROM emp;

--partitions in database

SELECT partition_name,partition_ordinal_position,table_rows
FROM information_schema.partitions WHERE table_name='range_part';

SELECT partition_name,partition_ordinal_position,table_rows
FROM information_schema.partitions WHERE table_name='range_hiredate';

SELECT * FROM range_part PARTITION (p_1000) LIMIT 25;


INSERT INTO range_hiredate SELECT empno,ename,hiredate FROM check_extent;

EXPLAIN SELECT * FROM range_hiredate 
WHERE hiredate BETWEEN DATE_FORMAT("1981-00-00", "%Y-%m-%d") AND DATE_FORMAT("1987-00-00", "%Y-%m-%d");

SELECT DATE_FORMAT("2017-06-15", "%Y-%m-%d");





--HASH

CREATE TABLE hash_emp(
    empno INT PRIMARY KEY,
    ename VARCHAR(25), 
    sal FLOAT(11,2)
) PARTITION BY HASH(empno) PARTITIONS 4;

INSERT INTO hash_emp SELECT empno,ename,sal FROM check_extent;

EXPLAIN SELECT * FROM hash_emp WHERE empno =2;


SELECT partition_name,partition_ordinal_position,table_rows
FROM information_schema.partitions WHERE table_name='hash_emp';

SELECT * FROM hash_emp PARTITION (p1);


--temporary table

CREATE TEMPORARY TABLE temp_1(SAL FLOAT);

INSERT INTO temp_1 SELECT sal FROM emp;


--explain emp
EXPLAIN SELECT * FROM emp WHERE deptno=10;

EXPLAIN SELECT * FROM deptno WHERE dname='SALES';

EXPLAIN SELECT * FROM REGIONS WHERE REGION_ID=1;

EXPLAIN SELECT * FROM departments WHERE location_id=1700;

EXPLAIN SELECT ename,sal FROM emp WHERE sal IN (SELECT MIN(SAL) FROM emp);

EXPLAIN SELECT deptno FROM emp WHERE job='CLERK'
UNION
SELECT deptno FROM emp WHERE job='SALESMAN';

EXPLAIN SELECT deptno FROM emp
UNION
SELECT dname FROM dept;

EXPLAIN SELECT ename,dname FROM emp NATURAL JOIN dept;


--

EXPLAIN FORMAT=TREE SELECT * FROM fruit WHERE ID=101;

EXPLAIN FORMAT=TREE SELECT * FROM check_extent WHERE job='president';

--Indexes 

SHOW INDEX FROM emp;

SELECT DISTINCT table_name,COLUMN_NAME,index_name 
FROM information_schema.statistics
WHERE table_schema='hr' AND table_name='employees';

--create index
CREATE INDEX ID_IDX on fruit(ID);

EXPLAIN FORMAT=TREE SELECT * FROM fruit WHERE ID=101;

EXPLAIN FORMAT=TREE SELECT * FROM REGIONS WHERE region_id=1;

--Index table scan
EXPLAIN FORMAT=TREE SELECT ename FROM emp WHERE deptno=20 AND job='clerk';


--FORCE INDEX
 EXPLAIN FORMAT=TREE SELECT ename FROM emp FORCE INDEX(FK_deptno) WHERE deptno=20 AND job='clerk';

 --IGNORE INDEX
  EXPLAIN FORMAT=TREE SELECT ename FROM emp IGNORE INDEX(FK_deptno) WHERE deptno=20 AND job='clerk';

  --CHECK INDEX VISIBLE or INVISIBLE
  SELECT index_name,is_visible FROM information_schema.`STATISTICS`
  WHERE table_schema='db_optimised' AND table_name='emp';

--To Make it Visibile
  ALTER TABLE emp ALTER INDEX FK_deptno VISIBLE;

CREATE INDEX IX_job_deptno ON emp (deptno,job);

CREATE INDEX IX_job ON emp (job);


--sub QUERY

EXPLAIN SELECT * from (SELECT max(sal) FROM emp)a;

SHOW INDEXES from emp;

ALTER TABLE emp alter index IX_job_deptno VISIBLE;

EXPLAIN SELECT * FROM emp FORCE INDEX (IX_job_deptno)  WHERE deptno=20 AND `JOB`='CLERK';

ALTER TABLE emp DROP CONSTRAINT IX_job;



-- SHOW ALL INDEXES IN SERVER
SELECT * FROM SYS.SCHEMA_UNUSED_INDEXES;


--aggregate

EXPLAIN FORMAT=TREE SELECT AVG(SAL) FROM emp;

EXPLAIN FORMAT=TREE SELECT SUM(sal), job FROM emp GROUP BY `JOB`;

EXPLAIN FORMAT=TREE SELECT SUM(sal), job from emp GROUP BY job HAVING job<>'analyst';

EXPLAIN SELECT SUM(sal), job from emp GROUP BY job HAVING job<>'analyst';


EXPLAIN FORMAT=TREE SELECT SUM(salary), job from employees GROUP BY job HAVING job<>'analyst';


EXPLAIN FORMAT=TREE SELECT SUM(sal), job from check_extent GROUP BY job HAVING job<>'analyst';

EXPLAIN FORMAT=TREE SELECT SUM(sal), job from check_extent WHERE job<>'analyst' GROUP BY job ;


--PRACTICE

--a
CREATE TABLE IF NOT EXISTS student1 (
    student_id int(4) PRIMARY KEY,
    student_name varchar(15),
    RESULT CHAR(1),
    CHECK ( result IN ('P','F'))
);

INSERT INTO student1 (student_id,student_name) SELECT empno,ename FROM emp1;


--b
UPDATE student1 SET result= CASE 
            WHEN student_name LIKE '%S%' THEN
                    'P' 
            ELSE 'F'
            END;

SELECT * FROM emp;
--c
SELECT result,COUNT(*) FROM student1 GROUP BY result;

--d
EXPLAIN FORMAT=TREE SELECT result,COUNT(*) FROM student1 GROUP BY result;

ALTER TABLE student1 ALTER INDEX IX_result VISIBLE;


--e
CREATE INDEX IX_result ON student1 (result);


--employee
EXPLAIN FORMAT=TREE SELECT result,COUNT(*) FROM employee GROUP BY result;


SELECT SUM(salary), job_id FROM emp GROUP BY job_id
UNION
SELECT SUM(salary),NULL FROM employee;


--JOINS Optimization

EXPLAIN FORMAT=TREE SELECT region_name,country_name FROM reg1 
NATURAL JOIN country1;


EXPLAIN SELECT region_name,country_name FROM reg1 NATURAL JOIN country1;


CREATE INDEX IX_regionID ON country1 (regionid);
DROP INDEX IX_regionID ON reg1;
CREATE INDEX IX_regionIDC ON reg1 (regionid);

ALTER TABLE country1 ADD CONSTRAINT FOREIGN KEY (region_id) REFERENCES reg1(region_id);

--composite partition

CREATE TABLE compo_range_hash (empno INT,ename VARCHAR(20), sal INT, Job VARCHAR(20))
PARTITION BY RANGE(sal)
SUBPARTITION BY HASH(empno)
SUBPARTITIONS 2
(
    PARTITION P_1K VALUES LESS THAN (1000),
    PARTITION P_2K VALUES LESS THAN (2000),
    PARTITION P_3K VALUES LESS THAN (3000),
    PARTITION P_4K VALUES LESS THAN (4000),
    PARTITION P_MAX VALUES LESS THAN MAXVALUE
);

INSERT INTO compo_range_hash SELECT empno,ename,sal,job FROM check_extent;

--partitions
SELECT partition_name, table_rows,SUBPARTITION_name FROM information_schema.`PARTITIONS`
WHERE `TABLE_NAME`='compo_range_hash';


--partitions VALUES

SELECT * FROM compo_range_hash PARTITION(P_1K);
SELECT * FROM compo_range_hash PARTITION(P_1Ksp0);


--subquery
SELECT * FROM emp WHERE sal IN (SELECT MIN(sal) FROM emp);
EXPLAIN SELECT * FROM emp WHERE sal IN (SELECT MIN(sal) FROM emp);
EXPLAIN FORMAT=TREE SELECT * FROM emp WHERE sal IN (SELECT MIN(sal) FROM emp);

SHOW INDEXES FROM emp;

--correlated subquery

EXPLAIN FORMAT=TREE SELECT ename,sal,deptno FROM emp e WHERE sal > (SELECT avg(sal) FROM emp WHERE deptno=e.deptno);


--inlined subquery
SELECT e.ename,e.sal,e.deptno,m.avsal FROM emp e
JOIN (SELECT deptno,avg(sal) avsal FROM emp GROUP BY deptno) m ON e.deptno=m.deptno
AND e.sal>m.avsal;


--departements where no employees working
EXPLAIN FORMAT=TREE SELECT d.deptno,d.dname FROM dept d
WHERE NOT EXISTS (SELECT 1 FROM emp e WHERE d.deptno=d.deptno) ORDER BY d.deptno;

EXPLAIN FORMAT=TREE SELECT dname,deptno FROM dept WHERE deptno NOT IN (SELECT deptno FROM emp);

<<<<<<< Updated upstream
=======


--practice

EXPLAIN FORMAT=TREE SELECT ename, CASE 
            WHEN sal>3000 THEN 'Good Salary'
            WHEN sal=3000 THEN 'Average Salary'
            ELSE 'Poor Salary'
            END
            FROM emp;



EXPLAIN FORMAT=TREE SELECT ename, CASE 
            WHEN sal>3000 THEN 'Good Salary'
            WHEN sal=3000 THEN 'Average Salary'
            ELSE 'Poor Salary'
            END
            FROM emp WHERE deptno=30;

EXPLAIN FORMAT=TREE SELECT ename, IF(sal>3000,'Good Salary','Poor Salary') 
FROM emp WHERE deptno=30;         


--practice
SELECT ename,sal,sal*1.5 FROM emp;
EXPLAIN FORMAT=TREE SELECT ename,sal,sal*1.5 AS 'newsal' FROM emp
WHERE sal*1.5>3000;
>>>>>>> Stashed changes
