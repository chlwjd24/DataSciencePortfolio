DELIMITER //

DROP PROCEDURE IF EXISTS country_list;

//

DELIMITER //

CREATE PROCEDURE country_list(INOUT c_list TEXT)

BEGIN

DECLARE cnt varchar(255);
DECLARE finished INT DEFAULT 0;

DECLARE countries Cursor For
     
SELECT distinct country from customers;

DECLARE ConTINUE handler for NOT FOUND SET finished=1;

OPEN countries;

while finished !=1 DO

FETCH countries into cnt;

SET c_list =CONCAT (c_list,cnt,',');

END WHILE;

CLOSE countries;

END 
//

delimiter ;


SET @c_list='';

CALL country_list(@c_list);
SELECT @c_list;




DROP TABLE IF EXISTS products_audit;


CREATE TABLE products_audit(audit_id int auto_increment primary key, 
productCode varchar(15) not null, 
quantityInStock smallint(6),
buyPrice decimal(10,2),
MSRP decimal(10,2),
updateUser varchar(20) not null,
 updateTime datetime not null);

DELIMITER //

DROP trigger IF EXISTS log_products_update

//

DELIMITER //

CREATE trigger log_products_update

BEFORE UPDATE ON products

for each row

BEGIN

INSERT INTO products_audit(productCode,quantityInStock,buyPrice, MSRP, updateUser, updateTime) VALUES (OLD.productCode, OLD.quantityInStock, OLD.buyPrice, OLD.MSRP, current_user, NOW());

END 
//

delimiter ;



SELECT * from products;


update products 
SET buyPrice='50.81' WHERE productCode ='S10_1678';


SELECT * from products;

SELECT * from products_audit;




-- Task 1


DELIMITER //

DROP PROCEDURE IF EXISTS PrintEmployee;

//

DELIMITER //

CREATE PROCEDURE PrintEmployee (IN EmpNo INT)
BEGIN 
DECLARE empName varchar(50);

DECLARE supervisor INT;

DECLARE found TEXT DEFAULT 'FALSE';
    
SELECT DISTINCT employeeNumber into found FROM employees WHERE employeeNumber=EmpNo;
     
IF found != 'FALSE' THEN
        
SELECT CONCAT( firstName, ' ',lastName), reportsTo INTO empName, supervisor from employees Where employeeNumber=EmpNo;
		
SELECT CONCAT (empName, 'reports to employeNumber', supervisor) as 'OUTPUT';
ELSE
	 	
SELECT "EMPLOYEENUMBER not found." AS 'OUTPUT';
	 

END IF;

END

//

Delimiter ;


SELECT * from employees;


CALL PrintEmployee(1056);






-- Task 2


DELIMITER //

DROP PROCEDURE IF EXISTS FindCustomersByCountry;

//

DELIMITER //


CREATE PROCEDURE FindCustomersByCountry(IN country_name TEXT)
BEGIN
DECLARE cNumber INT;

DECLARE cName TEXT;

SELECT customerNumber, customerName INTO cNumber , cName from customers where country=country_name; 

SELECT cNumber AS 'Customer Number', cName AS 'Customer Name';

END
//
Delimiter ; 


CALL FindCustomersByCountry('AUSTRALIA');





-- Task 3


DELIMITER //

DROP PROCEDURE IF EXISTS FindCustomersByCountry;

//

DELIMITER //


CREATE PROCEDURE FindCustomersByCountry(IN country_name TEXT)

BEGIN

DECLARE v_finished INT DEFAULT 0;

DECLARE cNumber INT;

DECLARE cName TEXT;

DECLARE customers_country_rec CURSOR FOR  

SELECT customerNumber, customerName from customers where country=country_name;
 

DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished=1;


OPEN customers_country_rec;

REPEAT 
FETCH customers_country_rec INTO cNumber , cName;
SELECT cNumber AS 'Customer Number', cName AS 'Customer Name';

UNTIL v_finished
END 
REPEAT;

CLOSE customers_country_rec; 

END

//

Delimiter ;




-- Task 4



CALL FindCustomersByCountry('AUSTRALIA');





-- Task 5

DELIMITER //

DROP PROCEDURE IF EXISTS CalcBonusCredit

//
CREATE PROCEDURE CalcBonusCredit (IN cNumber INT(11))

BEGIN
	
DECLARE found INT DEFAULT 0;
    
DECLARE oldcredit, newcredit NUMERIC(10,2) DEFAULT 0.0;
    
SELECT 1 into found FROM customers WHERE customerNumber = cNumber;
    
IF FOUND = 1 THEN
		
SELECT creditLimit into oldcredit FROM customers WHERE customerNumber = cNumber;
		
CASE 
			
WHEN oldcredit >= 100000 THEN
				
SET newcredit = oldcredit + 25  ;
			
WHEN oldcredit >= 50000 AND oldcredit < 100000 THEN
				
SET newcredit = oldcredit + 15;
			
ELSE
				
SET newcredit = oldcredit+500;
		
END CASE;
        
UPDATE customers
        
SET creditLimit = newcredit
        
WHERE customerNumber = cNumber;
        
SELECT 'RECORD UPDATED.' AS 'OUTPUT';
	
ELSE
		
SELECT 'CUSTOMER NOT FOUND' AS 'OUTPUT';
	
END IF;

END
//

DELIMITER ;



CALL CalcBonusCredit(141);



-- Task 6



CALL FindCustomersByCountry('USA');



-- Task 7

DELIMITER //

DROP TRIGGER IF EXISTS check_creditLimit ;

//
DELIMITER //

CREATE TRIGGER check_creditLimit
BEFORE UPDATE ON customers
for each row 
BEGIN
DECLARE msg VARCHAR (255);

DECLARE min_limit DECIMAL (10,2) DEFAULT 500;

IF NEW.creditlimit < min_limit Then
SET msg ='ERROR !!! The minimum Credit for any customer is 500';

SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =msg;

END IF ;

END

//

DELIMITER ; 

Task 8 

update customers set creditLimit=458 where customerNumber=114;


Task 9 

DELIMITER //
DROP TRIGGER IF EXISTS AmountCheck //
CREATE TRIGGER AmountCheck
AFTER INSERT ON orderdetails
    FOR EACH ROW
BEGIN
    DECLARE TotalAmount_Payable Numeric (10,2) DEFAULT 0.0;
    SELECT sum(NEW.quantityOrdered*NEW.priceEach) into TotalAmount_Payable
    FROM orderdetails
    WHERE orderNumber = NEW.orderNumber;
   
    IF TotalAmount_Payable < 2000 THEN
 UPDATE orders
        SET status = 'Pending'
        WHERE orderNumber = NEW.orderNumber;
       
ELSE
 UPDATE orders
        SET status = 'Confirmed'
        WHERE orderNumber = NEW.orderNumber;
END IF;
END
//
DELIMITER ;



insert into orderdetails values(10116,'S24_2022',12,44.35,2) ;
select * from orders where orderNumber= 10116;

