CREATE VIEW IF NOT EXISTS T3 as
SELECT precipitation + snow_fall as p,
CONCAT(ROUND(pickup_latitude,2),", ",ROUND(pickup_longitude,2)) as pickup_area
FROM taxis;

CREATE VIEW IF NOT EXISTS RAIN AS
Select pickup_area,COUNT(p) as c
FROM T3
WHERE p > 0.05
GROUP BY pickup_area;

CREATE VIEW IF NOT EXISTS NOTRAIN AS
Select pickup_area,COUNT(p) as c2
FROM T3
WHERE p <= 0.05
GROUP BY pickup_area;

SELECT RAIN.pickup_area,RAIN.c/NOTRAIN.c2 AS FACTOR
FROM RAIN JOIN NOTRAIN ON RAIN.pickup_area = NOTRAIN.pickup_area
GROUP BY RAIN.pickup_area,RAIN.c,NOTRAIN.c2;

DROP VIEW IF EXISTS T3;
DROP VIEW IF EXISTS RAIN;
DROP VIEW IF EXISTS NOTRAIN;
