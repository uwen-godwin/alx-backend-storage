-- 7-average_score.sql
-- Stored procedure to compute average score for a user

DELIMITER //

CREATE PROCEDURE ComputeAverageScoreForUser(IN user_id INT)
BEGIN
    DECLARE avg_score FLOAT;

    -- Compute average score for the user
    SELECT AVG(score) INTO avg_score
    FROM corrections
    WHERE user_id = user_id;

    -- Update average_score in users table
    UPDATE users
    SET average_score = avg_score
    WHERE id = user_id;
    
    -- Display computed average score
    SELECT CONCAT('Average score for user ', (SELECT name FROM users WHERE id = user_id), ': ', avg_score) AS 'Average Score';
END //

DELIMITER ;
