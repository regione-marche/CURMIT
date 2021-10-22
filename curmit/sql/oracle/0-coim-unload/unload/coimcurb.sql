SET echo OFF feedback OFF head OFF linesize         68
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_urb                          FORMAT A8                                       HEADING 'X'
COLUMN cod_comune                       FORMAT A8                                       HEADING 'X'
COLUMN descrizione                      FORMAT A50                                      HEADING 'X'
SELECT cod_urb
      ,cod_comune
      ,descrizione
  FROM coimcurb

spool file/\coimcurb.dat
/
spool OFF
