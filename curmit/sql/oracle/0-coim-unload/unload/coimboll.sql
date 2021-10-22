SET echo OFF feedback OFF head OFF linesize       4181
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_bollini                      FORMAT 099999999999.999999999999                HEADING 'X'
COLUMN cod_manutentore                  FORMAT A8                                       HEADING 'X'
COLUMN data_consegna                    FORMAT A10                                      HEADING 'X'
COLUMN nr_bollini                       FORMAT 09999999                                 HEADING 'X'
COLUMN matricola_da                     FORMAT A20                                      HEADING 'X'
COLUMN matricola_a                      FORMAT A20                                      HEADING 'X'
COLUMN pagati                           FORMAT A1                                       HEADING 'X'
COLUMN costo_unitario                   FORMAT 0999.99                                  HEADING 'X'
COLUMN nr_bollini_resi                  FORMAT 09999999                                 HEADING 'X'
COLUMN note                             FORMAT A4000                                    HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
COLUMN data_scadenza                    FORMAT A10                                      HEADING 'X'
COLUMN cod_tpbo                         FORMAT A2                                       HEADING 'X'
COLUMN imp_pagato                       FORMAT 09999999.99                              HEADING 'X'
SELECT cod_bollini
      ,cod_manutentore
      ,TO_CHAR(data_consegna,'YYYY-MM-DD') data_consegna
      ,nr_bollini
      ,matricola_da
      ,matricola_a
      ,pagati
      ,costo_unitario
      ,nr_bollini_resi
      ,note
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
      ,TO_CHAR(data_scadenza,'YYYY-MM-DD') data_scadenza
      ,cod_tpbo
      ,imp_pagato
  FROM coimboll

spool file/\coimboll.dat
/
spool OFF
