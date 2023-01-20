 
  CREATE INDEX IX_hiredate ON  emp (HIREDATE);

 EXPLAIN FORMAT=TREE SELECT * FROM emp WHERE MONTHNAME(hiredate)='january';
 EXPLAIN FORMAT=TREE SELECT * FROM emp WHERE hiredate>'1985-01-01';


 ALTER TABLE emp ADD 
 INDEX((MONTHNAME(hiredate)));


 CREATE INDEX IX_ename ON emp (ename);

 EXPLAIN FORMAT=TREE SELECT * FROM emp WHERE YEAR(hiredate)=1981;

SHOW INDEX FROM emp;

--Hash INDEX 
CREATE TABLE hr.testhash (
    fname VARCHAR(50) NOT NULL,
    lname VARCHAR(50) NOT NULL,
    KEY USING HASH(fname)
) ENGINE=MEMORY;

INSERT INTO hr.testhash SELECT first_name, last_name from hr.employees 
WHERE department_id IN (60,90);

EXPLAIN FORMAT=TREE SELECT * FROM hr.testhash;


--fulltext index
CREATE TABLE hr.full_t AS SELECT first_name,last_name FROM hr.employees;

ALTER TABLE hr.full_t ADD fulltext(first_name,last_name);

SHOW INDEXES FROM hr.full_t;

EXPLAIN FORMAT=TREE SELECT * FROM hr.full_t WHERE MATCH(first_name,last_name)
AGAINST ('Alexander%');


