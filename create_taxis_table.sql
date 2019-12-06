CREATE EXTERNAL TABLE IF NOT EXISTS taxis
(
row_idx int,
id string,
vendor_id int,
pickup_datetime TIMESTAMP,
dropoff_datetime TIMESTAMP,
passager_count int,
pickup_longitude float,
pickup_latitude float,
dropoff_longitude float,
dropoff_latitude float,
haversine_distance float,
maximum_temperature int,
minimum_temperature int,
average_temperature float,
precipitation float,
snow_fall float,
snow_depth float
)


row format delimited fields terminated by ',';

load data local inpath '/root/work/taxis.csv' overwrite into table taxis;

DROP TABLE taxis_preprocessed;
CREATE TABLE taxis_preprocessed as
select row_idx,id vendor_id, pickup_datetime, dropoff_datetime, passager_count,
pickup_longitude, pickup_latitude,
CONCAT(ROUND(pickup_latitude,2),", ",ROUND(pickup_longitude,2)) as pickup_area,
CONCAT(ROUND(dropoff_latitude,2),", ",ROUND(dropoff_longitude,2)) as dropoff_area,
from_unixtime(unix_timestamp(pickup_datetime), 'EEE') as week_day_,
dropoff_longitude, dropoff_latitude, haversine_distance, maximum_temperature,
minimum_temperature, average_temperature, precipitation, snow_fall, snow_depth
from taxis;

select * from taxis_preprocessed limit 3;
