/*
                Study: Business more likely to have more reviews
                I want to know, What kind of business people like to review more? 
                and In which city?
*/

SELECT  C.Category
        ,COUNT(DISTINCT R.business_id) AS Business_reviewed
FROM review AS R
INNER JOIN business AS B ON R.business_id = B.id
INNER JOIN category AS C ON R.business_id = C.business_id
GROUP BY C.Category
ORDER BY Business_reviewed DESC;

/*
+------------------------+-------------------+
| category               | Business_reviewed |
+------------------------+-------------------+
| Restaurants            |                 5 |
| Food                   |                 3 |
| American (Traditional) |                 2 |
| Nightlife              |                 2 |
| Active Life            |                 1 |
| Arts & Entertainment   |                 1 |
| Asian Fusion           |                 1 |
| Barbeque               |                 1 |
| Bars                   |                 1 |
| Beaches                |                 1 |
| Breakfast & Brunch     |                 1 |
| Chinese                |                 1 |
| Desserts               |                 1 |
| Ethnic Food            |                 1 |
| Farmers Market         |                 1 |
| Fruits & Veggies       |                 1 |
| Indian                 |                 1 |
| Malaysian              |                 1 |
| Market Stalls          |                 1 |
| Meat Shops             |                 1 |
| Music Venues           |                 1 |
| Noodles                |                 1 |
| Pakistani              |                 1 |
| Parks                  |                 1 |
| Public Markets         |                 1 |
+------------------------+-------------------+
(Output limit exceeded, 25 of 32 total rows shown)
*/

SELECT  B.City
        ,C.Category
        ,SUM(B.review_count) AS Reviews
FROM review AS R
INNER JOIN business AS B ON R.business_id = B.id
INNER JOIN category AS C ON R.business_id = C.business_id
GROUP BY C.Category, B.City
ORDER BY Reviews DESC;

/*
+-----------+------------------------+---------+
| city      | category               | Reviews |
+-----------+------------------------+---------+
| Phoenix   | Restaurants            |    1669 |
| Las Vegas | Asian Fusion           |    1536 |
| Las Vegas | Chinese                |    1536 |
| Las Vegas | Malaysian              |    1536 |
| Las Vegas | Noodles                |    1536 |
| Las Vegas | Restaurants            |    1536 |
| Las Vegas | Soup                   |    1536 |
| Las Vegas | Taiwanese              |    1536 |
| Cleveland | Ethnic Food            |    1446 |
| Cleveland | Farmers Market         |    1446 |
| Cleveland | Food                   |    1446 |
| Cleveland | Fruits & Veggies       |    1446 |
| Cleveland | Market Stalls          |    1446 |
| Cleveland | Meat Shops             |    1446 |
| Cleveland | Public Markets         |    1446 |
| Cleveland | Seafood Markets        |    1446 |
| Cleveland | Shopping               |    1446 |
| Cleveland | Specialty Food         |    1446 |
| Phoenix   | American (Traditional) |    1293 |
| Phoenix   | Barbeque               |    1293 |
| Phoenix   | Bars                   |    1293 |
| Phoenix   | Food                   |    1293 |
| Phoenix   | Nightlife              |    1293 |
| Phoenix   | Smokehouse             |    1293 |
| Phoenix   | Breakfast & Brunch     |     376 |
+-----------+------------------------+---------+
(Output limit exceeded, 25 of 39 total rows shown)

The data indicates that the business more likely to
have more reviews are Restaurants and the best cities to have
restaurants are Phoenix and Las Vegas
*/