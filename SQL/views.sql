-- Active: 1671688949427@@127.0.0.1@3308@hr

CREATE VIEW v1
AS SELECT employee_id, first_name, last_name, salary, job_id FROM employees
WHERE department_id =60;

SELECT * FROM v1;

CREATE VIEW v2 AS SELECT department_id, SUM(salary) 'Totalsalary'
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id;

SELECT * from v2;

DELETE from v2 WHERE department_id=10;


--complex VIEW
CREATE VIEW v4 AS SELECT region_name,country_name 
FROM regions NATURAL JOIN countries;

SELECT * FROM v4;

-- Cannot DELETE
DELETE FROM v4 WHERE region_name = 'americas';


CREATE VIEW v5 AS SELECT * FROM employees
WHERE department_id=90 WITH CHECK OPTION;


SELECT * FROM v5;

UPDATE v5 SET department_id=40 WHERE employee_id =100;
