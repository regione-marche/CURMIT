SET echo OFF feedback OFF head OFF linesize       4018
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_enre                         FORMAT A8                                       HEADING 'X'
COLUMN cod_cimp                         FORMAT A8                                       HEADING 'X'
COLUMN testo_anom                       FORMAT A4000                                    HEADING 'X'
SELECT cod_enre
      ,cod_cimp
      ,testo_anom
  FROM coimanec

spool file/\coimanec.dat
/
spool OFF
