-- Active: 1671688949427@@127.0.0.1@3308@hr
---ALTER TABLE

CREATE TABLE IF NOT EXISTS `test` (c1 int, c2 date, c3 char(2), c4 VARCHAR(20));

-- ADD COLUMN using ALTER
ALTER TABLE `test` ADD c5 TIMESTAMP;

--to enter at the first
ALTER TABLE `test` ADD c6 NUMERIC(10) first;
ALTER TABLE `test` ADD c7 SMALLINT AFTER c2;
desc test;

--Primary key
ALTER TABLE `test` ADD PRIMARY KEY (c1);

--CHECK
ALTER TABLE `test` ADD CONSTRAINT `CH_test` CHECK(c3 IN ('a','b','c','d','e','f'));

--UNIQUE 
ALTER TABLE `test` ADD CONSTRAINT `UQ_test` UNIQUE(c4);

--FOREIGN KEY
ALTER TABLE `test1` ADD CONSTRAINT `FK_test` FOREIGN KEY (c2) REFERENCES `test`(c2);

--CHANGE Datatype
ALTER TABLE `test1` MODIFY c5 TIMESTAMP NOT NULL;

--RENAME
ALTER TABLE `test` RENAME COLUMN c5 TO c51;
ALTER TABLE `test1` RENAME TO `test2`;

--DROP
ALTER TABLE `test` DROP COLUMN c51;

ALTER TABLE `test` DROP CONSTRAINT `UQ_test`;

-- alter set default
ALTER TABLE DEFAULT_tab alter c2 set DEFAULT 9.5;

------------------------------------Practice------------------------------------

CREATE TABLE `debt` (id INT(4) PRIMARY KEY AUTO_INCREMENT,name VARCHAR(25));

ALTER TABLE `debt` AUTO_INCREMENT=1001;

INSERT INTO `debt` (name) VALUES ('Agni'),('Tejas'),('Trishul');
SELECT * FROM `itpl_tab`;

ALTER TABLE debt ADD COLUMN location VARCHAR(15);

UPDATE `debt` SET place = CASE id 
                                        WHEN 1001 THEN 'banglore'
                                        WHEN 1002 THEN 'chennai' 
                                        WHEN 1003 THEN 'hyderabad' 
                                        WHEN 1004 THEN 'delhi' END;

--d
ALTER TABLE `debt` RENAME COLUMN location TO place;

--e
ALTER TABLE `debt` RENAME itpl_tab;

--f

ALTER TABLE itpl_tab MODIFY id INT(10) NOT NULL;
ALTER TABLE `itpl_tab` DROP PRIMARY KEY;

--g
CREATE TABLE `itpl_bak` AS SELECT * FROM `itpl_tab`;

SELECT * from itpl_tab;
--h
DROP TABLE itpl_tab;

--change DEFAULT VALUES
CREATE TABLE DEFAULT_tab (c1 int,c2 numeric(10,2) DEFAULT 10.25);

desc default_tab;

ALTER TABLE DEFAULT_tab alter c2 set DEFAULT 9.5;

