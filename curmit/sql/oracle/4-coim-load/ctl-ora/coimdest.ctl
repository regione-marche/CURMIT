--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coimdest
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
)