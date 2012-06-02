-- -------------------------------------------------------------
-- find all occurances of tables with the given field, in the
-- specified database.  Use dbsWithField to scan on a db level.
-- -------------------------------------------------------------
delimiter //
DROP PROCEDURE IF EXISTS `_tablesWithField` //
CREATE PROCEDURE `_tablesWithField` (
OUT _tables CHAR(255),  -- list of dbs & tables that have fieldName
IN fieldName CHAR(255), -- field name to look for in tables
IN dbName CHAR(255)     -- name of db to scan
) BEGIN
  SELECT GROUP_CONCAT(c.`TABLE_NAME` SEPARATOR ', ') INTO _tables
  FROM `information_schema`.`COLUMNS` c
  WHERE c.`COLUMN_NAME` = fieldName AND c.`TABLE_SCHEMA` = dbName
  GROUP BY c.`TABLE_SCHEMA`;
END //
delimiter ;
