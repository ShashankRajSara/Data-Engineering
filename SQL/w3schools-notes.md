- SQL keywords are NOT case sensitive: select is the same as SELECT

- The SELECT statement is used to select data from a database. The data returned is stored in a result table, called the result-set.

```sql
SELECT column1, column2, ...
FROM table_name;
SELECT * FROM Customers;
```
- The SELECT DISTINCT statement is used to return only distinct (different) values.

```sql
SELECT DISTINCT Country FROM Customers;
```

- The WHERE clause is used to filter records. It is used to extract only those records that fulfill a specified condition.

```sql
SELECT * FROM Customers
WHERE Country='Mexico';
```

- The WHERE clause can be combined with AND, OR, and NOT operators. The AND and OR operators are used to filter records based on more than one condition:
    - The AND operator displays a record if all the conditions separated by AND are TRUE.
    - The OR operator displays a record if any of the conditions separated by OR is TRUE.
    - The NOT operator displays a record if the condition(s) is NOT TRUE.
```sql
SELECT * FROM Customers
WHERE NOT Country='Germany' AND NOT Country='USA';

SELECT * FROM Customers
WHERE Country='Germany' AND (City='Berlin' OR City='München');

```
- The ORDER BY keyword is used to sort the result-set in ascending or descending order.
```sql
SELECT * FROM Customers
ORDER BY Country ASC, CustomerName DESC;
```
- The INSERT INTO statement is used to insert new records in a table.
```sql
INSERT INTO Customers (CustomerName, ContactName, Address, City, PostalCode, Country)
VALUES ('Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', '4006', 'Norway');
```
- NULL- A field with a NULL value is a field with no value.
- A NULL value is different from a zero value or a field that contains spaces. A field with a NULL value is one that has been left blank during record creation!

```sql
SELECT CustomerName, ContactName, Address
FROM Customers
WHERE Address IS NOT NULL;
```

- The UPDATE statement is used to modify the existing records in a table.
```sql
UPDATE Customers
SET ContactName = 'Alfred Schmidt', City= 'Frankfurt'
WHERE CustomerID = 1;
```
- The DELETE statement is used to delete existing records in a table.
```sql
DELETE FROM Customers WHERE CustomerName='Alfreds Futterkiste';
```

- LIMIT
```sql
SELECT * FROM Customers
WHERE Country='Germany'
LIMIT 3;
```

- MAX(), MIN()
```sql
SELECT MAX(Price) AS LargestPrice
FROM Products;

SELECT MIN(Price) AS SmallestPrice
FROM Products;
```


================ SQL Database ================================================================

- The CREATE TABLE statement is used to create a new table in a database.
```sql
CREATE TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);

CREATE TABLE TestTable AS
SELECT customername, contactname
FROM customers;
```

- The DROP TABLE statement is used to drop an existing table in a database.
```sql
DROP TABLE Shippers;
```

- The TRUNCATE TABLE statement is used to delete the data inside a table, but not the table itself.
```sql
TRUNCATE TABLE Shippers;
```

- ALTER TABLE:
    - The ALTER TABLE statement is used to add, delete, or modify columns in an existing table.
    - The ALTER TABLE statement is also used to add and drop various constraints on an existing table.

```sql
ALTER TABLE Customers ADD Email varchar(255);

ALTER TABLE Customers DROP COLUMN Email;

ALTER TABLE table_name RENAME COLUMN old_name to new_name;

ALTER TABLE table_name MODIFY COLUMN column_name datatype;
```

- SQL Constraints
    - SQL constraints are used to specify rules for the data in a table.

    - Constraints are used to limit the type of data that can go into a table. This ensures the accuracy and reliability of the data in the table. If there is any violation between the constraint and the data action, the action is aborted.

    - Constraints can be column level or table level. Column level constraints apply to a column, and table level constraints apply to the whole table.

    - The following constraints are commonly used in SQL:
        - NOT NULL - Ensures that a column cannot have a NULL value
        - UNIQUE - Ensures that all values in a column are different
        - PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
        - FOREIGN KEY - Prevents actions that would destroy links between tables
        - CHECK - Ensures that the values in a column satisfies a specific condition
        - DEFAULT - Sets a default value for a column if no value is specified
        - CREATE INDEX - Used to create and retrieve data from the database very quickly

```sql
ALTER TABLE Persons
ADD CONSTRAINT UC_Person UNIQUE (ID,LastName);

ALTER TABLE Persons
DROP INDEX UC_Person;

ALTER TABLE Persons
ADD PRIMARY KEY (ID);

ALTER TABLE Orders
ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);

ALTER TABLE Persons
ADD CONSTRAINT CHK_PersonAge CHECK (Age>=18 AND City='Sandnes');

ALTER TABLE Persons ADD CHECK (Age>=18);

ALTER TABLE Persons DROP CHECK CHK_PersonAge;
```

- The DEFAULT constraint is used to set a default value for a column.
```sql
ALTER TABLE Persons
ALTER City SET DEFAULT 'Sandnes';

ALTER TABLE Persons
ALTER City DROP DEFAULT;
```

- SQL CREATE INDEX Statement
    - The CREATE INDEX statement is used to create indexes in tables.
    - Indexes are used to retrieve data from the database more quickly than otherwise. The users cannot see the indexes, they are just used to speed up searches/queries.
    - Updating a table with indexes takes more time than updating a table without (because the indexes also need an update). So, only create indexes on columns that will be frequently searched against.

```sql
CREATE INDEX idx_lastname
ON Persons (LastName);

ALTER TABLE table_name
DROP INDEX index_name;
```

- AUTO INCREMENT Field
    - Auto-increment allows a unique number to be generated automatically when a new record is inserted into a table.
    - Often this is the primary key field that we would like to be created automatically every time a new record is inserted.
    - MySQL uses the AUTO_INCREMENT keyword to perform an auto-increment feature.
    - By default, the starting value for AUTO_INCREMENT is 1, and it will increment by 1 for each new record.

```sql
ALTER TABLE Persons AUTO_INCREMENT=100;
```