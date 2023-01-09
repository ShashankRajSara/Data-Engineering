-- Active: 1671688949427@@127.0.0.1@3308@hr

--1.
SELECT CONCAT(EmpFname,' ',EmpLname) 'FullName'
FROM EmployeeInfo
WHERE EmpFname LIKE 'S%'
AND
DOB > '02-05-1970' AND  DOB <'31-12-1975';

--2.
SELECT department, COUNT(EmpID) 'DeptEmpCount'
FROM EmployeeInfo
GROUP BY department
HAVING COUNT(EmpID)<2
ORDER BY COUNT(EmpID) DESC;


--3.
SELECT CONCAT(EmpFname,' ',EmpLname) 'FullName', EmpPosition
FROM EmployeeInfo ei
INNER JOIN EmployeePosition ep
USING (EmpID)
WHERE EmpPosition = 'Manager';

