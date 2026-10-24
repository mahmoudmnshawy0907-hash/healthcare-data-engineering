SELECT name
FROM sqlite_master
WHERE type = 'table';


SELECT Country, Year, Value
FROM egypt_health_statistics
ORDER BY Year DESC;


SELECT COUNT(*) AS total_records
FROM egypt_health_statistics;


SELECT Country, Year, Value
FROM egypt_health_statistics
ORDER BY Year DESC
LIMIT 1;


SELECT
    MIN(Value) AS lowest_value,
    MAX(Value) AS highest_value,
    MAX(Value) - MIN(Value) AS difference
FROM egypt_health_statistics;


SELECT Country, Year, Value
FROM egypt_health_statistics
WHERE Year = 2011;



SELECT Country, Year, Value
FROM egypt_health_statistics
WHERE Year = 2024;


SELECT
    Country,
    Year,
    Indicator_Code,
    COUNT(*) AS duplicate_count
FROM egypt_health_statistics
GROUP BY Country, Year, Indicator_Code
HAVING COUNT(*) > 1;


SELECT COUNT(*) AS duplicate_groups
FROM (
    SELECT Country, Year, Indicator_Code
    FROM egypt_health_statistics
    GROUP BY Country, Year, Indicator_Code
    HAVING COUNT(*) > 1
);


SELECT COUNT(*) AS incomplete_records
FROM egypt_health_statistics
WHERE Country IS NULL
   OR Year IS NULL
   OR Indicator_Code IS NULL
   OR Value IS NULL
   OR Source_URL IS NULL;


   SELECT COUNT(*) AS invalid_value_records
FROM egypt_health_statistics
WHERE Value < 0
   OR Value > 100;


   SELECT COUNT(*) AS total_records
FROM egypt_health_statistics;


SELECT Country, Year, Value
FROM egypt_health_statistics
ORDER BY Year DESC;