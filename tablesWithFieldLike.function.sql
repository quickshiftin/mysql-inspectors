-- ----------------------------------------------------------------------
-- wrapper function so client code doesn't have to deal w/ variables
-- ----------------------------------------------------------------------
delimiter //
DROP FUNCTION IF EXISTS `tablesWithFieldLike` //
CREATE FUNCTION `tablesWithFieldLike`(fieldName CHAR(255), dbName CHAR(255))
  RETURNS TEXT
BEGIN
  DECLARE sTables TEXT;
  CALL _tablesWithFieldLike(sTables, fieldName, dbName);
  RETURN sTables;
END //
delimiter ;
