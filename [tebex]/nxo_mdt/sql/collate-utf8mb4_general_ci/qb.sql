-- The following queries populate two linking tables from existing tables.
-- The linking tables serve as a bridge between your existing data and additional features you're implementing.

-- This SQL command inserts 'citizenid' from the 'players' table into both the 'identifier' and 'stateid' columns of the 'drx_mdt_player_link' table.
INSERT IGNORE INTO `drx_mdt_player_link` (identifier, stateid)
SELECT citizenid, citizenid
FROM players;

-- This SQL command inserts identifiers from the 'player_vehicles' table into the 'drx_mdt_vehicle_link' table.
INSERT IGNORE INTO `drx_mdt_vehicle_link` (identifier)
SELECT plate
FROM player_vehicles;

-- Setting SQL Mode for safety and compatibility.
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

DELIMITER //

-- Begin definition of the player link delete trigger.
-- This trigger is invoked after a row is deleted from the 'players' table.
-- It ensures that corresponding data in the 'drx_mdt_player_link' is also removed.
CREATE TRIGGER drx_mdt_player_link_delete
AFTER DELETE
ON players FOR EACH ROW
BEGIN
  DELETE FROM drx_mdt_player_link WHERE identifier = OLD.citizenid;
END //
-- End definition of the trigger.

-- Begin definition of the player link insert trigger.
-- This trigger assigns the 'citizenid' as the 'stateid' after a new row is inserted into the 'players' table.
CREATE TRIGGER drx_mdt_player_link_trigger
AFTER INSERT
ON players FOR EACH ROW
BEGIN
  INSERT IGNORE INTO drx_mdt_player_link (identifier, stateid) VALUES (NEW.citizenid, NEW.citizenid);
END //
-- End definition of the trigger.

-- Begin definition of the vehicle link delete trigger.
-- This trigger is invoked after a row is deleted from the 'player_vehicles' table.
-- It ensures that corresponding data in the 'drx_mdt_vehicle_link' is also removed.
CREATE TRIGGER drx_mdt_vehicle_link_delete
AFTER DELETE
ON player_vehicles FOR EACH ROW
BEGIN
  DELETE FROM drx_mdt_vehicle_link WHERE identifier = OLD.plate;
END //
-- End definition of the trigger.

-- Begin definition of the vehicle link insert trigger.
-- This trigger inserts the vehicle's plate into the 'drx_mdt_vehicle_link' table after a new row is added to the 'player_vehicles' table.
CREATE TRIGGER drx_mdt_vehicle_link_trigger
AFTER INSERT
ON player_vehicles FOR EACH ROW
BEGIN
  INSERT IGNORE INTO drx_mdt_vehicle_link (identifier) VALUES (NEW.plate);
END //
-- End definition of the trigger.

DELIMITER ;

-- Reset SQL mode to its original setting.
SET SQL_MODE=@OLDTMP_SQL_MODE;