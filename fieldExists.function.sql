-- ----------------------------------------------------------------------
-- wrapper function so client code doesn't have to deal w/ variables
-- ----------------------------------------------------------------------
delimiter //
DROP FUNCTION IF EXISTS `fieldExists` //
CREATE FUNCTION `fieldExists`(tableName CHAR(255), columnName CHAR(255), dbName CHAR(255))
  RETURNS BOOLEAN
BEGIN
  DECLARE bExists BOOLEAN;
  CALL _fieldExists(bExists, tableName, columnName, dbName);
  RETURN bExists;
END //
delimiter ;
