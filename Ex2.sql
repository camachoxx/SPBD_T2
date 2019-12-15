--get necessary info from the dataset
Drop view if exists time_preprocessed_view;
CREATE VIEW IF NOT EXISTS time_preprocessed_view as
select haversine_distance, pickup_datetime, dropoff_datetime,
from_unixtime(unix_timestamp(date_format(pickup_datetime, 'y-M-d H:m:00')) - minute(pickup_datetime)*60 + (INT(minute(pickup_datetime) / 15)* 15*60 ),'H:m:00') as time_15_minutes_bin,
pickup_area,
week_day_,
(unix_timestamp(dropoff_datetime) - unix_timestamp(pickup_datetime))/60 as duration_minutes
from taxis_preprocessed;

Drop Table if exists T2_answer;
CREATE Table T2_answer as
select week_day_, time_15_minutes_bin, pickup_area,
INT(AVG(duration_minutes)) as avg_duration_minutes,
INT(AVG(haversine_distance)) as avg_distance
from time_preprocessed_view
group by pickup_area, week_day_, time_15_minutes_bin
order by pickup_area, week_day_, time_15_minutes_bin desc;
