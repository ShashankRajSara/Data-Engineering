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


--D - Return Book 

USE `library`;
DROP procedure IF EXISTS `return_book`;

USE `library`;
DROP procedure IF EXISTS `library`.`return_book`;
;

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `return_book`(IN book_id INT,IN copy_id INT)
BEGIN
	
	DECLARE bid INT DEFAULT NULL;
	SELECT bookid INTO bid FROM bres WHERE bookid=book_id;
    UPDATE bloan SET ACT_DATE = curdate() WHERE bookid=book_id AND c_id=copy_id;
	IF book_id=bid  THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='**It is Reserved**';
	else
		UPDATE bcopy SET status='available' WHERE bookid=book_id AND c_id=copy_id;	
        
	END IF;
END$$

DELIMITER ;
;


select * from member ;



--E - reserve_book procedure

USE `library`;
DROP procedure IF EXISTS `reserve_book`;

DELIMITER $$
USE `library`$$
CREATE PROCEDURE `reserve_book` (IN mem_id INT,IN book_id INT)
BEGIN
	DECLARE bid INT DEFAULT NULL;
    DECLARE errortext varchar(30);
    SET errortext = CONCAT('**BOOK is reserved and expected return date is **',CURDATE()+2);
	SELECT DISTINCT bookid into bid FROM bcopy WHERE status='rented';
    IF book_id=bid THEN
		INSERT INTO bres VALUES (mem_id,book_id,CURDATE());
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT= errortext;
	END IF;
END$$

DELIMITER ;





--F - A PROCEDURE TO PASS MEMBER ID 

-- BOOKS ON LOAN TO:
-- member_id:22
-- member_name:shekar***********
-- book#:4
-- title:P.T.Olap
-- loandate:29-AUG-18

USE `library`;
DROP procedure IF EXISTS `pmem_book`;

DELIMITER $$
USE `library`$$
CREATE PROCEDURE `pmem_book` (IN mem_id INT)
BEGIN
	DECLARE var INT DEFAULT NULL;
    DECLARE outp varchar(50);
    
    SET outp = CONCAT('NO BOOKS TAKEN BY THE MEMBER- ',mem_id);
    
    SELECT mid INTO var FROM bloan WHERE mid=mem_id;
    
    IF (mid=mem_id) THEN
		SELECT m.mid 'member_id', m.mname 'member_name', b.bookid 'book#', b.btitle 'title',bl.ldate 'loandate'
		FROM bloan bl
		INNER JOIN member m USING (mid)
		INNER JOIN book b USING(bookid)
		WHERE m.mid=mem_id;
	ELSE 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT= outp;
	END IF;
END$$

DELIMITER ;



-- EXTRA CHALLENGE
-- -----------------------------
-- 1. WHEN ACTUAL RETURN DATE EXCEEDS EXPECTED RETURN DATE, FINE SHOULD BE LEVIED.
-- (PER DAY RS.5) after expected return date.
-- 2. Create a trigger to accomplish the above task. 
-- 3. List all the books taken by a particular member.
-- 4.List all the members took a particular book.












































