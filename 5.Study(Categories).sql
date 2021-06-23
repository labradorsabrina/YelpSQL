/*          Study: Which category is more popular and successful for a business?

            I will basically group categories and calculate the average star rating and review counts 
            of each of them, and rank them in a descending order. For further analysis, we may also 
            include the number of sample size into account. For example, some categories may have 
            very high average of star ratings, but actually there are only 4 samples in this category, 
            leading to an unfair comparison.                         
                  
+---------------------------+----------------+---------------+--------------------+
| category                  | average_review |  average_star | number_of_business |
+---------------------------+----------------+---------------+--------------------+
| Restaurants               |  63.4366197183 | 3.45774647887 |                 71 |
| Shopping                  |  32.5666666667 | 3.98333333333 |                 30 |
| Food                      |  77.4347826087 | 3.78260869565 |                 23 |
| Nightlife                 |          67.55 |         3.475 |                 20 |
| Bars                      |  77.7647058824 |           3.5 |                 17 |
| Health & Medical          |  11.9411764706 | 4.08823529412 |                 17 |
| Home Services             |          5.875 |           4.0 |                 16 |
| Beauty & Spas             |  9.15384615385 | 3.88461538462 |                 13 |
| Local Services            |  8.33333333333 | 4.20833333333 |                 12 |
| American (Traditional)    |  102.545454545 | 3.81818181818 |                 11 |
| Active Life               |           13.1 |          4.15 |                 10 |
| Automotive                |           22.0 |           4.5 |                  9 |
| Hotels & Travel           |  42.3333333333 | 3.22222222222 |                  9 |
| Burgers                   |         37.125 |         3.125 |                  8 |
| Sandwiches                |         121.75 |        3.9375 |                  8 |
| Arts & Entertainment      |  55.4285714286 |           4.0 |                  7 |
| Fast Food                 |  26.4285714286 | 3.21428571429 |                  7 |
| Mexican                   |  46.7142857143 |           3.5 |                  7 |
| American (New)            |  80.1666666667 | 3.33333333333 |                  6 |
| Event Planning & Services |  19.6666666667 |          3.75 |                  6 |
| Hair Salons               |  10.8333333333 | 4.08333333333 |                  6 |
| Bakeries                  |           47.8 |           4.1 |                  5 |
| Doctors                   |           11.0 |           4.2 |                  5 |
| Indian                    |           12.6 |           3.6 |                  5 |
| Japanese                  |           30.4 |           3.8 |                  5 |
+---------------------------+----------------+---------------+--------------------+        
*/
SELECT c.category,
    AVG(b.review_count) AS average_review,
    AVG(b.stars) AS average_star,
    COUNT(c.business_id) AS number_of_business
FROM business b
INNER JOIN category c ON b.id = c.business_id
GROUP BY c.category
ORDER BY number_of_business DESC;