-- Q3b-1 Number of visits per hour

SELECT
	rounded.visit_hour,
	COUNT(rounded.visit_hour) AS "visit_num"
FROM(
	SELECT
			visit_time,
			DATE_ADD( 
				DATE_ADD(visit_time, INTERVAL -MINUTE(visit_time) MINUTE)
				, INTERVAL -SECOND(visit_time) SECOND
			) AS visit_hour
	FROM q3
) rounded
GROUP BY rounded.visit_hour
ORDER BY rounded.visit_hour;

-- Q3b-2 Cumulative number visits per hour

SET @running_total := 0;
SELECT
	 CONCAT('hour ', HOUR(raw.visit_hour)) AS "hour",
	(@running_total := @running_total + raw.visit_num) AS cumulative_visit
FROM (
	SELECT
		rounded.visit_hour,
		COUNT(rounded.visit_hour) AS "visit_num"
	FROM(
		SELECT
				visit_time,
				DATE_ADD( 
					DATE_ADD(visit_time, INTERVAL -MINUTE(visit_time) MINUTE)
					, INTERVAL -SECOND(visit_time) SECOND
				) AS visit_hour
		FROM q3
	) rounded
	GROUP BY rounded.visit_hour
	ORDER BY rounded.visit_hour
) AS raw;

-- Q3b-3 Number of new visitors per hour

	SELECT
		rounded.visit_hour,
		COUNT(DISTINCT rounded.user_id) AS "new_visitor_num"
	FROM(
		SELECT
				user_id,
				DATE_ADD( 
					DATE_ADD(MIN(visit_time), INTERVAL -MINUTE(MIN(visit_time)) MINUTE)
					, INTERVAL -SECOND(MIN(visit_time)) SECOND
				) AS visit_hour
		FROM q3
		GROUP BY user_id
	) rounded
	GROUP BY rounded.visit_hour
	ORDER BY rounded.visit_hour;

-- Q3b-4 Cumulative number of new visitors per hour


SET @running_total := 0;
SELECT
	 CONCAT('hour ', HOUR(raw.visit_hour)) AS "hour",
	(@running_total := @running_total + raw.new_visitor_num) AS cumulative_new_visitor
FROM (
	SELECT
		rounded.visit_hour,
		COUNT(DISTINCT rounded.user_id) AS "new_visitor_num"
	FROM(
		SELECT
				user_id,
				DATE_ADD( 
					DATE_ADD(MIN(visit_time), INTERVAL -MINUTE(MIN(visit_time)) MINUTE)
					, INTERVAL -SECOND(MIN(visit_time)) SECOND
				) AS visit_hour
		FROM q3
		GROUP BY user_id
	) rounded
	GROUP BY rounded.visit_hour
	ORDER BY rounded.visit_hour
) AS raw;

