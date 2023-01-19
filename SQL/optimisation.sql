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

