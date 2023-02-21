--To create a database with a proper character set and collation
CREATE DATABASE IF NOT EXISTS profile_maker CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- To use a DB
USE db_name;
USE profile_maker;

--To see the default character set and collation for a given database, use these statements:
SELECT @@character_set_database, @@collation_database;
--Alternatively, to display the values without changing the default database:
SELECT DEFAULT_CHARACTER_SET_NAME, DEFAULT_COLLATION_NAME
FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'db_name';


--Creating a `users` table
CREATE TABLE `users` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, 
  `username` varchar(25) NOT NULL UNIQUE,
  `password` varchar(25) NOT NULL,
  `prefix` enum('Mr.','Mrs.','Ms.', 'Mx.') DEFAULT NULL,
  `name` varchar(25) DEFAULT NULL, 
  `email` varchar(50) DEFAULT NULL, 
  `mobile` varchar(10) DEFAULT NULL, 
  `age` tinyint UNSIGNED DEFAULT NULL, 
  `gender` enum('Male','Female','Genderqueer', 'Undisclosed') DEFAULT NULL, 
  `state` varchar(30) DEFAULT NULL, 
  `profilePic` varchar(50) DEFAULT NULL,
  `resume` varchar(50) DEFAULT NULL,
  `creationTime` datetime DEFAULT CURRENT_TIMESTAMP, 
  `modificationTime` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `PK_users` PRIMARY KEY (`id`),
  CONSTRAINT `UQ_users_email` UNIQUE (`email`),
  CONSTRAINT `UQ_users_profilePic` UNIQUE (`profilePic`),
  CONSTRAINT `UQ_users_resume` UNIQUE (`resume`),
  CONSTRAINT `CHK_users_mobile` CHECK(`mobile` is null or `mobile` regexp '^[0-9]{10}$'),
  INDEX `IX_users_email` (`email`),
  INDEX `IX_users_username_password` (`username`, `password`)
) ENGINE=InnoDB;

--Creating a `skills` static table
CREATE TABLE `skills` (
  `id` smallint UNSIGNED NOT NULL AUTO_INCREMENT,
  `skillName` varchar(25) NOT NULL,
  CONSTRAINT `PK_skills` PRIMARY KEY (`id`),
  CONSTRAINT `UQ_skills_skillName` UNIQUE (`skillName`),
  INDEX `IX_skills_skillName` (`skillName`)
) ENGINE=InnoDB;

--Creating a `user_skills` junction/pivot/association/cross-reference table
CREATE TABLE `user_skills` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` int(11) UNSIGNED NOT NULL,
  `skillId` smallint UNSIGNED NOT NULL,
  CONSTRAINT `PK_userskills` PRIMARY KEY (`id`),
  CONSTRAINT FK_users_userskills FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE, 
  CONSTRAINT FK_skills_userskills FOREIGN KEY (`skillId`) REFERENCES `skills` (`id`) ON DELETE CASCADE,
  UNIQUE INDEX `IX_userskills_userId_skillId` (`userId`, `skillId`)
) ENGINE=InnoDB;

--Note
/* If the table has a multiple-column index, 
  any leftmost prefix of the index can be used by the optimizer to look up rows. 
  For example, if you have a three-column index on (col1, col2, col3), 
  you have indexed search capabilities on (col1), 
  (col1, col2), 
  and (col1, col2, col3). */

--Showing all tables in a DB
SHOW tables;

--Showing CREATE TABLE command used for `users`
SHOW CREATE TABLE `users`;

--Getting information about `users` relation (table) schema
DESC `users`;
--Alternatively:
DESCRIBE `users`;
-- Alternatively:
SHOW columns FROM profile_maker.`users`;

--Showing all existing indexes on `users` table
SHOW INDEXES from `users`;

--Dropping an existing index on `users` table
DROP INDEX `IX_users_email` on `users`;
DROP INDEX `username` on `users`; 

--Adding an index via ALTER TABLE command to the `users` table
ALTER TABLE users ADD CONSTRAINT UQ_users_username UNIQUE (username); 

-- Dropping the PRIMARY index
ALTER TABLE `users` DROP PRIMARY KEY;

  
--Inserting a record into a `users` table
INSERT INTO `users` ( 
                      `username`, 
                      `password`, 
                      `prefix`, 
                      `name`, 
                      `email`,
                      `age`,
                      `gender`,
                      `state`,
                      `profilePic`,
                      `resume` ) 
             VALUES ( 
                      'akash', 
                      'mindfire', 
                      'Mr.', 
                      'Akash Das', 
                      'mfs.akash@gmail.com',
                      '24',
                      'Male', 
                      'Odisha', 
                      'profile_photo1580209112127.0.0.1.png', 
                      'Resume1580205705127.0.0.1.pdf' );

--Inserting multiple records at once into `skills` relation (w/o mentioning column names)
INSERT INTO 
            `skills` 
      VALUES
            (null, 'HTML'),
            (null, 'CSS'), 
            (null, 'JavaScript'), 
            (null, 'jQuery'), 
            (null, 'MySQL'), 
            (null, 'PHP');

--Inserting records into `user_skills` table
INSERT INTO `user_skills` VALUES(null, 1, 1);
INSERT INTO `user_skills` VALUES(null, 1, 2);
INSERT INTO `user_skills` VALUES(null, 1, 3);


--Updating a record in `users` table
UPDATE `users` SET `mobile` = '9987654321' WHERE `username` = 'akash';


--Setting MySQL to strict mode
SET SQL_MODE = 'STRICT_ALL_TABLES';

--Alternatively
SET @@SESSION.SQL_MODE = 'STRICT_ALL_TABLES';

--Which, must be set for every session. And you can check this by running the following:
SELECT @@SESSION.SQL_MODE; -- 'STRICT_ALL_TABLES'
SELECT @@GLOBAL.SQL_MODE; -- 'NO_ENGINE_SUBSTITUTION'

--If you have access please set this at the global level:
SET @@GLOBAL.SQL_MODE = 'STRICT_ALL_TABLES';