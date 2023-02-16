-- Active: 1671688949427@@127.0.0.1@3308@assignments

-- Active: 1671688949427@@127.0.0.1@3308@assignments
/*
1. Write a SQL statement to create a table countries including columns country_id, country_name, and region_id, and
    make sure that the combination of columns country_id and region_id will be unique.
*/

CREATE TABLE IF NOT EXISTS `countries` (
    `country_id` smallint UNSIGNED NOT NULL AUTO_INCREMENT,
    `country_name` varchar(30) DEFAULT  NULL,
    `region_id` smallint UNSIGNED DEFAULT NULL,
    CONSTRAINT `UQ_crid` UNIQUE (country_id,region_id)
) ENGINE=InnoDB;

ALTER TABLE `countries` ADD CONSTRAINT `FK_` FOREIGN KEY

SHOW CREATE TABLE countries;


/*
2. Write a SQL statement to create a table named jobs including columns job_id, job_title, min_salary, and max_salary, 
    and make sure that, the default value for job_title is blank and min_salary is 8000 and max_salary is NULL will be entered 
    automatically at the time of insertion if no value assigned for the specified columns.
*/

CREATE TABLE IF NOT EXISTS `jobs` (
    `jobs_id` int UNSIGNED NOT NULL AUTO_INCREMENT, 
    `job_title` varchar(30) DEFAULT '',
    `min_salary` INT UNSIGNED DEFAULT 8000,
    `max_salary` INT UNSIGNED DEFAULT NULL,
    CONSTRAINT `PK_jid` PRIMARY KEY (jobs_id)
)ENGINE= InnoDB;

/*
3. Write a SQL statement to create a table job_history including columns employee_id, start_date, end_date, job_id, 
and department_id and make sure that, the employee_id column does not contain any duplicate value at the time of insertion
 and the foreign key column job_id contain only those values which exist in the jobs table.

Here is the structure of the table jobs;

Field	Type	Null	Key	Default	Extra
JOB_ID	varchar(10)	NO	PRI		
JOB_TITLE	varchar(35)	NO		NULL	
MIN_SALARY	decimal(6,0)	YES		NULL	
MAX_SALARY	decimal(6,0)	YES		NULL	
*/

CREATE TABLE IF NOT EXISTS `job_history`(
    `employee_id` int UNSIGNED UNIQUE,
    `start_date` date,
    `end_date` date,
    `job_id` int UNSIGNED,
    `department_id` int UNSIGNED,
    CONSTRAINT  `FK_jobid` FOREIGN KEY (`job_id`) REFERENCES `jobs`(`jobs_id`) ON DELETE CASCADE
)ENGINE=InnoDB;

/* 
4. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, email,
 phone_number hire_date, job_id, salary, commission, manager_id, and department_id and make sure that the employee_id 
 column does not contain any duplicate value at the time of insertion and the foreign key columns combined by department_id 
 and manager_id columns contain only those unique combination values, which combinations exist in the departments table.

Assume the structure of the departments table below.

Field	Type	Null	Key	Default	Extra
DEPARTMENT_ID	decimal(4,0)	NO	PRI	0	
DEPARTMENT_NAME	varchar(30)	NO		NULL	
MANAGER_ID	decimal(6,0)	NO	PRI	0	
LOCATION_ID	decimal(4,0)	YES		NULL	
*/

DROP TABLE `departments`;
CREATE TABLE IF NOT EXISTS `departments` (
    `department_id` int UNSIGNED NOT NULL DEFAULT 0,
    `department_name` varchar(30) DEFAULT NULL,
    `manager_id` int UNSIGNED NOT NULL DEFAULT 0,
    `location_id` int UNSIGNED DEFAULT NULL
)ENGINE=InnoDB;
ALTER TABLE `departments` ADD CONSTRAINT `PK_departments` PRIMARY KEY (`department_id`);
ALTER TABLE `departments` ADD CONSTRAINT `UQ_departments_manager_id` UNIQUE (`manager_id`);


CREATE TABLE IF NOT EXISTS `employees` (
    `employee_id` int UNSIGNED UNIQUE,
    `first_name` varchar(30) DEFAULT NULL,
    `last_name` varchar(30) DEFAULT NULL,
    `email` varchar(40) DEFAULT NULL,
    `phone_number`varchar(10) DEFAULT NULL,
    `hire_date` date,
    `job_id` int NOT NULL,
    `salary` INT DEFAULT NULL,
    `commission` INT DEFAULT NULL,
    `manager_id` int UNSIGNED NOT NULL DEFAULT 0,
    `department_id` int UNSIGNED NOT NULL DEFAULT 0
)ENGINE=InnoDB;

ALTER TABLE `employees` ADD CONSTRAINT `FK_departments_employees` FOREIGN KEY (`manager_id`,`department_id`) REFERENCES departments(`manager_id`,`department_id`) ON DELETE CASCADE;
desc employees;

/*
8. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, job_id, salary and make sure that, 
the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column job_id, referenced by the
 column job_id of jobs table, can contain only those values which are exists in the jobs table. The InnoDB Engine have been used to create the tables.
  The specialty of the statement is that, The ON DELETE NO ACTION and the ON UPDATE NO ACTION actions will reject the deletion and any updates.
  */

CREATE TABLE employees(
    `employee_id` int NOT NULL,
    `first_name` varchar NOT NULL,
    `last_name` varchar NOT NULL,
    `job_id` varchar NOT NULL,
    `salary` int NOT NULL,
    PRIMARY KEY (`employee_id`),
    UNIQUE KEY `employee_id` (`employee_id`),
    UNIQUE KEY `first_name` (`first_name`, `last_name`),
    UNIQUE KEY `job_id` (`job_id`),
    UNIQUE KEY `employee_id` (`employee_id`)

)ENGINE=InnoDB;



