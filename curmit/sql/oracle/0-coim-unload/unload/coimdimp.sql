SET echo OFF feedback OFF head OFF linesize      44611
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_dimp                         FORMAT A8                                       HEADING 'X'
COLUMN cod_impianto                     FORMAT A8                                       HEADING 'X'
COLUMN data_controllo                   FORMAT A10                                      HEADING 'X'
COLUMN gen_prog                         FORMAT 09999999                                 HEADING 'X'
COLUMN cod_manutentore                  FORMAT A8                                       HEADING 'X'
COLUMN cod_responsabile                 FORMAT A8                                       HEADING 'X'
COLUMN cod_proprietario                 FORMAT A8                                       HEADING 'X'
COLUMN cod_occupante                    FORMAT A8                                       HEADING 'X'
COLUMN cod_documento                    FORMAT A8                                       HEADING 'X'
COLUMN flag_status                      FORMAT A1                                       HEADING 'X'
COLUMN garanzia                         FORMAT A1                                       HEADING 'X'
COLUMN conformita                       FORMAT A1                                       HEADING 'X'
COLUMN lib_impianto                     FORMAT A1                                       HEADING 'X'
COLUMN lib_uso_man                      FORMAT A1                                       HEADING 'X'
COLUMN inst_in_out                      FORMAT A1                                       HEADING 'X'
COLUMN idoneita_locale                  FORMAT A1                                       HEADING 'X'
COLUMN ap_ventilaz                      FORMAT A1                                       HEADING 'X'
COLUMN ap_vent_ostruz                   FORMAT A1                                       HEADING 'X'
COLUMN pendenza                         FORMAT A1                                       HEADING 'X'
COLUMN sezioni                          FORMAT A1                                       HEADING 'X'
COLUMN curve                            FORMAT A1                                       HEADING 'X'
COLUMN lunghezza                        FORMAT A1                                       HEADING 'X'
COLUMN conservazione                    FORMAT A1                                       HEADING 'X'
COLUMN scar_ca_si                       FORMAT A1                                       HEADING 'X'
COLUMN scar_parete                      FORMAT A1                                       HEADING 'X'
COLUMN riflussi_locale                  FORMAT A1                                       HEADING 'X'
COLUMN assenza_perdite                  FORMAT A1                                       HEADING 'X'
COLUMN pulizia_ugelli                   FORMAT A1                                       HEADING 'X'
COLUMN antivento                        FORMAT A1                                       HEADING 'X'
COLUMN scambiatore                      FORMAT A1                                       HEADING 'X'
COLUMN accens_reg                       FORMAT A1                                       HEADING 'X'
COLUMN disp_comando                     FORMAT A1                                       HEADING 'X'
COLUMN ass_perdite                      FORMAT A1                                       HEADING 'X'
COLUMN valvola_sicur                    FORMAT A1                                       HEADING 'X'
COLUMN vaso_esp                         FORMAT A1                                       HEADING 'X'
COLUMN disp_sic_manom                   FORMAT A1                                       HEADING 'X'
COLUMN organi_integri                   FORMAT A1                                       HEADING 'X'
COLUMN circ_aria                        FORMAT A1                                       HEADING 'X'
COLUMN guarn_accop                      FORMAT A1                                       HEADING 'X'
COLUMN assenza_fughe                    FORMAT A1                                       HEADING 'X'
COLUMN coibentazione                    FORMAT A1                                       HEADING 'X'
COLUMN eff_evac_fum                     FORMAT A1                                       HEADING 'X'
COLUMN cont_rend                        FORMAT A1                                       HEADING 'X'
COLUMN pot_focolare_mis                 FORMAT 0999.99                                  HEADING 'X'
COLUMN portata_comb_mis                 FORMAT 0999.99                                  HEADING 'X'
COLUMN temp_fumi                        FORMAT 0999.99                                  HEADING 'X'
COLUMN temp_ambi                        FORMAT 0999.99                                  HEADING 'X'
COLUMN o2                               FORMAT 0999.99                                  HEADING 'X'
COLUMN co2                              FORMAT 0999.99                                  HEADING 'X'
COLUMN bacharach                        FORMAT 0999.99                                  HEADING 'X'
COLUMN co                               FORMAT 099999.9999                              HEADING 'X'
COLUMN rend_combust                     FORMAT 0999.99                                  HEADING 'X'
COLUMN osservazioni                     FORMAT A4000                                    HEADING 'X'
COLUMN raccomandazioni                  FORMAT A4000                                    HEADING 'X'
COLUMN prescrizioni                     FORMAT A4000                                    HEADING 'X'
COLUMN data_utile_inter                 FORMAT A10                                      HEADING 'X'
COLUMN n_prot                           FORMAT A20                                      HEADING 'X'
COLUMN data_prot                        FORMAT A10                                      HEADING 'X'
COLUMN delega_resp                      FORMAT A50                                      HEADING 'X'
COLUMN delega_manut                     FORMAT A50                                      HEADING 'X'
COLUMN num_bollo                        FORMAT A20                                      HEADING 'X'
COLUMN costo                            FORMAT 0999.99                                  HEADING 'X'
COLUMN tipologia_costo                  FORMAT A2                                       HEADING 'X'
COLUMN riferimento_pag                  FORMAT A20                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN potenza                          FORMAT 0999999.99                               HEADING 'X'
COLUMN flag_pericolosita                FORMAT A1                                       HEADING 'X'
COLUMN flag_co_perc                     FORMAT A1                                       HEADING 'X'
COLUMN flag_tracciato                   FORMAT A2                                       HEADING 'X'
COLUMN cod_docu_distinta                FORMAT A8                                       HEADING 'X'
COLUMN scar_can_fu                      FORMAT A1                                       HEADING 'X'
COLUMN tiraggio                         FORMAT 0999999.99                               HEADING 'X'
COLUMN ora_inizio                       FORMAT A8                                       HEADING 'X'
COLUMN ora_fine                         FORMAT A8                                       HEADING 'X'
COLUMN rapp_contr                       FORMAT A1                                       HEADING 'X'
COLUMN rapp_contr_note                  FORMAT A4000                                    HEADING 'X'
COLUMN certificaz                       FORMAT A1                                       HEADING 'X'
COLUMN certificaz_note                  FORMAT A4000                                    HEADING 'X'
COLUMN dich_conf                        FORMAT A1                                       HEADING 'X'
COLUMN dich_conf_note                   FORMAT A4000                                    HEADING 'X'
COLUMN libretto_bruc                    FORMAT A1                                       HEADING 'X'
COLUMN libretto_bruc_note               FORMAT A4000                                    HEADING 'X'
COLUMN prev_incendi                     FORMAT A1                                       HEADING 'X'
COLUMN prev_incendi_note                FORMAT A4000                                    HEADING 'X'
COLUMN lib_impianto_note                FORMAT A4000                                    HEADING 'X'
COLUMN ispesl                           FORMAT A1                                       HEADING 'X'
COLUMN ispesl_note                      FORMAT A4000                                    HEADING 'X'
COLUMN data_scadenza                    FORMAT A10                                      HEADING 'X'
COLUMN num_autocert                     FORMAT A20                                      HEADING 'X'
COLUMN esame_vis_l_elet                 FORMAT A1                                       HEADING 'X'
COLUMN funz_corr_bruc                   FORMAT A1                                       HEADING 'X'
COLUMN lib_uso_man_note                 FORMAT A4000                                    HEADING 'X'
COLUMN volimetria_risc                  FORMAT 0999999.99                               HEADING 'X'
COLUMN cunsumo_annuo                    FORMAT 0999999.99                               HEADING 'X'
SELECT cod_dimp
      ,cod_impianto
      ,TO_CHAR(data_controllo,'YYYY-MM-DD') data_controllo
      ,gen_prog
      ,cod_manutentore
      ,cod_responsabile
      ,cod_proprietario
      ,cod_occupante
      ,cod_documento
      ,flag_status
      ,garanzia
      ,conformita
      ,lib_impianto
      ,lib_uso_man
      ,inst_in_out
      ,idoneita_locale
      ,ap_ventilaz
      ,ap_vent_ostruz
      ,pendenza
      ,sezioni
      ,curve
      ,lunghezza
      ,conservazione
      ,scar_ca_si
      ,scar_parete
      ,riflussi_locale
      ,assenza_perdite
      ,pulizia_ugelli
      ,antivento
      ,scambiatore
      ,accens_reg
      ,disp_comando
      ,ass_perdite
      ,valvola_sicur
      ,vaso_esp
      ,disp_sic_manom
      ,organi_integri
      ,circ_aria
      ,guarn_accop
      ,assenza_fughe
      ,coibentazione
      ,eff_evac_fum
      ,cont_rend
      ,pot_focolare_mis
      ,portata_comb_mis
      ,temp_fumi
      ,temp_ambi
      ,o2
      ,co2
      ,bacharach
      ,co
      ,rend_combust
      ,osservazioni
      ,raccomandazioni
      ,prescrizioni
      ,TO_CHAR(data_utile_inter,'YYYY-MM-DD') data_utile_inter
      ,n_prot
      ,TO_CHAR(data_prot,'YYYY-MM-DD') data_prot
      ,delega_resp
      ,delega_manut
      ,num_bollo
      ,costo
      ,tipologia_costo
      ,riferimento_pag
      ,utente
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,potenza
      ,flag_pericolosita
      ,flag_co_perc
      ,flag_tracciato
      ,cod_docu_distinta
      ,scar_can_fu
      ,tiraggio
      ,ora_inizio
      ,ora_fine
      ,rapp_contr
      ,rapp_contr_note
      ,certificaz
      ,certificaz_note
      ,dich_conf
      ,dich_conf_note
      ,libretto_bruc
      ,libretto_bruc_note
      ,prev_incendi
      ,prev_incendi_note
      ,lib_impianto_note
      ,ispesl
      ,ispesl_note
      ,TO_CHAR(data_scadenza,'YYYY-MM-DD') data_scadenza
      ,num_autocert
      ,esame_vis_l_elet
      ,funz_corr_bruc
      ,lib_uso_man_note
      ,volimetria_risc
      ,cunsumo_annuo
  FROM coimdimp

spool file/\coimdimp.dat
/
spool OFF
