-- Active: 1671688949427@@127.0.0.1@3308@healthcare

-- Problem Statement 1:
-- The healthcare department has requested a system to analyze the performance of stateReport companies and their plan.
-- For this purpose, create a stored procedure that returns the performance of different stateReport plans of an 
-- stateReport company. When passed the stateReport company ID the procedure should generate and return all the 
-- stateReport plan names the provided company issues, the number of treatments the plan was claimed for, and the name 
-- of the disease the plan was claimed for the most. The plans which are claimed more are expected to appear above the
--  plans that are claimed less.




DROP PROCEDURE `stateReport`;
DELIMITER //

CREATE PROCEDURE stateReport(comId INT)
BEGIN
    WITH cte AS (
    SELECT `planName`, `diseaseName`,
    COUNT(`treatmentID`) 'noOfTreatments',
    DENSE_RANK() OVER (PARTITION BY `companyID` ORDER BY COUNT(`treatmentID`) DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) 'dRank'
    FROM insurancecompany
    INNER JOIN insuranceplan USING(`companyID`)
    LEFT JOIN claim USING(UIN)
    LEFT JOIN treatment USING(`claimID`)
    INNER JOIN disease USING(`diseaseID`)
    WHERE `companyID`=comId
    GROUP BY `planName`, `diseaseName`
    ORDER BY noOfTreatments DESC
    )
    SELECT `planName`,`diseasename`, noOfTreatments FROM cte
    WHERE dRank=1;
END //

DELIMITER ;

CALL stateReport(1118);




-- Problem Statement 2:
-- It was reported by some unverified sources that some pharmacies are more popular for certain diseases. 
-- The healthcare department wants to check the validity of this report.
-- Create a stored procedure that takes a disease name as a parameter and would return the top 3 pharmacies 
-- the patients are preferring for the treatment of that disease in 2021 as well as for 2022.
-- Check if there are common pharmacies in the top 3 list for a disease, in the years 2021 and the year 2022.
-- Call the stored procedure by passing the values “Asthma” and “Psoriasis” as disease names and draw a conclusion
--  from the result.


DROP PROCEDURE `stateReport`;
DELIMITER //

CREATE PROCEDURE stateReport(disName VARCHAR(45))
BEGIN
    SELECT `pharmacyName`, COUNT(`treatmentID`) 'noOfTreatments'
    FROM pharmacy
    INNER JOIN prescription USING(`pharmacyID`)
    INNER JOIN contain USING(`prescriptionID`)
    INNER JOIN treatment USING(`treatmentID`)
    INNER JOIN disease USING(`diseaseID`)
    WHERE `diseaseName`=disName AND YEAR(date) IN (2021,2022)
    GROUP BY `pharmacyName`
    ORDER BY noOfTreatments DESC
    LIMIT 3;
END //

DELIMITER ;

CALL stateReport('Asthma');
CALL stateReport('Psoriasis');



-- Problem Statement 3:
-- Jacob, as a business strategist, wants to figure out if a state is appropriate for setting up an stateReport company or not.
-- Write a stored procedure that finds the num_patients, num_insurance_companies, and insurance_patient_ratio, 
-- the stored procedure should also find the avg_insurance_patient_ratio and if the insurance_patient_ratio of the 
-- given state is less than the avg_insurance_patient_ratio then it Recommendation section can have the value 
-- “Recommended” otherwise the value can be “Not Recommended”.

DROP PROCEDURE `stateReport`;
DELIMITER //

CREATE PROCEDURE stateReport(stName VARCHAR(45))
BEGIN
    WITH cte AS (
        SELECT state, COUNT(`patientID`) num_patients, COUNT(DISTINCT`companyID`) num_insurance_companies, 
        COUNT(DISTINCT`patientID`)/ COUNT(`companyID`) insurance_patient_ratio
        FROM address
        INNER JOIN insurancecompany USING(`addressID`)
        INNER JOIN person USING(`addressID`)
        INNER JOIN patient ON person.`personID`=patient.`patientID`
        INNER JOIN treatment USING(`patientID`)
        WHERE state=stName
        GROUP BY state
    ), cte2 AS (SELECT AVG(insurance_patient_ratio) avg_insurance_patient_ratio FROM cte)
    SELECT state, num_patients, num_insurance_companies, insurance_patient_ratio,
    CASE WHEN insurance_patient_ratio < avg_insurance_patient_ratio 
        THEN 'Recommended'
        ELSE 'Not Recommeded'
    END AS 'Recommendation'
     FROM cte,cte2
;
END //

DELIMITER ;

CALL stateReport('FL');


-- Description of the terms used:
-- num_patients: number of registered patients in the given state
-- num_insurance_companies:  The number of registered stateReport companies in the given state
-- insurance_patient_ratio: The ratio of registered patients and the number of stateReport companies in the given state
-- avg_insurance_patient_ratio: The average of the ratio of registered patients and the number of stateReport for all the states.


-- Problem Statement 4:
-- Currently, the data from every state is not in the database, The management has decided to add the data from other states
--  and cities as well. It is felt by the management that it would be helpful if the date and time were to be stored whenever
--  new city or state data is inserted.
-- The management has sent a requirement to create a PlacesAdded table if it doesn’t already exist, that has four attributes.
--  placeID, placeName, placeType, and timeAdded.

-- Description
-- placeID: This is the primary key, it should be auto-incremented starting from 1
-- placeName: This is the name of the place which is added for the first time
-- placeType: This is the type of place that is added for the first time. The value can either be ‘city’ or ‘state’
-- timeAdded: This is the date and time when the new place is added
CREATE TABLE IF NOT EXISTS placesAdded  ( 
    placeId BIGINT PRIMARY KEY AUTO_INCREMENT,
    placeName VARCHAR(65) NOT NULL,
    placeType ENUM('city','state'),
    timeAdded DATETIME );
    
ALTER TABLE placesAdded AUTO_INCREMENT=1;


-- You have been given the responsibility to create a system that satisfies the requirements of the management. 
-- Whenever some data is inserted in the Address table that has a new city or state name, the PlacesAdded table
-- should be updated with relevant data. 

DELIMITER // 
CREATE TRIGGER after_address_insert
AFTER INSERT 
ON address FOR EACH ROW BEGIN
IF (NEW.city NOT IN (SELECT placeName FROM placesAdded WHERE placeType='city')) THEN
    INSERT INTO placesAdded VALUES (NEW.addressId,NEW.city,'city',NOW());
ELSEIF (NEW.state NOT IN (SELECT placeName FROM placesAdded WHERE placeType='state')) THEN
    INSERT INTO placesAdded VALUES (NEW.addressId,NEW.state,'state',NOW());
ELSE
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='**No Record Inserted Into placesAdded Table**';
END IF;

END //

DELIMITER ;

INSERT INTO address VALUES(102,'102 Koramangala', 'Banglore','Karnataka',570095);

SELECT * FROM placesadded;

-- Problem Statement 5:
-- Some pharmacies suspect there is some discrepancy in their inventory management. 
-- The quantity in the ‘Keep’ is updated regularly and there is no record of it. They have requested to create a system 
-- that keeps track of all the transactions whenever the quantity of the inventory is updated.

-- You have been given the responsibility to create a system that automatically updates a Keep_Log table which has the following fields:
-- id: It is a unique field that starts with 1 and increments by 1 for each new entry
-- medicineID: It is the medicineID of the medicine for which the quantity is updated.
-- quantity: The quantity of medicine which is to be added. If the quantity is reduced then the number can be negative.
-- For example:  If in Keep the old quantity was 700 and the new quantity to be updated is 1000, then in Keep_Log the 
-- quantity should be 300.
-- Example 2: If in Keep the old quantity was 700 and the new quantity to be updated is 100, then in Keep_Log the 
-- quantity should be -600.
;

CREATE TABLE keep_log (
    id INT PRIMARY KEY AUTO_INCREMENT,
    medicine_id INT,
    quantity INT
    );
    
ALTER TABLE keep_log AUTO_INCREMENT=1;


DELIMITER // 
CREATE TRIGGER after_keep_insert
AFTER UPDATE 
ON keep FOR EACH ROW BEGIN

DECLARE v INT;
SET v= NEW.quantity - OLD.quantity;

UPDATE keep_log SET quantity= v WHERE medicineId=NEW.medicineId;

END //

DELIMITER ;




-- Q11

-- Problem Statement 1:
-- Patients are complaining that it is often difficult to find some medicines. 
-- They move from pharmacy to pharmacy to get the required medicine. 
-- A system is required that finds the pharmacies and their contact number that have the required medicine in their inventory.
--  So that the patients can contact the pharmacy and order the required medicine.
-- Create a stored procedure that can fix the issue


DELIMITER //

CREATE Procedure findMedicine(
    IN medName VARCHAR(30)
)
BEGIN
    SELECT p.pharmacyName, p.phone
    FROM pharmacy p
        JOIN keep k ON k.`pharmacyID` = p.`pharmacyID`
        JOIN medicine m on m.`medicineID` = k.`medicineID`
    WHERE m.productName = medName
    ;
END//

DELIMITER ;

CALL findMedicine("FAULDVINCRI");


-- Problem Statement 2:
-- The pharmacies are trying to estimate the average cost of all the prescribed medicines per prescription, 
-- for all the prescriptions they have prescribed in a particular year. 
-- Create a stored function that will return the required value when the pharmacyID and year are passed to it. 
-- Test the function with multiple values.


DROP FUNCTION avgCost_per_Prescription;

DELIMITER //

CREATE Function avgCost_per_Prescription(
    pharmId INT(15),
    yr INT(6)
)
RETURNS DECIMAL(20,6)
DETERMINISTIC
BEGIN
    declare avg_cost DECIMAL(20,6);
    SELECT  AVG(m.`maxPrice`) INTO avg_cost 
    FROM pharmacy p
        JOIN prescription pr ON pr.`pharmacyID` = p.`pharmacyID`
        JOIN contain c ON c.`prescriptionID` = pr.`prescriptionID`
        JOIN medicine m ON m.`medicineID` = c.`medicineID`
        JOIN treatment t ON t.`treatmentID` = pr.`treatmentID`
    WHERE YEAR(t.`date`) = yr and p.`pharmacyID` = pharmId
    GROUP BY p.`pharmacyID`
    ;

    RETURN avg_cost;
END//

DELIMITER ;

SELECT `pharmacyID`,`pharmacyName`, avgCost_per_Prescription(`pharmacyID`,2022)
FROM pharmacy;


-- Problem Statement 3:
-- The healthcare department has requested an application that finds out the disease that was spread the most in a state for a given year. 
-- So that they can use the information to compare the historical data and gain some insight.
-- Create a stored function that returns the name of the disease for which the patients from a particular
--  state had the most number of treatments for a particular year. Provided the name of the state and year is passed to 
--  the stored function.


DROP FUNCTION mostSpread_disease;

DELIMITER //

CREATE Function mostSpread_disease(
    states VARCHAR(5),
    yr INT(6)
)
RETURNS VARCHAR(200)
DETERMINISTIC
BEGIN
    declare maxDiseases VARCHAR(200);
    SELECT GROUP_CONCAT(dname) into maxDiseases
    FROM (
        SELECT a.state st, d.`diseaseName` dname, COUNT(distinct t.`patientID`) cnt, 
                DENSE_RANK() OVER(PARTITION BY a.state ORDER BY count(distinct t.`patientID`) desc) ranks
        FROM disease d
            JOIN treatment t on t.`diseaseID` = d.`diseaseID`
            JOIN person pr on pr.`personID` = t.`patientID`
            JOIN address a on a.`addressID` = pr.`addressID`
        WHERE YEAR(t.date) = yr and a.state = states
        GROUP BY a.state,d.`diseaseName`
        -- ORDER BY a.state, cnt desc
    ) a
    WHERE a.ranks = 1
    -- GROUP BY a.st
    ;

    RETURN maxDiseases;
END//

DELIMITER ;


select mostSpread_disease('AK', 2022);
-- FROM address;

select DISTINCT state FROM address;


-- Problem Statement 4:
-- The representative of the pharma union, Aubrey, has requested a system that she can use to find how many people in a 
-- specific CITY have been treated for a specific DISEASE in a specific YEAR.
-- Create a stored function for this purpose.



DROP FUNCTION cityWiseDisease_count;

DELIMITER //

CREATE Function cityWiseDisease_count(
    citys VARCHAR(30),
    dis VARCHAR(50),
    yr INT(6)
)
RETURNS INT
DETERMINISTIC
BEGIN
    declare cnt int;

    SELECT COUNT(distinct t.`patientID`) into cnt
    FROM disease d
        JOIN treatment t on t.`diseaseID` = d.`diseaseID`
        JOIN person pr on pr.`personID` = t.`patientID`
        JOIN address a on a.`addressID` = pr.`addressID`
    WHERE YEAR(t.date) = yr and a.city = citys and d.diseaseName = dis
    GROUP BY a.city,d.`diseaseName`
    ;

    RETURN cnt;
END//

DELIMITER ;

SELECT 'Norman', cityWiseDisease_count('Norman',"Alzheimer's disease",2022)
;

-- Problem Statement 5:
-- The representative of the pharma union, Aubrey, is trying to audit different aspects of the pharmacies. 
-- She has requested a system that can be used to find the average balance for claims submitted by a 
-- specific insurance company in the year 2022. 
-- Create a stored function that can be used in the requested application. 


DROP FUNCTION avgBal_ICompany;

DELIMITER //

CREATE Function avgBal_ICompany(
    icompany VARCHAR(30)
)
RETURNS DECIMAL(20,10)
DETERMINISTIC
BEGIN
    declare avg_bal DECIMAL(20,10);

    SELECT AVG(c.balance) into avg_bal
    FROM insurancecompany ic 
        JOIN insuranceplan ip on ic.`companyID` = ip.`companyID`
        JOIN claim c on c.uin = ip.uin
        JOIN treatment t on t.`claimID` = c.`claimID`
    WHERE YEAR(t.`date`) = 2022 and ic.`companyName` = icompany
    GROUP BY ic.`companyName`
    ORDER BY ic.`companyName`
    ;

    RETURN avg_bal;
END //

DELIMITER ;

SELECT avgBal_ICompany('Acko General Insurance Ltd.�');



