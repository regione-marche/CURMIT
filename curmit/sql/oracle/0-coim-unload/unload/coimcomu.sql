SET echo OFF feedback OFF head OFF linesize         97
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_comune                       FORMAT A8                                       HEADING 'X'
COLUMN cod_provincia                    FORMAT A8                                       HEADING 'X'
COLUMN denominazione                    FORMAT A40                                      HEADING 'X'
COLUMN flag_val                         FORMAT A1                                       HEADING 'X'
COLUMN cap                              FORMAT A5                                       HEADING 'X'
COLUMN id_belfiore                      FORMAT A4                                       HEADING 'X'
COLUMN cod_istat                        FORMAT A7                                       HEADING 'X'
COLUMN popolaz_citt                     FORMAT 0999999                                  HEADING 'X'
COLUMN popolaz_aimp                     FORMAT 0999999                                  HEADING 'X'
SELECT cod_comune
      ,cod_provincia
      ,denominazione
      ,flag_val
      ,cap
      ,id_belfiore
      ,cod_istat
      ,popolaz_citt
      ,popolaz_aimp
  FROM coimcomu

spool file/\coimcomu.dat
/
spool OFF
