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


--Q4




-- Q5

-- Problem Statement 1:
-- Johansson is trying to prepare a report on patients who have gone through treatments more
-- than once. Help Johansson prepare a report that shows the patient&#39;s name, the number of
-- treatments they have undergone, and their age, Sort the data in a way that the patients who
-- have undergone more treatments appear on top.


SELECT  t.`patientID`,p.`personName`, COUNT(t.`treatmentID`) count_trtmnts, TIMESTAMPDIFF(YEAR,pt.dob,CURRENT_DATE), pt.dob
FROM person p
    JOIN patient pt on pt.`patientID` = p.`personID`
    JOIN treatment t on t.`patientID` = p.`personID`
GROUP BY t.`patientID`,p.`personName`
HAVING count_trtmnts > 1
ORDER BY count_trtmnts DESC;

-- SELECT * FROM treatment;


-- Problem Statement 2:
-- Bharat is researching the impact of gender on different diseases, He wants to analyze if a
-- certain disease is more likely to infect a certain gender or not.
-- Help Bharat analyze this by creating a report showing for every disease how many males
-- and females underwent treatment for each in the year 2021. It would also be helpful for
-- Bharat if the male-to-female ratio is also shown.

-- EXPLAIN FORMAT = tree
SELECT d.diseaseName, sum(if(p.gender = 'male',1,0)) numOfMales, sum(if(p.gender = 'female',1,0)) numOfFemales, sum(if(p.gender = 'male',1,0))/sum(if(p.gender = 'female',1,0)) males_females_ratio
FROM disease d
    JOIN treatment t on t.`diseaseID` = d.`diseaseID`
    JOIN person p on p.`personID` = t.`patientID`
WHERE year(t.`date`) = 2021
GROUP BY d.`diseaseName`
;

-- EXPLAIN FORMAT = tree 
SELECT disease, numOfMales, cnt-numOfMales numOfFemales, numOfMales/(cnt-numOfMales)
FROM (
    SELECT d.diseaseName disease, sum(if(p.gender = 'male',1,0)) numOfMales, COUNT(*) cnt
    FROM disease d
        JOIN treatment t on t.`diseaseID` = d.`diseaseID`
        JOIN person p on p.`personID` = t.`patientID`
    WHERE YEAR(t.`date`) = 2021
    GROUP BY d.`diseaseName`
    
) a
;


-- Problem Statement 3:
-- Kelly, from the Fortis Hospital management, has requested a report that shows for each
-- disease, the top 3 cities that had the most number treatment for that disease.
-- Generate a report for Kelly’s requirement.

SELECT  disease, city, cnt
FROM (
    SELECT d.`diseaseName` disease,a.city city,count(distinct p.`personID`) cnt, DENSE_RANK() OVER(PARTITION BY d.`diseaseName` ORDER BY count(distinct p.`personID`) DESC ) ranks3
    FROM disease d
        JOIN treatment t on t.`diseaseID` = d.`diseaseID`
        JOIN person p on p.`personID` = t.`patientID`
        JOIN address a on a.`addressID` = p.`addressID`
    GROUP BY d.`diseaseName`,a.city
    -- HAVING ranks3 < 4
    ORDER BY d.`diseaseName`, cnt desc

) a
WHERE ranks3 < 4
;



-- Problem Statement 4:
-- Brooke is trying to figure out if patients with a particular disease are preferring some
-- pharmacies over others or not, For this purpose, she has requested a detailed pharmacy
-- report that shows each pharmacy name, and how many prescriptions they have prescribed
-- for each disease in 2021 and 2022, She expects the number of prescriptions prescribed in
-- 2021 and 2022 be displayed in two separate columns.
-- Write a query for Brooke’s requirement.


SELECT ph.`pharmacyName` phrmcyname, d.`diseaseName` disName, 
        sum(if (year(t.date) = 2021,1,0)), sum(if (year(t.date) = 2022,1,0)) 
FROM pharmacy ph
    JOIN prescription pr on pr.`pharmacyID` = ph.`pharmacyID`
    JOIN treatment t on t.`treatmentID` = pr.`treatmentID`
    JOIN disease d on d.`diseaseID` = t.`diseaseID`
WHERE YEAR(t.`date`)  in (2021,2022)
GROUP BY ph.`pharmacyName`, d.`diseaseName`

;


-- Problem Statement 5:
-- Walde, from Rock tower insurance, has sent a requirement for a report that presents which
-- insurance company is targeting the patients of which state the most.
-- Write a query for Walde that fulfills the requirement of Walde.
-- Note: We can assume that the insurance company is targeting a region more if the patients
-- of that region are claiming more insurance of that company.









--Q6

-- Problem Statement 1: 
-- The healthcare department wants a pharmacy report on the percentage of hospital-exclusive medicine prescribed in the year 2022.
-- Assist the healthcare department to view for each pharmacy, the pharmacy id, pharmacy name, total quantity of medicine 
-- prescribed in 2022, total quantity of hospital-exclusive medicine prescribed by the pharmacy in 2022, and the percentage 
-- of hospital-exclusive medicine to the total medicine prescribed in 2022.
-- Order the result in descending order of the percentage found. 
WITH cte AS (
    SELECT `pharmacyID`,`pharmacyName`, SUM(quantity) TotalMedicinesPres, 
    SUM(IF(`hospitalExclusive`='S',quantity,0)) 'Total Hospital Exl'
    FROM pharmacy
    LEFT JOIN prescription USING(`pharmacyID`)
    INNER JOIN contain USING(`prescriptionID`)
    INNER JOIN medicine USING(`medicineID`)
    INNER JOIN treatment USING(`treatmentID`)
    WHERE YEAR(date)=2022
    GROUP BY `pharmacyID`
) SELECT *, ROUND(`Total Hospital Exl`/`TotalMedicinesPres`*100,2) 'Percentage' FROM cte;


-- Problem Statement 2:  
-- Sarah, from the healthcare department, has noticed many people do not claim insurance for their treatment. 
-- She has requested a state-wise report of the percentage of treatments that took place without claiming insurance. 
-- Assist Sarah by creating a report as per her requirement.
SELECT state, ROUND(COUNT(`claimID`)/COUNT(`treatmentID`)*100,2) 'Percentage'
FROM address
INNER JOIN person p USING (`addressID`)
INNER JOIN treatment t ON p.`personID`=t.`patientID`
LEFT JOIN claim USING(`claimID`)
GROUP BY state
ORDER BY Percentage DESC;


-- Problem Statement 3:  
-- Sarah, from the healthcare department, is trying to understand if some diseases are spreading in a particular region. 
-- Assist Sarah by creating a report which shows for each state, the number of the most and least treated diseases by the 
-- patients of that state in the year 2022. 
WITH cte AS (
    SELECT state, `diseaseName`,COUNT(`treatmentID`) 'noOftreatments'
    FROM address
    INNER JOIN person p USING (`addressID`)
    INNER JOIN treatment t ON p.`personID`=t.`patientID`
    INNER JOIN disease USING(`diseaseID`)
    GROUP BY state,`diseaseName`
    ORDER BY state,noOftreatments DESC
)
SELECT DISTINCT state, FIRST_VALUE(`diseaseName`) OVER(PARTITION BY state) 'MinDisease',
FIRST_VALUE(noOftreatments) OVER(PARTITION BY state) 'noOfMINtreatments',
LAST_VALUE(`diseaseName`) OVER(PARTITION BY state) 'MaxDisease',
LAST_VALUE(noOftreatments) OVER(PARTITION BY state) 'noOfMAXtreatments'
FROM cte;

-- Problem Statement 4: 
-- Manish, from the healthcare department, wants to know how many registered people are registered as patients as well, 
-- in each city. Generate a report that shows each city that has 10 or more registered people belonging to it and the 
-- number of patients from that city as well as the percentage of the patient with respect to the registered people.
SELECT city, COUNT(`personID`) 'noOfPatients',ROUND(COUNT(`patientID`)/COUNT(`personID`)*100,2) "Percentage"
FROM address
INNER JOIN person pe USING (`addressID`)
LEFT JOIN patient pa ON pe.`personID`=pa.`patientID`
GROUP BY city
HAVING noOfPatients >10;



-- Problem Statement 5:  
-- It is suspected by healthcare research department that the substance “ranitidine” might be causing some side effects. 
-- Find the top 3 companies using the substance in their medicine so that they can be informed about it.
SELECT DISTINCT `companyName`
FROM medicine
WHERE `substanceName` LIKE '%ranitidina%'
LIMIT 3;





-- Q7.


-- Problem Statement 1: 
-- Insurance companies want to know if a disease is claimed higher or lower than average.  
Write a stored procedure that returns “claimed higher than average” or “claimed lower than average” when the diseaseID is passed to it. 
-- Hint: Find average number of insurance claims for all the diseases. 
 If the number of claims for the passed disease is higher than the average return “claimed higher than average” otherwise “claimed lower than average”.

-- Problem Statement 2:  
-- Joseph from Healthcare department has requested for an application which helps him get genderwise report for any disease. 
-- Write a stored procedure when passed a disease_id returns 4 columns,
-- disease_name, number_of_male_treated, number_of_female_treated, more_treated_gender
-- Where, more_treated_gender is either ‘male’ or ‘female’ based on which gender underwent more often for the disease, if the number is same for both the genders, the value should be ‘same’.
-- Problem Statement 3:  
-- The insurance companies want a report on the claims of different insurance plans. 
-- Write a query that finds the top 3 most and top 3 least claimed insurance plans.
-- The query is expected to return the insurance plan name, the insurance company name which has that plan, and whether the plan is the most claimed or least claimed. 

-- Problem Statement 4: 
-- The healthcare department wants to know which category of patients is being affected the most by each disease.
-- Assist the department in creating a report regarding this.
-- Provided the healthcare department has categorized the patients into the following category.
-- YoungMale: Born on or after 1st Jan  2005  and gender male.
-- YoungFemale: Born on or after 1st Jan  2005  and gender female.
-- AdultMale: Born before 1st Jan 2005 but on or after 1st Jan 1985 and gender male.
-- AdultFemale: Born before 1st Jan 2005 but on or after 1st Jan 1985 and gender female.
-- MidAgeMale: Born before 1st Jan 1985 but on or after 1st Jan 1970 and gender male.
-- MidAgeFemale: Born before 1st Jan 1985 but on or after 1st Jan 1970 and gender female.
-- ElderMale: Born before 1st Jan 1970, and gender male.
-- ElderFemale: Born before 1st Jan 1970, and gender female.

-- Problem Statement 5:  
-- Anna wants a report on the pricing of the medicine. She wants a list of the most expensive and most affordable medicines only. 
-- Assist anna by creating a report of all the medicines which are pricey and affordable, listing the companyName, productName, description, maxPrice, and the price category of each. Sort the list in descending order of the maxPrice.
-- Note: A medicine is considered to be “pricey” if the max price exceeds 1000 and “affordable” if the price is under 5. Write a query to find 
