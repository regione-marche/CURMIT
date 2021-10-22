SET echo OFF feedback OFF head OFF linesize         82
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN id_settore                       FORMAT A20                                      HEADING 'X'
COLUMN descrizione                      FORMAT A50                                      HEADING 'X'
COLUMN responsabile                     FORMAT A10                                      HEADING 'X'
SELECT id_settore
      ,descrizione
      ,responsabile
  FROM coimsett

spool file/\coimsett.dat
/
spool OFF
