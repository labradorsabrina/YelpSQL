/*
            Study: Finding the correlation between the likes with 
            the rates given to the businesses, using the attribute 
            `Like` in the table `Tip`.
        
            I'm going to need two sources of data (tables):
                First, I join these two tables based on users and business. 
                Then I sort them based on rating to see if there is a correlation 
                between the number of stars and likes.


            The reason I chose this analysis and thus, the data sets is that 
            psychologists have shown that how people think about something can 
            completely change even after a few minutes and they think that how 
            people think just after occurrence of an event is a better 
            representative for the quality of that event compared to what they 
            say after thinking about it. 
            
            Because the tip table is related to the occurrence of the event 
            (shopping) and they write a review after hours or even days, 
            comparing these two tables can help us to explore the validity 
            what psychologists claim. As the result shows there is a slight 
            correlation between the number of likes and stars, but this correlation 
            is not strong. So what psychologists claim seems to be fairly valid. 

+-------+-------+
| stars | likes |
+-------+-------+
|     3 |     2 |
|     5 |     2 |
|     5 |     1 |
|     5 |     1 |
|     5 |     1 |
|     5 |     1 |
|     5 |     1 |
|     5 |     1 |
|     5 |     1 |
|     5 |     1 |
|     3 |     1 |
|     4 |     1 |
|     4 |     1 |
|     4 |     1 |
|     4 |     1 |
|     4 |     1 |
|     4 |     1 |
|     4 |     1 |
|     4 |     1 |
|     4 |     1 |
|     4 |     1 |
|     4 |     1 |
|     4 |     1 |
|     4 |     1 |
|     4 |     1 |
+-------+-------+
(Output limit exceeded, 25 of 1227 total rows shown)
*/

SELECT R.stars
        ,T.likes
FROM review AS R
INNER JOIN tip AS T ON R.user_id = T.user_id
ORDER BY T.likes DESC;