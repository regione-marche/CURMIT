DEF table_name=&1
DEF dflt_precision=24
DEF dflt_scale=12
STORE SET 'creactl.tmp' replace
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

-- Select da db
COLUMN var1 NOPRINT
COLUMN var2 NOPRINT

SELECT 'A1' var1
      ,0 var2
      ,'--OPTIONS(DIRECT=TRUE)'
  FROM dual
UNION
SELECT 'A2'
      ,0
      ,'LOAD DATA'
  FROM dual
UNION
SELECT 'A3'
      ,0
      ,'CHARACTERSET UTF8'
  FROM dual
UNION
--SELECT 'A3'
--      ,0
--      ,'INFILE ''&&table_name..DAT'''
--  FROM dual
--UNION
--SELECT 'A4'
--      ,0
--      ,'BADFILE &&table_name..BAD'
--  FROM dual
--UNION
--SELECT 'A5'
--      ,0
--      ,'DISCARDFILE &&table_name..DSC'
--  FROM dual
--UNION
--SELECT 'A6'
--      ,0
--      ,'DISCARDMAX 999'
--  FROM dual
--UNION
SELECT 'A7'
      ,0
      ,'INTO TABLE &&table_name'
  FROM dual
UNION
SELECT 'A8'
      ,0
      ,'REPLACE'
  FROM dual
UNION
SELECT 'A9'
      ,0
      ,'FIELDS TERMINATED BY ''|'''
  FROM dual
UNION
SELECT 'A91'
      ,0
      ,'TRAILING NULLCOLS'
  FROM dual
UNION
SELECT 'C1'
      ,column_id
      ,RPAD(DECODE(column_id ,1 ,'('
                                ,','
                  ) || UPPER(column_name)
           ,31)
    || DECODE(data_type ,'CHAR' ,'CHAR(' || data_length || ')'
                        ,'VARCHAR' ,'CHAR(' || data_length || ')'
                        ,'VARCHAR2' ,'CHAR(' || data_length || ')'
                        ,'DATE' ,'DATE(10) "YYYY-MM-DD"'
                        ,'NUMBER' ,'DECIMAL EXTERNAL(' || DECODE(data_precision ,'' ,&dflt_precision+2
                                                                                    ,GREATEST(data_precision - data_scale ,1) + DECODE(data_scale ,0 ,0 ,1) + data_scale + 1) || ')'
                        ,'FLOAT', 'DECIMAL EXTERNAL(' || TO_CHAR(&dflt_precision+2) || ')'
                        ,'ERROR--' || data_type
             ) || ' NULLIF (' || UPPER(column_name) || ' = BLANKS)'
  FROM user_tab_columns
 WHERE table_name = upper('&&table_name')
UNION
SELECT 'C9'
      ,0
      ,')'
  FROM dual
 ORDER BY
       1
      ,2

REM set echo off
REM set feedback off
REM set head off
REM set pagesize 0
REM set trimspool on
REM set verify off

SPOOL ctl/&&table_name..ctl
/
SPOOL OFF

CLEAR COLUMNS
@'creactl.tmp'
UNDEF table_name
UNDEF dflt_precision
UNDEF dflt_scale
