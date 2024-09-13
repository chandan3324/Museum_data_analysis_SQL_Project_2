CREATE DATABASE museumdata;

-- use database 
USE museumdata;

-- use painting;

SHOW TABLES;
SELECT * FROM artist;
SELECT * FROM museum;
SELECT * FROM museum_hours;
SELECT * FROM canvas_size;
SELECT * FROM product_size;
SELECT * FROM subject;
SELECT * FROM work;

-- Joining Tables:
-- 1. Retrieve the full name of artists along with the names of the museums where their works are displayed.
CREATE VIEW DATA AS
SELECT a.full_name, w.name as workname , m.name as museumname
FROM work as w
INNER JOIN artist as a
ON a.artist_id = w.artist_id
INNER JOIN museum as m
on w.museum_id=m.museum_id;

SELECT * FROM DATA;

-- 2. Group By and Count:
-- How many works does each artist have in the database? Display the artist's full name along with the count of their works, ordered by the count in descending order.
SELECT full_name, COUNT(workname) AS Count_of_Work
FROM DATA 
GROUP BY full_name
ORDER BY Count_of_work DESC;	

-- 3. Order By and Limit:
-- List the top 5 museums with the highest number of works displayed in the database, along with their respective counts.
SELECT museumname, count(workname) AS Number_of_work
FROM DATA 
GROUP BY museumname
ORDER BY Number_of_work DESC
LIMIT 5;

-- 4. Join, Order By, and Limit:
-- Display the names and styles of the works along with the corresponding museum names, ordered by the museum name in ascending order. Limit the results to 10.
SELECT w.name AS workname , w.style AS workstyle, m.name AS museumname
FROM work as w
INNER JOIN museum as m
ON w.museum_id = m.museum_id
ORDER BY museumname
LIMIT 10;

SELECT * FROM artist;
SELECT * FROM work;
SELECT * FROM PRODUCT_SIZE;


-- 5.Join, Group By, and Sum:
-- Show the total sale price for each artist's works. Display the artist's full name along with the total sale price, ordered by the total sale price in descending order.
CREATE VIEW view1 as
SELECT a.full_name, p.sale_price 
FROM artist as a
INNER JOIN work as w
ON a.artist_id = w.artist_id
INNER JOIN product_size as p
ON w.work_id = p.work_id;

SELECT * FROM view1;

SELECT full_name, count(sale_price) as Total_sales_price
FROM view1
GROUP BY full_name
ORDER BY Total_sales_price DESC;


-- 6. Join, Group By, and Having:
-- List artists who have more than 3 works in the database, along with the count of their works.
CREATE VIEW view2 as 
SELECT a.full_name, w.work_id 
FROM  artist as a
INNER JOIN work as w
ON a.artist_id = w.artist_id;

SELECT * FROM view2;

SELECT full_name, count(work_id) as  Count_of_work
FROM view2
GROUP BY full_name
HAVING Count_of_work > 3;

select * from artist;
select * from work;
select * from product_size;

-- 7. Join, Where, and Order By:
-- Retrieve the names of works and their corresponding artists' full names for works that have a sale price smaller than their regular price. 
CREATE VIEW view3 as 
SELECT a.full_name, w.name, p.sale_price, p.regular_price
FROM artist as a
INNER JOIN work as w
ON a.artist_id = w.artist_id
INNER JOIN product_size as p
ON w.work_id = p.work_id;

SELECT * FROM view3;

SELECT * FROM view3
WHERE sale_price < regular_price
ORDER BY sale_price DESC;

SELECT * FROM canvas_size;
SELECT * FROM work;
SELECT * FROM product_size;
-- 8. Join, Group By, and Average:
-- Calculate the average height and width of the artworks in the database. Display the average height and width.
CREATE VIEW view4 as 
SELECT w.name as artwork, c.height, c.width 
FROM product_size as p
INNER JOIN canvas_size as c
ON p.size_id = c.size_id
INNER JOIN work as w
ON p.work_id = w.work_id;

SELECT * FROM view4;

SELECT artwork, avg(height) as avg_height, avg(width) as avg_width
FROM view4
GROUP BY artwork
ORDER BY avg_height DESC;

-- Join, Group By, and Max:
-- 9 Find the maximum sale price among all the works in each museum. Display the museum name along with the maximum sale price.
SELECT * FROM museum;
SELECT * FROM product_size;
SELECT * FROM work;

CREATE VIEW view5 AS 
SELECT m.name as museum_name, p.sale_price
FROM product_size as p
INNER JOIN work as w
ON p.work_id = w.work_id
INNER JOIN museum as m
ON w.museum_id = m.museum_id;

SELECT * FROM view5;

SELECT museum_name, max(sale_price) as maximum_sale_price
FROM view5
GROUP BY museum_name
ORDER BY maximum_sale_price DESC;


-- Join, Group By, and Concatenate:
-- 10. Concatenate the first name and last name of artists along with their nationality, separated by a comma. Display the concatenated string along with the count of works by each artist, ordered by the count in descending order.
SELECT * FROM artist;
CREATE VIEW view6 as
SELECT concat_ws(',', first_name, last_name, nationality) as Intro, full_name from artist;

SELECT * FROM view6;

CREATE VIEW Intro as
SELECT v.Intro as concatinated ,a.full_name,w.work_id,a.artist_id 
FROM view6 as v
INNER JOIN artist as a
ON v.full_name = a.full_name
INNER JOIN work as w
ON a.artist_id = w.artist_id;

SELECT * FROM Intro;

SELECT concatinated, full_name, count(work_id) as Work_CNT
FROM Intro
GROUP BY concatinated,full_name
ORDER BY Work_CNT DESC;
