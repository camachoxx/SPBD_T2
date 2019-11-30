CREATE EXTERNAL TABLE IF NOT EXISTS iris
(
sepal_length float,
sepal_width float,
petal_length float,
petal_width float,
target int
)

row format delimited fields terminated by ',';
TBLPROPERTIES ("orc.compress"="SNAPPY","orc.bloom.filters.columns"="macaddress");
load data local inpath '/root/work/iris.csv' overwrite into table iris;


select sepal_length as sepal_length from iris
limit 6;
