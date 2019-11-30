
CREATE VIEW IF NOT EXISTS T2 as
SELECT from_unixtime(unix_timestamp(pickup_datetime), 'EEEE') as w,
pickoff_datetime,dropoff_datetime,haversine_distance,
CONCAT(ROUND(pickup_latitude,2),", ",ROUND(pickup_longitude,2)) as pickup_area
FROM taxis;



