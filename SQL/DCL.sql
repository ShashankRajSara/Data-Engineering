-- Active: 1671688949427@@127.0.0.1@3308@hr

-- DCL - DATA Control Language
-- GRANT
-- REVOKE

-- Craete User
CREATE USER 'test'@'localhost' IDENTIFIED BY 'test';

SELECT USER FROM mysql.user;
SELECT DATABASE();

GRANT ALL PRIVILEGES ON hr.job_grades TO 'test'@'localhost';

SHOW GRANTS FOR test@localhost;

REVOKE ALL PRIVILEGES ON
hr.job_grades FROM test@localhost;

GRANT CREATE ON hr.* TO test@localhost;

GRANT INSERT ON hr.* to test@localhost;

GRANT SELECT ON hr.* TO test@localhost;

-- to see all GRANTS
SHOW GRANTS FOR test@localhost;


--To revoke all GRANTS
REVOKE ALL ON hr.* FROM test@localhost;

