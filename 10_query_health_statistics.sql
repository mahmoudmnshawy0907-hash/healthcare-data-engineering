SELECT COUNT(*) AS total_records
FROM health_statistics;


SELECT Country, Year, Value
FROM health_statistics
ORDER BY Year DESC, Value DESC;


SELECT h.Country, h.Year, h.Value
FROM health_statistics AS h
WHERE h.Year = (
    SELECT MAX(h2.Year)
    FROM health_statistics AS h2
    WHERE h2.Country = h.Country
)
ORDER BY h.Value DESC;