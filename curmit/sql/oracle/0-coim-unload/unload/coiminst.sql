SET echo OFF feedback OFF head OFF linesize         42
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_inst                         FORMAT A1                                       HEADING 'X'
COLUMN descr_inst                       FORMAT A40                                      HEADING 'X'
SELECT cod_inst
      ,descr_inst
  FROM coiminst

spool file/\coiminst.dat
/
spool OFF
