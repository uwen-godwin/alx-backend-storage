-- Task 4: Buy buy buy
-- Create a trigger that decreases item quantity after adding a new order

-- Initial setup: Create tables and insert initial data
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS orders;

CREATE TABLE IF NOT EXISTS items (
    name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL DEFAULT 10
);

CREATE TABLE IF NOT EXISTS orders (
    item_name VARCHAR(255) NOT NULL,
    number INT NOT NULL
);

INSERT INTO items (name) VALUES ("apple"), ("pineapple"), ("pear");

-- Trigger to decrease quantity after adding order
DELIMITER //
CREATE TRIGGER decrease_quantity AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE items
    SET quantity = quantity - NEW.number
    WHERE name = NEW.item_name;
END //
DELIMITER ;
