DEF table_name=&1
DEF column_name=&2


-- Select da db



SELECT 'create sequence '||
       (SELECT decode ('&sequence_name' , null
                      , '&table_name' 
                      , decode ('&table_name' , '&sequence_name'
                               , '&table_name'
                               , '&sequence_name')) 
          FROM dual)||
       '_s start with '||
       (SELECT to_char(nvl(max(to_number(&column_name, '999999999999')),0) + 1
                      , '9999999999')
          FROM &table_name
          &where_condition)||
       ';'
  FROM dual

-- eseguo la query
/

UNDEF table_name
UNDEF column_name

