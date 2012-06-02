mysql-inspectors
================

A set of stored procedures and functions encapsulating schema inspection via information_schema.

dbsWithField - VARCHAR(1000) dbsWithField(<fieldName> CHAR(255))
----------------------------------------------------------------
 Get a list of databases that have field on any table with a given name.

    select dbsWithField('product_id');
    +-------------------------------------------------------------+
    | dbsWithField('product_id')                                  |
    +-------------------------------------------------------------+
    | trophies, customwear, pq_admin, curious, mysql, media_magic |
    +-------------------------------------------------------------+

tablesWithField - VARCHAR(1000) tablesWithField(<fieldName> CHAR(255), <dbName> CHAR(255))
------------------------------------------------------------------------------------------
 Get a list of talbes in a given database that have a field with a given name.

    select tablesWithField('product_id', 'trophies');
    +-------------------------------------------------------------+
    | tablesWithField('product_id', 'trophies')                   |
    +-------------------------------------------------------------+
    | coupon_product, order_product, product, product_description |
    +-------------------------------------------------------------+

fieldExists - BOOLEAN fieldExists(<tableName> CHAR(255), <fieldName> CHAR(255), <dbName> CHAR(255))
---------------------------------------------------------------------------------------------------
 Search for existence of a given field on a given table in a given database.

    select fieldExists('coupon_product', 'product_id', 'trophies');
    +--------------------------------------------------------+
    | fieldExists('coupon_product', 'product_id', 'trohies') |
    +--------------------------------------------------------+
    |                                                      1 |
    +--------------------------------------------------------+
