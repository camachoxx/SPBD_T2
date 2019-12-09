DROP VIEW IF EXISTS taxis_preprocessed;

CREATE VIEW IF NOT EXISTS T4 as
SELECT (dropoff_datetime - pickup_datetime) as travel_time,
CONCAT(CONCAT(ROUND(pickup_latitude,1),", ",ROUND(pickup_longitude,1)),", ",
CONCAT(ROUND(dropoff_latitude,1),", ",ROUND(dropoff_longitude,1))) as r,
vendor_id
FROM taxis;

SELECT *
FROM T4
DISTRIBUTE BY r;

DROP VIEW IF EXISTS T4;
DROP VIEW IF EXISTS V0;
DROP VIEW IF EXISTS V1;