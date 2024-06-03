-- Task 1
DELIMITER $$
DROP PROCEDURE IF EXISTS ASequence $$
CREATE PROCEDURE ASequence (IN n INT)
BEGIN
	DECLARE a INT DEFAULT 1;
    DECLARE b INT DEFAULT 1;
    DECLARE i INT DEFAULT 1;
    DECLARE temp int;
    DECLARE str TEXT DEFAULT '';
    SET str = concat (str, a, ' ');
    SET str = concat (str, b, ' ');
    WHILE i<= n-2 DO
		SET temp = a + b;
        SET str = concat (str, temp, ' ');
        SET a = b;
        SET b = temp;
        SET i = i+1;
    END WHILE;
    SELECT str AS 'The Sequence';
END
$$
DELIMITER ;

CALL ASequence (10);

-- Task 2
DELIMITER //
DROP PROCEDURE IF EXISTS TotalAmountPayable //
CREATE PROCEDURE TotalAmountPayable (IN oNumber INT(11), OUT amount NUMERIC(10,2))
BEGIN
	 DECLARE found TEXT DEFAULT 'FALSE';
     SELECT DISTINCT orderNumber into found FROM orderdetails WHERE orderNumber = oNumber;
     IF found != 'FALSE' THEN
		SELECT sum(quantityOrdered*priceEach) into amount
		FROM orderdetails
        WHERE orderNumber = oNumber
		GROUP BY ordernumber;
	 ELSE
	 	SELECT "Order not found." AS 'OUTPUT';
	 END IF;
END
//
DELIMITER ;

-- Task 3
CALL TotalAmountPayable(10100, @amount);
SELECT @amount AS 'Total Amount Payable';

-- Task 4
DELIMITER //
DROP FUNCTION IF EXISTS CalcTotalAmountPayable //
CREATE FUNCTION CalcTotalAmountPayable (oNumber INT(11))
	RETURNS NUMERIC(10,2)
    DETERMINISTIC
BEGIN
	DECLARE amount NUMERIC(10,2) DEFAULT 0.0;
	SELECT sum(quantityOrdered*priceEach) into amount
	FROM orderdetails
	WHERE orderNumber = oNumber
	GROUP BY ordernumber;
	RETURN amount;
END
//
DELIMITER ;

-- Task 5
SELECT orderNumber, CalcTotalAmountPayable(orderNumber) AS 'Total Amount Payable' FROM orders;

-- Task 6
DELIMITER //
DROP PROCEDURE IF EXISTS NumberOfCustByCountry //
CREATE PROCEDURE NumberOfCustByCountry (IN c TEXT, OUT numberOfCustomers INT)
BEGIN
	DECLARE found TEXT DEFAULT 'FALSE';
    SELECT DISTINCT country into found FROM customers WHERE country = c;
    IF found != 'FALSE' THEN
		SELECT count(customerNumber) into numberOfCustomers
		FROM customers
		WHERE country = c
		GROUP BY country;
	ELSE 
		SELECT "Country not found.";
	END IF;
END 
//
DELIMITER ;

-- Task 7
CALL NumberOfCustByCountry('Australia', @totalCustomers);
SELECT @totalCustomers AS 'Output';

-- Task 8
DELIMITER //
DROP PROCEDURE IF EXISTS CalcBonusCredit //
CREATE PROCEDURE CalcBonusCredit (IN cNumber INT(11))
BEGIN
	DECLARE found INT DEFAULT 0;
    DECLARE oldcredit, newcredit NUMERIC(10,2) DEFAULT 0.0;
    SELECT 1 into found FROM customers WHERE customerNumber = cNumber;
    IF FOUND = 1 THEN
		SELECT creditLimit into oldcredit FROM customers WHERE customerNumber = cNumber;
		CASE 
			WHEN oldcredit >= 200000 THEN
				SET newcredit = oldcredit + 50000;
			WHEN oldcredit >= 150000 AND oldcredit < 200000 THEN
				SET newcredit = oldcredit + 30000;
			WHEN oldcredit >= 100000 AND oldcredit < 150000 THEN
				SET newcredit = oldcredit + 15000;
			WHEN oldcredit >= 50000 AND oldcredit < 100000 THEN
				SET newcredit = oldcredit + 5000;
			ELSE
				SET newcredit = oldcredit;
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
-- select creditLimit from customers where customerNumber = 141;