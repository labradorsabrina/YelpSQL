/*
                Study: Spot a good business opportunity studying the attributes 
                and ratings of the actual businesses. 

                The idea is that when there is a good average of reviews the probability 
                of have a good amount of clients increase and a good rating for a business 
                could mean that is a service needed.
         
      I’m gonna need a dataset with the business attributes, average of stars ratings and 
      count of businesses for each attribute.

+----------------------------+-----------+---------------+----------------+
| name                       | Stars_bin |   Reviews_AVG | Business_count |
+----------------------------+-----------+---------------+----------------+
| BusinessAcceptsCreditCards | 2-3       | 34.2580645161 |             62 |
| RestaurantsPriceRange2     | 2-3       | 43.5909090909 |             44 |
| BusinessParking            | 2-3       | 46.3414634146 |             41 |
| BikeParking                | 2-3       | 50.2777777778 |             36 |
| RestaurantsTakeOut         | 2-3       |  57.275862069 |             29 |
| GoodForKids                | 2-3       |         55.75 |             28 |
| RestaurantsGoodForGroups   | 2-3       | 54.8571428571 |             28 |
| OutdoorSeating             | 2-3       | 66.8076923077 |             26 |
| RestaurantsReservations    | 2-3       | 58.8076923077 |             26 |
| RestaurantsDelivery        | 2-3       |         61.92 |             25 |
| NoiseLevel                 | 2-3       |        63.125 |             24 |
| Ambience                   | 2-3       |  65.652173913 |             23 |
| HasTV                      | 2-3       | 65.8260869565 |             23 |
| RestaurantsAttire          | 2-3       | 60.2173913043 |             23 |
| Alcohol                    | 2-3       | 68.3181818182 |             22 |
| GoodForMeal                | 2-3       | 62.7727272727 |             22 |
| RestaurantsTableService    | 2-3       | 62.8181818182 |             22 |
| WiFi                       | 2-3       | 76.0909090909 |             22 |
| ByAppointmentOnly          | 4-5       |          10.0 |             21 |
| WheelchairAccessible       | 2-3       |         59.85 |             20 |
| Caters                     | 2-3       | 77.7368421053 |             19 |
| AcceptsInsurance           | 4-5       |          12.0 |              8 |
| DriveThru                  | 2-3       | 41.2857142857 |              7 |
| DogsAllowed                | 2-3       |          86.5 |              6 |
| BusinessAcceptsBitcoin     | 4-5       |           6.4 |              5 |
+----------------------------+-----------+---------------+----------------+

There is a clearly a good opportunity of business on WIFI businesses because 
there is quite quantity of business registers, they have a good average of 
reviews and they are rated between 4-5 stars

*/

SELECT
  A.name
  ,
  CASE
    WHEN AVG(B.stars) >= 0 AND AVG(B.stars) < 2 THEN '1-2'
    WHEN AVG(B.stars) >= 2 AND AVG(B.stars) < 4 THEN '2-3'
    WHEN AVG(B.stars) >= 4 AND AVG(B.stars) <= 5 THEN '4-5'
   Else 'Error'
   END AS Stars_bin
   , AVG(review_count) AS Reviews_AVG
   , COUNT(DISTINCT B.id) AS Business_count
FROM business AS B
INNER JOIN Attribute AS A ON A.business_id = B.id
WHERE B.is_open = 1
GROUP BY A.name
ORDER BY Business_count DESC

