SET echo OFF feedback OFF head OFF linesize         49
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_cimp_dimp                    FORMAT A8                                       HEADING 'X'
COLUMN prog_anom                        FORMAT A8                                       HEADING 'X'
COLUMN tipo_anom                        FORMAT A8                                       HEADING 'X'
COLUMN cod_tanom                        FORMAT A8                                       HEADING 'X'
COLUMN dat_utile_inter                  FORMAT A10                                      HEADING 'X'
COLUMN flag_origine                     FORMAT A2                                       HEADING 'X'
SELECT cod_cimp_dimp
      ,prog_anom
      ,tipo_anom
      ,cod_tanom
      ,TO_CHAR(dat_utile_inter,'YYYY-MM-DD') dat_utile_inter
      ,flag_origine
  FROM coimanom

spool file/\coimanom.dat
/
spool OFF
