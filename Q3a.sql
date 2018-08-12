SELECT
	COUNT(*) as "total_visit_num",
	COUNT(DISTINCT user_id) as "distinct_user",
	COUNT(DISTINCT page_id) as "distinct_page"
FROM q3;

WITH raw AS(
	SELECT
		CONCAT(rounded.visit_hour,' - ',DATE_ADD(rounded.visit_hour, INTERVAL 3599 SECOND)) AS "visit_hour",
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
	ORDER BY visit_num
)
(SELECT * FROM raw ORDER BY raw.visit_num DESC LIMIT 1)
UNION ALL
(SELECT * FROM raw ORDER BY raw.visit_num LIMIT 1);

SELECT
	page_id,
	COUNT(*) as "visit_num"
FROM q3
GROUP BY page_id
ORDER BY visit_num DESC
LIMIT 1;
