-- ----------------------------------------------------------------------
-- wrapper function so client code doesn't have to deal w/ variables
-- ----------------------------------------------------------------------
delimiter //
DROP FUNCTION IF EXISTS `dbsWithField` //
CREATE FUNCTION `dbsWithField`(fieldName CHAR(255))
	RETURNS TEXT
BEGIN
	DECLARE sDbs TEXT;
	CALL _dbsWithField(sDbs, fieldName);
	RETURN sDbs;
END //
delimiter ;
