SET echo OFF feedback OFF head OFF linesize       1154
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_movi                         FORMAT 09999999                                 HEADING 'X'
COLUMN tipo_movi                        FORMAT A2                                       HEADING 'X'
COLUMN cod_impianto                     FORMAT A8                                       HEADING 'X'
COLUMN data_scad                        FORMAT A10                                      HEADING 'X'
COLUMN importo                          FORMAT 099999999999.999999999999                HEADING 'X'
COLUMN importo_pag                      FORMAT 099999999999.999999999999                HEADING 'X'
COLUMN data_pag                         FORMAT A10                                      HEADING 'X'
COLUMN tipo_pag                         FORMAT A2                                       HEADING 'X'
COLUMN data_compet                      FORMAT A10                                      HEADING 'X'
COLUMN riferimento                      FORMAT A8                                       HEADING 'X'
COLUMN nota                             FORMAT A1000                                    HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
SELECT cod_movi
      ,tipo_movi
      ,cod_impianto
      ,TO_CHAR(data_scad,'YYYY-MM-DD') data_scad
      ,importo
      ,importo_pag
      ,TO_CHAR(data_pag,'YYYY-MM-DD') data_pag
      ,tipo_pag
      ,TO_CHAR(data_compet,'YYYY-MM-DD') data_compet
      ,riferimento
      ,nota
      ,utente
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
  FROM coimmovi

spool file/\coimmovi.dat
/
spool OFF
