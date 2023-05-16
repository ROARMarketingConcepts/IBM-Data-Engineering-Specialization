--Create a cube query using the columns year, city, stationid, and average waste collected.

WITH combined_data As
(SELECT b."year",c.city,a.stationid, a."wastecollected"
FROM public."MyFactTrips" a
LEFT OUTER JOIN public."MyDimDate" b
ON a.dateid = b.dateid
LEFT OUTER JOIN public."MyDimStation" c
ON a.stationid = c.stationid)

SELECT combined_data."year",combined_data.city,combined_data.stationid,ROUND(AVG(combined_data."wastecollected"),2) AS avg_waste
FROM combined_data
GROUP BY CUBE(combined_data."year",combined_data.city,combined_data.stationid)
ORDER BY combined_data."year",combined_data.city