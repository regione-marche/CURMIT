SET echo OFF feedback OFF head OFF linesize       4073
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_impianto                     FORMAT A8                                       HEADING 'X'
COLUMN cod_manutentore                  FORMAT A8                                       HEADING 'X'
COLUMN data_ini_valid                   FORMAT A10                                      HEADING 'X'
COLUMN data_fin_valid                   FORMAT A10                                      HEADING 'X'
COLUMN note                             FORMAT A4000                                    HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
SELECT cod_impianto
      ,cod_manutentore
      ,TO_CHAR(data_ini_valid,'YYYY-MM-DD') data_ini_valid
      ,TO_CHAR(data_fin_valid,'YYYY-MM-DD') data_fin_valid
      ,note
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
  FROM coimcoma

spool file/\coimcoma.dat
/
spool OFF
