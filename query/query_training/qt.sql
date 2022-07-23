USE query_training;


					-- INTERSECT, EXCEPT --
/*
-- INTERSECT = values what are available in table1 and in table2
-- EXCEPT = values what are available in table1 but not in table2

SELECT car_id FROM car_details
INTERSECT
SELECT car_id FROM available_cars
--
SELECT car_id FROM car_details
EXCEPT
SELECT car_id FROM available_cars
*/



					-- DISCTINCT --
/*
-- DISTINCT = unique values in column
SELECT DISTINCT car_brand FROM car_details;
SELECT COUNT(DISTINCT car_brand) AS 'Unique car brands' FROM car_details;
*/



					-- TOP, BOTTOM --
/*
-- TOP number || ..% PERCENT  = first n-values in select
-- there is NO BOTTOM func -> SELECT TOP ... ORDER BY ... DESC
-- bottom can be better with ORDER BY id
--
SELECT TOP 5 car_id,car_brand, car_brand_model
FROM car_details
ORDER BY car_id DESC;
--
SELECT TOP 15 PERCENT car_brand, car_brand_model
FROM car_details;
*/



					-- MIN, MAX, COUNT, AVG, SUM --
/*
-- MIN MAX values in fields
SELECT MIN(car_brand) AS 'First in list' FROM car_details;
SELECT MAX(car_id)  AS 'MAX id' FROM car_details;

-- COUNT number of values
SELECT COUNT(car_id) AS 'Count of Audi' FROM car_details
WHERE car_brand = 'Audi';

-- AVG number of values
-- in this case it's AVG by car_id
SELECT AVG(car_id) AS 'AVG of Audi' FROM car_details
WHERE car_brand = 'Audi';

-- SUM of values
SELECT SUM(price) AS 'Price of all cars' FROM available_cars
*/



					-- IN (list) --
/*
-- IN = list of elements
-- NOT IN (...) 
--
SELECT * FROM car_details
WHERE car_brand IN ('Volkswagen', 'Audi', 'BMW')
ORDER BY car_brand;

-- IN can be used to make list in a result of SELECT
-- it's important to choose identical columns in subquery
SELECT * FROM car_details
WHERE car_brand NOT IN (SELECT car_brand FROM car_details WHERE car_id BETWEEN 17 AND 20)
ORDER BY car_brand;
*/



					-- LIKE --
/*
-- % - any count of characters
-- _ - 1 character
-- [a-z] - all characters in brackets from a to z
-- [abc] - every character in bracket
-- [^abc] - every character NOT in bracket
--
SELECT * FROM car_showroom AS show JOIN available_cars AS car
	ON show.car_showroom_id = car.car_showroom_id
WHERE car.color LIKE '%ck'
--
SELECT * FROM car_showroom AS show JOIN available_cars AS car
	ON show.car_showroom_id = car.car_showroom_id
WHERE car.color LIKE 'o[a-z]%'
--
SELECT * FROM car_showroom AS show JOIN available_cars AS car
	ON show.car_showroom_id = car.car_showroom_id
WHERE car.color LIKE 'r[^qwtyui]_'
*/



					-- UNION --
/*
-- UNION queries by equal count of columns
SELECT showroom_brand FROM car_showroom
UNION
SELECT car_brand FROM car_details;
*/



					-- GROUP BY --
/*
-- GROUP BY used with aggregate functions (COUNT(), MAX(), MIN(), SUM(), AVG()) to 
-- group the result-set by one or more columns
--
SELECT COUNT(car_id) AS 'Count', car_brand FROM car_details
GROUP BY car_brand
HAVING COUNT(car_id) > 1	-- optional
ORDER BY COUNT(car_id) DESC
--
-- sum all price by color
SELECT SUM(price) AS 'Money', color FROM available_cars
GROUP BY color
ORDER BY SUM(price) DESC
*/



					-- ALL, ANY --
/*
-- ALL, ANY returns FALSE or TRUE and 
-- select needed rows
--
SELECT *
FROM car_details
WHERE car_brand = ALL
  (SELECT car_brand
  FROM car_details
  WHERE car_brand LIKE '%o%y%');
--
SELECT *
FROM car_details
WHERE car_brand != ANY
  (SELECT car_brand
  FROM car_details
  WHERE car_brand LIKE '%o%y%');
*/



					-- CASE -> WHEN, THEN, ELSE --
/*
SELECT car_brand, car_brand_model,
CASE
    WHEN car_id <= 17 THEN 'ID is <= 17'
    WHEN car_id > 17 AND car_id <= 20 THEN 'ID is > 17 and <= 20'
    ELSE 'ID is bigger than 20'
END AS 'ID info'	-- additional column
FROM car_details;
--
SELECT car_brand, car_brand_model
FROM car_details
ORDER BY
(CASE
    WHEN car_id <= 17 THEN car_brand
    ELSE car_brand_model
END);
*/




					-- UPDATE --
/*
-- Update ONLY for rows with price >= 38000
-- with case
--
UPDATE available_cars
SET price = 
	CASE 
		WHEN price >= 38000 THEN 40000
		ELSE 600
	END
WHERE price >= 38000;
--
-- default update
--
UPDATE available_cars
SET price = price * 2
WHERE price >= 500 AND price <= 90000;
--
UPDATE available_cars
SET price = price + 500
WHERE car_id IN (14,23,20);
*/



					-- JOINS --
/*
-- (INNER) JOIN = records that have matching values in both tables
-- LEFT (OUTER) JOIN = (INNER) JOIN + all records from the left table
-- RIGHT (OUTER) JOIN = (INNER) JOIN + all records from the right table
-- FULL (OUTER) JOIN = LEFT (OUTER) JOIN + RIGHT (OUTER) JOIN
--
SELECT * FROM car_details AS det 
	LEFT JOIN available_cars AS cars ON det.car_id = cars.car_id
SELECT * FROM car_details AS det 
	RIGHT JOIN available_cars AS cars ON det.car_id = cars.car_id
-- in this case INNER = RIGHT and LEFT = FULL

-- self join 
SELECT car1.car_brand, car2.car_brand_model FROM car_details AS car1, car_details AS car2
WHERE car1.car_id <> car2.car_id
	AND car1.car_brand = car2.car_brand 
ORDER BY car1.car_brand;
*/




					-- EXISTS --
/*
-- EXISTS return TRUE/FALSE
-- Checks for the existence of any record within the subquery
-- DOESN'T return any records
--
SELECT car_brand
FROM car_details
WHERE EXISTS (SELECT * FROM car_details WHERE car_id <= 20);
*/



					-- DATE --
/*
-- DATEADD(day/year, count of days/years, column) = add date
-- GETDATE() = current date
-- DATEPART(d/m/y, column) = return part of date
-- DATEDIFF() = difference between 2 dates
-- CONVERT(VARCHAR(...), date, 1-21(date style))
--
SELECT car_brand
FROM car_details
WHERE EXISTS (SELECT * FROM car_details WHERE car_id <= 20);
*/



					-- TRANSACTIONS --
/*
BEGIN TRANSACTION tran_1
	WITH MARK 'UPDATE car price'
	UPDATE available_cars
		SET price = price + 5000
		WHERE car_id = 21
	SELECT * FROM available_cars
ROLLBACK TRANSACTION	-- cancel changes
-- COMMIT TRANSACTION = accept changes
SELECT * FROM available_cars

--

BEGIN TRANSACTION
	UPDATE available_cars
		SET price = price + 5000
		WHERE car_id = 21
	SELECT * FROM available_cars

	SAVE TRANSACTION tran_2		-- savepoints = checkpionts

	UPDATE available_cars
		SET price = price + 5000
		WHERE car_id = 21
	SELECT * FROM available_cars

	ROLLBACK TRANSACTION tran_2	-- cancel changes, go to savepoint
	-- COMMIT TRANSACTION = accept changes
	SELECT * FROM available_cars
COMMIT TRANSACTION
*/

					-- STRING FUNCTIONS --
/*
ASCII		Returns the ASCII value for the specific character
CHAR		Returns the character based on the ASCII code
CHARINDEX	Returns the position of a substring in a string
CONCAT		Adds two or more strings together
CONCAT_WS	Adds two or more strings together with a separator
DATALENGTH	Returns the number of bytes used to represent an expression
DIFFERENCE	Compares two SOUNDEX values, and returns an integer value
FORMAT		Formats a value with the specified format
LEFT		Extracts a number of characters from a string (starting from left)
LEN			Returns the length of a string
LOWER		Converts a string to lower-case
LTRIM		Removes leading spaces from a string
NCHAR		Returns the Unicode character based on the number code
PATINDEX	Returns the position of a pattern in a string
QUOTENAME	Returns a Unicode string with delimiters added to make the string a valid SQL Server delimited identifier
REPLACE		Replaces all occurrences of a substring within a string, with a new substring
REPLICATE	Repeats a string a specified number of times
REVERSE		Reverses a string and returns the result
RIGHT		Extracts a number of characters from a string (starting from right)
RTRIM		Removes trailing spaces from a string
SOUNDEX		Returns a four-character code to evaluate the similarity of two strings
SPACE		Returns a string of the specified number of space characters
STR			Returns a number as string
STUFF		Deletes a part of a string and then inserts another part into the string, starting at a specified position
SUBSTRING	Extracts some characters from a string
TRANSLATE	Returns the string from the first argument after the characters specified in the second argument are translated into the characters specified in the third argument.
TRIM		Removes leading and trailing spaces (or other specified characters) from a string
UNICODE		Returns the Unicode value for the first character of the input expression
UPPER		Converts a string to upper-case
*/



					-- MATH FUNCTIONS --
/*
ABS		Returns the absolute value of a number
ACOS	Returns the arc cosine of a number
ASIN	Returns the arc sine of a number
ATAN	Returns the arc tangent of a number
ATN2	Returns the arc tangent of two numbers
AVG		Returns the average value of an expression
CEILING	Returns the smallest integer value that is >= a number
COUNT	Returns the number of records returned by a select query
COS		Returns the cosine of a number
COT		Returns the cotangent of a number
DEGREES	Converts a value in radians to degrees
EXP		Returns e raised to the power of a specified number
FLOOR	Returns the largest integer value that is <= to a number
LOG		Returns the natural logarithm of a number, or the logarithm of a number to a specified base
LOG10	Returns the natural logarithm of a number to base 10
MAX		Returns the maximum value in a set of values
MIN		Returns the minimum value in a set of values
PI		Returns the value of PI
POWER	Returns the value of a number raised to the power of another number
RADIANS	Converts a degree value into radians
RAND	Returns a random number
ROUND	Rounds a number to a specified number of decimal places
SIGN	Returns the sign of a number
SIN		Returns the sine of a number
SQRT	Returns the square root of a number
SQUARE	Returns the square of a number
SUM		Calculates the sum of a set of values
TAN		Returns the tangent of a number
*/