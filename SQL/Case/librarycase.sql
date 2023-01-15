-- Active: 1671688949427@@127.0.0.1@3308@library

USE `library`;
DROP procedure IF EXISTS `new_member`;

USE `library`;
DROP procedure IF EXISTS `library`.`new_member`;
;

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_member`(IN memName varchar(30),memPhone decimal(10,0))
BEGIN
	INSERT INTO member (mname,mphone,joindate) values (memName,memPhone,CURDATE());
    SELECT * from books;
END$$

DELIMITER ;


CALL new_member ('Shashank',8019988169);



--Trigger
DELIMITER $$
CREATE TRIGGER trig_insert_book
AFTER INSERT ON book
FOR EACH ROW
BEGIN
    INSERT INTO bcopy VALUES (1,new.`BOOKID`,'available');
END $$

DELIMITER ;

CALL new_book('SH','Shashank','Multiverse','Spaces');

--C

----    
USE `library`;
DROP function IF EXISTS `new_rental`;

USE `library`;
DROP function IF EXISTS `library`.`new_rental`;
;

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `new_rental`(bid INT, memid INT) RETURNS date
    DETERMINISTIC
BEGIN
	DECLARE vdate date;
    DECLARE stat varchar(20);
    DECLARE vcid INT;
    
    SELECT status,c_id INTO stat,vcid FROM bcopy WHERE status='available' AND `BOOKID`=bid limit 1;
    
    IF stat='available' THEN
    
        UPDATE bcopy SET status = 'rented' 
        WHERE status='available' AND `BOOKID`=bid AND c_id=1;
        SET vdate = CURDATE()+2;
        
        INSERT INTO bloan VALUES (bid,CURDATE(),0,memid,vdate,NULL,vcid);
        
	ELSE
		SET vdate = NULL;
        INSERT INTO bres VALUES (memid,bid,CURDATE());
	END IF;  
    
RETURN vdate;
END$$

DELIMITER ;
;



SELECT new_rental(1,1);