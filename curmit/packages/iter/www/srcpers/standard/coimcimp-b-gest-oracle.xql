<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_cimp_cod_impianto">
       <querytext>
           select cod_impianto
             from coimcimp
            where cod_cimp = :cod_cimp
       </querytext>
    </fullquery>

    <fullquery name="sel_enve_opve">
       <querytext>
           select nvl(o.cognome,'')
               || ' '
               || nvl(o.nome,'') 
               || ' - '
               || nvl(e.ragione_01,'') as des_opve
                , o.cod_opve
             from coimopve o
                , coimenve e
            where e.cod_enve = o.cod_enve
           $where_enve_opve
         order by e.ragione_01
                , o.cognome
                , o.nome
                , o.cod_opve
       </querytext>
    </fullquery>

    <fullquery name="sel_cimp_esito_negativo">
       <querytext>
           select '1'
             from coimcimp
            where cod_cimp = :cod_cimp
              and (   manutenzione_8a   = 'N'
                   or co_fumi_secchi_8b = 'N'
                   or indic_fumosita_8c = 'N'
                   or rend_comb_8d      = 'N')
       </querytext>
    </fullquery>

    <fullquery name="sel_gend_list">
       <querytext>
           select gen_prog
             from coimgend
            where cod_impianto = :cod_impianto
	      and flag_attivo  = 'S'
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp">
       <querytext>
           select iter_edit.data(a.data_installaz) as aimp_data_installaz
                , a.potenza            as aimp_pot_focolare_nom
		, a.potenza_utile      as aimp_pot_utile_nom
		, a.cod_combustibile   as aimp_cod_combustibile
		, a.cod_responsabile   as aimp_cod_responsabile
		, a.flag_resp          as aimp_flag_resp
                , a.cod_occupante      as aimp_cod_occupante
                , a.cod_proprietario   as aimp_cod_proprietario
                , a.cod_intestatario   as aimp_cod_intestatario
                , a.cod_amministratore as aimp_cod_amministratore
		, b.cognome            as aimp_cogn_resp
		, b.nome               as aimp_nome_resp
                , case a.flag_resp
                      when 'P' then 'il Proprietario'
                      when 'O' then 'l''Occupante'
                      when 'A' then 'l''Amministratore'
                      when 'I' then 'l''Intestatario'
                      when 'T' then 'un Terzo'
                      else 'Non noto'
                  end                  as aimp_flag_resp_desc
                , case a.cod_tpim
                      when 'A' then 'Singola unit&agrave; immobiliare'
                      when 'C' then 'Pi&ugrave; unit&agrave; immobiliari'
                      when '0' then 'Non noto'
                      else 'Non Noto;'
                  end                  as aimp_tipologia
                , c.descr_cted         as aimp_categoria_edificio
                , d.descr_tpdu         as aimp_dest_uso
                , iter_edit.num(a.volimetria_risc,2) as aimp_volumetria_risc
                , iter_edit.num(a.consumo_annuo,2) as aimp_consumo_annuo
             from coimaimp a
                , coimcitt b
                , coimcted c
                , coimtpdu d
            where a.cod_impianto      =  :cod_impianto
              and b.cod_cittadino (+) = a.cod_responsabile
              and c.cod_cted      (+) = a.cod_cted
              and d.cod_tpdu      (+) = a.cod_tpdu
       </querytext>
    </fullquery>

    <fullquery name="sel_gend">
       <querytext>
           select a.gen_prog_est       as gend_gen_prog_est
                , a.pot_focolare_nom   as gend_pot_focolare_nom
                , a.pot_utile_nom      as gend_pot_utile_nom
                , a.matricola          as gend_matricola
                , a.modello            as gend_modello
                , a.matricola_bruc     as gend_matricola_bruc
                , a.modello_bruc       as gend_modello_bruc
                , a.cod_combustibile   as gend_cod_combustibile
                , h.descr_comb         as gend_descr_comb  
                , b.descr_utgi         as gend_descr_utgi
                , c.descr_fuge         as gend_descr_fuge
                , d.descr_cost         as gend_descr_cost
                , iter_edit.data(a.data_installaz) as gend_data_installaz
                , case a.tipo_foco
                     when 'A' then 'Aperto'
                     when 'C' then 'Chiuso'
                     else 'Non Noto'
                  end                  as gend_tipo_focolare
                , case a.tiraggio
                     when 'F' then 'Forzato'
                     when 'N' then 'Naturale'
                     else 'Non Noto'
                  end                  as gend_tiraggio
                , a.modello            as gend_modello
                , a.matricola          as gend_matricola
                , case a.tipo_bruciatore
                     when 'A' then 'Atmosferico'
                     when 'P' then 'Soffiato'
                     when 'M' then 'Premiscelato'
                     else 'Non Noto'
                  end                  as gend_tipo_bruciatore
                , e.descr_cost         as gend_descr_cost_bruc
                , a.modello_bruc       as gend_modello_bruc
                , a.matricola_bruc     as gend_matricola_bruc
                , iter_edit.num(a.pot_focolare_lib, 2) as gend_pot_focolare_lib_edit
                , iter_edit.num(a.pot_utile_lib, 2)    as gend_pot_utile_lib_edit
                , f.descr_utgi         as gend_destinazione_uso
                , case a.locale 
                      when 'T' then 'Tecnico'
                      when 'E' then 'Esterno'
                      when 'I' then 'Interno'
                      else 'Non Noto'
                  end                  as gend_tipologia_locale
                , g.descr_fuge         as gend_fluido_termovettore
                , case a.cod_emissione 
                     when '0' then 'Canna fumaria non verificabile'
                     when 'C' then 'Canna fumaria collettiva al tetto'
                     when 'I' then 'Canna fumaria singola al tetto'
                     when 'P' then 'Scarico direttamente all''''esterno'
                     else 'Non Noto'
                  end                  as gend_tipologia_emissione 
                , case a.dpr_660_96
                     when 'S' then 'Standard'
                     when 'B' then 'A bassa temperatura'
                     when 'G' then 'A gas a condensazione'
                     else 'Non Noto'
                  end as gend_dpr_660_96
                , iter_edit.data(a.data_installaz) as gend_data_installazione
                , iter_edit_num(a.campo_funzion_max, 2) as campo_funzion_max
                , iter_edit_num(a.campo_funzion_min, 2) as campo_funzion_min
             from coimgend a
                , coimutgi b
                , coimfuge c
                , coimcost d
                , coimcost e
                , coimutgi f
                , coimfuge g
                , coimcomb h
            where a.cod_impianto = :cod_impianto
              and a.gen_prog     = :gen_prog
              and b.cod_utgi         (+) = a.cod_utgi
              and c.cod_fuge         (+) = a.mod_funz
              and d.cod_cost         (+) = a.cod_cost
              and e.cod_cost         (+) = a.cod_cost_bruc
              and f.cod_utgi         (+) = a.cod_utgi
              and g.cod_fuge         (+) = a.mod_funz
              and h.cod_combustibile (+) = a.cod_combustibile
       </querytext>
    </fullquery>

    <fullquery name="sel_gend_min">
       <querytext>
           select min(gen_prog_est)
             from coimgend
            where cod_impianto = :cod_impianto
	      and flag_attivo  = 'S'
       </querytext>
    </fullquery>

    <fullquery name="sel_cimp_esito">
       <querytext>
           select esito_verifica    as cimp_esito_verifica
                , flag_pericolosita as cimp_flag_pericolosita
             from coimcimp
            where cod_cimp = :cod_cimp
       </querytext>
    </fullquery>

    <fullquery name="sel_pote_cod_potenza">
       <querytext>
           select cod_potenza
             from coimpote
            where potenza_min <= :h_potenza
              and potenza_max >= :h_potenza
       </querytext>
    </fullquery>

    <fullquery name="sel_tari">
       <querytext>
           select a.importo
             from coimtari a
            where a.cod_potenza = :cod_potenza
              and a.tipo_costo  = :tipo_costo
              and a.cod_listino = :cod_listino
              and a.data_inizio = (select max(d.data_inizio) 
                                     from coimtari d 
                                    where d.cod_potenza  = :cod_potenza
                                      and d.cod_listino  = :cod_listino
                                      and d.tipo_costo   = :tipo_costo
                                      and d.data_inizio <=  current_date)
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_default">
       <querytext>
           select a.cod_inco
                , a.data_verifica
             from coiminco a
                , coimcinc b
            where a.cod_impianto =  :cod_impianto
              and b.cod_cinc     = a.cod_cinc
              and b.stato        =  '1'
         order by a.data_verifica desc
                , a.cod_inco      desc
       </querytext>
    </fullquery>

    <fullquery name="sel_cimp_inco_count">
       <querytext>
           select count(*)
             from coimcimp
            where cod_inco = :cod_inco
       </querytext>
    </fullquery>

    <fullquery name="sel_inco">
       <querytext>
           select data_assegn
                , cod_cinc
                , cod_impianto  as inco_cod_impianto
                , iter_edit.data(data_verifica) as inco_data_verifica
                , cod_opve      as inco_cod_opve
             from coiminco
            where cod_inco = :cod_inco
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp_data_controllo_max">
       <querytext>
           select iter_edit.data(max(data_controllo)) as dimp_data_controllo_max
             from coimdimp
            where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_citt">
       <querytext>
           select cod_cittadino
             from coimcitt
            where cognome   $eq_cognome
              and nome      $eq_nome
       </querytext>
    </fullquery>

    <fullquery name="sel_cinc">
       <querytext>
           select to_char(data_inizio,'yyyymmdd') as cinc_data_inizio
                , to_char(data_fine,'yyyymmdd')   as cinc_data_fine
             from coimcinc
            where cod_cinc = :cod_cinc
       </querytext>
    </fullquery>

    <fullquery name="sel_cimp_count_dup">
       <querytext>
           select count(*)
             from coimcimp
            where cod_impianto   = :cod_impianto
              and gen_prog       = :gen_prog
              and data_controllo = :data_controllo
           $where_cod_cimp
        </querytext>
    </fullquery>

    <fullquery name="sel_anom_count_dup">
       <querytext>
           select count(*)
             from coimanom
            where cod_cimp_dimp = :cod_cimp
              and cod_tanom     = :cod_anom_db
	      and flag_origine  = 'RV'
	      and prog_anom     > :prog_anom_max
	      and prog_anom    <> :prog_anom_db
       </querytext>
    </fullquery>

    <fullquery name="sel_tano">
       <querytext>
           select cod_tano||' '||nvl(descr_tano, '') as note
             from coimtano
            where cod_tano = :cod_anom_db
       </querytext>
    </fullquery>

    <fullquery name="sel_tano_scatenante">
       <querytext>
           select flag_scatenante
             from coimtano 
            where cod_tano = :cod_anomalia
       </querytext>
    </fullquery>

    <fullquery name="sel_comb">
       <querytext>
           select descr_comb 
             from coimcomb
            where cod_combustibile = :cod_combustibile
       </querytext>
    </fullquery>

    <fullquery name="sel_dual_cod_cimp">
       <querytext>
           select coimcimp_s.nextval as cod_cimp
             from dual
       </querytext>
    </fullquery>

    <partialquery name="ins_cimp">
       <querytext>
           insert
             into coimcimp 
                ( cod_cimp
                , cod_impianto
                , gen_prog
                , cod_inco
                , data_controllo
                , cod_opve
                , costo
                , nominativo_pres
                , presenza_libretto
                , libretto_corretto
                , dich_conformita
                , libretto_manutenz
                , mis_port_combust
                , mis_pot_focolare
                , verifica_areaz
                , rend_comb_conv
                , rend_comb_min
                , temp_fumi_md
                , t_aria_comb_md
                , temp_mant_md
                , temp_h2o_out_md
                , co2_md
                , o2_md
                , co_md
                , indic_fumosita_1a
                , indic_fumosita_2a
                , indic_fumosita_3a
                , indic_fumosita_md
                , manutenzione_8a
                , co_fumi_secchi_8b
                , indic_fumosita_8c
                , rend_comb_8d
                , esito_verifica
                , note_verificatore
                , note_resp
                , note_conf
                , tipologia_costo
                , riferimento_pag
                , pot_utile_nom
                , pot_focolare_nom
                , cod_combustibile
                , cod_responsabile
                , flag_pericolosita
                , data_ins
                , utente
                , flag_tracciato
                , new1_data_dimp
                , new1_data_paga_dimp
                , new1_conf_accesso
                , new1_pres_intercet
                , new1_pres_interrut
                , new1_asse_mate_estr
                , new1_pres_mezzi
                , new1_pres_cartell
                , new1_lavoro_nom_iniz
                , new1_lavoro_nom_fine
                , new1_lavoro_lib_iniz
                , new1_lavoro_lib_fine
                , new1_note_manu
                , new1_dimp_pres
                , new1_dimp_prescriz
                , new1_data_ultima_manu
                , new1_data_ultima_anal
                , new1_manu_prec_8a
                , new1_co_rilevato
                , new1_flag_peri_8p
                , n_prot
                , data_prot
                , volumetria
                , comsumi_ultima_stag
                , temp_h2o_out_1a
                , temp_h2o_out_2a
                , temp_h2o_out_3a
                , t_aria_comb_1a
                , t_aria_comb_2a
                , t_aria_comb_3a
                , temp_fumi_1a
                , temp_fumi_2a
                , temp_fumi_3a
                , co_1a
                , co_2a
                , co_3a
                , co2_1a
                , co2_2a
                , co2_3a
                , o2_1a
                , o2_2a
                , o2_3a
                , strumento
                , marca_strum
                , modello_strum
                , matr_strum
                , ubic_locale_norma
                , doc_ispesl
                , libr_manut_bruc
                , conf_imp_elettrico
                , doc_prev_incendi	        
           )
           values 
                (:cod_cimp
                ,:cod_impianto
                ,:gen_prog
                ,:cod_inco
                ,:data_controllo
                ,:cod_opve
                ,:costo
                ,:nominativo_pres
                ,:presenza_libretto
                ,:libretto_corretto
                ,:dich_conformita
                ,:libretto_manutenz
                ,:mis_port_combust
                ,:mis_pot_focolare
                ,:verifica_areaz
                ,:rend_comb_conv
                ,:rend_comb_min
                ,:temp_fumi_md
                ,:t_aria_comb_md
                ,:temp_mant_md
                ,:temp_h2o_out_md
                ,:co2_md
                ,:o2_md
                ,:co_md
                ,:indic_fumosita_1a
                ,:indic_fumosita_2a
                ,:indic_fumosita_3a
                ,:indic_fumosita_md
                ,:manutenzione_8a
                ,:co_fumi_secchi_8b
                ,:indic_fumosita_8c
                ,:rend_comb_8d
                ,:esito_verifica
                ,:note_verificatore
                ,:note_resp
                ,:note_conf
                ,:tipologia_costo
                ,:riferimento_pag
                ,:pot_utile_nom
                ,:pot_focolare_nom
                ,:cod_combustibile
                ,:cod_responsabile
                ,:flag_pericolosita
                , current_date
                ,:id_utente
                ,'AB'
                ,:new1_data_dimp
                ,:new1_data_paga_dimp
                ,:new1_conf_accesso
                ,:new1_pres_intercet
                ,:new1_pres_interrut
                ,:new1_asse_mate_estr
                ,:new1_pres_mezzi
                ,:new1_pres_cartell
                ,:new1_lavoro_nom_iniz
                ,:new1_lavoro_nom_fine
                ,:new1_lavoro_lib_iniz
                ,:new1_lavoro_lib_fine
                ,:new1_note_manu
                ,:new1_dimp_pres
                ,:new1_dimp_prescriz
                ,:new1_data_ultima_manu
                ,:new1_data_ultima_anal
                ,:new1_manu_prec_8a
                ,:new1_co_rilevato
                ,:new1_flag_peri_8p
                ,:n_prot
                ,:data_prot
                ,:volumetria
                ,:comsumi_ultima_stag
                ,:temp_h2o_out_1a
                ,:temp_h2o_out_2a
                ,:temp_h2o_out_3a
                ,:t_aria_comb_1a
                ,:t_aria_comb_2a
                ,:t_aria_comb_3a
                ,:temp_fumi_1a
                ,:temp_fumi_2a
                ,:temp_fumi_3a
                ,:co_1a
                ,:co_2a
                ,:co_3a
                ,:co2_1a
                ,:co2_2a
                ,:co2_3a
                ,:o2_1a
                ,:o2_2a
                ,:o2_3a
                ,:strumento
                ,:marca_strum
                ,:modello_strum
                ,:matr_strum
                ,:ubic_locale_norma
                ,:doc_ispesl
                ,:libr_manut_bruc
                ,:conf_imp_elettrico
                ,:doc_prev_incendi	        
                )
       </querytext>
    </partialquery>

    <partialquery name="upd_aimp_utente">
       <querytext>
           update coimaimp
              set data_mod     =  current_date
                , utente       = :id_utente
            where cod_impianto = :cod_impianto
       </querytext>
    </partialquery>

    <partialquery name="upd_aimp_volumetria">
       <querytext>
           update coimaimp
              set volimetria_risc = :volumetria
            where cod_impianto     = :cod_impianto
       </querytext>
    </partialquery>

    <partialquery name="upd_aimp_consumi">
       <querytext>
           update coimaimp
              set consumo_annuo = :comsumi_ultima_stag
            where cod_impianto     = :cod_impianto
       </querytext>
    </partialquery>

    <partialquery name="upd_aimp_resp">
       <querytext>
           update coimaimp
              set cod_responsabile = :cod_responsabile_upd
	        , flag_resp        = :flag_resp
                , data_mod         =  current_date
                , utente           = :id_utente
	    where cod_impianto     = :cod_impianto
       </querytext>
    </partialquery>

    <fullquery name="sel_rife_check">
       <querytext>
           select '1'
             from coimrife
            where cod_impianto   = :cod_impianto
              and ruolo          = :ruolo
              and data_fin_valid = (current_date - 1)
       </querytext>
    </fullquery>

    <partialquery name="ins_rife">
       <querytext>
           insert
             into coimrife
                ( cod_impianto
                , ruolo
                , data_fin_valid 
                , cod_soggetto
                , data_ins
                , utente)
           values
                (:cod_impianto
                ,:ruolo
                ,(current_date - 1)
                ,:cod_soggetto_old
                , current_date
                ,:id_utente
                )
       </querytext>
    </partialquery>

    <fullquery name="sel_gend_count">
       <querytext>
           select count(*)
	     from coimgend
	    where cod_impianto = :cod_impianto
              and flag_attivo  = 'S'
       </querytext>
    </fullquery>

    <fullquery name="sel_gend_sum_pot_focolare_nom">
       <querytext>
           select sum(pot_focolare_nom)
             from coimgend
            where cod_impianto = :cod_impianto
              and gen_prog    <> :gen_prog
              and flag_attivo  = 'S'
       </querytext>
    </fullquery>

    <partialquery name="upd_aimp_pote">
       <querytext>
           update coimaimp
	      set potenza          = :pot_focolare_nom_upd
	        , potenza_utile    = :pot_utile_nom_upd
	        , cod_potenza      = :cod_potenza
                , data_mod         =  current_date
                , utente           = :id_utente
            where cod_impianto     = :cod_impianto
       </querytext>
    </partialquery>

    <partialquery name="upd_aimp_comb">
       <querytext>
           update coimaimp
	      set cod_combustibile = :cod_combustibile
            where cod_impianto     = :cod_impianto
       </querytext>
    </partialquery>

    <partialquery name="upd_gend">
       <querytext>
	   update coimgend 
	      set cod_combustibile = :cod_combustibile_upd
	        , pot_focolare_nom = :pot_focolare_nom_upd
                , pot_utile_nom    = :pot_utile_nom_upd
            where cod_impianto     = :cod_impianto
	      and gen_prog         = :gen_prog
       </querytext>
    </partialquery>

    <fullquery name="sel_dual_cod_todo">
       <querytext>
           select 'coimtodo_s'.nextval as cod_todo
             from dual
       </querytext>
    </fullquery>

    <partialquery name="ins_todo">
       <querytext>
           insert
             into coimtodo
                ( cod_todo
                , cod_impianto
                , tipologia
                , note
                , cod_cimp_dimp
                , flag_evasione
                , data_evasione
                , data_evento
                , data_scadenza
                , data_ins
                , utente)
           values
		(:cod_todo
		,:cod_impianto
		,:tipologia
		,:note
		,:cod_cimp
                ,:flag_evasione
                ,:data_evasione
                ,:data_evento
                ,:data_scadenza
                , current_date
                ,:id_utente
                )
       </querytext>
    </partialquery>

    <fullquery name="sel_tano_anom">
        <querytext>
           select a.cod_tanom       as cod_tanom_check 
                , b.flag_scatenante as flag_scatenante_check
             from coimanom a
                , coimtano b
            where a.cod_cimp_dimp = :cod_cimp
	      and a.flag_origine  = 'RV'
	      and b.cod_tano      = a.cod_tanom
        </querytext>
    </fullquery>

    <partialquery name="upd_aimp_stato">
       <querytext>
           update coimaimp
              set stato_conformita = :stato_conformita
            where cod_impianto     = :cod_impianto
       </querytext>
    </partialquery>

    <fullquery name="sel_dual_cod_movi">
       <querytext>
           select coimmovi.nextval as cod_movi
             from dual
       </querytext>
    </fullquery>

    <partialquery name="ins_movi">
       <querytext>
           insert
             into coimmovi 
                ( cod_movi
                , tipo_movi
                , cod_impianto
                , data_scad
                , data_compet
                , importo
                , importo_pag
                , riferimento
                , data_pag
                , tipo_pag
                , data_ins
                , utente)
           values 
                (:cod_movi
                ,'VC'
                ,:cod_impianto
                ,:data_scad_pagamento
                ,:data_controllo
                ,:costo
                ,:importo_pag
                ,:cod_cimp
                ,:data_pag
                ,:tipologia_costo
                , current_date
                ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_movi">
       <querytext>
           update coimmovi
              set data_scad    = :data_scad_pagamento
                , data_compet  = :data_controllo
                , importo      = :costo
                , importo_pag  = :importo_pag
                , data_pag     = :data_pag
                , tipo_pag     = :tipologia_costo
                , data_mod     =  current_date
                , utente       = :id_utente
            where cod_movi     = :cod_movi                 
       </querytext>
    </partialquery>

    <fullquery name="sel_movi_check">
       <querytext>
           select cod_movi 
             from coimmovi
            where riferimento  = :cod_cimp
              and cod_impianto = :cod_impianto
              and tipo_movi    = 'VC'
       </querytext>
    </fullquery>

    <partialquery name="upd_inco">
       <querytext>
           update coiminco
              set cod_opve      = :cod_opve
                , data_verifica = :data_controllo
                , esito         = :esito_verifica
                , stato         = '8'
                , data_assegn   = :data_assegn
            where cod_inco      = :cod_inco                 
       </querytext>
    </partialquery>

    <partialquery name="upd_inco_old">
       <querytext>
           update coiminco
              set esito         =  null
            where cod_inco      = :cod_inco_old                 
       </querytext>
    </partialquery>

    <partialquery name="ins_anom">
       <querytext>
           insert
             into coimanom 
                ( cod_cimp_dimp
                , prog_anom
                , tipo_anom
                , cod_tanom
                , dat_utile_inter
                , flag_origine)
           values 
                (:cod_cimp
                ,:prog_anom_db
                ,'2'
                ,:cod_anom_db
                ,:data_ut_int_db
                ,'RV')
       </querytext>
    </partialquery>

    <partialquery name="del_todo_anom">
       <querytext>
           delete 
             from coimtodo
            where cod_impianto     = :cod_impianto
              and tipologia        = '2'
              and cod_cimp_dimp    = :cod_cimp
	      and substr(note,1,3) = (select cod_tanom
                                        from coimanom
                                       where cod_cimp_dimp = :cod_cimp
                                         and flag_origine  = 'RV'
                                         and prog_anom     = :prog_anom_db)
       </querytext>
    </partialquery>

    <partialquery name="del_anom">
       <querytext>
           delete
             from coimanom
            where cod_cimp_dimp = :cod_cimp
              and flag_origine  = 'RV'
              and prog_anom     = :prog_anom_db
       </querytext>
    </partialquery>

    <partialquery name="upd_cimp">
       <querytext>
           update coimcimp
              set cod_inco                  = :cod_inco
                , data_controllo            = :data_controllo
                , cod_opve                  = :cod_opve
                , costo                     = :costo
                , nominativo_pres           = :nominativo_pres
                , presenza_libretto         = :presenza_libretto
                , libretto_corretto         = :libretto_corretto
                , dich_conformita           = :dich_conformita
                , libretto_manutenz         = :libretto_manutenz
                , mis_port_combust          = :mis_port_combust
                , mis_pot_focolare          = :mis_pot_focolare
                , verifica_areaz            = :verifica_areaz
                , rend_comb_conv            = :rend_comb_conv
                , rend_comb_min             = :rend_comb_min
                , temp_fumi_md              = :temp_fumi_md
                , t_aria_comb_md            = :t_aria_comb_md
                , temp_mant_md              = :temp_mant_md
                , temp_h2o_out_md           = :temp_h2o_out_md
                , co2_md                    = :co2_md
                , o2_md                     = :o2_md
                , co_md                     = :co_md
                , indic_fumosita_1a         = :indic_fumosita_1a
                , indic_fumosita_2a         = :indic_fumosita_2a
                , indic_fumosita_3a         = :indic_fumosita_3a
                , indic_fumosita_md         = :indic_fumosita_md
                , manutenzione_8a           = :manutenzione_8a
                , co_fumi_secchi_8b         = :co_fumi_secchi_8b
                , indic_fumosita_8c         = :indic_fumosita_8c
                , rend_comb_8d              = :rend_comb_8d
                , esito_verifica            = :esito_verifica
                , note_verificatore         = :note_verificatore
                , note_resp                 = :note_resp
                , note_conf                 = :note_conf
                , tipologia_costo           = :tipologia_costo
                , riferimento_pag           = :riferimento_pag
                , pot_utile_nom             = :pot_utile_nom
                , pot_focolare_nom          = :pot_focolare_nom
                , cod_combustibile          = :cod_combustibile
                , cod_responsabile          = :cod_responsabile
                , flag_pericolosita         = :flag_pericolosita
                , data_mod                  = current_date
                , utente                    = :id_utente
                , new1_data_dimp            = :new1_data_dimp
                , new1_data_paga_dimp       = :new1_data_paga_dimp
                , new1_conf_accesso         = :new1_conf_accesso
                , new1_pres_intercet        = :new1_pres_intercet
                , new1_pres_interrut        = :new1_pres_interrut
                , new1_asse_mate_estr       = :new1_asse_mate_estr
                , new1_pres_mezzi           = :new1_pres_mezzi
                , new1_pres_cartell         = :new1_pres_cartell
                , new1_lavoro_nom_iniz      = :new1_lavoro_nom_iniz
                , new1_lavoro_nom_fine      = :new1_lavoro_nom_fine
                , new1_lavoro_lib_iniz      = :new1_lavoro_lib_iniz
                , new1_lavoro_lib_fine      = :new1_lavoro_lib_fine
                , new1_note_manu            = :new1_note_manu
                , new1_dimp_pres            = :new1_dimp_pres
                , new1_dimp_prescriz        = :new1_dimp_prescriz
                , new1_data_ultima_manu     = :new1_data_ultima_manu
                , new1_data_ultima_anal     = :new1_data_ultima_anal
                , new1_manu_prec_8a         = :new1_manu_prec_8a
                , new1_co_rilevato          = :new1_co_rilevato
                , new1_flag_peri_8p         = :new1_flag_peri_8p
                , n_prot                    = :n_prot
                , data_prot                 = :data_prot
                , volumetria                = :volumetria
                , comsumi_ultima_stag       = :comsumi_ultima_stag
                , temp_h2o_out_1a           = :temp_h2o_out_1a
                , temp_h2o_out_2a           = :temp_h2o_out_2a
                , temp_h2o_out_3a           = :temp_h2o_out_3a
                , t_aria_comb_1a            = :t_aria_comb_1a
                , t_aria_comb_2a            = :t_aria_comb_2a
                , t_aria_comb_3a            = :t_aria_comb_3a
                , temp_fumi_1a              = :temp_fumi_1a
                , temp_fumi_2a              = :temp_fumi_2a
                , temp_fumi_3a              = :temp_fumi_3a
                , co_1a                     = :co_1a
                , co_2a                     = :co_2a
                , co_3a                     = :co_3a
                , co2_1a                    = :co2_1a
                , co2_2a                    = :co2_2a
                , co2_3a                    = :co2_3a
                , o2_1a                     = :o2_1a
                , o2_2a                     = :o2_2a
                , o2_3a                     = :o2_3a
                , strumento                 = :strumento
                , marca_strum               = :marca_strum
                , modello_strum             = :modello_strum
                , matr_strum                = :matr_strum
                , ubic_locale_norma         = :ubic_locale_norma
                , doc_ispesl                = :doc_ispesl
                , libr_manut_bruc           = :libr_manut_bruc
                , conf_imp_elettrico        = :conf_imp_elettrico
                , doc_prev_incendi	    = :doc_prev_incendi
            where cod_cimp          = :cod_cimp
       </querytext>
    </partialquery>

    <partialquery name="del_cimp">
       <querytext>
           delete
             from coimcimp
            where cod_cimp = :cod_cimp
       </querytext>
    </partialquery>

    <partialquery name="del_movi">
       <querytext>
          delete from coimmovi
           where tipo_movi   = 'VC'
             and riferimento = :cod_cimp
       </querytext>
    </partialquery>

    <partialquery name="del_todo_all">
       <querytext>
           delete
             from coimtodo
            where cod_impianto  = :cod_impianto
              and tipologia    in ('2', '6')
              and cod_cimp_dimp = :cod_cimp
       </querytext>
    </partialquery>

    <partialquery name="del_anom_all">
       <querytext>
           delete
             from coimanom
            where cod_cimp_dimp = :cod_cimp
	      and flag_origine  = 'RV'
       </querytext>
    </partialquery>

    <fullquery name="sel_cimp">
       <querytext>
           select a.gen_prog
                , a.cod_inco
                , iter_edit.data(a.data_controllo) as data_controllo
                , a.cod_opve
                , iter_edit.num(a.costo, 2) as costo
                , a.nominativo_pres
                , a.presenza_libretto
                , a.libretto_corretto
                , a.dich_conformita
                , a.libretto_manutenz
                , iter_edit.num(a.mis_port_combust, 2) as mis_port_combust
                , iter_edit.num(a.mis_pot_focolare, 2) as mis_pot_focolare
                , a.verifica_areaz
                , iter_edit.num(a.rend_comb_conv, 2) as rend_comb_conv
                , iter_edit.num(a.rend_comb_min, 2) as rend_comb_min
                , iter_edit.num(a.temp_fumi_md, 2) as temp_fumi_md
                , iter_edit.num(a.t_aria_comb_md, 2) as t_aria_comb_md
                , iter_edit.num(a.temp_mant_md, 2) as temp_mant_md
                , iter_edit.num(a.temp_h2o_out_md, 2) as temp_h2o_out_md
                , iter_edit.num(a.co2_md, 2) as co2_md
                , iter_edit.num(a.o2_md, 2) as o2_md
                , iter_edit.num(a.co_md, 2) as co_md
                , iter_edit.num(a.indic_fumosita_1a, 2) as indic_fumosita_1a
                , iter_edit.num(a.indic_fumosita_2a, 2) as indic_fumosita_2a
                , iter_edit.num(a.indic_fumosita_3a, 2) as indic_fumosita_3a
                , iter_edit.num(a.indic_fumosita_md, 2) as indic_fumosita_md
                , a.manutenzione_8a
                , a.co_fumi_secchi_8b
                , a.indic_fumosita_8c
                , a.rend_comb_8d
                , a.esito_verifica
                , a.note_verificatore
                , a.note_resp
                , a.note_conf
                , a.tipologia_costo
                , a.riferimento_pag
                , iter_edit.data(b.data_scad) as data_scad
                , case
                      when importo_pag is null
                       and data_pag    is null
                      then 'N'
                      else 'S'
                  end         as flag_pagato
                , iter_edit.num(a.pot_focolare_nom, 2) as pot_focolare_nom
                , iter_edit.num(a.pot_utile_nom, 2)    as pot_utile_nom
                , a.cod_combustibile		
                , a.cod_responsabile
                , c.nome    as nome_responsabile
                , c.cognome as cogn_responsabile
                , a.flag_pericolosita
                , a.data_ins
                , iter_edit.data(a.new1_data_dimp) as new1_data_dimp
                , iter_edit.data(a.new1_data_paga_dimp) as new1_data_paga_dimp
                , a.new1_conf_accesso
                , a.new1_pres_intercet
                , a.new1_pres_interrut
                , a.new1_asse_mate_estr
                , a.new1_pres_mezzi
                , a.new1_pres_cartell
                , iter_edit.num(a.new1_lavoro_nom_iniz ,2) as new1_lavoro_nom_iniz
                , iter_edit.num(a.new1_lavoro_nom_fine ,2) as new1_lavoro_nom_fine
                , iter_edit.num(a.new1_lavoro_lib_iniz ,2) as new1_lavoro_lib_iniz
                , iter_edit.num(a.new1_lavoro_lib_fine ,2) as new1_lavoro_lib_fine
                , a.new1_note_manu
                , a.new1_dimp_pres
                , a.new1_dimp_prescriz
                , iter_edit.data(a.new1_data_ultima_manu) as new1_data_ultima_manu
                , iter_edit.data(a.new1_data_ultima_anal) as new1_data_ultima_anal
                , a.new1_manu_prec_8a
                , iter_edit.num(a.new1_co_rilevato, 2) as new1_co_rilevato
                , a.new1_flag_peri_8p
                , a.n_prot
                , iter_edit.data(a.data_prot) as data_prot
                , iter_edit.num(a.volumetria, 2) as volumetria
                , iter_edit.num(a.comsumi_ultima_stag, 2) as comsumi_ultima_stag
                , a.temp_h2o_out_1a
                , a.temp_h2o_out_2a
                , a.temp_h2o_out_3a
                , a.t_aria_comb_1a
                , a.t_aria_comb_2a
                , a.t_aria_comb_3a
                , a.temp_fumi_1a
                , a.temp_fumi_2a
                , a.temp_fumi_3a
                , a.co_1a
                , a.co_2a
                , a.co_3a
                , a.co2_1a
                , a.co2_2a
                , a.co2_3a
                , a.o2_1a
                , a.o2_2a
                , a.o2_3a
                , a.strumento
                , a.marca_strum
                , a.modello_strum
                , a.matr_strum
                , a.ubic_locale_norma
                , a.doc_ispesl
                , a.libr_manut_bruc
                , a.conf_imp_elettrico
                , a.doc_prev_incendi	        
             from coimcimp a
                , coimmovi b
                , coimcitt c
            where a.cod_cimp          =  :cod_cimp
              and b.riferimento   (+) = a.cod_cimp
              and b.cod_impianto  (+) = a.cod_impianto
              and b.tipo_movi     (+) =  'VC'
              and c.cod_cittadino (+) = a.cod_responsabile
       </querytext>
    </fullquery>

    <fullquery name="sel_anom">
       <querytext>
           select prog_anom
	        , cod_tanom 
		, iter_edit.data(dat_utile_inter) as dat_utile_inter
             from coimanom 
            where cod_cimp_dimp = :cod_cimp
	      and flag_origine  = 'RV'
            and rownum =  5
         order by to_number(prog_anom,'99999999')
       </querytext>
    </fullquery>

    <fullquery name="check_dimp">
       <querytext>
           select cod_dimp
             from coimdimp a 
            where a.cod_impianto    = :cod_impianto
              and a.data_controllo  = (select max(b.data_controllo)
                                         from coimdimp b
                                        where b.cod_impianto = :cod_impianto
                                        $where_data_controllo)
              and (   a.osservazioni    <> 'NO'
                   or a.raccomandazioni <> 'NO'
                   or a.prescrizioni    <> 'NO'
                   or exists (select '1'
                                from coimanom c
                               where c.cod_cimp_dimp = a.cod_dimp
                                 and c.flag_origine  = 'MH')
                  )
       </querytext>
    </fullquery>

    <fullquery name="sel_cimp_data">
       <querytext>
           select data_controllo
             from coimcimp
            where cod_cimp = :cod_cimp
       </querytext>
    </fullquery>

    <fullquery name="check_modh_old">
       <querytext>
           select max(data_controllo) as data_ultimo_modh
             from coimcimp
            where cod_impianto = :cod_impianto              
       </querytext>
    </fullquery>

    <fullquery name="sel_cimp_check_multiple">
       <querytext>
           select count(*) as conta_cimp_multiple
             from coimcimp
            where cod_impianto = :cod_impianto
	      and to_char(data_ins,'yyyymmdd') = to_char(sysdate, 'yyyymmdd')
       </querytext>
    </fullquery>

    <fullquery name="sel_cimp_pag1">
       <querytext>
           select a.dich_conformita
                , a.new1_conf_accesso
                , a.new1_pres_intercet
                , a.new1_pres_interrut
                , a.new1_asse_mate_estr
                , a.new1_pres_mezzi
                , a.new1_pres_cartell
                , a.verifica_areaz
                , a.presenza_libretto
                , a.libretto_corretto
                , a.libretto_manutenz
                , a.ubic_locale_norma
                , a.doc_ispesl
                , a.libr_manut_bruc
                , a.conf_imp_elettrico
                , a.doc_prev_incendi	        
             from coimcimp a
            where a.cod_impianto = :cod_impianto
	      and to_char(data_ins,'yyyymmdd') = to_char(sysdate, 'yyyymmdd')
              and rownum = 1
       </querytext>
    </fullquery>

    <fullquery name="sel_opve_strum">
       <querytext>
           select strumento     as strumento_opve
		, marca_strum   as marca_strum_opve
		, modello_strum as modello_strum_opve
                , matr_strum    as matr_strum_opve
             from coimopve 
             $where_opve
       </querytext>
    </fullquery>

</queryset>
