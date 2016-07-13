SELECT id as review_id, title, author, reviewer,
        status, lines_count
        FROM jdoc.reviews WHERE 
        (status IN ('assigned', 'responded', 'dassigned', 'dresponded') AND
	author = 'yoavp')
        OR (status = 'reviewed' AND assigned = 'yoavp')
        ORDER BY author, reviewer

http://bugs/sql_query.cgi?db=bugs_rg&q=SELECT+id+as+review_id%2C+title%2C+author%2C+reviewer%2C%0A+++status%2C+lines_count%0A+++FROM+jdoc.reviews+WHERE+%0A+++%28status+IN+%28%27assigned%27%2C+%27responded%27%2C+%27dassigned%27%2c+%27dresponded%27%29%0A+++AND+author+%3D+%27yoavp%27%29%0A+++OR+%28status+%3D+%27reviewed%27+AND+reviewer+%3D+%27yoavp%27%29%0A+++ORDER+BY+author%2C+reviewer

http://bugs/sql_query.cgi?db=bugs_rg&q=SELECT+id+as+review_id%2C+title%2C+author%2C+reviewer%2C+status%2C+lines_count%0A++FROM+jdoc.reviews+WHERE+%0A++%28author+%3D+%27yoavp%27+OR+reviewer+%3D+%27yoavp%27%29%0A+++AND+status+%21%3D+%27closed%27%0A++ORDER+BY+author%2C+reviewer
