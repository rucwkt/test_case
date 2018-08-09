SELECT
	COUNT(uid_filtered)
FROM(
	SELECT
		DISTINCT(CASE WHEN event_name = 'FIRST_INSTALL' and DATE(time) = '2017-04-01' THEN uid ELSE 'D' END) AS "uid_filtered",
		COUNT(CASE WHEN DATE(time) > '2017-04-01' and DATE(time) < '2017-04-09' THEN event_name END) AS "event_num"
	FROM piwik_track
	GROUP BY uid
) filter
WHERE uid_filtered <> 'D' 
AND event_num > 0;