SELECT COUNT(sleep_per_day.IDandDate)
FROM `bellabeat.sleep_per_day`

SELECT COUNT(IDandDate)
FROM `bellabeat.daily_activity`

SELECT COUNT(IDandDate)
FROM `bellabeat.daily_activity`
WHERE TotalSteps > 0
