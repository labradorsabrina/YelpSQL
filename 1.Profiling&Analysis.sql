/*            
              Yelp Dataset Profiling and Understanding

1. Total number of records for each of the tables:
*/

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