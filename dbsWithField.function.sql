-- ----------------------------------------------------------------------
-- wrapper function so client code doesn't have to deal w/ variables
-- ----------------------------------------------------------------------
delimiter //
DROP FUNCTION IF EXISTS `dbsWithField` //
CREATE FUNCTION `dbsWithField`(fieldName CHAR(255))
	RETURNS VARCHAR(1000)
BEGIN
	DECLARE sDbs VARCHAR(1000);
	CALL _dbsWithField(sDbs, fieldName);
	RETURN sDbs;
END //
delimiter ;
