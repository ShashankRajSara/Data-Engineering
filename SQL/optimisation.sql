
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

