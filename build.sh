#!/bin/bash

cat \
dbsWithField.procedure.sql \
fieldExists.procedure.sql \
tablesWithField.procedure.sql \
dbsWithField.function.sql \
fieldExists.function.sql \
tablesWithField.function.sql \
> install.sql
