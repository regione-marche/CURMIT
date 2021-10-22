SET echo OFF feedback OFF head OFF linesize        103
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN tipo_documento                   FORMAT A2                                       HEADING 'X'
COLUMN descrizione                      FORMAT A100                                     HEADING 'X'
SELECT tipo_documento
      ,descrizione
  FROM coimtdoc

spool file/\coimtdoc.dat
/
spool OFF
