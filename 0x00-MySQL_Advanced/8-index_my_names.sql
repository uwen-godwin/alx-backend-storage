-- 8-index_my_names.sql
-- Create index on the first letter of name

USE holberton;

-- Create index
CREATE INDEX idx_name_first ON names (LEFT(name, 1));

-- Verify index creation
SHOW INDEX FROM names;
