-- Task 3: Old school band
-- List bands with Glam rock as their main style, ranked by longevity

-- Import the table dump
SOURCE metal_bands.sql;

-- Calculate lifespan based on formed and split years
SELECT band_name, (2022 - formed) AS lifespan
FROM bands
WHERE style = 'Glam rock'
ORDER BY lifespan DESC;
