-- Task 2: Best band ever!
-- Rank country origins of bands by number of fans

-- Import the table dump
SOURCE metal_bands.sql;

-- Query to rank bands by country based on number of fans
SELECT origin AS origin, COUNT(*) AS nb_fans
FROM bands
GROUP BY origin
ORDER BY nb_fans DESC;
