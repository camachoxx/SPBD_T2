Drop view if exists T2_temp1;
CREATE VIEW IF NOT EXISTS T2_temp1 as
select haversine_distance, pickup_datetime, dropoff_datetime,
from_unixtime(unix_timestamp(date_format(pickup_datetime, 'y-M-d H:m:00')) - minute(pickup_datetime)*60 + (INT(minute(pickup_datetime) / 15)* 15*60 ),'H:m:00') as time_,
pickup_area,
from_unixtime(unix_timestamp(pickup_datetime), 'EEE') as week_day_name_
from taxis_preprocessed;

select week_day_name_,time_,pickup_area,
AVG(unix_timestamp(pickup_datetime)-unix_timestamp(dropoff_datetime)) as avg_duration,
AVG(haversine_distance) as avg_distance
from T2_temp1
group by pickup_area,week_day_name_,time_
limit 10;


--select avg(haversine_distance) from T2
--GROUP BY time_, week_day_name_, region_;
