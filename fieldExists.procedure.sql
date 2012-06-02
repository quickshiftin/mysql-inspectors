-- ------------------------------------------------------------
-- Use the information_schema to tell if a field exists.
-- Optional param dbName, defaults to current database
-- ------------------------------------------------------------
delimiter //
DROP PROCEDURE IF EXISTS `_fieldExists` //
CREATE PROCEDURE `_fieldExists` (
OUT _exists BOOLEAN,      -- return value
IN tableName CHAR(255),   -- name of table to look for
IN columnName CHAR(255),  -- name of column to look for
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
