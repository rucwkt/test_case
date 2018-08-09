SELECT
	COUNT(uid)
FROM(
	SELECT
		distinct uid
	FROM piwik_track
	GROUP BY uid
	HAVING 	COUNT(CASE WHEN event_name = 'FIRST_INSTALL' AND DATE(time) = '2017-04-01' THEN event_name END) > 0
	AND COUNT(CASE WHEN DATE(time) > '2017-04-01' and DATE(time) < '2017-04-09' THEN event_name END) > 0
) uid_filtered;