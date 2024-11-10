
use assignment3;
DROP TABLE IF EXISTS Borrowedby, Holding, Authoredby, Author, Book, Publisher, Member, Branch;

/*Table structure for table `branch` */
CREATE TABLE Branch (
  BranchID INT NOT NULL, 
  BranchSuburb varchar(255) NOT NULL,
  BranchState char(3) NOT NULL,
  PRIMARY KEY (BranchID)
);

CREATE TABLE Member (
  MemberID INT NOT NULL, 
  MemberStatus char(9) DEFAULT 'REGULAR',
  MemberName varchar(255) NOT NULL,
  MemberAddress varchar(255) NOT NULL,
  MemberSuburb varchar(25) NOT NULL,
  MemberState char(3) NOT NULL,
  MemberExpDate DATE,
  MemberPhone varchar(10),
  PRIMARY KEY (`MemberID`)
);

CREATE TABLE Publisher (
  PublisherID INT NOT NULL, 
  PublisherName varchar(255) NOT NULL,
  PublisherAddress varchar(255) DEFAULT NULL,
  PRIMARY KEY (PublisherID)
);

CREATE TABLE Book (
  BookID INT NOT NULL,
  BookTitle varchar(255) NOT NULL,
  PublisherID INT NOT NULL,
  PublishedYear INT4,
  Price Numeric(5,2) NOT NULL,
  PRIMARY KEY (BookID),
  KEY PublisherID (PublisherID),
  CONSTRAINT publisher_fk_1 FOREIGN KEY (PublisherID) REFERENCES Publisher (PublisherID) ON DELETE RESTRICT
);

CREATE TABLE Author (
  AuthorID INT NOT NULL, 
  AuthorName varchar(255) NOT NULL,
  AuthorAddress varchar(255) NOT NULL,
  PRIMARY KEY (AuthorID)
);

CREATE TABLE Authoredby (
  BookID INT NOT NULL,
  AuthorID INT NOT NULL, 
  PRIMARY KEY (BookID,AuthorID),
  KEY BookID (BookID),
  KEY AuthorID (AuthorID),
  CONSTRAINT book_fk_1 FOREIGN KEY (BookID) REFERENCES Book (BookID) ON DELETE RESTRICT,
  CONSTRAINT author_fk_1 FOREIGN KEY (AuthorID) REFERENCES Author (AuthorID) ON DELETE RESTRICT
);

CREATE TABLE Holding (
  BranchID INT NOT NULL, 
  BookID INT NOT NULL,
  InStock INT DEFAULT 1,
  OnLoan INT DEFAULT 0,
  PRIMARY KEY (BranchID, BookID),
  KEY BookID (BookID),
  KEY BranchID (BranchID),
  CONSTRAINT holding_cc_1 CHECK(InStock>=OnLoan),
  CONSTRAINT book_fk_2 FOREIGN KEY (BookID) REFERENCES Book (BookID) ON DELETE RESTRICT,
  CONSTRAINT branch_fk_1 FOREIGN KEY (BranchID) REFERENCES Branch (BranchID) ON DELETE RESTRICT
);

CREATE TABLE Borrowedby (
  BookIssueID INT UNSIGNED NOT NULL AUTO_INCREMENT,
  BranchID INT NOT NULL,
  BookID INT NOT NULL,
  MemberID INT NOT NULL,
  DateBorrowed DATE,
  DateReturned DATE DEFAULT NULL,
  ReturnDueDate DATE,
  PRIMARY KEY (BookIssueID),
  KEY BookID (BookID),
  KEY BranchID (BranchID),
  KEY MemberID (MemberID),
  CONSTRAINT borrowedby_cc_1 CHECK(DateBorrowed<ReturnDueDate),
  CONSTRAINT holding_fk_1 FOREIGN KEY (BookID,BranchID) REFERENCES holding (BookID,BranchID) ON DELETE RESTRICT,
  CONSTRAINT member_fk_1 FOREIGN KEY (MemberID) REFERENCES Member (MemberID) ON DELETE RESTRICT
) ;

DELETE FROM Author;
INSERT INTO Author (AuthorID,AuthorName,AuthorAddress ) 
VALUES ('1', 'Tolstoy','Russian Empire');
INSERT INTO Author (AuthorID,AuthorName,AuthorAddress ) 
VALUES ('2', 'Tolkien','England');
INSERT INTO Author (AuthorID,AuthorName,AuthorAddress ) 
VALUES ('3', 'Asimov','America');
INSERT INTO Author (AuthorID,AuthorName,AuthorAddress ) 
VALUES ('4', 'Silverberg','America');
INSERT INTO Author (AuthorID,AuthorName,AuthorAddress ) 
VALUES ('5', 'Paterson','Australia');

DELETE FROM Branch;
INSERT INTO Branch (BranchID,BranchSuburb,BranchState) 
VALUES ('1','Parramatta','NSW');
INSERT INTO Branch (BranchID,BranchSuburb,BranchState) 
VALUES ('2','North Ryde','NSW');
INSERT INTO Branch (BranchID,BranchSuburb,BranchState) 
VALUES ('3','Sydney City','NSW');

DELETE FROM Publisher;
INSERT INTO Publisher (PublisherID,PublisherName,PublisherAddress ) 
VALUES ('1','Penguin','New York');
INSERT INTO Publisher (PublisherID,PublisherName,PublisherAddress ) 
VALUES ('2','Platypus','Sydney');
INSERT INTO Publisher (PublisherID,PublisherName,PublisherAddress ) 
VALUES ('3','Another Choice','Patagonia');

DELETE FROM Member;
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('1','REGULAR','Joe','4 Nowhere St','Here','NSW','2021-09-30','0434567811');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('2','REGULAR','Pablo','10 Somewhere St','There','ACT','2022-09-30','0412345678');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('3','REGULAR','Chen','23/9 Faraway Cl','Far','QLD','2020-11-30','0412346578');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('4','REGULAR','Zhang','Dunno St','North','NSW','2020-12-31','');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('5','REGULAR','Saleem','44 Magnolia St','South','SA','2020-09-30','1234567811');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('6','SUSPENDED','Homer','Middle of Nowhere','North Ryde','NSW','2020-09-30','1234555811');

DELETE FROM Book;
select * from book;
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('1','Anna Karenina','1','2003',12.75);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('2','War and Peace','2','1869',139.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('3','The Hobbit','2','1937',9.19);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('4','I, Robot','2','1950',29.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('5','The Positronic Man','3','2010',125.99);

DELETE FROM Authoredby;
INSERT INTO Authoredby (BookID,AuthorID) VALUES ('1', '1');
INSERT INTO Authoredby (BookID,AuthorID) VALUES ('2', '1');
INSERT INTO Authoredby (BookID,AuthorID) VALUES ('3', '2');
INSERT INTO Authoredby (BookID,AuthorID) VALUES ('4', '3');
INSERT INTO Authoredby (BookID,AuthorID) VALUES ('5', '3');
INSERT INTO Authoredby (BookID,AuthorID) VALUES ('5', '4');

DELETE FROM Holding;
INSERT INTO Holding (BranchID,BookID,InStock,OnLoan) 
VALUES ('1', '1','2','2');
INSERT INTO Holding (BranchID,BookID,InStock,OnLoan) 
VALUES ('1', '2','2','1');
INSERT INTO Holding (BranchID,BookID,InStock,OnLoan) 
VALUES ('1', '3','3','1');
INSERT INTO Holding (BranchID,BookID,InStock,OnLoan) 
VALUES ('2', '1','1','1');
INSERT INTO Holding (BranchID,BookID,InStock,OnLoan) 
VALUES ('2', '4','3','2');
INSERT INTO Holding (BranchID,BookID,InStock,OnLoan) 
VALUES ('3', '4','4','0');
INSERT INTO Holding (BranchID,BookID,InStock,OnLoan) 
VALUES ('3', '5','2','1');

DELETE FROM Borrowedby;
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('1', '1','2',curdate(),NULL,date_add(curdate(),INTERVAL 3 WEEK));
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('2', '4','4',curdate(),NULL,date_add(curdate(),INTERVAL 3 WEEK));
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('2', '1','4',curdate(),NULL,date_add(curdate(),INTERVAL 3 WEEK));
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('2', '4','1',curdate(),NULL,date_add(curdate(),INTERVAL 3 WEEK));
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('3', '5','3',curdate(),NULL,date_add(curdate(),INTERVAL 3 WEEK));
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('1', '1','1','2020-08-30',NULL,'2020-09-30');
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('1', '2','2','2020-08-30',NULL,'2020-09-30');
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('3', '4','2','2020-08-30',NULL,'2020-09-30');

-------------- TASK 1 -------------- 

-- Adds a new column "OverdueFee" to the "`member`" table with a default value of 0 to store the overdue fees.
ALTER TABLE `member`
ADD COLUMN OverdueFee INT DEFAULT 0;

-- Add a constraint to the `member` table to ensure that the value of the OverdueFee column is always greater than or equal to 0.
ALTER TABLE `member`
ADD CONSTRAINT chk_fees CHECK (OverdueFee >= 0);

-- Insert some test data into the `member` table
INSERT INTO `member` (MemberID, MemberStatus, MemberName, MemberAddress, MemberSuburb, MemberState, MemberExpDate, MemberPhone, OverdueFee)
VALUES ('7', 'REGULAR', 'John', '12 Magnolia St', 'North', 'SA', '2020-10-21', '1234567891', 0),
       ('8', 'SUSPENDED', 'Jane', 'Middle of Nowhere', 'South Ryde', 'NSW', '2020-10-30', '1234555891', 32);

-- Try to insert a negative overdue fee amount and verify constraint blocks the invalid data.
INSERT INTO `member` (MemberID, MemberStatus, MemberName, MemberAddress, MemberSuburb, MemberState, MemberExpDate, MemberPhone, OverdueFee)
VALUES ('9', 'REGULAR', 'Pete', '40 Magnolia St', 'North', 'SA', '2020-10-25', '1234567899', -2);

--	Update the overdue fees for a member.
UPDATE `member`
SET OverdueFee = 2
WHERE MemberID = 7;

-- Try to update a negative overdue fee amount for a member and verify constraint blocks the invalid data.
UPDATE `member`
SET OverdueFee = -2
WHERE MemberID = 7;

-------------- TASK 2 -------------- 

-- A trigger to prevent a member's status being updated to REGULAR, if they have outstanding books or fees.
DROP TRIGGER IF EXISTS member_status_update_check; 
DELIMITER //
CREATE TRIGGER member_status_update_check BEFORE UPDATE ON `member`  
FOR EACH ROW 
BEGIN
    DECLARE unreturned_book INT; 
    -- Check if the member status is updated from SUSPENDED to REGULAR.
    IF NEW.MemberStatus = 'REGULAR' AND OLD.MemberStatus = 'SUSPENDED' THEN
        -- Get the number of unreturned books from the borrowedby table.
        SET unreturned_book = 	(SELECT COUNT(*) 
                        FROM borrowedby AS B 
                        WHERE B.MemberID = NEW.MemberID 
                        AND DateReturned IS NULL 
                        AND ReturnDueDate < CURDATE());  
        -- Check if there is any unreturned books or unpaid overdue fee. If true, then throw an error.
        IF unreturned_book != 0 OR NEW.OverdueFee != 0 THEN 
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Cannot update member status. Unreturned books exist with overdue fees.'; 
        END IF; 
    END IF;
END //
DELIMITER ; 

-- A trigger to automatically update the status as soon as the overdue fee is paid off and there is no unreturned book.
DROP TRIGGER IF EXISTS auto_update_status_when_paying_overdue_fee;
DELIMITER //
CREATE TRIGGER auto_update_status_when_paying_overdue_fee BEFORE UPDATE ON `member`
FOR EACH ROW 
BEGIN
    DECLARE unreturned_book INT;
    -- Check if the overdue fee is paid
    IF NEW.OverdueFee = 0 AND OLD.OverdueFee != 0 AND OLD.MemberStatus = 'SUSPENDED' THEN
        -- Get the number of unreturned books from the borrowedby table.
        SET unreturned_book = 	(SELECT COUNT(*) 
								FROM borrowedby AS B 
								WHERE B.MemberID = NEW.MemberID 
								AND DateReturned IS NULL 
								AND ReturnDueDate < CURDATE()); 
        -- Check if there is no unreturned book. If true, set the member status to regular.
        IF unreturned_book = 0 THEN 
            SET NEW.MemberStatus = 'REGULAR';
        END IF; 
    END IF;
END //
DELIMITER ; 

-- A trigger to automatically update the status as soon as a book is return and the overdue fee has already been paid.
DROP TRIGGER IF EXISTS auto_update_status_when_returning_book;
DELIMITER $$ 
CREATE TRIGGER  auto_update_status_when_returning_book AFTER UPDATE ON borrowedby
FOR EACH ROW 
BEGIN
    DECLARE unreturned_book INT; 
    DECLARE overdue_fee INT;
    DECLARE member_status VARCHAR(10);
    -- Get the overdue fee and member status from the member table
    SELECT MemberStatus, OverdueFee INTO member_status, overdue_fee FROM `member` AS M WHERE M.MemberID =  NEW.MemberID;
    -- Check if there is no unpaid overdue fee and their member status is SUSPENDED.
    IF overdue_fee = 0 and member_status = 'SUSPENDED' and NEW.DateReturned IS NOT NULL THEN
        -- Get the number of unreturned books from the borrowedby table.
        SET unreturned_book = 	(SELECT COUNT(*) 
								FROM borrowedby AS B 
								WHERE B.MemberID = NEW.MemberID 
								AND DateReturned IS NULL 
								AND ReturnDueDate < CURDATE()); 
        -- Check if there is no unreturned book. If true, set the member status to regular.
        IF unreturned_book = 0 THEN 
            UPDATE `member` SET MemberStatus = 'REGULAR' WHERE MemberID = NEW.MemberID;
        END IF; 
    END IF;
END$$
DELIMITER ; 

 -- TASK 3-- 
-- A stored procedure to update the member status who currently have an overdue item and their membership has been suspended twice in the past three years.
DROP PROCEDURE IF EXISTS terminate_member;
DELIMITER //
CREATE PROCEDURE terminate_member()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE terminate_member_id INT;
    -- Create a cursor to store the IDs of the users to terminate.
    DECLARE cur_terminate_member CURSOR FOR
	(SELECT m.MemberID
	FROM Member m
	JOIN BorrowedBy b ON m.MemberID = b.MemberID
	AND (
		(b.DateReturned > b.ReturnDueDate OR b.DateReturned IS NULL)
		OR (b.DateReturned IS NULL AND b.ReturnDueDate < CURDATE())
	)
	AND (b.ReturnDueDate < CURDATE() AND b.ReturnDueDate >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR))
	JOIN BorrowedBy be ON m.MemberID = be.MemberID
	AND be.DateReturned IS NULL
	AND be.ReturnDueDate < CURDATE()
	GROUP BY m.MemberID
	HAVING COUNT(*) >= 2);

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur_terminate_member;
    
    -- Loop to terminated all membership of the users above.
	terminate_loop: LOOP
		FETCH cur_terminate_member INTO terminate_member_id;
		UPDATE Member m
		SET MemberStatus = 'TERMINATED'
		WHERE m.MemberID = terminate_member_id;
        IF done = 1 THEN LEAVE terminate_loop;
		END IF;
	END LOOP;

    CLOSE cur_terminate_member;
END //
DELIMITER ;

-- we create more for other rules as well-- 
-- A trigger to verify rule BR1 - BR4 and auto-increase the loaned book if borrow successfully.
DROP TRIGGER IF EXISTS validate_borrow; 
DELIMITER //
CREATE TRIGGER validate_borrow 
BEFORE INSERT ON BorrowedBy 
FOR EACH ROW 
BEGIN 
    -- BR1: Check if book is in stock.
    IF (SELECT InStock 
        FROM Holding 
        WHERE BranchID = NEW.BranchID AND 
        BookID = NEW.BookID) = 0 THEN 
        SIGNAL SQLSTATE '45010' SET MESSAGE_TEXT = 'Book not in stock'; 
    END IF; 
     
    -- BR2: Check member status.
    IF (SELECT MemberStatus 
        FROM Member 
        WHERE MemberID = NEW.MemberID) <> 'REGULAR' THEN 
        SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Must be REGULAR to borrow book'; 
    END IF; 
     
    -- BR3: Check not already borrowed book today,
    IF EXISTS(SELECT 1 
              FROM BorrowedBy 
              WHERE MemberID = NEW.MemberID 
              AND BookID = NEW.BookID 
              AND DateBorrowed = NEW.DateBorrowed 
              AND BorrowedID <> NEW.BorrowedID) THEN 
        SIGNAL SQLSTATE '45002' SET MESSAGE_TEXT = 'Book already borrowed today'; 
    END IF; 
     
    -- BR4: Check borrow limit.
    IF (SELECT COUNT(*) 
        FROM BorrowedBy 
        WHERE MemberID = NEW.MemberID 
        AND DateReturned IS NULL) >= 5 THEN 
        SIGNAL SQLSTATE '45003' SET MESSAGE_TEXT = 'Borrow limit reached'; 
    END IF; 
END $$ 
DELIMITER ;

-- A trigger to verify rule BR5.
DROP TRIGGER IF EXISTS check_return_due_date; 
DELIMITER $$ 
CREATE TRIGGER check_return_due_date  
BEFORE INSERT ON BorrowedBy
FOR EACH ROW
BEGIN
    -- Check if return due date us greater than member expiry date.
    IF NEW.ReturnDueDate > 
        (SELECT MemberExpDate  
        FROM Member  
        WHERE MemberID = NEW.MemberID)
    THEN
        SIGNAL SQLSTATE '45011' SET MESSAGE_TEXT = 'Due date cannot be past member expiry date'; 
    END IF;
END;

-- A store procedure to calculate and execute rule BR6 and BR7.
DROP PROCEDURE IF EXISTS update_overdue_fee_and_member_status;
DELIMITER $$
CREATE PROCEDURE update_overdue_fee_and_member_status()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE member_id INT;
    DECLARE overdue_fee INT DEFAULT 0;
    -- Create a cursor to store all member IDs and their fees.
    DECLARE cur_terminate_member CURSOR FOR
    (SELECT bb.MemberID, sum(CURDATE() - bb.ReturnDueDate) * 2 as Fee
	from borrowedby as bb
	where bb.DateReturned is null 
	AND bb.ReturnDueDate <= CURDATE()
	group by bb.MemberID);

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur_terminate_member;
    
    -- Loop update the fees and statuses in the member table
	fee_loop: LOOP
		FETCH cur_terminate_member INTO member_id, overdue_fee;
		UPDATE Member m
		SET OverdueFee = overdue_fee, 
        MemberStatus = 	(CASE
							WHEN overdue_fee = 0 THEN 'REGULAR'
							ELSE 'SUSPENDED'
						END)
		WHERE m.MemberID = member_id;
        IF done = 1 THEN LEAVE fee_loop;
		END IF;
	END LOOP;

    CLOSE cur_terminate_member;
END $$
DELIMITER ; -- done task 3
 
-- TASK 4-- 
-- Test case T2 1.1
-- Insert new member with no overdue fee
INSERT INTO `member` (MemberID, MemberStatus, MemberName, MemberAddress, MemberSuburb, MemberState, MemberExpDate, MemberPhone, OverdueFee)
VALUES ('7', 'SUSPENDED', 'John', '12 Magnolia St', 'North', 'SA', '2020-10-21', '1234567891', 0);
-- Insert new borrow record with return date to indicate that this book is already returned
INSERT INTO `borrowedby` (`BookIssueID`, `BranchID`, `BookID`, `MemberID`, `DateBorrowed`, `DateReturned`, `ReturnDueDate`) 
VALUES ('9', '1', '1', '7', '2020-08-30', '2020-09-01', '2020-09-04');
-- Update MemberStatus to 'REGULAR'
UPDATE `member` SET MemberStatus = 'REGULAR' WHERE MemberID = 7;
select * from member;

-- Test case T2 1.2
-- Insert new member with no overdue fee
INSERT INTO `member` (MemberID, MemberStatus, MemberName, MemberAddress, MemberSuburb, MemberState, MemberExpDate, MemberPhone, OverdueFee)
VALUES ('7', 'SUSPENDED', 'John', '12 Magnolia St', 'North', 'SA', '2020-10-21', '1234567891', 0);
-- Insert new borrow record without return date to indicate that this book is past due time (since 2020 already passed)
INSERT INTO `borrowedby` (`BookIssueID`, `BranchID`, `BookID`, `MemberID`, `DateBorrowed`, `ReturnDueDate`) 
VALUES ('9', '1', '1', '7', '2020-08-30', '2020-09-04');
-- Update MemberStatus to REGULAR--
UPDATE `member` SET MemberStatus = 'REGULAR' WHERE MemberID = 7;

-- Test case T2 1.3
-- Insert new member with $10 overdue fee
INSERT INTO `member` (MemberID, MemberStatus, MemberName, MemberAddress, MemberSuburb, MemberState, MemberExpDate, MemberPhone, OverdueFee)
VALUES ('7', 'SUSPENDED', 'John', '12 Magnolia St', 'North', 'SA', '2020-10-21', '1234567891', 10);
-- Insert new borrow record with return date to indicate that this book is already returned
INSERT INTO `borrowedby` (`BookIssueID`, `BranchID`, `BookID`, `MemberID`, `DateBorrowed`, `DateReturned`, `ReturnDueDate`) 
VALUES ('9', '1', '1', '7', '2020-08-30', '2020-09-01', '2020-09-04');
-- Update MemberStatus to â€˜REGULARâ€™
UPDATE `member` SET MemberStatus = 'REGULAR' WHERE MemberID = 7;

-- Test case T2 2.1
-- Insert new member with no overdue fee
INSERT INTO `member` (MemberID, MemberStatus, MemberName, MemberAddress, MemberSuburb, MemberState, MemberExpDate, MemberPhone, OverdueFee)
VALUES ('7', 'SUSPENDED', 'John', '12 Magnolia St', 'North', 'SA', '2020-10-21', '1234567891', 0);
-- Insert new borrow record with return date to indicate that this book is already returned
INSERT INTO `borrowedby` (`BookIssueID`, `BranchID`, `BookID`, `MemberID`, `DateBorrowed`, `DateReturned`, `ReturnDueDate`) 
VALUES ('9', '1', '1', '7', '2020-08-30', '2020-09-01', '2020-09-04');
-- Update OverdueFee to 0
UPDATE `member` SET OverdueFee = 0 WHERE MemberID = 7;
select * from member;

-- Test case T2 2.2
-- Insert new member with $100 overdue fee
INSERT INTO `member` (MemberID, MemberStatus, MemberName, MemberAddress, MemberSuburb, MemberState, MemberExpDate, MemberPhone, OverdueFee)
VALUES ('7', 'SUSPENDED', 'John', '12 Magnolia St', 'North', 'SA', '2020-10-21', '1234567891', 100);
-- Insert new borrow record without return date to indicate that this book is past due time (since 2020 already passed)
INSERT INTO `borrowedby` (`BookIssueID`, `BranchID`, `BookID`, `MemberID`, `DateBorrowed`, `ReturnDueDate`) 
VALUES ('9', '1', '1', '7', '2020-08-30', '2020-09-04');
-- Update OverdueFee to 0
UPDATE `member` SET OverdueFee = 0 WHERE MemberID = 7;

-- Test case T2 3.1
-- Insert new member with no overdue fee
INSERT INTO `member` (MemberID, MemberStatus, MemberName, MemberAddress, MemberSuburb, MemberState, MemberExpDate, MemberPhone, OverdueFee)
VALUES ('7', 'SUSPENDED', 'John', '12 Magnolia St', 'North', 'SA', '2020-10-21', '1234567891', 0);
-- Insert new borrow record with return date to indicate that this book is already returned
INSERT INTO `borrowedby` (`BookIssueID`, `BranchID`, `BookID`, `MemberID`, `DateBorrowed`, `DateReturned`, `ReturnDueDate`) 
VALUES ('9', '1', '1', '7', '2020-08-30', '2020-09-01', '2020-09-04');
-- Return the book by inserting to DateReturned
UPDATE `borrowedby` SET DateReturned = CURDATE() WHERE MemberID = 7;

-- Test case T2 3.2
-- Insert new member with $100 overdue fee
INSERT INTO `member` (MemberID, MemberStatus, MemberName, MemberAddress, MemberSuburb, MemberState, MemberExpDate, MemberPhone, OverdueFee)
VALUES ('7', 'SUSPENDED', 'John', '12 Magnolia St', 'North', 'SA', '2020-10-21', '1234567891', 100);
-- Insert new borrow record without return date to indicate that this book is past due time (since 2020 already passed)
INSERT INTO `borrowedby` (`BookIssueID`, `BranchID`, `BookID`, `MemberID`, `DateBorrowed`, `ReturnDueDate`) 
VALUES ('9', '1', '1', '7', '2020-08-30', '2020-09-04');
-- Return the book by inserting to DateReturned
UPDATE `borrowedby` SET DateReturned = CURDATE() WHERE MemberID = 7;

-- Test case T3
INSERT INTO `member` (MemberID, MemberStatus, MemberName, MemberAddress, MemberSuburb, MemberState, MemberExpDate, MemberPhone, OverdueFee)
VALUES ('7', 'SUSPENDED', 'Aiden', '12 Magnolia St', 'North', 'SA', '2020-10-21', '1234567891', 0);
-- Insert 3 borrow records (2 suspending attempts, 1 currently overdue book) --> To Terminate
INSERT INTO `borrowedby` (`BookIssueID`, `BranchID`, `BookID`, `MemberID`, `DateBorrowed`, `DateReturned`, `ReturnDueDate`) 
VALUES  ('9', '1', '1', '7', '2021-08-30', '2021-09-10', '2021-09-04'),
        ('10', '1', '1', '7', '2022-08-31', '2022-09-20', '2022-09-05'),
        ('11', '1', '1', '7', '2023-08-30', null, '2023-09-04');
INSERT INTO `member` (MemberID, MemberStatus, MemberName, MemberAddress, MemberSuburb, MemberState, MemberExpDate, MemberPhone, OverdueFee)
VALUES ('8', 'REGULAR', 'Brad', '12 Magnolia St', 'North', 'SA', '2020-10-21', '1234567891', 0);
-- Insert 3 borrow records (2 suspending attempts, 1 currently overdue book) --> To Terminate
INSERT INTO `borrowedby` (`BookIssueID`, `BranchID`, `BookID`, `MemberID`, `DateBorrowed`, `DateReturned`, `ReturnDueDate`) 
VALUES  ('12', '1', '1', '8', '2021-08-30', '2021-09-10', '2021-09-04'),
        ('13', '1', '1', '8', '2022-08-31', '2022-09-20', '2022-09-05'),
        ('14', '1', '1', '8', '2023-08-30', null, '2023-09-04');
INSERT INTO `member` (MemberID, MemberStatus, MemberName, MemberAddress, MemberSuburb, MemberState, MemberExpDate, MemberPhone, OverdueFee)
VALUES ('9', 'REGULAR', 'Clyde', '12 Magnolia St', 'North', 'SA', '2020-10-21', '1234567891', 0);
-- Insert 2 borrow records (2 suspending attempts) --> To Ignore (no current overdue book)
INSERT INTO `borrowedby` (`BookIssueID`, `BranchID`, `BookID`, `MemberID`, `DateBorrowed`, `DateReturned`, `ReturnDueDate`) 
VALUES  ('15', '1', '1', '9', '2021-08-30', '2021-09-10', '2021-09-04'),
        ('16', '1', '1', '9', '2022-08-31', '2022-09-20', '2022-09-05');
INSERT INTO `member` (MemberID, MemberStatus, MemberName, MemberAddress, MemberSuburb, MemberState, MemberExpDate, MemberPhone, OverdueFee)
VALUES ('10', 'SUSPENDED', 'David', '12 Magnolia St', 'North', 'SA', '2020-10-21', '1234567891', 0);
-- Insert 2 borrow records (1 suspending attempt, 1 overdue book) --> To Terminate (according to BR7, overdue book = suspending attempt)
INSERT INTO `borrowedby` (`BookIssueID`, `BranchID`, `BookID`, `MemberID`, `DateBorrowed`, `DateReturned`, `ReturnDueDate`) 
VALUES  ('17', '1', '1', '10', '2021-08-30', '2021-09-10', '2021-09-04'),
        ('18', '1', '1', '10', '2023-08-30', null, '2023-09-04');
INSERT INTO `member` (MemberID, MemberStatus, MemberName, MemberAddress, MemberSuburb, MemberState, MemberExpDate, MemberPhone, OverdueFee)
VALUES ('11', 'REGULAR', 'Ella', '12 Magnolia St', 'North', 'SA', '2020-10-21', '1234567891', 0);

CALL terminate_member()

