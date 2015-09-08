-- IS607 Week 2 Assignment
-- Use tables in flights database
-- How many airplanes have listed speeds?
SELECT * FROM flights LIMIT 5;


SELECT count(*), 'num_listed_speed'
FROM planes
WHERE speed IS NOT NULL;

-- What is the minimum listed speed?
SELECT MAX(speed)
FROM planes;

-- What is the maximum listed speed?
SELECT MIN(speed)
FROM planes;

-- What is the total distance flown by all the planes in January 2013?
SELECT SUM(distance)
FROM flights
WHERE year = 2013 
AND month = 1;
 
--  What is the total distance flown by all of the planes in January 2013 where the tailnum is missing?
SELECT SUM(distance)
FROM flights
WHERE year = 2013 
AND month = 1
AND tailnum IS NULL;

/* What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer?  
Write this statement first using an INNER JOIN, then using a LEFT OUTER JOIN.  
How do your results compare? */ 

SELECT p.manufacturer, SUM(distance)
FROM flights as f
INNER JOIN planes as p
ON f.tailnum = p.tailnum
WHERE f.year = 2013 
AND f.month = 7
AND f.day = 5
GROUP BY p.manufacturer;


SELECT p.manufacturer, SUM(distance)
FROM flights as f
LEFT OUTER JOIN planes as p
ON f.tailnum = p.tailnum
WHERE f.year = 2013 
AND f.month = 7
AND f.day = 5
GROUP BY p.manufacturer;

/* The results differ in that when the left outer join is used results are 
included for no manufacturer is listed (manufacturer is null) */

/* Write and answer at least one question of your own choosing that joins information from 
at least three of the tables in the flights database.

On July 5th, 2013, find the first 10 flights departing the NYC area (GIVEN THAT THIS IS THE SCOPE OF THE FLIGHTS DATABASE 
and excluding flights with unknown departure times), the airlines associated with these flights and the manufacturer and tail number
of the airplane.  Also include he airport codes for origin and destination, and the name of the destination airport.  

*/ 

SELECT f.dep_time, al.name, f.origin, f.dest, ap.name, p.manufacturer, f.tailnum 
FROM flights as f
INNER JOIN planes as p
ON f.tailnum = p.tailnum
INNER JOIN airlines as al
ON f.carrier = al.carrier
INNER JOIN airports as ap
ON ap.faa = f.dest
WHERE f.year = 2013 
AND f.month = 7
AND f.day = 5
AND f.dep_time IS NOT NULL
ORDER BY f.dep_time ASC LIMIT 10;
