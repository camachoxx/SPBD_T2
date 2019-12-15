-- get necessary info from the dataset
DROP VIEW IF EXISTS vendor_routes_and_travel_time;
CREATE VIEW vendor_routes_and_travel_time as
SELECT unix_timestamp(dropoff_datetime) - unix_timestamp(pickup_datetime) as travel_time,
CONCAT(pickup_area,", ",dropoff_area) as route,
vendor_id
FROM taxis_preprocessed;

-- get average travel time for each route and vendor

DROP VIEW IF EXISTS avg_travel_time_per_route_per_vendor;
CREATE VIEW avg_travel_time_per_route_per_vendor as
SELECT vendor_id, route, avg(travel_time) as avg_travel_time
FROM vendor_routes_and_travel_time
group by route,vendor_id;

--seperate both vendors

DROP VIEW IF EXISTS vendor_1;
CREATE VIEW vendor_1 as
select * from avg_travel_time_per_route_per_vendor
where vendor_id = 0;

DROP VIEW IF EXISTS vendor_2;
CREATE VIEW vendor_2 as
select * from avg_travel_time_per_route_per_vendor
where vendor_id = 1;

-- compute final index that allows to compare avg travel time of both vendors on each route
Drop Table if exists T4_answer;
CREATE Table T4_answer as
SELECT vendor_1.route, (vendor_1.avg_travel_time / 60) as vendor_1_avg_travel_time_minutes, (vendor_2.avg_travel_time / 60) as vendor_2_avg_travel_time_minutes
from vendor_1 inner join vendor_2 on vendor_1.route = vendor_2.route;
