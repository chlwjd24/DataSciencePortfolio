DELIMITER //

DROP PROCEDURE IF EXISTS CalculateAverage;

CREATE PROCEDURE CalculateAverage()
BEGIN
	DECLARE lower_limit, upper_limit INT;
    DECLARE num_count, total INT DEFAULT 0;
    DECLARE range_average Numeric(5,2) DEFAULT 0;
    
    SET lower_limit = 3;  -- fixed parameter
    SET upper_limit = 15; -- fixed parameter
    
    WHILE (lower_limit + num_count) <= upper_limit DO
		SET total = total + lower_limit + num_count;
        SET num_count = num_count + 1;
	END WHILE;
    
    SET range_average = total / num_count;
    SELECT range_average 'Range Average';
END //
DELIMITER ;

CALL CalculateAverage();

DELIMITER //

DROP PROCEDURE IF EXISTS giveDiscount;

CREATE PROCEDURE giveDiscount(IN price Numeric(5,2), IN discount_code CHAR(1))
BEGIN
	DECLARE discount Numeric(5,2);
    CASE 
		WHEN discount_code = 'A' THEN
			SET discount = price*0.2;  -- 20% discount
        WHEN discount_code = 'B' THEN
			SET discount = price*0.15; -- 15% discount
        WHEN discount_code = 'C' THEN
			SET discount = price*0.1;  -- 10% discount
        WHEN discount_code = 'D' THEN
			SET discount = price*0.05; -- 5% discount
	/* ELSE
		-- discuss what happens if ELSE is omitted and an invalid discount code is given
        -- e.g., CALL giveDiscount(100, 'Z');
        -- discuss how to fix it
		SET discount = 0; */
    END CASE; 
    SELECT (price - discount) 'Sale Price';
END //

DELIMITER ;
 
CALL giveDiscount(100, 'A');

DELIMITER //

DROP PROCEDURE IF EXISTS OddOrEven;

CREATE PROCEDURE OddOrEven(IN myNumber INT)
BEGIN
	IF myNumber % 2 = 0 THEN 
		SELECT concat(myNumber," is even");
	ELSE
		SELECT concat(myNumber," is odd");
    END IF;
END //

DELIMITER ;
 
CALL OddOrEven(123);

DELIMITER //

DROP PROCEDURE IF EXISTS print_oddnumbers;

DELIMITER //
CREATE PROCEDURE print_oddnumbers(IN lower_limit INT, IN upper_limit INT)
BEGIN
	DECLARE num_count INT;
    SET  num_count = lower_limit;
    WHILE num_count <= upper_limit DO
		IF num_count % 2 <> 0 THEN 
			SELECT concat(num_count," is odd");
		END IF;
		SET num_count = num_count + 1;
	END WHILE;
END//
DELIMITER ;

CALL print_oddnumbers(5,15);

