-- 4-store.sql
-- Create a trigger to decrease quantity in items table after inserting into orders table

DELIMITER //

CREATE TRIGGER decrease_quantity_after_order
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE items
    SET quantity = quantity - NEW.number
    WHERE name = NEW.item_name;
END //

DELIMITER ;
