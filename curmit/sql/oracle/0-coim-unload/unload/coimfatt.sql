SET echo OFF feedback OFF head OFF linesize       4567
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_fatt                         FORMAT A8                                       HEADING 'X'
COLUMN data_fatt                        FORMAT A10                                      HEADING 'X'
COLUMN num_fatt                         FORMAT A10                                      HEADING 'X'
COLUMN cod_sogg                         FORMAT A8                                       HEADING 'X'
COLUMN tipo_sogg                        FORMAT A1                                       HEADING 'X'
COLUMN imponibile                       FORMAT 099999.99                                HEADING 'X'
COLUMN perc_iva                         FORMAT 099.99                                   HEADING 'X'
COLUMN flag_pag                         FORMAT A1                                       HEADING 'X'
COLUMN matr_da                          FORMAT A20                                      HEADING 'X'
COLUMN matr_a                           FORMAT A20                                      HEADING 'X'
COLUMN n_bollini                        FORMAT 099999999999.999999999999                HEADING 'X'
COLUMN nota                             FORMAT A4000                                    HEADING 'X'
COLUMN mod_pag                          FORMAT A400                                     HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN id_utente                        FORMAT A10                                      HEADING 'X'
SELECT cod_fatt
      ,TO_CHAR(data_fatt,'YYYY-MM-DD') data_fatt
      ,num_fatt
      ,cod_sogg
      ,tipo_sogg
      ,imponibile
      ,perc_iva
      ,flag_pag
      ,matr_da
      ,matr_a
      ,n_bollini
      ,nota
      ,mod_pag
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,id_utente
  FROM coimfatt

spool file/\coimfatt.dat
/
spool OFF
