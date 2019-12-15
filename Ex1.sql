--get necessary info from the dataset
DROP VIEW P1_preprocessed_view;
CREATE VIEW P1_preprocessed_view as
SELECT week_day_,
CONCAT(pickup_area, " - ", dropoff_area) as route,
from_unixtime(unix_timestamp(pickup_datetime),'hh') as hour_
FROM taxis_preprocessed;

-- get the answer without the restriction on the group size

DROP VIEW P1_answer_all_routes_view;
CREATE VIEW P1_answer_all_routes_view as
Select week_day_, hour_, route, count(route) as n_routes
FROM P1_preprocessed_view
group by week_day_, hour_, route
Sort by week_day_, hour_, route, n_routes desc;

-- Now we only want the top 10 most frequent routes of each group
DROP table P1_answer_most_frequent_routes;
CREATE table P1_answer_most_frequent_routes as
select week_day_, hour_, route, n_routes from (
  select week_day_, hour_, route, n_routes, row_number() over( partition by week_day_, hour_ order by n_routes desc) as rank_
  from P1_answer_all_routes_view
) t where rank_ <=10;
