-- Active: 1671688949427@@127.0.0.1@3308@org
USE org;


----------------------------------------------------------------
-- CREATE UPDATE TRIGGER
CREATE TRIGGER after_worker_update 
    AFTER UPDATE ON worker
    FOR EACH ROW 
UPDATE title
SET 
    worker_ref_id = NEW.worker_id
WHERE
    worker_ref_id = OLD.worker_id;

-- UPDATE
UPDATE worker 
SET 
    worker_id = 100,
WHERE
    first_name = 'Niharika';


----------------------------------------------------

-- INSERT TRIGGER
CREATE TRIGGER after_worker_insert
    AFTER INSERT
    ON worker
    FOR EACH ROW
BEGIN
        INSERT INTO title
            VALUES (
                NEW.worker_id, "New Joinee", NOW()
            );


-- INSERT
INSERT INTO worker
    VALUES (
        10, 'Shashank', 'Raj', 5000, NOW(), 'IT'
    );

----------------------------------------------------------------

SHOW TRIGGERS;

DROP TRIGGER IF EXISTS after_worker_insert;


