DROP TABLE IF EXISTS taxis;
CREATE EXTERNAL TABLE IF NOT EXISTS taxis 
(
line int,
id string,
vendor_id int,
pickup_datetime TimeStamp,
dropoff_datetime TimeStamp,
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
row format delimited 
fields terminated by ',' 
lines terminated by '\n' 
STORED AS TEXTFILE
location '/taxis.csv'
tblproperties ("skip.header.line.count"="1");


SHOW TABLES;