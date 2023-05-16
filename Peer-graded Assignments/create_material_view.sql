--Create an MQT named max_waste_stats using the columns city, stationid, trucktype, and max waste collected.

CREATE MATERIALIZED VIEW max_waste_stats (city, stationid, trucktype, max_waste) AS

(WITH combined_data As
	(SELECT c.city,a.stationid, b.trucktype, a."wastecollected"
	FROM public."MyFactTrips" a
	LEFT OUTER JOIN public."MyDimTruck" b
	ON a.truckid = b.truckid
	LEFT OUTER JOIN public."MyDimStation" c
	ON a.stationid = c.stationid)

SELECT combined_data.city,combined_data.stationid,combined_data.trucktype, MAX(combined_data."wastecollected") AS max_waste
FROM combined_data
GROUP BY combined_data.city,combined_data.stationid,combined_data.trucktype
ORDER BY combined_data.city,combined_data.stationid)