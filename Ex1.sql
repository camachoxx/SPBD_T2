-- This view contains the full routes as the concatenation of pickup_area and dropoff_area
-- as well as the weekday and pickup hour

--Drop view if exists P1_preprocessed_view
--CREATE VIEW IF NOT EXISTS P1_preprocessed_view as
DROP table P1_preprocessed_view;
CREATE table P1_preprocessed_view as
SELECT week_day_,
CONCAT(pickup_area, " - ", dropoff_area) as route,
from_unixtime(unix_timestamp(pickup_datetime),'hh') as hour_
FROM taxis_preprocessed;

-- This view contains the
--CREATE VIEW IF NOT EXISTS P1_answer_all_routes as
DROP table P1_answer_all_routes;
CREATE table P1_answer_all_routes as
Select  week_day_,hour_,route,count(route) as n_routes
FROM P1_preprocessed_view
group by week_day_,hour_,route
Sort by week_day_,hour_,route,n_routes desc;

-- Getting the size of each group
select n_routes
from P1_answer_all_routes
sort by n_routes desc
limit 30;
-- there are some groups with very high number of records

-- The sum of n_routes should still be equal to the number of records of the original table
-- To check that we run the following:
-- select count(*) from taxisDEBUG
-- select sum(n_routes) from P1_answer_naive
-- and both results should match

-- Now we only want the top 3 most frequent routes of each group
DROP table P1_answer_most_frequent_routes;
CREATE table P1_answer_most_frequent_routes as
select * from (
  select week_day_, hour_, route, n_routes, row_number() over( partition by week_day_, hour_ order by n_routes desc) as rank_
  from P1_answer_all_routes
) t where rank_ <=10;

-- confirm the sizes of each group are below 10
select count(route) as routes
from P1_answer_most_frequent_routes
group by week_day_, hour_
sort by routes desc
limit 30;
