CREATE VIEW IF NOT EXISTS T1 as
SELECT from_unixtime(unix_timestamp(pickup_datetime), 'EEEE') as w,
from_unixtime(unix_timestamp(pickup_datetime),'hh') as h,
CONCAT(CONCAT(ROUND(pickup_latitude,2),", ",ROUND(pickup_longitude,2)),", ",
CONCAT(ROUND(dropoff_latitude,2),", ",ROUND(dropoff_longitude,2))) as r
FROM taxis;

Select  w,h,r,count(r) as c
FROM T1
GROUP BY w,h,r
ORDER BY c;