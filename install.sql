-- -------------------------------------------------------------
-- find all databases that have tables with the specified field
-- -------------------------------------------------------------
delimiter //
-- core procedure which does heavy lifting of query
DROP PROCEDURE IF EXISTS `_dbsWithField` //
CREATE PROCEDURE `_dbsWithField` (
OUT _dbs TEXT, -- list of dbs & tables that have fieldName
IN fieldName CHAR(255)  -- field name to look for in tables
) BEGIN
  SELECT GROUP_CONCAT(DISTINCT t.`TABLE_SCHEMA` SEPARATOR ', ') INTO _dbs
  FROM `information_schema`.`COLUMNS` c
  JOIN `information_schema`.`TABLES` t
    ON t.`TABLE_SCHEMA` = c.`TABLE_SCHEMA` AND t.`TABLE_NAME` = c.`TABLE_NAME`
  WHERE c.`COLUMN_NAME` = fieldName
  GROUP BY c.`COLUMN_NAME`;
END //
delimiter ;
-- ------------------------------------------------------------
-- Use the information_schema to tell if a field exists.
-- Optional param dbName, defaults to current database
-- ------------------------------------------------------------
delimiter //
DROP PROCEDURE IF EXISTS `_fieldExists` //
CREATE PROCEDURE `_fieldExists` (
OUT _exists BOOLEAN,      -- return value
IN columnName CHAR(255),  -- name of column to look for
IN tableName CHAR(255),   -- name of table to look for
IN dbName CHAR(255)       -- optional specific db
) BEGIN
-- try current db if none provided
-- XXX inside a stored procedure, database() always resolves
--     to the db in which it's installed, so this feature is
--     useless unless it's installed on the db you would like
--     it to work on (read: WEAK).
SET @_dbName := IF(dbName IS NULL, database(), dbName);
SELECT @_dbName;
IF CHAR_LENGTH(@_dbName) = 0
THEN -- bail if no db to work with
  SELECT FALSE INTO _exists;
ELSE -- we have a db to work with
  SELECT IF(count(*) > 0, TRUE, FALSE) INTO _exists
  FROM `information_schema`.`COLUMNS` c
  WHERE 
  c.`TABLE_SCHEMA`    = @_dbName
  AND c.`TABLE_NAME`  = tableName
  AND c.`COLUMN_NAME` = columnName;
END IF;
END //
delimiter ;
-- -------------------------------------------------------------
-- find all occurances of tables with the given field, in the
-- specified database.  Use dbsWithField to scan on a db level.
-- -------------------------------------------------------------
delimiter //
DROP PROCEDURE IF EXISTS `_tablesWithField` //
CREATE PROCEDURE `_tablesWithField` (
OUT _tables TEXT, -- list of dbs & tables that have fieldName
IN fieldName CHAR(255),    -- field name to look for in tables
IN dbName CHAR(255)        -- name of db to scan
) BEGIN
  SELECT GROUP_CONCAT(c.`TABLE_NAME` SEPARATOR ', ') INTO _tables
  FROM `information_schema`.`COLUMNS` c
  WHERE c.`COLUMN_NAME` = fieldName AND c.`TABLE_SCHEMA` = dbName
  GROUP BY c.`TABLE_SCHEMA`;
END //
delimiter ;
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
-- ----------------------------------------------------------------------
-- wrapper function so client code doesn't have to deal w/ variables
-- ----------------------------------------------------------------------
delimiter //
DROP FUNCTION IF EXISTS `tablesWithField` //
CREATE FUNCTION `tablesWithField`(fieldName CHAR(255), dbName CHAR(255))
  RETURNS TEXT
BEGIN
  DECLARE sTables TEXT;
  CALL _tablesWithField(sTables, fieldName, dbName);
  RETURN sTables;
END //
delimiter ;
