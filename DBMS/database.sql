DROP DATABASE IF EXISTS lost_and_found;
CREATE DATABASE lost_and_found;
USE lost_and_found;


DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS storedLocations;

CREATE TABLE storedLocations (
  locationName VARCHAR(100),
  locationLatitude DECIMAL(10, 8) NOT NULL,
  locationLongitude DECIMAL(11,8) NOT NULL,
  PRIMARY KEY(locationName)
);

CREATE TABLE items (
  description VARCHAR(1000),
  summary VARCHAR(100),
  itemLatitude DECIMAL(10, 8) NOT NULL,
  itemLongitude DECIMAL(11, 8) NOT NULL,
  foundDateTime DATETIME,
  status ENUM('claimed', 'unclaimed', 'sold'),
  tags SET('dummy1', 'dummy2'),
  itemID INT NOT NULL AUTO_INCREMENT,
  storedLocation VARCHAR(100),
  PRIMARY KEY(itemID),
  FOREIGN KEY (storedLocation) REFERENCES storedLocations(locationName)
);

DROP PROCEDURE IF EXISTS insertIntoItems;
DROP PROCEDURE IF EXISTS claimItem;
DROP PROCEDURE IF EXISTS sellItem;
DROP PROCEDURE IF EXISTS searchText;
DROP PROCEDURE IF EXISTS searchDateTime;
DROP PROCEDURE IF EXISTS searchLocation;
DROP PROCEDURE IF EXISTS editLostItem;

DELIMITER //
CREATE PROCEDURE dummyProcedure (itemID_input INT)
BEGIN
    SELECT description FROM items
    WHERE itemID = itemID_input;
END//

CREATE PROCEDURE insertIntoItems (description_input VARCHAR(1000), summary_input VARCHAR(100),
  itemLatitude_input DECIMAL(10, 8), itemLongitude_input DECIMAL(11, 8), foundDateTime_input DATETIME,
  tags_input SET('dummy1', 'dummy2'), storedLocation_input VARCHAR(100))
BEGIN
  INSERT INTO items (description, summary, itemLatitude, itemLongitude, foundDateTime,
  status, tags, storedLocation)
  values (description_input, summary_input, itemLatitude_input, itemLongitude_input,
  foundDateTime_input, 'unclaimed', tags_input, storedLocation_input);
  SELECT LAST_INSERT_ID();
END//

CREATE PROCEDURE claimItem (itemID_input INT)
BEGIN
  UPDATE items SET status='claimed'
  WHERE itemID=itemID_input;
END//

CREATE PROCEDURE sellItem (itemID_input INT)
BEGIN
  UPDATE items SET status='sold'
  WHERE itemID=itemID_input;
END//

CREATE PROCEDURE searchText (searchString VARCHAR(100))
BEGIN
  SELECT * FROM items
  WHERE INSTR(LOWER(description), LOWER(searchString)) > 0
  OR INSTR(LOWER(summary), LOWER(searchString)) > 0;
END//

CREATE PROCEDURE searchDateTime (startDate DATETIME, endDate DATETIME)
BEGIN
  SELECT * FROM items
  WHERE startDate <= foundDateTime
  AND endDate >= foundDateTime;
END//

CREATE PROCEDURE searchLocation (searchString VARCHAR(100))
BEGIN
  SELECT * FROM items
  WHERE INSTR(LOWER(storedLocation), LOWER(searchString)) > 0;
END//

CREATE PROCEDURE editLostItem (description_input VARCHAR(1000), summary_input VARCHAR(100),
  itemLatitude_input DECIMAL(10, 8), itemLongitude_input DECIMAL(11, 8), foundDateTime_input DATETIME,
  tags_input SET('dummy1', 'dummy2'), storedLocation_input VARCHAR(100), itemID_input INT)
BEGIN
  UPDATE items SET description=description_input,summary=summary_input,itemLatitude=itemLatitude_input,
  itemLongitude=itemLongitude_input, foundDateTime=foundDateTime_input, status=status_input,
  tags=tags_input, storedLocation=storedLocation_input
  WHERE itemID=itemID_input;
END//

CREATE PROCEDURE insertStoredLocation (locationName_input VARCHAR(100),
  locationLatitude_input DECIMAL(10, 8), locationLongitude_input DECIMAL(11, 8))
BEGIN
  INSERT INTO storedLocations (locationName, locationLatitude, locationLongitude)
  values (locationName_input, locationLatitude_input, locationLongitude_input);
END//

DELIMITER ;
