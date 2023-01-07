-- Active: 1671688949427@@127.0.0.1@3308@org
USE org;

DELIMITER //

CREATE TRIGGER after_worker_insert
    AFTER INSERT
    ON worker
    FOR EACH ROW
BEGIN
        INSERT INTO title
            VALUES (
                NEW.worker_id, "New Joinee", NOW()
            );
END //

DELIMITER ;

INSERT INTO worker
    VALUES (
        10, 'Shashank', 'Raj', 5000, NOW(), 'IT'
    );

SHOW TRIGGERS;

SELECT * from title;
DROP TRIGGER IF EXISTS after_worker_insert;
