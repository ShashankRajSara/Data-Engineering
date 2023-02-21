-- Active: 1671688949427@@127.0.0.1@3308@healthcare

ALTER TABLE claim ADD CONSTRAINT `FK_Insurance_Claim` 
FOREIGN KEY (uin) REFERENCES insuranceplan (uin);

ALTER TABLE insuranceplan ADD CONSTRAINT `FK_InsCompany_InsPlan` 
FOREIGN KEY (companyId) REFERENCES insurancecompany (companyId);

ALTER TABLE treatment ADD CONSTRAINT `FK_patient_treatment` 
FOREIGN KEY (patientId) REFERENCES patient (patientId);

ALTER TABLE treatment ADD CONSTRAINT `FK_disease_treatment` 
FOREIGN KEY (diseaseId) REFERENCES disease (diseaseId);

ALTER TABLE treatment ADD CONSTRAINT `FK_claim_treatment` 
FOREIGN KEY (claimId) REFERENCES claim (claimId);

ALTER TABLE patient ADD CONSTRAINT `FK_person_patient` 
FOREIGN KEY (patientId) REFERENCES person (personId);

ALTER TABLE person ADD CONSTRAINT `FK_address_person` 
FOREIGN KEY (addressId) REFERENCES address (addressId);

ALTER TABLE prescription ADD CONSTRAINT `FK_pharmacy_prescription` 
FOREIGN KEY (pharmacyId) REFERENCES pharmacy (pharmacyId);

ALTER TABLE prescription ADD CONSTRAINT `FK_treatment_prescription` 
FOREIGN KEY (treatmentId) REFERENCES treatment (treatmentId);

ALTER TABLE contain ADD CONSTRAINT `FK_prescription_contain` 
FOREIGN KEY (prescriptionId) REFERENCES prescription (prescriptionId);

ALTER TABLE contain ADD CONSTRAINT `FK_medicine_contain` 
FOREIGN KEY (medicineId) REFERENCES medicine (medicineId);

ALTER TABLE pharmacy ADD CONSTRAINT `FK_address_pharmacy` 
FOREIGN KEY (addressId) REFERENCES address (addressId);

ALTER TABLE keep ADD CONSTRAINT `FK_medicine_keep` 
FOREIGN KEY (medicineId) REFERENCES medicine (medicineId);

ALTER TABLE keep ADD CONSTRAINT `FK_pharmacy_keep` 
FOREIGN KEY (pharmacyId) REFERENCES pharmacy (pharmacyId);

ALTER TABLE insurancecompany ADD CONSTRAINT `FK_address_InsCompany` 
FOREIGN KEY (addressId) REFERENCES address (addressId);

