SET echo OFF feedback OFF head OFF linesize         23
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_tpbo                         FORMAT A2                                       HEADING 'X'
COLUMN descr_tpbo                       FORMAT A20                                      HEADING 'X'
SELECT cod_tpbo
      ,descr_tpbo
  FROM coimtpbo

spool file/\coimtpbo.dat
/
spool OFF
