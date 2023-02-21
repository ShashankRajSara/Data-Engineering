- ACID
    --ACID is an acronym that refers to the set of 4 key properties that define a transaction: Atomicity, Consistency, Isolation, and Durability.
    --If a database operation has these ACID properties, it can be called an ACID transaction, and data storage systems that apply these operations are called transactional systems.
    --ACID transactions guarantee that each read, write, or modification of a table has the following properties:
        Atomicity - each statement in a transaction (to read, write, update or delete data) is treated as a single unit. Either the entire statement is executed, or none of it is executed. This property prevents data loss and corruption from occurring if, for example, if your streaming data source fails mid-stream.
        Consistency - ensures that transactions only make changes to tables in predefined, predictable ways. Transactional consistency ensures that corruption or errors in your data do not create unintended consequences for the integrity of your table.
        Isolation - when multiple users are reading and writing from the same table all at once, isolation of their transactions ensures that the concurrent transactions don’t interfere with or affect one another. Each request can occur as though they were occurring one by one, even though they're actually occurring simultaneously.
        Durability - ensures that changes to your data made by successfully executed transactions will be saved, even in the event of system failure.

-Database Architecture (3 Level Architecture)

    External Level (Individual User View)
                    v
    Conceptual Level (community user view)
                    v
    Internal level (storage view)
                    v
                 Database

- 4-Steps to create database
    --Collect the Database
    --Prepare ER Diagrams
    --Convert ER diagrams into tables
    -- Normalize the table

-ER Diagrams:
    --Entity
    --Relationship
    --attributes => *Defining Columns*
    --Keys   => *Uniquely identifies a row/tuple*
        
- REDUNDANCY
    - Same data stored in multiple locations
    - memory
    - inconsistancy
==============================================================================

- NORMALIZATION
    - Dependencies: 
        - Functional => A depends on B
        - Partial => (A,B) => C
        - Transitive => attribute depends on an attribute other than primary key

- Normal Forms:
    - 1 NF:
        - Eliminate repeating groups
        - ensures atomic values
    - 2 NF
    - 3 NF

- Constraints can be defined at 2 levels
    - Column Level
    - Table level

==============================================================
**SELECT**

- *DISTINCT* => 
    - Eliminates Duplicates
    - Applied only on 1st column, based upon 1st column 2nd column having duplicates
    - we can use distinct only once in the SELECT Statement
    - Single column must be given to DISTINCT

- *COLUMN ALIASING:*
    - To change display headings
    - 3 Ways:
        - ENAME "empname" 
        - ENAME AS "empname"
        - ENAME empname

- *SET:* Define a Variable and assign value to it
    - SET @v1=20;
    - SET @v2=3000, @v4=5000;

- *ORDER BY;*
    - To Sort the data
    - Ways:
        - ORDER BY ename;
        - ORDER BY ename asc;
        - ORDER BY ename DESC;
        - ORDER BY <COLUMN N0>
        - ORDER BY 'ALIAS'  => *MySQL Does not Give As ANTICIPATED*
        - ORDER BY ALIAS => MySQL ORDERs

- *LIMIT:*
    - Limits the number of rows for Display
    - LIMIT(x,y)  => Skip x and show y records

- **SQL Functions:**
    - Single-Row Functions => Character, Numer, Date & Control Functions
    - Multiple-Row Functions 

- Character Functions:
    - CONCAT()
    - UPPER()
    - LOWER()
    - SUBSTR('str')
    - SUBSTR('str',1) => From first position remaining will be displayed
    - SUBSTR('str',1,3) => from 1st position upto a length of 3
    - INSTR('str',3) => Position of the Specified characted => ONLY THE FIRST OCCURANCE
    - LEFT/RIGHT => Displays Starting FROM Left/Right 
    - TRIM()    => SELECT TRIM('h' FROM 'helloh');
    - REPLACE(str,'a','b') => 
    - LPAD/RPAD - left/right padding the giving character to specified length
    - REPEAT('str',10) => repeating str 10 times
    - REVERSE()

*No of A's in the String*
SELECT  LENGTH("MARY HAD A LITTILE LAMB")-LENGTH(REPLACE("MARY HAD A LITTILE LAMB",'A',''));


- NUMBER Functions:
    - MOD(num,1) => Modulus Function
    - SIGN(A-B) => A>B = 1 , A=B 0, A<B = -1;
    - CHAR
    - ROUND
    - TRUNCATE
    - CEIL
    - FLOOR

==========================================
DATE FUNCTIONS

- Returning Current Date and Time 
    - CURDATE()
    - CURRENT_DATE
    - NOW()
    - CURRENT_TIMESTAMP
    - SYSDATE()
- Returning Date& Time Parts
    - DATE()
    - TIME()
    - YEAR()
    - MONTH()
    - MONTHNAME()
    - DAY()
    - DAYNAME()
    - HOUR()
    - MI()
    - QUARTER()
- Modifying Dates
- Returning Difference between dates

**DATE_FORMAT**
-  %a => 3 letter day
-  %W => Whole day
-  %b => 3 letter month
-  %M => full month
-  %y => 2 digits
-  %Y => 4 digits
-  %d => day count in month
-  %w => day count in a week
-  %j => day count in a year

- EXTRACT
    - extract(year from 'date')
    - extract(month from 'date')
    - extract(day from 'date')

- Returning Difference
    - DATEDIFF('date1','date2') => Only two arguments
    - TIMESTAMPDIFF() => Year, Month, Day
    - 

- Modifying Dates
    - DATE_ADD => Years, Months, Days
    - DATE_SUB => YEARS, Months, Days
    - INTERVAL '1' Year
    - SELECT DATE_ADD(CURDATE(), INTERVAL '1' YEAR) 'ADD1YEAR';

- LAST_DAY() => Shows the last day of the Month
- MAKEDATE() => returns the date, if integers are given
    - MAKEDATE(YEAR,Days)

- STR_TO_DATE() => String to Date

===========================
CONTROL FUNCTIONS

- **IF (A,B,C):**
    - If A is TRUE Returns B else C

- **CASE**
    -  CASE WHEN <CONDITION> THEN <VAL1>
        ....
        ..
        ELSE <VALN>
        END

    -     SELECT ename, sal, job,
    (CASE JOB WHEN 'CLERK' THEN 1.75*Sal 
            WHEN 'SALESMAN' THEN 2*SAL
            WHEN 'Analyst' THEN 1.75*SAL
            ELSE SAL 
            END) 'BONUS'

    FROM emp ORDER BY 3;

- NULLIF(A,B)
    - IF A=B Returns NULL Else A

- IFNULL
    IFNULL(A,B)

===============================
**Aggregate Functions**

SET @@sql_mode="only_full_group_by";

Also called as Multirow functions or group functions

*AVG & SUM => Only be used for Numeric Data Types*

- COUNT()
    - COUNT(*) => includes NULL values
    - COUNT(<column>) => excludes NULL Values 
- MIN
- MAX
- AVG
- SUM 
a

===========================
MATH

- SET Operators:
    - to select Data from similar select statements
    - No of columns should be same in all select statements

- TYPES:
    - UNION => Shows Distinct Values
    - UNION ALL => Shows all the values including Duplicates
    - INTERSECTION => Common values

- ORDER BY  
    - It should be used after all select statements
    - but it workd only for 1st select statement

================================

JOINS - To Select Data from multiple Tables

2 Types of Syntaxes:

Oracle Propritary Syntax                     SQL-99
====================================================================
 EQUI                                       INNER JOIN
 OUTER                                      OUTER(L,R,F)
 NON EQUI                                   JOIN(Different Tables)
 CARTESIAN                                  CROSS
 SELF                                       NATURAL, USING

RULES(SQL-99)
====================
1. Column names sould have the format
    e.ename OR emp.ename
    d.dname OR dept.dname
    E,D are called table aliases

2. Type of JOIN to be Specified (INNER, OUTER, NATURAL, CROSS..)

3. Join Condition uses ON Clause

4. Additional Conditions will be done Using:
    - AND operator
    - WHERE Clause

- INNER JOIN => Uses "=" Operator
- OUTER JOIN => INNER JOIN + Missing Data
- NON EQUI => Other than '=' operator for Joining
- NATURAL JOIN => Joined naturally on common columns, No condition should be mentioned. Shouldn't use when there are more than one column column.
- USING- if column name is same


================================
SUB-QUERY

- SELECT INSIDE SELECT
- Evaluating Unknown Through Known

TYPES
- Single Row => Returns 1 Row                   =,<>,<,>
- Multiple Row => Returns more than 1 Row       IN,NOT IN,ANY,ALL
- MULTIPLE Column
- Nested
- Correlated

RULES for SUBQUERY
------------
1. Sub Query Executes 1st
2. Result Will be used by OUTER query and then gets executed
3. Sub query should be enclosed in brackets



================
-NULL
    --NULL values are not 0 or BLANK
    --It represents Unknown values
    --use IS NULL or IS NOT NULL to retrive NULL values



-INSERT
    --Default order => INSERT INTO COMPANY_NEW VALUES (1, 'WIPRO');
    --Changed Order => INSERT INTO COMPANY_NEW(compname,compid) VALUES ('TCS',2);
    --Multiple Rows => INSERT INTO COMPANY_NEW VALUES (3,'ORACLE'),(4,'INFOSYS'),(5,'SG'),(6,'CTS');
    --Using SET variable => SET @v1=7, @v2='emc2'; INSERT INTO company_new values (@v1,@v2);
    --Inserting NULL => Omit the column(INSERT INTO company_new(compid) VALUES (9);) , Explicitly use NULL (INSERT INTO company_new VALUES (8,NULL);)
    --Copying rows from other table => INSERT INTO company_new SELECT col1,col2 FROM <Tablename> ==VALUES Keyword is not present in this Command==
    --Explicitly Default => INSERT INTO default_tab VALUES(201,DEFAULT);

-UPDATE => Modifying existing Rows
    --Syntax: UPDATE <tablename> SET col1=value1,col2=value2 WHERE <condition>
    --

=====================
DCL
==============
GRANT and REVOKE

- Permissions to interact with Database


================================================================
TCL
---------

- COMMIT and ROLLBACK

START TRANSACTION;
DML
ROLLBACK;

- LOCKING
- DDL & DCL commands will auto commit a Transaction.

================================================================

Difference between DELETE and TRACE 

TRUNCATE                                DELETE
----------------------------------------------------------------
- DDL commands                           - DML
- WHERE Clause can't be used            - WHERE clause can be used
- NO ROLLBACK                           - ROLLBACK using START TRANSACTION

- DROP - Removes Structure and Data.


================================================================
DDL - DATA Definition Language

CREATE, ALTER, DROP, TRUNCATE 

- ALTER 
    - ADD COLUMNS, CONSTRAINTS(except NOT NULL)
    - MODIFY 
        - NULL TO NOT NULL
        - CHANGE DATATYPE 
        - CHANGE SIZE 
        - CHANGE DEFAULT
    - RENAME
        - COLUMNS
        - TABLE
    - DROP
        - COLUMNS
        - CONSTRAINTS


===============
VIEWS
===============

- Virtual Table
- Types - Simple and Complex

SIMPLE                                                          COMPLEX
---------------------------------------------------------------------------
OUT OF Single Table                                         More than one table
Permits DML                                                 Not always


- No DMLs on Views
    - Group BY
    - GROUP functions
    - Union operator
    - DISTINCT 

================================================================

Programming
================================================================

- Procedures
- Functions
- Triggers

*NOTE: 
    - DO NOT USE '\' - It is a escape character*
    - DO NOT USE DDL & DCL shouldn't be used

- BEGIN-----END

- PROCEDURE
    - SPECIFIC ACTION(SELECT, INSERT, UPDATE, DELETE...)
    - Modular Programming
    - Pre Compiled
    - IN, OUT, INOUT

- Rules for Variables
    - Should be declared after the begin statement
    - Each variable should be declared separately
    - Do not use column names for variables
    - Ex:   DECLARE v1 int;

- 3 attributes
    - Sequence => Order in which code should be flow => CASE
    - Selection => Choice making process => *IF ELSEIF ELSE*
    - Iteration => WHILE, SIMPLE, REPEAT


- IF
    IF <cond> THEN 
        <statement>;
    END IF;

- IF ELSE
    IF <cond> THEN
        STATEMENT;
    ELSE
        statement;
    END IF;

- ELSEIF
    IF <cond> THEN
        statement;
    ELSEIF <cond> THEN
        statement;
    ELSE
        statement;
    END IF;



- WHILE:
    - Does the activity as long as condition is true
    - Syntax:
        DELIMITER $$
        CREATE PROCEDURE sp_name()
        BEGIN
            DECLARE
            WHILE <condition> DO
                statements;
            END WHILE;
        END $$


- --command to see routines in a database
```sql
        SELECT SPECIFIC_name, ROUTINE_type
        FROM INFORMATION_SCHEMA.routines
        WHERE routine_schema='hr';
```

- FUNCTION:
    - Procedure [may or may not return a value], [Does not contain return statement], [cant be used directly with SQL statements]
    - function [Must return a single value], [return statement is must], [cant be used with SQL statements directly]
    - Syntax:
    ```sql
        CREATE FUNCTION <functionname> () 
        RETURNS DATATYPE 
        DETERMINISTIC
        BEGIN
            DECLARE
            ..
            ..
            RETURN
        END
    ```


- TRIGGER
    - Whenever event occurs triggers fires
    - INSERT, UPDATE, DELETE
    - TIMINGS - BEFORE, AFTER
    - ROW LEVEL - NEW, OLD

                *NEW*                 *OLD*
    INSERT      yes                   no
    UPDATE      yes                   yes
    DELETE      no                    yes

```sql
    CREATE TRIGGER <name>
    BEFORE/AFTER <event>
    ON <tablename>
    FOR EACH ROW
    BEGIN
        STATEMENTs
    END
```


==============================================
WINDOW FUNCTIONS
============================================

- OVER() => ORDER BY, Partition,
- Ranking Functions => Row_number(), rank(), dense_rank()

- NOTE: 
        - RANK() - When there is a tie, It leaves a Gap
        - DENSE_RANK() - No Gaps, when there is a tie

- *Comparing functions* - to compare value of the current row wrt to previous/next row
    - LAG - access data from previous row
    - LEAD - return data from next row
    - first_value - return
    - last_value 
        - RANGE- *Between unbounded preceding and unbounded following*
        - ROWS - *between unbounded preceding and current row*, *between current row and unbounded following*
    - nth_value - return

- Ntile - Divides the rows into partitions


================================================================
CTE - Common Table Expressions
================================================================

```sql
WITH dc AS 
(SELECT deptno, COUNT(*) cnt 
FROM emp GROUP BY deptno)
SELECT e.ename 'emp', e.deptno 'edep', m.ename 'manager', m.deptno 'mdep',
dc1.cnt 'empcount', dc2.cnt 'managercount'
FROM emp e JOIN emp m
ON e.mgr=m.empno
JOIN dc dc1 ON e.deptno=dc1.deptno
JOIN dc dc2 ON m.deptno=dc2.deptno;

```

==================  
Architecture
====================
- information_schema.files

- DATA Directory => SHOW variables like 'datadir';
- Base Directory => SHOW variables like 'basedir';


- rows inside datapages
- datapages inside extends
- extends inside datafiles
- datafiles inside tablespaces

- Other Table types
    - Partitioned tables
        - List Partitioning
        - Range partitioning => Most of the companies use this type of partitioning
    - Temporary tables

- SELECT
    - Parsing
    - Optimizing
    - Executing
    - Fetching

- FORCING INDEX
    - USE INDEX
    - FORCE INDEX
    - IGNORE INDEX

- Invisible Indexes
    - ALTER TABLE emp ALTER INDEX FK_deptno INVISIBLE;
    - To temporarily make INDEX invisible

- temporary table
    - available until session

- CURSOR
    - To handle result row by row
    - Declare, Open, Fetch, Close

- SELECT type
    - Simple
    - Primary
    - UNION
    - Subquery

- TYPE
    - NULL
    - ref => Non Unique
    - const Primary KEY/UNIQUE
    - INDEX_MERGE => Where clause columns having individual indexes
    - ALL
    - RANGE 

- Optimizer Join
    - Hash Join => No Indexes
    - Nested loops => 

- Composite Partition
    - Main Partition should be List/Range
    - Subpartition HASH
        - AND Operator

- INDEXES
    - UNIQUE
    - NON Unique
    - Functional Index
    - Hash Index