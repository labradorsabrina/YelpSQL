--Part 1: Yelp Dataset Profiling and Understanding

--1. Total number of records for each of the tables:

SELECT COUNT(*) from business; -- Business Table (10000) rows
SELECT COUNT(*) from attribute; -- Attribute (10000)
SELECT COUNT(*) from category; -- Category (10000) rows 
SELECT COUNT(*) from checkin; -- Checkin (10000) rows
SELECT COUNT(*) from elite_years; -- elite_years (10000) rows
SELECT COUNT(*) from friend; -- friend (10000) rows 
SELECT COUNT(*) from hours; -- hours (10000) rows
SELECT COUNT(*) from photo; -- photo (10000) rows
SELECT COUNT(*) from review; -- review (10000) rows
SELECT COUNT(*) from tip; -- tip (10000) rows
SELECT COUNT(*) from user; -- user (10000) rows

--2. Total distinct records by either the foreign key or primary key for each table. 

SELECT Count(DISTINCT(id)) from business; -- Business Table (10000) rows
SELECT Count(DISTINCT(business_id)) from hours; -- Hours Table (1562) rows
SELECT Count(DISTINCT(business_id)) from category; -- Category Table (2643) rows
SELECT Count(DISTINCT(business_id)) from attribute; -- Attribute Table (1115) rows
SELECT  Count(DISTINCT(id)),
        Count(DISTINCT(business_id)),
        Count(DISTINCT(user_id)) 
        from review; -- review Table (10000), (8090), (9581)
SELECT Count(DISTINCT(business_id)) from checkin; -- Chekin Table (493) rows
SELECT  Count(DISTINCT(id)), 
        Count(DISTINCT(business_id)) 
        from photo; -- Photo Table (10000), (6493) Distinctive rows
SELECT  Count(DISTINCT(user_id)), 
        Count(DISTINCT(business_id))
        from tip; -- Tip Table (537) Distictive user,  (3979) Distinctive business
SELECT COUNT(id) from user; -- (10000) Distinctive users.
SELECT Count(DISTINCT(user_id)) from friend; -- Only (11) distictive users has friends
SELECT Count(DISTINCT(user_id)) from elite_years; -- (2780) Users have elite years.

-- 3. Checking NULL values on User Table

SELECT
  SUM(CASE WHEN id is null then 1 else 0 end) AS id
  ,SUM(CASE WHEN name is null then 1 else 0 end) AS Name
  ,SUM(CASE WHEN review_count is null then 1 else 0 end) AS Review_count
  ,SUM(CASE WHEN yelping_since is null then 1 else 0 end) AS Yelping_since
  ,SUM(CASE WHEN useful is null then 1 else 0 end) AS Useful
  ,SUM(CASE WHEN funny is null then 1 else 0 end) AS Funny
  ,SUM(CASE WHEN cool is null then 1 else 0 end) AS Cool
  ,SUM(CASE WHEN fans is null then 1 else 0 end) AS Fans
  ,SUM(CASE WHEN average_stars is null then 1 else 0 end) AS Average_stars
  ,SUM(CASE WHEN compliment_hot is null then 1 else 0 end) AS Compliment_hot
  ,SUM(CASE WHEN compliment_more is null then 1 else 0 end) AS Compliment_more
  ,SUM(CASE WHEN compliment_profile is null then 1 else 0 end) AS Compliment_profile
  ,SUM(CASE WHEN compliment_cute is null then 1 else 0 end) AS Compliment_cute
  ,SUM(CASE WHEN compliment_list is null then 1 else 0 end) AS Compliment_list
  ,SUM(CASE WHEN compliment_note is null then 1 else 0 end) AS Compliment_note
  ,SUM(CASE WHEN compliment_plain is null then 1 else 0 end) AS Compliment_plain
  ,SUM(CASE WHEN compliment_cool is null then 1 else 0 end) AS Compliment_cool
  ,SUM(CASE WHEN compliment_funny is null then 1 else 0 end) AS Compliment_funny
  ,SUM(CASE WHEN compliment_writer is null then 1 else 0 end) AS Compliment_writer
  ,SUM(CASE WHEN compliment_photos is null then 1 else 0 end) AS Compliment_photos
FROM User;

-- 4. Checking the smallest (minimum), largest (maximum), and average (mean) value for the following tables and fields:

--	i. Table: Review, Column: Stars
	Select MIN(stars), 
       MAX(stars),
       AVG(stars) from review;
--		min:	1	max:	5	avg: 3.7082
		
	
--	ii. Table: Business, Column: Stars
	Select MIN(stars), 
       MAX(stars),
       AVG(stars) from business;
--		min:  1.0	max:   5.0 	avg: 3.6549
		
	
--	iii. Table: Tip, Column: Likes
	Select MIN(likes), 
       MAX(likes),
       AVG(likes) from tip;
--		min:   0 	max:	2	avg: 0.0144
		
	
--	iv. Table: Checkin, Column: Count
    Select MIN(count), 
       MAX(count),
       AVG(count) from checkin;
--		min:	1	max:	53	avg: 1.9414
		
	
--	v. Table: User, Column: Review_count
	Select MIN(review_count), 
       MAX(review_count),
       AVG(review_count) from user;
--		min:	0	max:	2000	avg: 24.2995

-- 5. List the cities with the most reviews in descending order:

SELECT
  SUM(review_count) AS reviews,
  City
FROM Business
GROUP BY City
ORDER BY reviews_total DESC

/*
+-----------------+---------+
| city            | reviews |
+-----------------+---------+
| Las Vegas       |   82854 |
| Phoenix         |   34503 |
| Toronto         |   24113 |
| Scottsdale      |   20614 |
| Charlotte       |   12523 |
| Henderson       |   10871 |
| Tempe           |   10504 |
| Pittsburgh      |    9798 |
| Montréal        |    9448 |
| Chandler        |    8112 |
| Mesa            |    6875 |
| Gilbert         |    6380 |
| Cleveland       |    5593 |
| Madison         |    5265 |
| Glendale        |    4406 |
| Mississauga     |    3814 |
| Edinburgh       |    2792 |
| Peoria          |    2624 |
| North Las Vegas |    2438 |
| Markham         |    2352 |
| Champaign       |    2029 |
| Stuttgart       |    1849 |
| Surprise        |    1520 |
| Lakewood        |    1465 |
| Goodyear        |    1155 |
+-----------------+---------+
(Output limit exceeded, 25 of 362 total rows shown)

*/
	
-- 6. Distribution of star ratings at the business in the following cities:

--i. Avon

Select b.stars, 
       b.review_count 
       from (business) b 
       WHERE b.City = "Avon"
       ORDER BY 1 DESC;

/*
+---------+----------------+
| b.stars | b.review_count |
+---------+----------------+
|     5.0 |              3 |
|     4.5 |             31 |
|     4.0 |              4 |
|     4.0 |             17 |
|     3.5 |              7 |
|     3.5 |             31 |
|     3.5 |             50 |
|     2.5 |              3 |
|     2.5 |              3 |
|     1.5 |             10 |
+---------+----------------+
*/

--ii. Beachwood

Select b.stars, 
       b.review_count 
       from (business) b 
       WHERE b.City = "Beachwood"
       ORDER BY 1 DESC;

/*
+---------+----------------+
| b.stars | b.review_count |
+---------+----------------+
|     5.0 |              6 |
|     5.0 |              4 |
|     5.0 |              6 |
|     5.0 |              3 |
|     5.0 |              4 |
|     4.5 |             14 |
|     4.5 |              3 |
|     4.0 |             69 |
|     3.5 |              3 |
|     3.5 |              3 |
|     3.0 |              8 |
|     3.0 |              3 |
|     2.5 |              3 |
|     2.0 |              8 |
+---------+----------------+
*/

--7. Top 3 users based on their total number of reviews:

Select u.name, 
       u.review_count 
       from (user) u 
       ORDER BY 2 DESC
       LIMIT 3;

Select u.name, 
       Count(r.id) 
       from (user) u INNER JOIN (review) r
       ON u.id = r.user_id
       GROUP BY 1
       ORDER BY 2 DESC
       LIMIT 3;

/*
    +--------+----------------+
    | u.name | u.review_count |
    +--------+----------------+
    | Gerald |           2000 |
    | Sara   |           1629 |
    | Yuri   |           1339 |
    +--------+----------------+

    +-----------+-------------+
    | u.name    | Count(r.id) |
    +-----------+-------------+
    | Ed        |           3 |
    | Amy       |           2 |
    | Christina |           2 |
    +-----------+-------------+
*/

-- 8. Does posing more reviews correlate with more fans?

    -- As table below illustrates, posing more reviews does not necessarily correlate with more fans. 
    -- For example, although, Gerald has posed the most reviews, he has fewer fans in comparison with Mimi. 
    -- Therefore, sorting the users in descending order based on their total number of reviews does not sort the fans in the same order, 
    -- meaning that there is not a correlation between the total number of reviews and number of fans. 	


    SELECT
        name
        , id
        , review_count
        , fans
        FROM user
        ORDER BY 3 DESC;

    /*
    +-----------+------------------------+--------------+------+
    | name      | id                     | review_count | fans |
    +-----------+------------------------+--------------+------+
    | Gerald    | -G7Zkl1wIWBBmD0KRy_sCw |         2000 |  253 |
    | Sara      | -3s52C4zL_DHRK0ULG6qtg |         1629 |   50 |
    | Yuri      | -8lbUNlXVSoXqaRRiHiSNg |         1339 |   76 |
    | .Hon      | -K2Tcgh2EKX6e6HqqIrBIQ |         1246 |  101 |
    | William   | -FZBTkAZEXoP7CYvRV2ZwQ |         1215 |  126 |
    | Harald    | --2vR0DIsmQ6WfcSzKWigw |         1153 |  311 |
    | eric      | -gokwePdbXjfS0iF7NsUGA |         1116 |   16 |
    | Roanna    | -DFCC64NXgqrxlO8aLU5rg |         1039 |  104 |
    | Mimi      | -8EnCioUmDygAbsYZmTeRQ |          968 |  497 |
    | Christine | -0IiMAZI2SsQ7VmyzJjokQ |          930 |  173 |
    | Ed        | -fUARDNuXAfrOn4WLSZLgA |          904 |   38 |
    | Nicole    | -hKniZN2OdshWLHYuj21jQ |          864 |   43 |
    | Fran      | -9da1xk7zgnnfO1uTVYGkA |          862 |  124 |
    | Mark      | -B-QEUESGWHPE_889WJaeg |          861 |  115 |
    | Christina | -kLVfaJytOJY2-QdQoCcNQ |          842 |   85 |
    | Dominic   | -kO6984fXByyZm3_6z2JYg |          836 |   37 |
    | Lissa     | -lh59ko3dxChBSZ9U7LfUw |          834 |  120 |
    | Lisa      | -g3XIcCb2b-BD0QBCcq2Sw |          813 |  159 |
    | Alison    | -l9giG8TSDBG1jnUBUXp5w |          775 |   61 |
    | Sui       | -dw8f7FLaUmWR7bfJ_Yf0w |          754 |   78 |
    | Tim       | -AaBjWJYiQxXkCMDlXfPGw |          702 |   35 |
    | L         | -jt1ACMiZljnBFvS6RRvnA |          696 |   10 |
    | Angela    | -IgKkE8JvYNWeGu8ze4P8Q |          694 |  101 |
    | Crissy    | -hxUwfo3cMnLTv-CAaP69A |          676 |   25 |
    | Lyn       | -H6cTbVxeIRYR-atxdielQ |          675 |   45 |
    +-----------+------------------------+--------------+------+
    (Output limit exceeded, 25 of 10000 total rows shown)
    */

-- 9. Are there more reviews with the word "love" or with the word "hate" in them?

	-- Answer:
    -- LOVE
    	
	-- SQL code used to arrive at answer:
SELECT
        SUM(CASE WHEN lower(text) LIKE '%love%' THEN 1 ELSE 0 END) AS LOVE,
        SUM(CASE WHEN lower(text) LIKE '%hate%' THEN 1 ELSE 0 END) AS HATE
FROM review;
    
    /*
    +------+------+
    | LOVE | HATE |
    +------+------+
    | 1780 |  232 |
    +------+------+
    */

-- 10. Top 10 users with the most fans:
	
	SELECT 
        name
        ,id
        ,fans
        FROM user
        ORDER BY fans DESC;

    /*
    +-----------+------------------------+------+
    | name      | id                     | fans |
    +-----------+------------------------+------+
    | Amy       | -9I98YbNQnLdAmcYfb324Q |  503 |
    | Mimi      | -8EnCioUmDygAbsYZmTeRQ |  497 |
    | Harald    | --2vR0DIsmQ6WfcSzKWigw |  311 |
    | Gerald    | -G7Zkl1wIWBBmD0KRy_sCw |  253 |
    | Christine | -0IiMAZI2SsQ7VmyzJjokQ |  173 |
    | Lisa      | -g3XIcCb2b-BD0QBCcq2Sw |  159 |
    | Cat       | -9bbDysuiWeo2VShFJJtcw |  133 |
    | William   | -FZBTkAZEXoP7CYvRV2ZwQ |  126 |
    | Fran      | -9da1xk7zgnnfO1uTVYGkA |  124 |
    | Lissa     | -lh59ko3dxChBSZ9U7LfUw |  120 |
    | Mark      | -B-QEUESGWHPE_889WJaeg |  115 |
    | Tiffany   | -DmqnhW4Omr3YhmnigaqHg |  111 |
    | bernice   | -cv9PPT7IHux7XUc9dOpkg |  105 |
    | Roanna    | -DFCC64NXgqrxlO8aLU5rg |  104 |
    | Angela    | -IgKkE8JvYNWeGu8ze4P8Q |  101 |
    | .Hon      | -K2Tcgh2EKX6e6HqqIrBIQ |  101 |
    | Ben       | -4viTt9UC44lWCFJwleMNQ |   96 |
    | Linda     | -3i9bhfvrM3F1wsC9XIB8g |   89 |
    | Christina | -kLVfaJytOJY2-QdQoCcNQ |   85 |
    | Jessica   | -ePh4Prox7ZXnEBNGKyUEA |   84 |
    | Greg      | -4BEUkLvHQntN6qPfKJP2w |   81 |
    | Nieves    | -C-l8EHSLXtZZVfUAUhsPA |   80 |
    | Sui       | -dw8f7FLaUmWR7bfJ_Yf0w |   78 |
    | Yuri      | -8lbUNlXVSoXqaRRiHiSNg |   76 |
    | Nicole    | -0zEEaDFIjABtPQni0XlHA |   73 |
    +-----------+------------------------+------+
    (Output limit exceeded, 25 of 10000 total rows shown)
    */

--    Part 2: Inferences and Analysis

--  City: Las Vegas & Category: Restaurants
--  and group the businesses in that city or category by their overall star rating. 
--  Compare the businesses with 2-3 stars to the businesses with 4-5 stars and answer the following questions.

SELECT
   CASE
       WHEN B.stars >= 2 AND B.stars < 4 THEN '2-3'
       WHEN B.stars >= 4 AND B.stars <= 5 THEN '4-5'
       WHEN B.stars >= 0 AND B.stars < 2 THEN '0-2'
   Else 'Error'
   END AS Stars_group
   ,
   CASE
       WHEN C.Category = 'Restaurants' THEN 'Restaurant'
       WHEN B.City = 'Las Vegas' THEN 'Las Vegas'
   Else 'Other'
   END AS Selection_group
  ,AVG(
   CASE
       WHEN
       ABS(TRIM(SUBSTR(SUBSTR(REPLACE(hours,'|','  '), -11),1,5), '-') -
           TRIM(SUBSTR(hours,-5), '-')) = 0
       THEN 24
   Else
       ABS(TRIM(SUBSTR(SUBSTR(REPLACE(hours,'|','  '), -11),1,5), '-') -
           TRIM(SUBSTR(hours,-5), '-'))
   END
   )
   AS Avg_daily_hours
   ,COUNT(DISTINCT H.hours) AS Days
   ,COUNT(DISTINCT B.id) AS Businesses
--    ,B.id
--    ,B.name
FROM business AS B
INNER JOIN Hours AS H ON B.id = H.business_id
INNER JOIN Category AS C ON B.id = C.business_id
WHERE Selection_group != 'Other'
GROUP BY Stars_group, Selection_group
ORDER BY Selection_group

/* City = 'Las Vegas'
+-------------+-----------------+-----------------+------+------------+
| Stars_group | Selection_group | Avg_daily_hours | Days | Businesses |
+-------------+-----------------+-----------------+------+------------+
| 2-3         | Las Vegas       |   15.4951456311 |   27 |          4 |
| 4-5         | Las Vegas       |   9.07432432432 |   49 |          9 |
| 2-3         | Restaurant      |   11.1547619048 |  150 |         25 |
| 4-5         | Restaurant      |   9.54545454545 |  113 |         18 |
+-------------+-----------------+-----------------+------+------------+
*/
	
/*
i. Do the two groups you chose to analyze have a different distribution of hours?
Yes, The data indicate that the businesses that are open for more hours on average 
are more likely to have 2-3 stars. 

For this analysis I first calculate the distribution of daily hours worked per
business, taking in consideration that the businesses open at 0:00 and closing at 0:00
are open 24 hours per day, like this:
*/

SELECT DISTINCT
   TRIM(SUBSTR(SUBSTR(REPLACE(hours,'|','  '), -11),1,5), '-') AS Begin
   ,TRIM(SUBSTR(hours,-5), '-') AS End   
   ,CASE
       WHEN
       ABS(TRIM(SUBSTR(SUBSTR(REPLACE(hours,'|','  '), -11),1,5), '-') -
           TRIM(SUBSTR(hours,-5), '-')) = 0
       THEN 24
   Else
       ABS(TRIM(SUBSTR(SUBSTR(REPLACE(hours,'|','  '), -11),1,5), '-') -
           TRIM(SUBSTR(hours,-5), '-'))
   END
   AS Daily_hours
   ,H.hours
    ,B.name
FROM business AS B
INNER JOIN Hours AS H ON B.id = H.business_id
LEFT JOIN Category AS C ON B.id = C.business_id
ORDER BY B.name

/*

+-------+-------+-------------+-----------------------+--------------------+
| Begin | End   | Daily_hours | hours                 | name               |
+-------+-------+-------------+-----------------------+--------------------+
| 11:00 | 23:00 |          12 | Monday|11:00-23:00    | 99 Cent Sushi      |
| 11:00 | 23:00 |          12 | Tuesday|11:00-23:00   | 99 Cent Sushi      |
| 11:00 | 23:00 |          12 | Friday|11:00-23:00    | 99 Cent Sushi      |
| 11:00 | 23:00 |          12 | Wednesday|11:00-23:00 | 99 Cent Sushi      |
| 11:00 | 23:00 |          12 | Thursday|11:00-23:00  | 99 Cent Sushi      |
| 11:00 | 23:00 |          12 | Sunday|11:00-23:00    | 99 Cent Sushi      |
| 11:00 | 23:00 |          12 | Saturday|11:00-23:00  | 99 Cent Sushi      |
|  9:00 | 18:00 |           9 | Monday|9:00-18:00     | A & A Traders      |
|  9:00 | 18:00 |           9 | Tuesday|9:00-18:00    | A & A Traders      |
|  9:00 | 18:00 |           9 | Friday|9:00-18:00     | A & A Traders      |
|  9:00 | 18:00 |           9 | Wednesday|9:00-18:00  | A & A Traders      |
|  9:00 | 18:00 |           9 | Thursday|9:00-18:00   | A & A Traders      |
|  9:00 | 18:00 |           9 | Saturday|9:00-18:00   | A & A Traders      |
|  8:30 | 17:30 |           9 | Friday|8:30-17:30     | AAA Phoenix Office |
|  8:30 | 17:30 |           9 | Tuesday|8:30-17:30    | AAA Phoenix Office |
|  8:30 | 17:30 |           9 | Thursday|8:30-17:30   | AAA Phoenix Office |
|  8:30 | 17:30 |           9 | Wednesday|8:30-17:30  | AAA Phoenix Office |
|  8:30 | 17:30 |           9 | Monday|8:30-17:30     | AAA Phoenix Office |
|  7:00 | 16:00 |           9 | Friday|7:00-16:00     | Adobe Montessori   |
|  7:00 | 16:00 |           9 | Tuesday|7:00-16:00    | Adobe Montessori   |
|  7:00 | 16:00 |           9 | Thursday|7:00-16:00   | Adobe Montessori   |
|  7:00 | 16:00 |           9 | Wednesday|7:00-16:00  | Adobe Montessori   |
|  7:00 | 16:00 |           9 | Monday|7:00-16:00     | Adobe Montessori   |
|  8:00 | 17:00 |           9 | Tuesday|8:00-17:00    | Ahn & Perez, DDS   |
|  7:00 | 17:00 |          10 | Thursday|7:00-17:00   | Ahn & Perez, DDS   |
+-------+-------+-------------+-----------------------+--------------------+

Then I make a classification of rating binning the stars into two groups: 2-3, 4-5
After that, I calculate the average hours worked daily per business and the days
worked per week to visualize differences
*/

SELECT DISTINCT
   CASE
       WHEN B.stars >= 2 AND B.stars < 4 THEN '2-3'
       WHEN B.stars >= 4 AND B.stars <= 5 THEN '4-5'
       WHEN B.stars >= 0 AND B.stars < 2 THEN '0-2'
   Else 'Error'
   END AS Rating
  ,AVG(
   CASE
       WHEN
       ABS(TRIM(SUBSTR(SUBSTR(REPLACE(hours,'|','  '), -11),1,5), '-') -
           TRIM(SUBSTR(hours,-5), '-')) = 0
       THEN 24
   Else
       ABS(TRIM(SUBSTR(SUBSTR(REPLACE(hours,'|','  '), -11),1,5), '-') -
           TRIM(SUBSTR(hours,-5), '-'))
   END
   )
   AS Avg_daily_hours
   ,COUNT(DISTINCT H.hours) AS Days_per_week
    ,B.name
FROM business AS B
INNER JOIN Hours AS H ON B.id = H.business_id
LEFT JOIN Category AS C ON B.id = C.business_id
WHERE B.City = 'Las Vegas'
GROUP BY B.name
ORDER BY Rating;

/* City = 'Las Vegas'
+--------+-----------------+---------------+--------------------------------+
| Rating | Avg_daily_hours | Days_per_week | name                           |
+--------+-----------------+---------------+--------------------------------+
| 2-3    |            24.0 |             7 | Hi Scores - Blue Diamond       |
| 2-3    |            14.0 |             7 | Walgreens                      |
| 2-3    |            11.0 |             7 | Wingstop                       |
| 2-3    |             7.0 |             6 | Wooly Wonders                  |
| 4-5    |   8.16666666667 |             6 | Anthem Pediatrics              |
| 4-5    |            13.0 |             7 | Big Wong Restaurant            |
| 4-5    |            10.0 |             4 | Children's Dental Center       |
| 4-5    |             9.0 |             5 | Desert Medical Equipment       |
| 4-5    |   8.57142857143 |             7 | Jacques Cafe                   |
| 4-5    |             9.0 |             6 | Motors & More                  |
| 4-5    |             8.0 |             7 | Red Rock Canyon Visitor Center |
| 4-5    |             9.0 |             6 | Sweet Ruby Jane Confections    |
| 4-5    |   7.71428571429 |             7 | Vue at Centennial              |
+--------+-----------------+---------------+--------------------------------+

Businesses with 2-3 stars appear to have more hours open than the 
ones with 4-5:
        1. The rating of 2-3 stars have a median of 100 hours worked per week 
        2. While the businesses with 4-5 stars have a median of 56 hours worked per week
However we cannot conclude this for sure because there is a too small business population 
at Las Vegas, and there is much more business with 4-5 stars than the ones with 2-3 stars, 
so we need to look deeper in the restaurants dataset.

*/

SELECT DISTINCT
   CASE
       WHEN B.stars >= 2 AND B.stars < 4 THEN '2-3'
       WHEN B.stars >= 4 AND B.stars <= 5 THEN '4-5'
       WHEN B.stars >= 0 AND B.stars < 2 THEN '0-2'
   Else 'Error'
   END AS Rating
  ,AVG(
   CASE
       WHEN
       ABS(TRIM(SUBSTR(SUBSTR(REPLACE(hours,'|','  '), -11),1,5), '-') -
           TRIM(SUBSTR(hours,-5), '-')) = 0
       THEN 24
   Else
       ABS(TRIM(SUBSTR(SUBSTR(REPLACE(hours,'|','  '), -11),1,5), '-') -
           TRIM(SUBSTR(hours,-5), '-'))
   END
   )
   AS Avg_daily_hours
   ,COUNT(DISTINCT H.hours) AS Days_per_week
    ,B.name
FROM business AS B
INNER JOIN Hours AS H ON B.id = H.business_id
LEFT JOIN Category AS C ON B.id = C.business_id
WHERE C.Category = 'Restaurants'
AND
Rating = '2-3'
GROUP BY B.name
ORDER BY Rating;

/* Category = Restaurants AND Stars = 2-3
+--------+-----------------+---------------+-----------------------------+
| Rating | Avg_daily_hours | Days_per_week | name                        |
+--------+-----------------+---------------+-----------------------------+
| 2-3    |            12.0 |             7 | 99 Cent Sushi               |
| 2-3    |   10.5714285714 |             7 | Big Smoke Burger            |
| 2-3    |   9.14285714286 |             7 | Brubaker's Pub              |
| 2-3    |             4.5 |             6 | Cafe Tandoor                |
| 2-3    |            12.0 |             7 | Five Guys                   |
| 2-3    |            11.0 |             7 | Flaming Kitchen             |
| 2-3    |   9.57142857143 |             7 | Gallagher's                 |
| 2-3    |   9.85714285714 |             7 | Irish Republic              |
| 2-3    |   11.5714285714 |             7 | Mad Mex - South Hills       |
| 2-3    |   14.2857142857 |             7 | McDonald's                  |
| 2-3    |            17.0 |             7 | Oinky's Pork Chop Heaven    |
| 2-3    |            10.0 |             7 | Otto Onkel                  |
| 2-3    |            12.0 |             6 | P & J Hamburgers Inn        |
| 2-3    |   12.5714285714 |             7 | Papa Da Vinci               |
| 2-3    |   9.83333333333 |             6 | Ping's Cafe                 |
| 2-3    |   11.4285714286 |             7 | Pizzaiolo                   |
| 2-3    |   8.28571428571 |             7 | Poutine Lafleur             |
| 2-3    |   11.6666666667 |             6 | Restaurant Rosalie          |
| 2-3    |   11.8333333333 |             6 | Saigon Grille               |
| 2-3    |            15.0 |             7 | Senor Taco                  |
| 2-3    |   15.1666666667 |             6 | Subway                      |
| 2-3    |             9.0 |             7 | The Erin Mills Pump & Patio |
| 2-3    |            10.0 |             7 | Thirsty Goat                |
| 2-3    |             9.0 |             6 | What A Bagel                |
| 2-3    |            11.0 |             7 | Wingstop                    |
+--------+-----------------+---------------+-----------------------------+
*/

SELECT DISTINCT
   CASE
       WHEN B.stars >= 2 AND B.stars < 4 THEN '2-3'
       WHEN B.stars >= 4 AND B.stars <= 5 THEN '4-5'
       WHEN B.stars >= 0 AND B.stars < 2 THEN '0-2'
   Else 'Error'
   END AS Rating
  ,AVG(
   CASE
       WHEN
       ABS(TRIM(SUBSTR(SUBSTR(REPLACE(hours,'|','  '), -11),1,5), '-') -
           TRIM(SUBSTR(hours,-5), '-')) = 0
       THEN 24
   Else
       ABS(TRIM(SUBSTR(SUBSTR(REPLACE(hours,'|','  '), -11),1,5), '-') -
           TRIM(SUBSTR(hours,-5), '-'))
   END
   )
   AS Avg_daily_hours
   ,COUNT(DISTINCT H.hours) AS Days_per_week
    ,B.name
FROM business AS B
INNER JOIN Hours AS H ON B.id = H.business_id
LEFT JOIN Category AS C ON B.id = C.business_id
WHERE C.Category = 'Restaurants'
AND
Rating = '4-5'
GROUP BY B.name
ORDER BY Rating;

/* Category = Restaurants AND Stars = 4-5
+--------+-----------------+---------------+----------------------------------------+
| Rating | Avg_daily_hours | Days_per_week | name                                   |
+--------+-----------------+---------------+----------------------------------------+
| 4-5    |             9.0 |             6 | Big City Grill                         |
| 4-5    |            13.0 |             7 | Big Wong Restaurant                    |
| 4-5    |            11.0 |             7 | Bootleggers Modern American Smokehouse |
| 4-5    |   7.71428571429 |             7 | C's Restaurant Bakery and Coffee Shop  |
| 4-5    |   15.1428571429 |             7 | Cabin Fever                            |
| 4-5    |   6.42857142857 |             7 | Charlie D's Catfish & Chicken          |
| 4-5    |             4.8 |             5 | Edulis                                 |
| 4-5    |   10.2857142857 |             7 | Eklectic Pie - Mesa                    |
| 4-5    |   11.5714285714 |             7 | Green Corner Restaurant                |
| 4-5    |             9.0 |             7 | Hermanos Mexican Grill                 |
| 4-5    |   8.57142857143 |             7 | Jacques Cafe                           |
| 4-5    |   6.66666666667 |             6 | Masamune Japanese Restaurant           |
| 4-5    |            10.0 |             7 | Miros Cantina Mexicana                 |
| 4-5    |   10.4285714286 |             7 | Nabers Music, Bar & Eats               |
| 4-5    |   8.71428571429 |             7 | Rise and Dine Cafe                     |
| 4-5    |   7.33333333333 |             6 | Slyman's Restaurant                    |
| 4-5    |   11.5714285714 |             7 | Sushi Osaka                            |
| 4-5    |   8.42857142857 |             7 | The Cider Mill                         |
+--------+-----------------+---------------+----------------------------------------+

We have a larger population of restaurants, so we can look in this data 
and say that:
        1. The restaurants with 2-3 stars worked on average 23% more hours 
        per week than the restaurants with 4-5 stars. 
        2. Restaurants with 2-3 stars have a median of 72 hours worked per week 
        while the restaurants with 4-5 stars have a median of 62 hours worked 
        per week.
*/





/*ii. Do the two groups you chose to analyze have a different number of reviews?
Yes, in the table below we can appreciate that there is a relationship between more reviews and better stars.

+------------------------+--------+------------+---------+
| Selection_group        | Rating | Businesses | Reviews |
+------------------------+--------+------------+---------+
| Las Vegas              | 2-3    |        664 |   34748 |
| Las Vegas              | 4-5    |        835 |   46013 |
| Restaurant             | 2-3    |         39 |    1095 |
| Restaurant             | 4-5    |         26 |    2339 |
| Restaurant - Las Vegas | 2-3    |          1 |     123 |
| Restaurant - Las Vegas | 4-5    |          3 |     939 |
+------------------------+--------+------------+---------+
*/

SELECT
 CASE
     WHEN id IN (SELECT business_id FROM Category AS C WHERE Category = 'Restaurants') AND City = 'Las Vegas' THEN 'Restaurant - Las Vegas'
     WHEN id IN (SELECT business_id FROM Category AS C WHERE Category = 'Restaurants') THEN 'Restaurant'
     WHEN City = 'Las Vegas' THEN 'Las Vegas'
 Else 'Other'
 END AS Selection_group
 ,
 CASE
     WHEN stars >= 2 AND stars < 4 THEN '2-3'
     WHEN stars >= 4 AND stars <= 5 THEN '4-5'
     WHEN stars >= 0 AND stars < 2 THEN '0-2'
 Else 'Error'
 END AS Rating
 ,COUNT(id) AS Businesses
 ,SUM(review_count) AS Reviews
FROM business
WHERE
Selection_group != 'Other'
AND
Rating != '0-2'
GROUP BY Selection_group, Rating;


         
         
/* iii. Are you able to infer anything from the location data provided between these two groups? Explain.
        The tourism industry influences the market to open more business causing more reviews 
        so businesses in these cities are more likely to have reviews with 4-5 stars.
*/
SELECT
 CASE
     WHEN stars >= 2 AND stars < 4 THEN '2-3'
     WHEN stars >= 4 AND stars <= 5 THEN '4-5'
     WHEN stars >= 0 AND stars < 2 THEN '0-2'
 Else 'Error'
 END AS Rating
 ,SUM(review_count) AS Reviews
 ,COUNT(id) AS Businesses
 ,City
FROM business
WHERE
Rating != '0-2'
GROUP BY City, Rating
ORDER BY Reviews DESC
LIMIT 25;

/*
+--------+---------+------------+------------+
| Rating | Reviews | Businesses | city       |
+--------+---------+------------+------------+
| 4-5    |   46952 |        838 | Las Vegas  |
| 2-3    |   34871 |        665 | Las Vegas  |
| 4-5    |   19848 |        503 | Phoenix    |
| 2-3    |   14061 |        448 | Phoenix    |
| 2-3    |   13992 |        512 | Toronto    |
| 4-5    |   12688 |        325 | Scottsdale |
| 4-5    |    9951 |        439 | Toronto    |
| 2-3    |    7780 |        157 | Scottsdale |
| 4-5    |    7277 |        170 | Montréal   |
| 4-5    |    7023 |        221 | Charlotte  |
| 4-5    |    5769 |        139 | Henderson  |
| 4-5    |    5583 |        139 | Tempe      |
| 2-3    |    5302 |        230 | Charlotte  |
| 4-5    |    5121 |        186 | Pittsburgh |
| 2-3    |    5044 |        129 | Henderson  |
| 2-3    |    4845 |        113 | Tempe      |
| 2-3    |    4652 |        161 | Pittsburgh |
| 4-5    |    4600 |        112 | Gilbert    |
| 4-5    |    4546 |        122 | Chandler   |
| 4-5    |    4022 |        103 | Cleveland  |
| 4-5    |    3775 |        159 | Mesa       |
| 2-3    |    3508 |        101 | Chandler   |
| 2-3    |    2934 |        125 | Mesa       |
| 4-5    |    2922 |         88 | Madison    |
| 4-5    |    2480 |         93 | Glendale   |
+--------+---------+------------+------------+
*/

--  2.	Group business based on the ones that are open and the ones that are closed. What differences can you find between the ones that are still open and the ones that are closed? 
--  List at least two differences and the SQL code you used to arrive at your answer.
		
	-- i. 	Difference 1: The business that are still open have higher rating.
    -- ii.	Difference 2: The business that are still open have more reviews.

	-- SQL code used for analysis:

SELECT  (name), 
        (stars),
        (category),
        (review_count),
        (hours),
        (neighborhood)
        FROM 
        business b INNER JOIN category c ON b.id = c.business_id
        INNER JOIN hours h ON h.business_id = c.business_id
        WHERE (is_open = 1)
        GROUP BY 1
        ORDER BY 4 DESC;




-- 3. For this last part of your analysis, you are going to choose the type of analysis you want to conduct on the Yelp dataset and are going to prepare the data for analysis.
-- Ideas for analysis include: Parsing out keywords and business attributes for sentiment analysis, clustering businesses to find commonalities or anomalies between them, predicting the overall star rating for a business, predicting the number of fans a user will have, and so on. These are just a few examples to get you started, so feel free to be creative and come up with your own problem you want to solve. Provide answers, in-line, to all of the following:
	
-- i. Indicate the type of analysis you chose to do: (Which business do people review?)
         
         
-- ii. Write 1-2 brief paragraphs on the type of data you will need for your analysis and why you chose that data:
/*
I want to know, What people like to review more? and In which city?
*/
                           
                  
iii. Output of your finished dataset:

/*
+------------------------+----------------------+
| category               | REVIEW NUMBER        |
+------------------------+----------------------+
| Restaurants            |                    9 |
| Food                   |                    6 |
| American (Traditional) |                    4 |
| Nightlife              |                    4 |
| Barbeque               |                    3 |
| Bars                   |                    3 |
| Smokehouse             |                    3 |
| Asian Fusion           |                    2 |
| Breakfast & Brunch     |                    2 |
| Chinese                |                    2 |
| Ethnic Food            |                    2 |
| Farmers Market         |                    2 |
| Fruits & Veggies       |                    2 |
| Malaysian              |                    2 |
| Market Stalls          |                    2 |
| Meat Shops             |                    2 |
| Noodles                |                    2 |
| Public Markets         |                    2 |
| Seafood Markets        |                    2 |
| Shopping               |                    2 |
| Soup                   |                    2 |
| Specialty Food         |                    2 |
| Taiwanese              |                    2 |
| Active Life            |                    1 |
| Arts & Entertainment   |                    1 |
+------------------------+----------------------+
*/

/*
+-----------------+---------------+
| city            | NUMBER_REVIEW |
+-----------------+---------------+
| Las Vegas       |           193 |
| Phoenix         |            65 |
| Toronto         |            51 |
| Scottsdale      |            37 |
| Henderson       |            30 |
| Tempe           |            28 |
| Pittsburgh      |            23 |
| Chandler        |            22 |
| Charlotte       |            21 |
| Montréal        |            18 |
| Madison         |            16 |
| Gilbert         |            13 |
| Mesa            |            13 |
| Cleveland       |            12 |
| North Las Vegas |             6 |
| Edinburgh       |             5 |
| Glendale        |             5 |
| Lakewood        |             5 |
| Cave Creek      |             4 |
| Champaign       |             4 |
| Markham         |             4 |
| North York      |             4 |
| Mississauga     |             3 |
| Surprise        |             3 |
| Avondale        |             2 |
+-----------------+---------------+
(Output limit exceeded, 25 of 67 total rows shown)
*/
         
         
iv. Provide the SQL code you used to create your final dataset:


SELECT  category, COUNT(r.business_id) AS REVIEW_NUMBER
        FROM review r INNER JOIN business b ON r.business_id = b.id
        INNER JOIN category c ON r.business_id = c.business_id
        GROUP BY 1
        ORDER BY 2 DESC;

SELECT  city, COUNT(r.id) AS NUMBER_REVIEW
        FROM review r INNER JOIN business b ON r.business_id = b.id
        GROUP BY 1
        ORDER BY 2 DESC;
