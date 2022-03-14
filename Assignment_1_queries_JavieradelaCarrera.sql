/*Assignment 1 Part 4 - Javiera de la Carrera*/

/*All the answers are in the Notebook with a few explanation. The relevant results are*
 * highlited in the Report*/
/*The order by function was changed different times to have a better understanding of the data*/

/*Question a*/

/*i. For each year and month:What was the total number of trips?*/

SELECT 
 year, month
 , COUNT(1) n_trips
FROM df_par
GROUP BY year, month
ORDER BY n_trips

/*ii. For each year and month:Which hour of the day had the most trips??*/
WITH x AS
(
    SELECT year, month, hour, COUNT(*) AS trips
    FROM df_par
    GROUP BY year,month, hour
)
SELECT x.year, x.month, x.hour, x.trips
FROM x
INNER JOIN
(
    SELECT year,month, MAX( trips ) AS maxCountX
    FROM x
    GROUP BY year,month
) x2
ON x2.maxCountX = x.trips
Order by trips

/*iii. For each year and month:Which weekday had the most trips??*/
/*The order by was changed to have a better understanding per year*/

WITH x AS
(
    SELECT year, month, dow_long, COUNT(*) AS trips
    FROM df_par
    GROUP BY year,month, dow_long
)
SELECT x.year,x.month, x.dow_long, x.trips
FROM x
INNER JOIN
(
    SELECT year,month, MAX( trips ) AS maxCountX
    FROM x
    GROUP BY year,month
) x2
ON x2.maxCountX = x.trips
Order by year, dow_long

/*iv. For each year and month:What was the average number of passengers??*/
SELECT 
 year, month
 , AVG(passenger_count) avg_pass
FROM df_par
GROUP BY year, month
Order by year,month

/*v. For each year and month:What was the average amount paid per trip (total_amount)?*/
SELECT 
 year, month
 , AVG(total_amount) avg_tot_amount
FROM df_par
GROUP BY year, month
ORDER BY year,month


/*vi. For each year and month:What was the average amount paid per passenger (total_amount)??*/
SELECT 
 year,month
 , AVG(total_amount/passenger_count) avg_ppp
FROM df_par
GROUP BY year, month
ORDER BY year, month

/*Question b*/

/*i. For each taxi colour (yellow and green):What was the average, median, minimum and maximum trip duration in seconds?*/
SELECT 
 taxi_type
 , AVG(duration*60)  avg_dur 
 , MIN(duration*60)  min_dur
 , MAX(duration*60)  max_dur
 , approx_percentile(duration*60, 0.5, 100) median_dur
FROM df_par
GROUP BY taxi_type

/*ii. For each year and month:What was the average, median, minimum and maximum trip distance in km?*/
SELECT 
 taxi_type
 , AVG(trip_distance*1.6)  avg_td 
 , MIN(trip_distance*1.6)  min_td
 , MAX(trip_distance*1.6)  max_td
 ,approx_percentile(trip_distance*1.6, 0.5, 100) median_td
FROM df_par
GROUP BY taxi_type

/*iii. For each year and month:What was the average, median, minimum and maximum speed in km per hour?*/
SELECT 
 taxi_type
 , AVG((trip_distance*1.6)/(duration/60))  avg_speed_km 
 , MIN((trip_distance*1.6)/(duration/60))  min_speed_km
 , MAX((trip_distance*1.6)/(duration/60))  max_speed_km
 , approx_percentile((trip_distance*1.6)/(duration/60), 0.5, 100) median_speed_km
FROM df_par
GROUP BY taxi_type

/*Question c*/

/*What was the percentage of trips where the driver received tips*/

/*assumption*
 *only for payment_type = credit card because for cash type NYC dataset does not have the information*
 *also, for other payment type it was assumed that there was not a tip because they are related with no payment*/
select 
(select count(*) from df_par where payment_type =1 AND tip_amount>0)/ count(*) as perc_with_tips
from df_par 
where payment_type =1

/*Question d*/
/*For trips where the driver received tips, What was the percentage where the driver received tips of at least $10.*/
select 
(select count(*) from df_par where payment_type =1 AND tip_amount >= 10)/ count(*) as perc_with_tips
from df_par 
where payment_type =1 and tip_amount > 0

/*Question e*/
/*classify each trip into bins of durations:  Then for each bins, calculate: 
Average speed (km per hour)
Average distance per dollar (km per $)
*/
SELECT 
  CASE  WHEN duration < 5 THEN "<5"
      WHEN duration >=5 AND duration <10 THEN "5-10"
      WHEN duration >=10 AND duration <20 THEN "10-20"
      WHEN duration >=20 AND duration <30 THEN "20-30"
      WHEN duration >=30 THEN ">30" 
      END as duration_bins,
  AVG((trip_distance*1.6)/(duration/60)) as ave_speed,
  AVG((trip_distance*1.6)/(total_amount)) as ave_dist_dollar
FROM df_par
GROUP BY 
  CASE  WHEN duration < 5 THEN "<5"
      WHEN duration >=5 AND duration <10 THEN "5-10"
      WHEN duration >=10 AND duration <20 THEN "10-20"
      WHEN duration >=20 AND duration <30 THEN "20-30"
      WHEN duration >=30 THEN ">30" 
      END

/*Question f*/
/*It was answered in the Notebook and in the Report*/





























