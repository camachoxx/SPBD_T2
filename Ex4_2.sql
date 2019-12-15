DROP VIEW IF EXISTS taxis_preprocessed;

CREATE VIEW IF NOT EXISTS T4 as
SELECT unix_timestamp(dropoff_datetime) - unix_timestamp(pickup_datetime) as travel_time,
CONCAT(CONCAT(ROUND(pickup_latitude,1),", ",ROUND(pickup_longitude,1)),", ",
CONCAT(ROUND(dropoff_latitude,1),", ",ROUND(dropoff_longitude,1))) as r,
vendor_id
FROM taxis
LIMIT 100;

CREATE VIEW IF NOT EXISTS V0 as
SELECT *
FROM T4
WHERE vendor_id = 0;

CREATE VIEW IF NOT EXISTS V1 as
SELECT *
FROM T4
WHERE vendor_id = 1;

-- Calculate the averange diference  in travel time between the two taxi companies

SELECT V1.r,from_unixtime(cast(AVG(V1.travel_time-V0.travel_time) as bigint), "HH:mm:ss") as dif
FROM V1 JOIN V0 ON V1.r = V0.r 
GROUP BY V1.r;

DROP VIEW IF EXISTS T4;
DROP VIEW IF EXISTS V0;
DROP VIEW IF EXISTS V1;