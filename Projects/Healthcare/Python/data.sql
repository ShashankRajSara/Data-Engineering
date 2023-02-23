-- Active: 1671688949427@@127.0.0.1@3308@healthcarepy

--mysql --local-infile=1 --port=3308 -u root -p

--18
CREATE TABLE IF NOT EXISTS hospitals (
    States VARCHAR(145),PHCs INT,CHCs INT,SDHs INT,DHs INT,Hospitals INT,HospitalBeds INT
    );

LOAD DATA LOCAL INFILE "C:/Users/Miles/Documents/GitHub/Futurense/Projects/Healthcare/Python/Clean_data/all_hospitals.csv"
INTO TABLE hospitals
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


--Census Table
CREATE TABLE IF NOT EXISTS census (
    State VARCHAR(145),District VARCHAR(145),Population INT,Male INT,Female INT,Literate INT,Literate_Male INT,
    Literate_Female INT,Households_Rural INT,Urban_Households INT,Households INT,Young_and_Adult INT,Middle_Aged INT,
    Senior_Citizen INT,Age_Not_Stated INT
);

LOAD DATA LOCAL INFILE "C:/Users/Miles/Documents/GitHub/Futurense/Projects/Healthcare/Python/Clean_data/Census_cleaned.csv"
INTO TABLE census
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;



--govt_hospitals Table
CREATE TABLE IF NOT EXISTS govt_hospitals (
State VARCHAR(145),Rural_Government_Hospitals INT,Rural_Government_Beds INT,Urban_Government_Hospitals INT,Urban_Government_Beds INT,Last_Updated date
);

LOAD DATA LOCAL INFILE "C:/Users/Miles/Documents/GitHub/Futurense/Projects/Healthcare/Python/Clean_data/government_hospital.csv"
INTO TABLE govt_hospitals
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

