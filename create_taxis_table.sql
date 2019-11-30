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

load data local inpath '/root/work/SPBD_T2/taxis.csv' overwrite into table taxis;
