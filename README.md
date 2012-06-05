mysql-inspectors
================

A set of stored procedures and functions encapsulating schema inspection via information_schema.

dbsWithField
----------------------------------------------------------------
 Get a list of databases that have field on any table with a given name.

### VARCHAR(1000) dbsWithField(fieldName CHAR(255))

    select dbsWithField('product_id');
    +-------------------------------------------------------------+
    | dbsWithField('product_id')                                  |
    +-------------------------------------------------------------+
    | trophies, customwear, pq_admin, curious, mysql, media_magic |
    +-------------------------------------------------------------+

tablesWithField
------------------------------------------------------------------------------------------
 Get a list of talbes in a given database that have a field with a given name.

### VARCHAR(1000) tablesWithField(fieldName CHAR(255), dbName CHAR(255))


    select tablesWithField('product_id', 'trophies');
    +-------------------------------------------------------------+
    | tablesWithField('product_id', 'trophies')                   |
    +-------------------------------------------------------------+
    | coupon_product, order_product, product, product_description |
    +-------------------------------------------------------------+

fieldExists
---------------------------------------------------------------------------------------------------
 Search for existence of a given field on a given table in a given database.

### BOOLEAN fieldExists(fieldName CHAR(255), tableName CHAR(255), dbName CHAR(255))

    select fieldExists('product_id', 'coupon_product', 'trophies');
    +--------------------------------------------------------+
    | fieldExists('product_id', 'coupon_product', 'trohies') |
    +--------------------------------------------------------+
    |                                                      1 |
    +--------------------------------------------------------+

Installation
------------------------------
 The stored procedures and functions need to go somewhere.  You might like to create one just
 for them like __inpsectors__ or something.

 One thing you should note, the last parameter on fieldExists is optional.  If installed on the
 database on which it is run, fieldExists will check the value of database(), in that case you
 can pass NULL for the value.

 At any rate all you need to do is run the install.sql script on the database of your choice;

     mysql -u admin -p -D inspectors < install.sql