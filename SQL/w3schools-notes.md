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
- The LIKE operator is used in a WHERE clause to search for a specified pattern in a column.

    - There are two wildcards often used in conjunction with the LIKE operator:
        - The percent sign (%) represents zero, one, or multiple characters
        - The underscore sign (_) represents one, single character
        - The percent sign and the underscore can also be used in combinations!

```sql
SELECT * FROM Customers
WHERE CustomerName LIKE 'a__%';

SELECT * FROM Customers
WHERE City LIKE 'L_n_on';
```

- The IN operator allows you to specify multiple values in a WHERE clause. The IN operator is a shorthand for multiple OR conditions.

```sql
SELECT * FROM Customers
WHERE Country NOT IN ('Germany', 'France', 'UK');

SELECT * FROM Customers
WHERE Country IN (SELECT Country FROM Suppliers);
```

- The BETWEEN operator selects values within a given range. The values can be numbers, text, or dates. The BETWEEN operator is inclusive: begin and end values are included.

```sql
SELECT * FROM Orders
WHERE OrderDate BETWEEN '1996-07-01' AND '1996-07-31';

SELECT * FROM Products
WHERE ProductName NOT BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni'
ORDER BY ProductName;
```
- A *JOIN* clause is used to combine rows from two or more tables, based on a related column between them.

```sql
SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate
FROM Orders
INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID;
```
- JOINs
    - INNER JOIN: Returns records that have matching values in both tables
    - LEFT JOIN: Returns all records from the left table, and the matched records from the right table
    - RIGHT JOIN: Returns all records from the right table, and the matched records from the left table
    - CROSS JOIN: Returns all records from both tables

```sql
SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate
FROM Orders
INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID;

SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
CROSS JOIN Orders
WHERE Customers.CustomerID=Orders.CustomerID;

SELECT column_name(s)
FROM table1 T1, table1 T2
WHERE condition;
```
- The *UNION* operator is used to combine the result-set of two or more SELECT statements.
    - Every SELECT statement within UNION must have the same number of columns
    - The columns must also have similar data types
    - The columns in every SELECT statement must also be in the same order

```sql
SELECT City, Country FROM Customers
WHERE Country='Germany'
UNION
SELECT City, Country FROM Suppliers
WHERE Country='Germany'
ORDER BY City;
```

- The MySQL GROUP BY Statement:
    - The GROUP BY statement groups rows that have the same values into summary rows, like "find the number of customers in each country".
    - The GROUP BY statement is often used with aggregate functions *(COUNT(), MAX(), MIN(), SUM(), AVG())* to group the result-set by one or more columns.

```sql
SELECT Shippers.ShipperName, COUNT(Orders.OrderID) AS NumberOfOrders FROM Orders
LEFT JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID
GROUP BY ShipperName;

SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
ORDER BY COUNT(CustomerID) DESC;
```

- HAVING - The HAVING clause was added to SQL because the WHERE keyword cannot be used with aggregate functions.

```sql
SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders
FROM Orders
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE LastName = 'Davolio' OR LastName = 'Fuller'
GROUP BY LastName
HAVING COUNT(Orders.OrderID) > 25;
```

- EXISTS - The EXISTS operator is used to test for the existence of any record in a subquery. The EXISTS operator returns TRUE if the subquery returns one or more records.
```sql
SELECT SupplierName
FROM Suppliers
WHERE EXISTS (SELECT ProductName FROM Products WHERE Products.SupplierID = Suppliers.supplierID AND Price = 22);

```

======================================================= SQL DATABASE ================================================================

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