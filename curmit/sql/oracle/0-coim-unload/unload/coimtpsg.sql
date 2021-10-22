SET echo OFF feedback OFF head OFF linesize        102
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN tipo_soggetto                    FORMAT A1                                       HEADING 'X'
COLUMN descrizione                      FORMAT A100                                     HEADING 'X'
SELECT tipo_soggetto
      ,descrizione
  FROM coimtpsg

spool file/\coimtpsg.dat
/
spool OFF
