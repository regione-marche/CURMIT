SET echo OFF feedback OFF head OFF linesize         83
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_relg                         FORMAT 09999999                                 HEADING 'X'
COLUMN cod_relt                         FORMAT 09999999                                 HEADING 'X'
COLUMN sezione                          FORMAT A1                                       HEADING 'X'
COLUMN id_clsnc                         FORMAT 0                                        HEADING 'X'
COLUMN id_stclsnc                       FORMAT 09                                       HEADING 'X'
COLUMN obj_refer                        FORMAT A1                                       HEADING 'X'
COLUMN id_pot                           FORMAT 09                                       HEADING 'X'
COLUMN id_per                           FORMAT 09                                       HEADING 'X'
COLUMN id_comb                          FORMAT 09                                       HEADING 'X'
COLUMN n                                FORMAT 099999                                   HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
SELECT cod_relg
      ,cod_relt
      ,sezione
      ,id_clsnc
      ,id_stclsnc
      ,obj_refer
      ,id_pot
      ,id_per
      ,id_comb
      ,n
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
  FROM coimrelt

spool file/\coimrelt.dat
/
spool OFF
