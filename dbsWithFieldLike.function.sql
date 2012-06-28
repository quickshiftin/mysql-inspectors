-- ----------------------------------------------------------------------
-- wrapper function so client code doesn't have to deal w/ variables
-- ----------------------------------------------------------------------
delimiter //
DROP FUNCTION IF EXISTS `dbsWithFieldLike` //
CREATE FUNCTION `dbsWithFieldLike`(fieldName CHAR(255))
	RETURNS TEXT
BEGIN
	DECLARE sDbs TEXT;
	CALL _dbsWithFieldLike(sDbs, fieldName);
	RETURN sDbs;
END //
delimiter ;
