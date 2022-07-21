USE query_training;

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