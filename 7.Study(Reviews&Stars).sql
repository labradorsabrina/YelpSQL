/*
        Study: Analyze whether there is a correlation between a user number of reviews 
        and average stars.
  
        For this analysis, I needed data on review counts and average stars per user. I also needed to 
        create bins to group users by their review counts.                        

+-------------------------+------------------------------+
| reviewcountbins         | ROUND(avg(average_stars), 2) |
+-------------------------+------------------------------+
| 8:500 or more reviews   |                         3.74 |
| 7:400 to 499 reviews    |                         3.68 |
| 6:300 to 399 reviews    |                         3.72 |
| 5:200 to 299 reviews    |                         3.77 |
| 4:100 to 199 reviews    |                         3.77 |
| 3:50 to 99 reviews      |                         3.75 |
| 2:25 to 49 reviews      |                         3.78 |
| 1:Fewer than 25 reviews |                         3.68 |
| 0:No reviews            |                         3.89 |
+-------------------------+------------------------------+       

        I found no correlation between the users number of reviews and average stars.
*/
SELECT CASE
    WHEN review_count = 0 THEN '0:No reviews'
    WHEN review_count < 25 THEN '1:Fewer than 25 reviews'
    WHEN review_count >= 25 AND review_count < 50 THEN '2:25 to 49 reviews'
    WHEN review_count >= 50 AND review_count < 100 THEN '3:50 to 99 reviews'
    WHEN review_count >= 100 AND review_count < 200 THEN '4:100 to 199 reviews'
    WHEN review_count >= 200 AND review_count < 300 THEN '5:200 to 299 reviews'
    WHEN review_count >= 300 AND review_count < 400 THEN '6:300 to 399 reviews'
    WHEN review_count >= 400 AND review_count < 500 THEN '7:400 to 499 reviews'
    WHEN review_count >= 500 THEN '8:500 or more reviews'
    ELSE 'other'
END AS reviewcountbins
,ROUND(avg(average_stars), 2)
FROM user
GROUP BY reviewcountbins
ORDER BY reviewcountbins DESC
;