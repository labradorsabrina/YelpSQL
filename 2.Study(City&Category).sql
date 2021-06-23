--  Study to make Inferences and Analysis of Yelp Dataset

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

/* 2.	Business group based on the ones that are open and the ones that are closed. 
What differences are between the ones that are still open and the ones that are closed? 
		
	-- i. 	Difference 1: The business that are still open have more reviews.

+---------+---------+
| is_open | Reviews |
+---------+---------+
|       0 |   35261 |
|       1 |  269300 |
+---------+---------+

+---------+---------------+--------------+-------------+
| is_open | SUM(R.Useful) | SUM(R.Funny) | SUM(R.Cool) |
+---------+---------------+--------------+-------------+
|    None |          9525 |         3872 |        4908 |
|       0 |            69 |           15 |          30 |
|       1 |           484 |          152 |         219 |
+---------+---------------+--------------+-------------+
*/

SELECT is_open, SUM(review_count) AS Reviews
FROM business
GROUP BY is_open;
 
SELECT B.is_open, SUM(R.Useful), SUM(R.Funny), SUM(R.Cool)
FROM review AS R
LEFT JOIN business AS B ON R.business_id = B.id
LEFT JOIN user AS U ON R.user_id = U.id
GROUP BY B.is_open;

/*
        -- ii.	Difference 2: The open businesses have more tips than the ones that are closed

+---------+-------+------------+
| is_open | Likes | Tips_count |
+---------+-------+------------+
|       0 |     1 |         97 |
|       1 |     9 |        580 |
+---------+-------+------------+
*/

SELECT B.is_open, SUM(likes) AS Likes, COUNT(*) AS Tips_count
FROM tip AS T
LEFT JOIN business AS B ON T.business_id = B.id
WHERE B.is_open IS NOT NULL
GROUP BY B.is_open;

/*       
iii. Difference 3:
         The ones that are open tend to have more stars than those not. 
*/

SQL code used for analysis:
SELECT is_open,
    AVG(review_count),
    AVG(stars)
FROM business
GROUP BY is_open;