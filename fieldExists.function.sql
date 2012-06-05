-- ----------------------------------------------------------------------
-- wrapper function so client code doesn't have to deal w/ variables
-- ----------------------------------------------------------------------
delimiter //
DROP FUNCTION IF EXISTS `fieldExists` //
CREATE FUNCTION `fieldExists`(columnName CHAR(255), tableName CHAR(255), dbName CHAR(255))
  RETURNS BOOLEAN
BEGIN
  DECLARE bExists BOOLEAN;
  CALL _fieldExists(bExists, columnName, tableName, dbName);
  RETURN bExists;
END //
delimiter ;
