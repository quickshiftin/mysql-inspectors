#!/bin/bash

cat \
dbsWithField.procedure.sql \
fieldExists.procedure.sql \
tablesWithField.procedure.sql \
dbsWithField.function.sql \
fieldExists.function.sql \
tablesWithField.function.sql \
dbsWithFieldLike.procedure.sql \
tablesWithFieldLike.procedure.sql \
fieldExistsLike.procedure.sql \
dbsWithFieldLike.function.sql \
tablesWithFieldLike.function.sql \
fieldExistsLike.function.sql \
> install.sql
