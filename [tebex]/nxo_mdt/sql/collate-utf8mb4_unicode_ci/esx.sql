-- The following queries populate two linking tables from existing tables.
-- The linking tables serve as a bridge between your existing data and additional features you're implementing.

-- This SQL command inserts identifiers from the 'users' table into the 'drx_mdt_player_link' table.
DELIMITER //

DROP PROCEDURE IF EXISTS PopulatePlayerLinkWithStateID//
DROP PROCEDURE IF EXISTS drx_mdt_populate_player_link//

CREATE PROCEDURE drx_mdt_populate_player_link()
BEGIN
  DECLARE finished INTEGER DEFAULT 0;
  DECLARE curr_identifier VARCHAR(255);
  DECLARE stateIdValue VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci; -- Specify collation here
  DECLARE isUnique INT DEFAULT 0;

  -- Cursors to iterate over each user
  DECLARE cur CURSOR FOR
    SELECT identifier FROM users;

  DECLARE CONTINUE HANDLER
    FOR NOT FOUND SET finished = 1;

  -- Start cursor
  OPEN cur;

  get_record: LOOP

    FETCH cur INTO curr_identifier;

    IF finished = 1 THEN
      LEAVE get_record;
    END IF;

    SET isUnique = 0;

    WHILE isUnique = 0 DO
      SET stateIdValue = CONCAT(
        CHAR(FLOOR(65 + RAND() * 26)),
        CHAR(FLOOR(65 + RAND() * 26)),
        CHAR(FLOOR(65 + RAND() * 26)),
        LPAD(FLOOR(RAND() * 100000), 5, '0')
      );

      -- Check for uniqueness
      IF NOT EXISTS (SELECT 1 FROM drx_mdt_player_link WHERE stateid = stateIdValue) THEN
        SET isUnique = 1;
      END IF;

    END WHILE;

    -- Insert the record into drx_mdt_player_link
    INSERT IGNORE INTO drx_mdt_player_link (identifier, stateid) VALUES (curr_identifier, stateIdValue);

  END LOOP get_record;

  -- Close cursor
  CLOSE cur;

END //
DELIMITER ;

CALL drx_mdt_populate_player_link();

-- This SQL command inserts identifiers from the 'owned_vehicles' table into the 'drx_mdt_vehicle_link' table.
INSERT IGNORE INTO `drx_mdt_vehicle_link` (identifier) SELECT plate FROM owned_vehicles;


-- Setting SQL Mode for safety and compatibility.
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

DELIMITER //

-- Begin definition of the player link delete trigger.
-- This trigger is invoked after a row is deleted from the 'users' table.
-- It ensures that corresponding data in the 'drx_mdt_player_link' is also removed.
CREATE TRIGGER drx_mdt_player_link_delete
AFTER DELETE
ON users FOR EACH ROW
BEGIN
  DELETE FROM drx_mdt_player_link WHERE identifier = OLD.identifier;
END //
-- End definition of the trigger.

-- Begin definition of the player link insert trigger.
-- This trigger generates a unique State ID after a new row is inserted into the 'users' table.
-- The State ID consists of three random uppercase letters and five random numbers.
CREATE TRIGGER drx_mdt_player_link_trigger
AFTER INSERT
ON users FOR EACH ROW
BEGIN
  DECLARE stateIdValue VARCHAR(10);
  DECLARE isUnique INT DEFAULT 0;

  WHILE isUnique = 0 DO
    SET stateIdValue = CONCAT(
      CHAR(FLOOR(65 + RAND() * 26)),
      CHAR(FLOOR(65 + RAND() * 26)),
      CHAR(FLOOR(65 + RAND() * 26)),
      LPAD(FLOOR(RAND() * 100000), 5, '0')
    );

    -- Check for uniqueness.
    IF NOT EXISTS (SELECT 1 FROM drx_mdt_player_link WHERE stateid = stateIdValue) THEN
      SET isUnique = 1;
    END IF;

  END WHILE;

  INSERT IGNORE INTO drx_mdt_player_link (identifier, stateid) VALUES (NEW.identifier, stateIdValue);
END //
-- End definition of the trigger.

-- Begin definition of the vehicle link delete trigger.
-- This trigger is invoked after a row is deleted from the 'owned_vehicles' table.
-- It ensures that corresponding data in the 'drx_mdt_vehicle_link' is also removed.
CREATE TRIGGER drx_mdt_vehicle_link_delete
AFTER DELETE
ON owned_vehicles FOR EACH ROW
BEGIN
  DELETE FROM drx_mdt_vehicle_link WHERE identifier = OLD.plate;
END //
-- End definition of the trigger.

-- Begin definition of the vehicle link insert trigger.
-- This trigger inserts the vehicle's plate into the 'drx_mdt_vehicle_link' table after a new row is added to the 'owned_vehicles' table.
CREATE TRIGGER drx_mdt_vehicle_link_trigger
AFTER INSERT
ON owned_vehicles FOR EACH ROW
BEGIN
  INSERT IGNORE INTO drx_mdt_vehicle_link (identifier) VALUES (NEW.plate);
END //
-- End definition of the trigger.

DELIMITER ;

-- Reset SQL mode to its original setting.
SET SQL_MODE=@OLDTMP_SQL_MODE;
