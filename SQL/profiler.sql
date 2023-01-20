
SELECT @@profiling;

SET profiling=1;

SELECT * FROM hr.regions;
SELECT * FROM check_extent;
SELECT * FROM compo_range_hash WHERE sal=3000;

SHOW profiles;

SHOW profile FOR QUERY 14;

SET profiling=0;