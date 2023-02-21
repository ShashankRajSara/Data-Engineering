-- Active: 1671688949427@@127.0.0.1@3308@hr
---For LOOP

DELIMITER //

CREATE PROCEDURE forLoopDemo()
BEGIN
        DECLARE x INT;
        DECLARE str VARCHAR(255);

        SET x = 0;
        SET str = '';

        loop_label: LOOP
                IF x > 5 THEN
                        LEAVE loop_label;
                END IF;
                SET x = x + 1;
                IF (x mod 2 = 0) THEN
                        ITERATE loop_label;
                ELSE
                        SET str = CONCAT(str, x, ', ');
                END IF;
        END LOOP;
        SELECT str;
END //

DELIMITER ;

CALL forLoopDemo();

DROP PROCEDURE forLoopDemo;




-- Repeat-loop demo
DELIMITER //

CREATE PROCEDURE repeatLoopDemo()
BEGIN
        DECLARE x INT;
        DECLARE str VARCHAR(255);

        SET x = 0;
        SET str = '';

        REPEAT
                SET x = x + 1;
                IF (x mod 2 <> 0) THEN
                        SET str = CONCAT(str, x, ', ');                        
                END IF;
        UNTIL x > 5
        END REPEAT;

        SELECT str;
END //

DELIMITER ;

CALL repeatLoopDemo();

DROP PROCEDURE repeatLoopDemo;

--WHILE loopDemo
DELIMITER //

CREATE PROCEDURE whileLoopDemo()
BEGIN
        DECLARE x INT;
        DECLARE str VARCHAR(255);

        SET x = 0;
        SET str = '';

        WHILE x <= 5 DO
                SET x = x + 1;
                IF (x mod 2 <> 0) THEN
                        SET str = CONCAT(str, x, ', ');                        
                END IF;
        END WHILE;

        SELECT str;
END //

DELIMITER ;

CALL whileLoopDemo();

DROP PROCEDURE whileLoopDemo;