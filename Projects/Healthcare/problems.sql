-- Active: 1671688949427@@127.0.0.1@3308@healthcare


--1.

-- Problem Statement 1:  Jimmy, from the healthcare department, has requested a report that shows how the number of treatments each 
-- age category of patients has gone through in the year 2022. The age category is as follows, Children (00-14 years), 
-- Youth (15-24 years), Adults (25-64 years), and Seniors (65 years and over). 
-- Assist Jimmy in generating the report. 
with patientCte AS (
    SELECT `patientID`,TIMESTAMPDIFF(YEAR,dob,NOW()) AS `age` FROM patient
)
SELECT CASE WHEN age <15 THEN 'Children'
            WHEN age>=15 AND age<=24 THEN 'Youth'
            WHEN age>=25 AND age<=64 THEN 'Adults'
            ELSE 'Seniors' END AS `age Category`,COUNT(*) FROM patientCte p
NATURAL JOIN treatment t
WHERE YEAR(t.date)=2022
GROUP BY `age Category`;



-- Problem Statement 2:  Jimmy, from the healthcare department, wants to know which disease is 
-- infecting people of which gender more often.
-- Assist Jimmy with this purpose by generating a report that shows for each disease the male-to-female ratio. 
-- Sort the data in a way that is helpful for Jimmy.

SELECT d.`diseaseName`, sum(CASE WHEN p.gender = 'male' THEN 1 ELSE 0 end)/sum(CASE WHEN p.gender = 'female' THEN 1 ELSE 0 end) male_to_female_ratio
FROM disease d 
    JOIN treatment t on d.`diseaseID` = t.`diseaseID`
    JOIN person p on p.`personID` = t.`patientID`
GROUP BY d.`diseaseName`;

-- Problem Statement 3: Jacob, from insurance management, has noticed that insurance claims are not made for all the treatments. 
-- He also wants to figure out if the gender of the patient has any impact on the insurance claim. Assist Jacob in this situation 
-- by generating a report that finds for each gender the number of treatments, number of claims, and treatment-to-claim ratio. 
-- And notice if there is a significant difference between the treatment-to-claim ratio of male and female patients.

select *, round(total_treatments/ total_claims, 2) as ratio from 
(
	select p.gender, count(t.treatmentID) as total_treatments,
	count(c.claimID) as total_claims from
	person p inner join treatment t
	on p.personID = t.patientID
	left join claim c
	on t.claimID = c.claimID
	GROUP BY p.gender
)a;


-- Problem Statement 4: The Healthcare department wants a report about the inventory of pharmacies. 
-- Generate a report on their behalf that shows how many units of medicine each pharmacy has in their inventory, 
-- the total maximum retail price of those medicines, and the total price of all the medicines after discount. 
-- Note: discount field in keep signifies the percentage of discount on the maximum price.
SELECT `pharmacyID`,COUNT(`medicineID`),ROUND(sum(`maxPrice`)), ROUND(SUM(`maxPrice`-`maxPrice`*discount/100))
FROM pharmacy
NATURAL JOIN keep
NATURAL JOIN medicine
GROUP BY `pharmacyID`
ORDER BY `pharmacyID`;



-- Problem Statement 5:  The healthcare department suspects that some pharmacies prescribe more medicines than others in a 
-- single prescription, for them, generate a report that finds for each pharmacy the maximum, minimum and average number of 
-- medicines prescribed in their prescriptions. 
SELECT `pharmacyID`, MAX(quantity),MIN(quantity),AVG(quantity) 
FROM prescription
NATURAL JOIN contain
GROUP BY `pharmacyID`;




--Q2.
-- Problem Statement 1: A company needs to set up 3 new pharmacies, they have come up with an idea that the pharmacy can be 
-- set up in cities where the pharmacy-to-prescription ratio is the lowest and the number of prescriptions should exceed 100. 
-- Assist the company to identify those cities where the pharmacy can be set up.

SELECT a.city, COUNT(DISTINCT p.`pharmacyID`)/COUNT(c.`prescriptionID`) ratio
FROM address a
    left JOIN pharmacy p on p.`addressID` = a.`addressID`
    JOIN prescription c on c.`pharmacyID` = p.`pharmacyID`
GROUP BY a.city--,p.`pharmacyID`
HAVING COUNT(c.`prescriptionID`) > 100
ORDER BY ratio 
limit 3;


-- Problem Statement 2: The State of Alabama (AL) is trying to manage its healthcare resources more efficiently. 
-- For each city in their state, they need to identify the disease for which the maximum number of patients have gone
--  for treatment. Assist the state for this purpose.
-- Note: The state of Alabama is represented as AL in Address Table.

with cte AS (
	SELECT city, `diseaseID`,COUNT(`patientID`) countP, DENSE_RANK() OVER(PARTITION BY city ORDER BY COUNT(`patientID`) DESC) AS 'dRank'
	FROM address
	NATURAL JOIN person
	INNER JOIN patient ON person.`personID`=patient.`patientID`
	NATURAL JOIN treatment
	WHERE state = 'AL'
	GROUP BY city, `diseaseID`
	ORDER BY countP DESC
)
SELECT city,`diseaseID`, countP
FROM cte
WHERE dRank =1
GROUP BY city, `diseaseID`;


-- Problem Statement 3: The healthcare department needs a report about insurance plans. 
-- The report is required to include the insurance plan, which was claimed the most and least for each disease.  
-- Assist to create such a report.

WITH cte AS
(
    SELECT d.diseaseName dname,i.`planName` plan, COUNT(c.`claimID`) cnt
    FROM disease d
        JOIN treatment t on t.`diseaseID` = d.`diseaseID`
        JOIN claim c on c.`claimID` = t.`claimID`
        JOIN insuranceplan i on i.uin = c.uin
    GROUP BY d.`diseaseName`,i.`planName`
    ORDER BY d.`diseaseName`, COUNT(c.`claimID`)
)
SELECT dname, plan, cnt
FROM cte ct
WHERE cnt in (SELECT min(cnt) from cte WHERE dname=ct.dname) OR
 cnt in (SELECT max(cnt) from cte WHERE dname=ct.dname);

-- Problem Statement 4: The Healthcare department wants to know which disease is most likely to infect multiple people 
-- in the same household. For each disease find the number of households that has more than one patient with the same disease. 
-- Note: 2 people are considered to be in the same household if they have the same address. 
SELECT * -- diseaseId,`diseaseName`,COUNT(DISTINCT addressId), COUNT( `patientID`) 'noOfPatients'
FROM person
INNER JOIN address USING (`addressID`)
INNER JOIN patient USING (`patientID`)
INNER JOIN treatment USING (`treatmentID`)
INNER JOIN disease USING (`diseaseID`)
GROUP BY diseaseId
HAVING noOfPatients>1;


SELECT a.diseaseName, sum(cnt_p)
FROM
    (    
    SELECT d.diseaseName diseaseName,count(t.`patientID`) cnt_p--,COUNT(DISTINCT p.`addressID`)
    from disease d 
        JOIN treatment t on t.`diseaseID` = d.`diseaseID`
        JOIN person p on p.`personID` = t.`patientID`
    GROUP BY d.`diseaseName`, p.`addressID`
    HAVING count(t.`patientID`) > 1) a
GROUP BY a.diseaseName
;


-- Problem Statement 5:  An Insurance company wants a state wise report of the treatments to claim ratio between 
-- 1st April 2021 and 31st March 2022 (days both included). Assist them to create such a report.
SELECT state, COUNT(`treatmentID`)/COUNT(`claimID`) AS `treat-claim-ratio`
FROM address
LEFT JOIN person USING (`addressID`)
INNER JOIN treatment ON person.`personID`=treatment.`patientID`
LEFT JOIN claim USING (`claimID`)
WHERE date BETWEEN '2021-04-01' AND '2022-03-31'
GROUP BY state
ORDER BY `treat-claim-ratio`;



-- Q3.

-- Problem Statement 1:  Some complaints have been lodged by patients that they have been prescribed hospital-exclusive medicine 
-- that they can’t find elsewhere and facing problems due to that. Joshua, from the pharmacy management, wants to get a report 
-- of which pharmacies have prescribed hospital-exclusive medicines the most in the years 2021 and 2022. Assist Joshua to generate 
-- the report so that the pharmacies who prescribe hospital-exclusive medicine more often are advised to avoid such practice if possible.   
with cte as
(select ph.pharmacyid,count(m.medicineid) as no_of_HEX_medicines,sum(c.quantity) as total_qty from 
pharmacy ph inner join prescription pr using(pharmacyid)
inner join treatment t on pr.treatmentid = t.treatmentid
inner join contain c on  pr.prescriptionid = c.prescriptionID
inner join medicine m on c.medicineid = m.medicineid
where m.hospitalExclusive = "S" and (year(t.date) in (2021,2022))
group by ph.pharmacyid
)
select phr.pharmacyname,cte.pharmacyID,cte.no_of_HEX_medicines,cte.total_qty
from pharmacy phr inner join cte using(pharmacyid)
order by cte.no_of_HEX_medicines DESC
limit 20;

with cte as (
SELECT DISTINCT state,city,COUNT(pharmacyid) OVER(PARTITION BY state,city) AS 'countph'
FROM pharmacy
INNER JOIN address USING (`addressID`)
)
SELECT state,city, RANK() OVER(PARTITION BY state ORDER BY countph DESC)
FROM cte
GROUP BY state,city;


-- Problem Statement 2: Insurance companies want to assess the performance of their insurance plans. Generate a report that 
-- shows each insurance plan, the company that issues the plan, and the number of treatments the plan was claimed for.
SELECT DISTINCT `companyName`,planName, COUNT(`treatmentID`)
FROM `insurancecompany`
INNER JOIN insuranceplan USING (`companyID`)
LEFT JOIN claim USING (UIN)
LEFT JOIN treatment USING (`claimID`)
GROUP BY `companyName`,`planName`
ORDER BY `companyName`;



-- Problem Statement 3: Insurance companies want to assess the performance of their insurance plans. Generate a report 
-- that shows each insurance company's name with their most and least claimed insurance plans.
with cte AS (SELECT `companyName`,`planName`, COUNT(`claimID`) 'claimCount'
FROM insurancecompany
INNER JOIN insuranceplan USING (`companyID`)
LEFT JOIN claim USING(uin)
GROUP BY `companyName`,`planName`
ORDER BY `companyName`,claimCount DESC
)
SELECT DISTINCT`companyName`, 
FIRST_VALUE(`planName`) OVER(PARTITION BY `companyName`) 'MaxClaim',
LAST_VALUE(`planName`) OVER(PARTITION BY `companyName`) 'MinClaim'
FROM cte
ORDER BY `companyName`;


-- Problem Statement 4:  The healthcare department wants a state-wise health report to assess which state requires more 
-- attention in the healthcare sector. Generate a report for them that shows the state name, number of registered people 
-- in the state, number of registered patients in the state, and the people-to-patient ratio. sort the data by people-to-patient ratio. 
SELECT state, COUNT(DISTINCT`personID`)/COUNT(`patientID`) AS ppratio
FROM address
INNER JOIN person
LEFT JOIN patient ON person.`personID`=`patient`.`patientID`
GROUP BY state
ORDER BY ppratio DESC;


-- Problem Statement 5:  Jhonny, from the finance department of Arizona(AZ), has requested a report 
-- that lists the total quantity of medicine each pharmacy in his state has prescribed that 
-- falls under Tax criteria I for treatments that took place in 2021. Assist Jhonny in generating the report. 

SELECT `pharmacyName`, SUM(quantity) 'Medicine Qty'
FROM address
INNER JOIN pharmacy USING(`addressID`)
INNER JOIN prescription USING(`pharmacyID`)
INNER JOIN contain USING(`prescriptionID`)
INNER JOIN medicine USING(`medicineID`)
INNER JOIN treatment USING(`treatmentID`)
WHERE state='AZ' AND `taxCriteria`='I' AND YEAR(date)=2021
GROUP BY `pharmacyName`
ORDER BY `Medicine Qty` DESC;


