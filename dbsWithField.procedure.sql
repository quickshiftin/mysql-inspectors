-- -------------------------------------------------------------
-- find all databases that have tables with the specified field
-- -------------------------------------------------------------
delimiter //
-- core procedure which does heavy lifting of query
DROP PROCEDURE IF EXISTS `_dbsWithField` //
CREATE PROCEDURE `_dbsWithField` (
OUT _dbs CHAR(255),    -- list of dbs & tables that have fieldName
IN fieldName CHAR(255) -- field name to look for in tables
) BEGIN
  SELECT GROUP_CONCAT(DISTINCT t.`TABLE_SCHEMA` SEPARATOR ', ') INTO _dbs
  FROM `information_schema`.`COLUMNS` c
  JOIN `information_schema`.`TABLES` t
    ON t.`TABLE_SCHEMA` = c.`TABLE_SCHEMA` AND t.`TABLE_NAME` = c.`TABLE_NAME`
  WHERE c.`COLUMN_NAME` = fieldName
  GROUP BY c.`COLUMN_NAME`;
END //
delimiter ;
