SET echo OFF feedback OFF head OFF linesize         59
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_regione                      FORMAT A8                                       HEADING 'X'
COLUMN denominazione                    FORMAT A40                                      HEADING 'X'
COLUMN flag_val                         FORMAT A1                                       HEADING 'X'
COLUMN cod_istat                        FORMAT A7                                       HEADING 'X'
SELECT cod_regione
      ,denominazione
      ,flag_val
      ,cod_istat
  FROM coimregi

spool file/\coimregi.dat
/
spool OFF
