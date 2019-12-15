-- get necessary info from the dataset
Drop view if exists preprocessed_precip_snowfall_view;
CREATE VIEW preprocessed_precip_snowfall_view as
SELECT (precipitation + snow_fall) as weather, pickup_area
FROM taxis_preprocessed;

Drop view if exists RAIN;
CREATE VIEW RAIN AS
Select pickup_area, COUNT(weather) as count_bad_weather
FROM preprocessed_precip_snowfall_view
WHERE weather > 0.05
GROUP BY pickup_area;
-- above 0.05 because we consider that the threshold for raining or snowfall

Drop view if exists NORAIN;
CREATE VIEW NORAIN AS
Select pickup_area, COUNT(weather) as count_nice_weather
FROM preprocessed_precip_snowfall_view
WHERE weather <= 0.05
GROUP BY pickup_area;
-- above 0.05 because we consider that the threshold for raining or snowfall

Drop Table if exists T3_answer;
CREATE Table T3_answer as
SELECT RAIN.pickup_area, (RAIN.count_bad_weather / NORAIN.count_nice_weather) AS FACTOR
FROM RAIN inner JOIN NORAIN ON RAIN.pickup_area = NORAIN.pickup_area;
