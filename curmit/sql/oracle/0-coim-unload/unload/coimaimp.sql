SET echo OFF feedback OFF head OFF linesize       4786
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_impianto                     FORMAT A8                                       HEADING 'X'
COLUMN cod_impianto_est                 FORMAT A10                                      HEADING 'X'
COLUMN cod_impianto_prov                FORMAT A8                                       HEADING 'X'
COLUMN descrizione                      FORMAT A50                                      HEADING 'X'
COLUMN provenienza_dati                 FORMAT A1                                       HEADING 'X'
COLUMN cod_combustibile                 FORMAT A8                                       HEADING 'X'
COLUMN cod_potenza                      FORMAT A8                                       HEADING 'X'
COLUMN potenza                          FORMAT 0999999.99                               HEADING 'X'
COLUMN potenza_utile                    FORMAT 0999999.99                               HEADING 'X'
COLUMN data_installaz                   FORMAT A10                                      HEADING 'X'
COLUMN data_attivaz                     FORMAT A10                                      HEADING 'X'
COLUMN data_rottamaz                    FORMAT A10                                      HEADING 'X'
COLUMN note                             FORMAT A4000                                    HEADING 'X'
COLUMN stato                            FORMAT A1                                       HEADING 'X'
COLUMN flag_dichiarato                  FORMAT A1                                       HEADING 'X'
COLUMN data_prima_dich                  FORMAT A10                                      HEADING 'X'
COLUMN data_ultim_dich                  FORMAT A10                                      HEADING 'X'
COLUMN cod_tpim                         FORMAT A8                                       HEADING 'X'
COLUMN consumo_annuo                    FORMAT 0999999.99                               HEADING 'X'
COLUMN n_generatori                     FORMAT 09                                       HEADING 'X'
COLUMN stato_conformita                 FORMAT A1                                       HEADING 'X'
COLUMN cod_cted                         FORMAT A8                                       HEADING 'X'
COLUMN tariffa                          FORMAT A8                                       HEADING 'X'
COLUMN cod_responsabile                 FORMAT A8                                       HEADING 'X'
COLUMN flag_resp                        FORMAT A1                                       HEADING 'X'
COLUMN cod_intestatario                 FORMAT A8                                       HEADING 'X'
COLUMN flag_intestatario                FORMAT A1                                       HEADING 'X'
COLUMN cod_proprietario                 FORMAT A8                                       HEADING 'X'
COLUMN cod_occupante                    FORMAT A8                                       HEADING 'X'
COLUMN cod_amministratore               FORMAT A8                                       HEADING 'X'
COLUMN cod_manutentore                  FORMAT A8                                       HEADING 'X'
COLUMN cod_installatore                 FORMAT A8                                       HEADING 'X'
COLUMN cod_distributore                 FORMAT A8                                       HEADING 'X'
COLUMN cod_progettista                  FORMAT A8                                       HEADING 'X'
COLUMN cod_amag                         FORMAT A10                                      HEADING 'X'
COLUMN cod_ubicazione                   FORMAT A8                                       HEADING 'X'
COLUMN localita                         FORMAT A40                                      HEADING 'X'
COLUMN cod_via                          FORMAT A8                                       HEADING 'X'
COLUMN toponimo                         FORMAT A20                                      HEADING 'X'
COLUMN indirizzo                        FORMAT A100                                     HEADING 'X'
COLUMN numero                           FORMAT A8                                       HEADING 'X'
COLUMN esponente                        FORMAT A3                                       HEADING 'X'
COLUMN scala                            FORMAT A5                                       HEADING 'X'
COLUMN piano                            FORMAT A5                                       HEADING 'X'
COLUMN interno                          FORMAT A3                                       HEADING 'X'
COLUMN cod_comune                       FORMAT A8                                       HEADING 'X'
COLUMN cod_provincia                    FORMAT A8                                       HEADING 'X'
COLUMN cap                              FORMAT A5                                       HEADING 'X'
COLUMN cod_catasto                      FORMAT A20                                      HEADING 'X'
COLUMN cod_tpdu                         FORMAT A8                                       HEADING 'X'
COLUMN cod_qua                          FORMAT A8                                       HEADING 'X'
COLUMN cod_urb                          FORMAT A8                                       HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
COLUMN flag_dpr412                      FORMAT A1                                       HEADING 'X'
COLUMN cod_impianto_dest                FORMAT A8                                       HEADING 'X'
COLUMN anno_costruzione                 FORMAT A10                                      HEADING 'X'
COLUMN marc_effic_energ                 FORMAT A10                                      HEADING 'X'
COLUMN volimetria_risc                  FORMAT 0999999.99                               HEADING 'X'
COLUMN gb_x                             FORMAT A50                                      HEADING 'X'
COLUMN gb_y                             FORMAT A50                                      HEADING 'X'
SELECT cod_impianto
      ,cod_impianto_est
      ,cod_impianto_prov
      ,descrizione
      ,provenienza_dati
      ,cod_combustibile
      ,cod_potenza
      ,potenza
      ,potenza_utile
      ,TO_CHAR(data_installaz,'YYYY-MM-DD') data_installaz
      ,TO_CHAR(data_attivaz,'YYYY-MM-DD') data_attivaz
      ,TO_CHAR(data_rottamaz,'YYYY-MM-DD') data_rottamaz
      ,note
      ,stato
      ,flag_dichiarato
      ,TO_CHAR(data_prima_dich,'YYYY-MM-DD') data_prima_dich
      ,TO_CHAR(data_ultim_dich,'YYYY-MM-DD') data_ultim_dich
      ,cod_tpim
      ,consumo_annuo
      ,n_generatori
      ,stato_conformita
      ,cod_cted
      ,tariffa
      ,cod_responsabile
      ,flag_resp
      ,cod_intestatario
      ,flag_intestatario
      ,cod_proprietario
      ,cod_occupante
      ,cod_amministratore
      ,cod_manutentore
      ,cod_installatore
      ,cod_distributore
      ,cod_progettista
      ,cod_amag
      ,cod_ubicazione
      ,localita
      ,cod_via
      ,toponimo
      ,indirizzo
      ,numero
      ,esponente
      ,scala
      ,piano
      ,interno
      ,cod_comune
      ,cod_provincia
      ,cap
      ,cod_catasto
      ,cod_tpdu
      ,cod_qua
      ,cod_urb
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
      ,flag_dpr412
      ,cod_impianto_dest
      ,TO_CHAR(anno_costruzione,'YYYY-MM-DD') anno_costruzione
      ,marc_effic_energ
      ,volimetria_risc
      ,gb_x
      ,gb_y
  FROM coimaimp

spool file/\coimaimp.dat
/
spool OFF
