-- 101-average_weighted_score.sql
-- Create stored procedure ComputeAverageWeightedScoreForUsers

USE holberton;

-- Drop procedure if exists to handle re-execution
DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUsers;

-- Create the procedure
DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE total_users INT;
    DECLARE user_id INT;
    DECLARE project_id INT;
    DECLARE user_score FLOAT;
    DECLARE weighted_score FLOAT;
    DECLARE weighted_sum FLOAT;
    DECLARE user_cursor CURSOR FOR
        SELECT u.id
        FROM users u;

    -- Temporary table to store weighted averages
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_weighted_average (
        user_id INT,
        weighted_average FLOAT
    );

    -- Set total users count
    SELECT COUNT(*) INTO total_users FROM users;

    -- Initialize cursor
    OPEN user_cursor;

    -- Loop through each user
    user_loop: LOOP
        FETCH user_cursor INTO user_id;
        IF done = 1 THEN
            LEAVE user_loop;
        END IF;

        -- Initialize weighted sum for current user
        SET weighted_sum = 0;

        -- Cursor for user's corrections
        DECLARE project_cursor CURSOR FOR
            SELECT c.project_id, c.score, p.weight
            FROM corrections c
            JOIN projects p ON c.project_id = p.id
            WHERE c.user_id = user_id;

        -- Initialize project cursor
        OPEN project_cursor;

        -- Loop through each correction
        project_loop: LOOP
            FETCH project_cursor INTO project_id, user_score, weighted_score;
            IF done = 1 THEN
                LEAVE project_loop;
            END IF;

            -- Calculate weighted score for each project
            SET weighted_sum = weighted_sum + (user_score * weighted_score);
        END LOOP;

        -- Close project cursor
        CLOSE project_cursor;

        -- Calculate average weighted score
        INSERT INTO temp_weighted_average (user_id, weighted_average)
        VALUES (user_id, weighted_sum / total_users);

    END LOOP;

    -- Close user cursor
    CLOSE user_cursor;

    -- Update users table with calculated average scores
    UPDATE users u
    JOIN temp_weighted_average t ON u.id = t.user_id
    SET u.average_score = t.weighted_average;

    -- Drop temporary table
    DROP TEMPORARY TABLE IF EXISTS temp_weighted_average;

END //
DELIMITER ;
