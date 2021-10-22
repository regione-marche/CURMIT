SET echo OFF feedback OFF head OFF linesize       4196
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_cinc                         FORMAT A8                                       HEADING 'X'
COLUMN descrizione                      FORMAT A40                                      HEADING 'X'
COLUMN data_inizio                      FORMAT A10                                      HEADING 'X'
COLUMN data_fine                        FORMAT A10                                      HEADING 'X'
COLUMN note                             FORMAT A4000                                    HEADING 'X'
COLUMN ctr_estrat_01                    FORMAT 09999999                                 HEADING 'X'
COLUMN ctr_estrat_02                    FORMAT 09999999                                 HEADING 'X'
COLUMN ctr_estrat_03                    FORMAT 09999999                                 HEADING 'X'
COLUMN ctr_estrat_04                    FORMAT 09999999                                 HEADING 'X'
COLUMN ctr_estrat_05                    FORMAT 09999999                                 HEADING 'X'
COLUMN ctr_estrat_06                    FORMAT 09999999                                 HEADING 'X'
COLUMN ctr_estrat_08                    FORMAT 09999999                                 HEADING 'X'
COLUMN ctr_estrat_09                    FORMAT 09999999                                 HEADING 'X'
COLUMN stato                            FORMAT A1                                       HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN id_utente                        FORMAT A10                                      HEADING 'X'
COLUMN controlli_prev                   FORMAT 0999999                                  HEADING 'X'
SELECT cod_cinc
      ,descrizione
      ,TO_CHAR(data_inizio,'YYYY-MM-DD') data_inizio
      ,TO_CHAR(data_fine,'YYYY-MM-DD') data_fine
      ,note
      ,ctr_estrat_01
      ,ctr_estrat_02
      ,ctr_estrat_03
      ,ctr_estrat_04
      ,ctr_estrat_05
      ,ctr_estrat_06
      ,ctr_estrat_08
      ,ctr_estrat_09
      ,stato
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,id_utente
      ,controlli_prev
  FROM coimcinc

spool file/\coimcinc.dat
/
spool OFF
