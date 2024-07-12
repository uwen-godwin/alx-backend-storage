-- Task 5: Email validation to sent
-- Create a trigger that resets the valid_email attribute only when email has been changed

-- Initial setup: Create users table and insert initial data
DROP TABLE IF EXISTS users;

CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    name VARCHAR(255),
    valid_email BOOLEAN NOT NULL DEFAULT 0
);

INSERT INTO users (email, name) VALUES ("bob@dylan.com", "Bob");
INSERT INTO users (email, name, valid_email) VALUES ("sylvie@dylan.com", "Sylvie", 1);
INSERT INTO users (email, name, valid_email) VALUES ("jeanne@dylan.com", "Jeanne", 1);

-- Trigger to reset valid_email on email change
DELIMITER //
CREATE TRIGGER reset_valid_email BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    IF NEW.email <> OLD.email THEN
        SET NEW.valid_email = 0;
    END IF;
END //
DELIMITER ;
