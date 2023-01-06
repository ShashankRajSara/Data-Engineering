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
- 
