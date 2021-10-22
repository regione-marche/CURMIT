SET echo OFF feedback OFF head OFF linesize       4166
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_inco                         FORMAT A8                                       HEADING 'X'
COLUMN cod_cinc                         FORMAT A8                                       HEADING 'X'
COLUMN tipo_estrazione                  FORMAT A8                                       HEADING 'X'
COLUMN cod_impianto                     FORMAT A8                                       HEADING 'X'
COLUMN data_estrazione                  FORMAT A10                                      HEADING 'X'
COLUMN data_assegn                      FORMAT A10                                      HEADING 'X'
COLUMN cod_opve                         FORMAT A8                                       HEADING 'X'
COLUMN data_verifica                    FORMAT A10                                      HEADING 'X'
COLUMN ora_verifica                     FORMAT A8                                       HEADING 'X'
COLUMN data_avviso_01                   FORMAT A10                                      HEADING 'X'
COLUMN cod_documento_01                 FORMAT A8                                       HEADING 'X'
COLUMN data_avviso_02                   FORMAT A10                                      HEADING 'X'
COLUMN cod_documento_02                 FORMAT A8                                       HEADING 'X'
COLUMN stato                            FORMAT A1                                       HEADING 'X'
COLUMN esito                            FORMAT A1                                       HEADING 'X'
COLUMN note                             FORMAT A4000                                    HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
COLUMN tipo_lettera                     FORMAT A1                                       HEADING 'X'
SELECT cod_inco
      ,cod_cinc
      ,tipo_estrazione
      ,cod_impianto
      ,TO_CHAR(data_estrazione,'YYYY-MM-DD') data_estrazione
      ,TO_CHAR(data_assegn,'YYYY-MM-DD') data_assegn
      ,cod_opve
      ,TO_CHAR(data_verifica,'YYYY-MM-DD') data_verifica
      ,ora_verifica
      ,TO_CHAR(data_avviso_01,'YYYY-MM-DD') data_avviso_01
      ,cod_documento_01
      ,TO_CHAR(data_avviso_02,'YYYY-MM-DD') data_avviso_02
      ,cod_documento_02
      ,stato
      ,esito
      ,note
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
      ,tipo_lettera
  FROM coiminco

spool file/\coiminco.dat
/
spool OFF
