-- Active: 1671688949427@@127.0.0.1@3308@db_optimised

DROP PROCEDURE pro_cursor;

DELIMITER $$

CREATE PROCEDURE pro_cursor(pno INT)
BEGIN
    DECLARE v1 NUMERIC(11,2);
    DECLARE v2 VARCHAR(20);
    DECLARE cur INT DEFAULT 0;
    
    DECLARE cur1 CURSOR for SELECT sal,ename FROM emp WHERE deptno=pno;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET cur=1;
    OPEN cur1;

    getcur: LOOP
        FETCH cur1 INTO v1,v2;
        IF cur=1 THEN
            LEAVE getcur;
        END IF;
            SELECT v1,v2;
    end LOOP;
    
END $$

DELIMITER ;

CALL pro_cursor(30);

SELECT sal,ename FROM emp WHERE deptno=30;
