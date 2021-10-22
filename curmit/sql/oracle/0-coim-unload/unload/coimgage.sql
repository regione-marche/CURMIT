SET echo OFF feedback OFF head OFF linesize       4075
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_opma                         FORMAT A8                                       HEADING 'X'
COLUMN cod_impianto                     FORMAT A8                                       HEADING 'X'
COLUMN stato                            FORMAT A1                                       HEADING 'X'
COLUMN data_prevista                    FORMAT A10                                      HEADING 'X'
COLUMN data_esecuzione                  FORMAT A10                                      HEADING 'X'
COLUMN note                             FORMAT A4000                                    HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
SELECT cod_opma
      ,cod_impianto
      ,stato
      ,TO_CHAR(data_prevista,'YYYY-MM-DD') data_prevista
      ,TO_CHAR(data_esecuzione,'YYYY-MM-DD') data_esecuzione
      ,note
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
  FROM coimgage

spool file/\coimgage.dat
/
spool OFF
