Drop view if exists time_preprocessed;
CREATE VIEW IF NOT EXISTS time_preprocessed as
select haversine_distance, pickup_datetime, dropoff_datetime,
from_unixtime(unix_timestamp(date_format(pickup_datetime, 'y-M-d H:m:00')) - minute(pickup_datetime)*60 + (INT(minute(pickup_datetime) / 15)* 15*60 ),'H:m:00') as time_,
pickup_area,
from_unixtime(unix_timestamp(pickup_datetime), 'EEE') as week_day_name_,
(unix_timestamp(dropoff_datetime) - unix_timestamp(pickup_datetime))/60 as duration_minutes
from taxis_preprocessed;

Drop Table if exists T2_answer;
CREATE Table T2_answer as
select week_day_name_,time_,pickup_area,
INT(AVG(duration_minutes)) as avg_duration_minutes,
INT(AVG(haversine_distance)) as avg_distance
from time_preprocessed
group by pickup_area,week_day_name_,time_
order by pickup_area,week_day_name_,time_ desc;


--select avg(haversine_distance) from T2
--GROUP BY time_, week_day_name_, region_;
