DEF table_name=&1
DEF dflt_precision=24
DEF dflt_scale=12

STORE SET 'unloadtb.tmp' replace
SET echo off
SET feedback off
SET head off
SET linesize 200
SET pagesize 0
SET space 0
SET tab off
SET trimspool on
SET termout off
SET verify off

-- lunghezza record in output
COLUMN rl NOPRINT NEW_VALUE _rowlen
SELECT SUM(DECODE(data_type ,'CHAR' ,data_length
                            ,'VARCHAR' ,data_length
                            ,'VARCHAR2' ,data_length
                            ,'DATE' ,10
                            ,'NUMBER' ,DECODE(data_precision ,'' ,&dflt_precision+2
                                                                 ,GREATEST(data_precision-data_scale ,1) + DECODE(data_scale ,0 ,0 ,1) + data_scale
                                             ) + 1
                            ,'FLOAT' ,&dflt_precision+2
                                     ,data_length
                 ) + 1
          ) - 1 rl
  FROM user_tab_columns
 WHERE table_name = UPPER('&&table_name')
   AND data_type  <> 'BLOB'
/

-- Select da db
COLUMN var1 NOPRINT
COLUMN var2 NOPRINT

-- settaggi SQL*Plus
SELECT 'A1' var1
      ,0    var2
      ,'SET echo OFF feedback OFF head OFF linesize &_rowlen '
  FROM dual
UNION
SELECT 'A2'
      ,1
      ,'SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"'
  FROM dual
UNION
-- formato colonne
SELECT 'B1'
      ,column_id
      ,'COLUMN '
    || RPAD(LOWER(column_name) ,32)
    || ' FORMAT '
    || RPAD(DECODE(data_type ,'CHAR' ,'A' || data_length
                             ,'VARCHAR2' ,'A' || data_length
                             ,'VARCHAR' ,'A' || data_length
                             ,'DATE' ,'A10'
                             ,'NUMBER' ,DECODE(data_precision ,'' ,RPAD('0' ,&dflt_precision-&dflt_scale ,'9') || '.' || RPAD('9' ,&dflt_scale ,'9')
                                                                  ,RPAD('0' ,GREATEST(data_precision - data_scale ,1) ,'9') || DECODE(data_scale ,0 ,''
                                                                                                                                                    ,'.'
                                                                                                                                     )
                                                                                                                            || DECODE(data_scale ,0 ,''
                                                                                                                                                    ,RPAD('9' ,data_scale ,'9')
                                                                                                                                     )
                                              )
                             ,'FLOAT' ,RPAD('0' ,&dflt_precision-&dflt_scale ,'9') || '.' || RPAD('9' ,&dflt_scale ,'9')
                             ,'ERROR'
                  )
           ,40)
    || ' HEADING ''X'''
  FROM user_tab_columns
 WHERE table_name = UPPER('&&table_name')
   AND data_type  <> 'BLOB'
UNION
-- select da db
SELECT 'C1'
      ,column_id
      ,DECODE(column_id ,1 ,'SELECT '
                           ,'      ,'
             )
    || DECODE(data_type ,'DATE' ,'TO_CHAR(' || LOWER(column_name) || ',''YYYY-MM-DD'') ' || LOWER(column_name)
                                ,LOWER(column_name)
             )
  FROM user_tab_columns
 WHERE table_name = UPPER('&&table_name')
   AND data_type  <> 'BLOB'
UNION
SELECT 'C2'
      ,0
      ,'  FROM &&table_name'
  FROM dual
UNION
SELECT 'C3'
      ,0
      ,DECODE(b.column_position ,1 ,' ORDER BY'
             )
  FROM user_constraints a
      ,user_ind_columns b
 WHERE b.table_name = a.table_name
   AND b.index_name = a.constraint_name
   AND a.table_name = UPPER('&&table_name')
   AND a.constraint_type = 'P'
   AND b.table_name = UPPER('&&table_name')
   AND b.column_position = 1
UNION
SELECT 'C3'
      ,b.column_position
      ,DECODE(b.column_position ,1 ,'       '
                                   ,'      ,'
             )
    || LOWER(b.column_name)
  FROM user_constraints a
      ,user_ind_columns b
 WHERE b.table_name = a.table_name
   AND b.index_name = a.constraint_name
   AND a.table_name = UPPER('&&table_name')
   AND a.constraint_type = 'P'
   AND b.table_name = UPPER('&&table_name')
UNION
SELECT 'C9'
      ,0
      ,' '
  FROM dual
UNION
-- spool
SELECT 'D1'
      ,0
      ,'spool file/\&&table_name..dat'
  FROM dual
UNION
-- esecuzione
SELECT 'D1'
      ,1
      ,'/'
  FROM dual
-- chiusura spool
UNION
SELECT 'D1'
      ,2
      ,'spool OFF'
  FROM dual
ORDER BY 1,2

REM set echo off
REM set feedback off
REM set head off
REM set pagesize 0
REM set trimspool on
REM set verify off

SPOOL unload/\&&table_name..sql
/
SPOOL OFF

@'unload\&&table_name'
@'unloadtb.tmp'

UNDEF table_name
UNDEF dflt_precision
UNDEF dflt_scale
