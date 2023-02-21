-- Active: 1671688949427@@127.0.0.1@3308@db_optimised
CREATE TABLE COMPANY_NEW (
    compid SMALLINT PRIMARY KEY,
    compname VARCHAR(20)
);

--Default Order
INSERT INTO COMPANY_NEW VALUES (1, 'WIPRO');

--Changed Order
INSERT INTO COMPANY_NEW(compname,compid) VALUES ('TCS',2);

--Multiple Rows
INSERT INTO COMPANY_NEW VALUES (3,'ORACLE'),(4,'INFOSYS'),(5,'SG'),(6,'CTS');

--Using SET variables
SET @v1=7, @v2='emc2';

INSERT INTO company_new values (@v1,@v2);

--Inserting NULL
INSERT INTO company_new(compid) VALUES (9);
INSERT INTO company_new VALUES (8,NULL);


--INSERT INTO Using DEFAULT
CREATE TABLE DEFAULT_TAB (c1 INT PRIMARY KEY, c2 TIMESTAMP DEFAULT Now());
DESC DEFAULT_tab;

INSERT INTO default_tab(c1) VALUES(101);
INSERT INTO default_tab VALUES(201,DEFAULT);

SELECT * FROM default_tab;