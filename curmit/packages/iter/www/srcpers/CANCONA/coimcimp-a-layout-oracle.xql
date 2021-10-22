<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_cimp_si_vie">
       <querytext>
                select a.cod_impianto
                     , a.cod_documento
                     , iter_edit.data(a.data_controllo) as data_controllo
                     , a.data_controllo as data_controllo_db
                     , case presenza_libretto
                           when 'S' then 'SI'
                           when 'N' then 'NO'
                           else 'Non noto'
                       end as pres_libr
                     , case libretto_corretto
                           when 'S' then 'SI'
                           when 'N' then 'NO'
                           else 'Non noto'
                       end as libr_corr
                     , case a.libretto_manutenz
                           when 'S' then 'SI'
                           when 'N' then 'NO'
                           when 'I' then 'Incompleta'
                           else 'Non noto'
                       end as libr_manut
                     , nvl(iter_edit.num(a.mis_port_combust, 2),'&nbsp;') as mis_port_combust
                     , nvl(iter_edit.num(a.mis_pot_focolare, 2),'&nbsp;') as mis_pot_focolare
                     , case a.stato_coiben
                           when 'B' then 'Buono'
                           when 'M' then 'Mediocre'
                           when 'S' then 'Scarso'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as stato_coiben
                     , case a.stato_canna_fum
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as stato_canna_fum
                     , case a.verifica_areaz
                           when 'P' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'A' then 'Assente'
                           else 'Non nota'
                       end as verifica_areaz
                     , nvl(iter_edit.num(a.temp_fumi_md, 2),'&nbsp;') as temp_fumi_md
                     , nvl(iter_edit.num(a.t_aria_comb_md, 2),'&nbsp;') as t_aria_comb_md
                     , nvl(iter_edit.num(a.temp_mant_md, 2),'&nbsp;') as temp_mant_md
                     , nvl(iter_edit.num(a.temp_h2o_out_md, 2),'&nbsp;') as temp_h2o_out_md
                     , nvl(iter_edit.num(a.co2_md, 2),'&nbsp;') as co2_md
                     , nvl(iter_edit.num(a.o2_md, 2),'&nbsp;') as o2_md
                     , nvl(iter_edit.num(a.co_md, 2),'&nbsp;') as co_md
                     , nvl(iter_edit.num(a.indic_fumosita_1a, 2),'&nbsp;') as indic_fumosita_1a
                     , nvl(iter_edit.num(a.indic_fumosita_2a, 2),'&nbsp;') as indic_fumosita_2a
                     , nvl(iter_edit.num(a.indic_fumosita_3a, 2),'&nbsp;') as indic_fumosita_3a
                     , nvl(iter_edit.num(a.indic_fumosita_md, 2),'&nbsp;') as indic_fumosita_md
                     , nvl(iter_edit.num(a.co_fumi_secchi, 2),'&nbsp;') as co_fumi_secchi
                     , nvl(iter_edit.num(a.rend_comb_conv, 2),'Non noto;') as rend_comb_conv
                     , nvl(iter_edit.num(a.rend_comb_min, 2),'Non noto;') as rend_comb_min
                     , case a.manutenzione_8a
                       when 'S' then 'Effettuata'
                       when 'N' then 'Non effettuata'
                       else 'Non noto'
                       end as manutenzione_8a
                     , case a.co_fumi_secchi_8b
                       when 'S' then 'Regolare'
                       when 'N' then 'Irregolare'
                       else 'Non noto'
                       end as co_fumi_secchi_8b
                     , case a.indic_fumosita_8c
                       when 'S' then 'Regolare'
                       when 'N' then 'Irregolare'
                       else 'Non noto'
                       end as indic_fumosita_8c
                     , case a.rend_comb_8d
                       when 'S' then 'Regolare'
                       when 'N' then 'Irregolare'
                       else 'Non noto'
                       end as rend_comb_8d
                     , case a.esito_verifica
                       when 'S' then 'Rientra'
                       when 'N' then 'Non rientra'
                       else 'Non noto'
                       end as esito_verifica
                     , a.note_verificatore
                     , iter_edit.data(b.data_installaz) as data_installaz
                     , nvl(c.descr_topo,'')||' '||nvl(c.descr_estesa,'')||' '||nvl(b.numero,'')||' '||nvl(b.esponente, '')||' '||nvl(m.denominazione,'') as ubicazione
                     , d.cognome as cogn_responsabile
                     , d.nome as nome_responsabile
                     , nvl(d.indirizzo,'')||'&nbsp;'||nvl(d.numero,'') as indi_resp
                     , d.comune as comu_resp
                     , nvl(d.telefono,'')||'&nbsp;'||nvl(d.cellulare,'') as telef_resp

                     , n.cognome as cogn_amministratore
                     , n.nome as nome_amministratore
                     , nvl(n.indirizzo,'')||'&nbsp;'||nvl(n.numero,'') as indi_ammin
                     , n.comune as comu_ammin
                     , nvl(n.telefono,'')||'&nbsp;'||nvl(n.cellulare,'') as telef_ammin
                     , o.cognome as cogn_occu
                     , o.nome as nome_occu
                     , nvl(o.indirizzo,'')||'&nbsp;'||nvl(o.numero,'') as indi_occu
                     , o.comune as comu_occu
                     , nvl(o.telefono,'')||'&nbsp;'||nvl(o.cellulare,'') as telef_occu
                     , p.cognome as cogn_prop
                     , p.nome as nome_prop
                     , nvl(p.indirizzo,'')||'&nbsp;'||nvl(p.numero,'') as indi_prop
                     , p.comune as comu_prop
                     , nvl(p.telefono,'')||'&nbsp;'||nvl(p.cellulare,'') as telef_prop
                     , b.flag_resp
                     , e.cognome||' '||nvl(e.nome,'') as opve
                     , h.descr_utgi as dest
                     , case f.mod_funz
                       when '1' then 'Aria'
                       when '2' then 'Acqua'
                       else 'Non noto'
                       end as mod_funz
                     , nvl(f.matricola,'Non nota') as matricola
                     , nvl(f.modello,'Non noto') as modello
                     , nvl(f.matricola_bruc,'Non nota') as matricola_bruc
                     , nvl(f.modello_bruc,'Non noto') as modello_bruc
                     , nvl(iter_edit.num(f.pot_focolare_nom, 2),'&nbsp;') as pot_focolare_nom
                     , nvl(iter_edit.num(f.pot_utile_nom, 2),'&nbsp;') as pot_utile_nom
                     , nvl(iter_edit.num(f.pot_focolare_lib, 2),'&nbsp;') as pot_focolare_lib
                     , g.descr_comb
                     , case a.flag_ispes
                       when 'T' then 'S&igrave;'
                       when 'F' then 'NO'
		       when 'V' then 'NV'
                       else 'Non noto'
                       end as flag_ispes
                     , case b.flag_resp
                           when 'P' then 'Proprietario'
                           when 'O' then 'Occupante'
                           when 'A' then 'Amministratore'
                           when 'I' then 'Intestatario'
                           when 'T' then 'Terzo responsabile (manutentore)'
                           else 'Non noto'
                       end                  as aimp_flag_resp_desc
                     , case b.cod_tpim
                           when 'A' then 'Singola unit&agrave; immobiliare'
                           when 'C' then 'Pi&ugrave; unit&agrave; immobiliari'
                           when '0' then 'Non noto'
                           else 'Non Noto;'
                       end                  as aimp_tipologia
                     , i.descr_cted         as aimp_categoria_edificio
                     , nvl(k.descr_cost,'&nbsp;')   as gend_descr_cost
                     , iter_edit.data(f.data_installaz) as gend_data_installaz
                     , case f.tipo_foco
                           when 'A' then 'Aperto'
                           when 'C' then 'Chiuso'
                           else 'Non Noto'
                       end                  as gend_tipo_focolare
                     , case f.tiraggio
                           when 'F' then 'Forzato'
                           when 'N' then 'Naturale'
                           else 'Non Noto'
                       end                  as gend_tiraggio
                     , nvl(f.modello,'&nbsp')    as gend_modello
                     , nvl(f.matricola,'&nbsp;') as gend_matricola
                     , case f.tipo_bruciatore
                           when 'A' then 'Atmosferico'
                           when 'P' then 'Soffiato'
                           when 'M' then 'Premiscelato'
                           else 'Non Noto'
                       end                  as gend_tipo_bruciatore
                     , nvl(l.descr_cost,'&nbsp;')  as gend_descr_cost_bruc
                     , nvl(f.modello_bruc,'&nbsp;') as gend_modello_bruc
                     , nvl(f.matricola_bruc,'&nbsp;') as gend_matricola_bruc
                     , nvl(iter_edit.num(f.pot_focolare_lib, 2),'&nbsp;') as gend_pot_focolare_lib_edit
                     , nvl(iter_edit.num(f.pot_utile_lib, 2),'&nbsp;')    as gend_pot_utile_lib_edit
                     , nvl(h.descr_utgi,'&nbsp;') as gend_destinazione_uso
                     , case f.locale 
                           when 'T' then 'Tecnico'
                           when 'E' then 'Esterno'
                           when 'I' then 'Interno'
                           else 'Non Noto'
                       end                  as gend_tipologia_locale
                     , nvl(j.descr_fuge,'&nbsp;') as gend_fluido_termovettore
                     , f.cod_emissione 
                     , iter_edit.data(a.new1_data_dimp) as new1_data_dimp
                     , iter_edit.data(a.new1_data_paga_dimp) as new1_data_paga_dimp
                     , case a.new1_conf_locale
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_conf_locale
                     , case a.new1_conf_accesso
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_conf_accesso
                     , case a.new1_pres_intercet
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_pres_intercet
                     , case a.new1_pres_interrut
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_pres_interrut
                     , case a.new1_asse_mate_estr
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_asse_mate_estr
                     , case a.new1_pres_mezzi
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_pres_mezzi
                     , case a.new1_pres_cartell
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_pres_cartell
                     , case a.new1_disp_regolaz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'                         
                       end as new1_disp_regolaz
                     , case a.new1_foro_presente
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_foro_presente
                     , case a.new1_foro_corretto
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_foro_corretto
                     , case a.new1_foro_accessibile
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_foro_accessibile
                     , case a.new1_canali_a_norma
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_canali_a_norma
                     , nvl(iter_edit.num(a.new1_lavoro_nom_iniz ,2),'0') as new1_lavoro_nom_iniz
                     , nvl(iter_edit.num(a.new1_lavoro_nom_fine ,2),'0') as new1_lavoro_nom_fine
                     , nvl(iter_edit.num(a.new1_lavoro_lib_iniz ,2),'0') as new1_lavoro_lib_iniz
                     , nvl(iter_edit.num(a.new1_lavoro_lib_fine ,2),'0') as new1_lavoro_lib_fine
                     , a.new1_note_manu
                     , case a.new1_dimp_pres
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_dimp_pres
                     , case a.new1_dimp_prescriz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_dimp_prescriz
                     , iter_edit.data(a.new1_data_ultima_manu) as new1_data_ultima_manu
                     , iter_edit.data(a.new1_data_ultima_anal) as new1_data_ultima_anal
                     , case a.new1_manu_prec_8a
                           when 'S' then 'Effettuata'
                           when 'N' then 'Non effettuata'
                           else 'Non noto'
                       end as new1_manu_prec_8a
                     , nvl(iter_edit.num(a.new1_co_rilevato, 2),'&nbsp;') as new1_co_rilevato
                     , case a.new1_flag_peri_8p 
                           when 'I' then 'Immediatamente'
                           when 'P' then 'Potenzialmente'
                           else 'Non noto'
                       end as new1_flag_peri_8p
                     , nvl(a.note_conf,'&nbsp;') as note_conf
                     , nvl(a.note_resp,'&nbsp;') as note_resp
                     , nvl(a.nominativo_pres,'&nbsp') as nominativo_pres
                     , f.gen_prog_est       as gend_gen_prog_est
                     , b.cod_impianto_est
                     , nvl(iter_edit.num(a.costo,2),'&nbsp') as costo
                     , q.descr_tpdu as aimp_dest_uso
                     , a.n_prot
                     , a.data_prot
                     , b.cod_responsabile
                     , a.pendenza
                     , a.ventilaz_lib_ostruz
                     , case a.disp_reg_cont_pre
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'
                       end as disp_reg_cont_pre
                     , case a.disp_reg_cont_funz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'
                       end as disp_reg_cont_funz
                     , case a.disp_reg_clim_funz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'
                       end as disp_reg_clim_funz
                     , iter_edit.num(a.volumetria,2) as volumetria
                     , iter_edit.num(a.comsumi_ultima_stag,2) as comsumi_ultima_stag
                     , iter_edit.num(a.temp_h2o_out_1a, 2) as temp_h2o_out_1a
                     , iter_edit.num(a.temp_h2o_out_2a, 2) as temp_h2o_out_2a
                     , iter_edit.num(a.temp_h2o_out_3a, 2) as temp_h2o_out_3a
                     , iter_edit.num(a.t_aria_comb_1a, 2) as t_aria_comb_1a
                     , iter_edit.num(a.t_aria_comb_2a, 2) as t_aria_comb_2a
                     , iter_edit.num(a.t_aria_comb_3a, 2) as t_aria_comb_3a
                     , iter_edit.num(a.temp_fumi_1a, 2) as temp_fumi_1a
                     , iter_edit.num(a.temp_fumi_2a, 2) as temp_fumi_2a
                     , iter_edit.num(a.temp_fumi_3a, 2) as temp_fumi_3a
                     , iter_edit.num(a.co_1a, 2) as co_1a
                     , iter_edit.num(a.co_2a, 2) as co_2a
                     , iter_edit.num(a.co_3a, 2) as co_3a
                     , iter_edit.num(a.co2_1a, 2) as co2_1a
                     , iter_edit.num(a.co2_2a, 2) as co2_2a
                     , iter_edit.num(a.co2_3a, 2) as co2_3a
                     , iter_edit.num(a.o2_1a, 2) as o2_1a
                     , iter_edit.num(a.o2_2a, 2) as o2_2a
                     , iter_edit.num(a.o2_3a, 2) as o2_3a
                     , a.strumento
                     , a.marca_strum
                     , a.modello_strum
                     , a.matr_strum
                     , iter_edit.num(b.volimetria_risc,2) as aimp_volumetria_risc
                     , iter_edit.num(b.consumo_annuo,2) as aimp_consumo_annuo
                     , case f.dpr_660_96
                          when 'S' then 'Standard'
                          when 'B' then 'A bassa temperatura'
                          when 'G' then 'A gas a condensazione'
                           else 'Non Noto'
                       end as gend_dpr_660_96
                     , iter_edit.data(f.data_installaz) as gend_data_installazione 
                     , case a.dich_conformita 
                          when 'S' then 'S&igrave;'
                          when 'N' then 'No'
                          else ''
                       end as dich_conformita
                     , iter_edit.data(r.data_inizio) as data_inizio_campagna
                     , iter_edit.data(r.data_fine) as data_fine_campagna
                  from coimcimp a
		     , coimaimp b
                     , coimviae c
                     , coimcitt d
                     , coimopve e
                     , coimgend f
                     , coimcomb g
                     , coimcted i
                     , coimutgi h
                     , coimfuge j
                     , coimcost k
                     , coimcost l
                     , coimcomu m
                     , coimcitt n
                     , coimcitt o
                     , coimcitt p
                     , coimtpdu q
                     , coimcinc r
                 where a.cod_cimp             = :cod_cimp
                   and b.cod_impianto         = a.cod_impianto
                   and c.cod_comune       (+) = b.cod_comune
                   and c.cod_via          (+) = b.cod_via
                   and d.cod_cittadino    (+) = b.cod_responsabile
                   and e.cod_opve         (+) = a.cod_opve
                   and f.cod_impianto         = a.cod_impianto
                   and f.gen_prog         (+) = a.gen_prog
                   and g.cod_combustibile (+) = f.cod_combustibile
                   and i.cod_cted         (+) = b.cod_cted
                   and h.cod_utgi         (+) = f.cod_utgi
                   and j.cod_fuge         (+) = f.mod_funz
                   and k.cod_cost         (+) = f.cod_cost
                   and l.cod_cost         (+) = f.cod_cost_bruc
                   and m.cod_comune       (+) = b.cod_comune
                   and n.cod_cittadino    (+) = b.cod_amministratore
                   and o.cod_cittadino    (+) = b.cod_occupante
                   and p.cod_cittadino    (+) = b.cod_proprietario
                   and q.cod_tpdu         (+) = b.cod_tpdu
                   and r.data_inizio     (+) <= a.data_controllo
                   and r.data_fine       (+) >= a.data_controllo

       </querytext>
    </fullquery>

    <fullquery name="sel_cimp_no_vie">
       <querytext>
                select nvl(b.toponimo,'')||' '||nvl(b.indirizzo,'')||' '||nvl(b.numero,'')||' '||nvl(b.esponente,'')||' '||nvl(m.denominazione,'') as ubicazione
                     , a.cod_impianto
                     , a.cod_documento
                     , iter_edit.data(a.data_controllo) as data_controllo
                     , a.data_controllo as data_controllo_db
                     , case presenza_libretto
                           when 'S' then 'SI'
                           when 'N' then 'NO'
                           else 'Non noto'
                       end as pres_libr
                     , case libretto_corretto
                           when 'S' then 'SI'
                           when 'N' then 'NO'
                           else 'Non noto'
                       end as libr_corr
                     , case a.libretto_manutenz
                           when 'S' then 'SI'
                           when 'N' then 'NO'
                           else 'Non noto'
                       end as libr_manut
                     , nvl(iter_edit.num(a.mis_port_combust, 2),'&nbsp;') as mis_port_combust
                     , nvl(iter_edit.num(a.mis_pot_focolare, 2),'&nbsp;') as mis_pot_focolare
                     , case a.stato_coiben
                           when 'B' then 'Buono'
                           when 'M' then 'Mediocre'
                           when 'S' then 'Scarso'
                           else 'Non noto'
                       end as stato_coiben
                     , case a.stato_canna_fum
                           when 'B' then 'Buono'
                           when 'M' then 'Mediocre'
                           when 'S' then 'Scarso'
                           else 'Non noto'
                       end as stato_canna_fum
                     , case a.verifica_areaz
                           when 'P' then 'Positiva'
                           when 'N' then 'Negativa'
                           else 'Non nota'
                       end as verifica_areaz
                     , nvl(iter_edit.num(a.temp_fumi_md, 2),'&nbsp;') as temp_fumi_md
                     , nvl(iter_edit.num(a.t_aria_comb_md, 2),'&nbsp;') as t_aria_comb_md
                     , nvl(iter_edit.num(a.temp_mant_md, 2),'&nbsp;') as temp_mant_md
                     , nvl(iter_edit.num(a.temp_h2o_out_md, 2),'&nbsp;') as temp_h2o_out_md
                     , nvl(iter_edit.num(a.co2_md, 2),'&nbsp;') as co2_md
                     , nvl(iter_edit.num(a.o2_md, 2),'&nbsp;') as o2_md
                     , nvl(iter_edit.num(a.co_md, 2),'&nbsp;') as co_md
                     , nvl(iter_edit.num(a.indic_fumosita_1a, 2),'&nbsp;') as indic_fumosita_1a
                     , nvl(iter_edit.num(a.indic_fumosita_2a, 2),'&nbsp;') as indic_fumosita_2a
                     , nvl(iter_edit.num(a.indic_fumosita_3a, 2),'&nbsp;') as indic_fumosita_3a
                     , nvl(iter_edit.num(a.indic_fumosita_md, 2),'&nbsp;') as indic_fumosita_md
                     , nvl(iter_edit.num(a.co_fumi_secchi, 2),'&nbsp;') as co_fumi_secchi
                     , nvl(iter_edit.num(a.rend_comb_conv, 2),'Non noto;') as rend_comb_conv
                     , nvl(iter_edit.num(a.rend_comb_min, 2),'Non noto;') as rend_comb_min
                     , case a.manutenzione_8a
                       when 'S' then 'Effettuata'
                       when 'N' then 'Non effettuata'
                       else 'Non noto'
                       end as manutenzione_8a
                     , case a.co_fumi_secchi_8b
                       when 'S' then 'Regolare'
                       when 'N' then 'Irregolare'
                       else 'Non noto'
                       end as co_fumi_secchi_8b
                     , case a.indic_fumosita_8c
                       when 'S' then 'Regolare'
                       when 'N' then 'Irregolare'
                       else 'Non noto'
                       end as indic_fumosita_8c
                     , case a.rend_comb_8d
                       when 'S' then 'Regolare'
                       when 'N' then 'Irregolare'
                       else 'Non noto'
                       end as rend_comb_8d
                     , case a.esito_verifica
                       when 'S' then 'Rientra'
                       when 'N' then 'Non rientra'
                       else 'Non noto'
                       end as esito_verifica
                     , a.note_verificatore
                     , iter_edit.data(b.data_installaz) as data_installaz
                     , d.cognome as cogn_responsabile
                     , d.nome as nome_responsabile
                     , nvl(d.indirizzo,'')||'&nbsp;'||nvl(d.numero,'') as indi_resp
                     , d.comune as comu_resp
                     , nvl(d.telefono,'')||'&nbsp;'||nvl(d.cellulare,'') as telef_resp

                     , n.cognome as cogn_amministratore
                     , n.nome as nome_amministratore
                     , nvl(n.indirizzo,'')||'&nbsp;'||nvl(n.numero,'') as indi_ammin
                     , n.comune as comu_ammin
                     , nvl(n.telefono,'')||'&nbsp;'||nvl(n.cellulare,'') as telef_ammin
                     , o.cognome as cogn_occu
                     , o.nome as nome_occu
                     , nvl(o.indirizzo,'')||'&nbsp;'||nvl(o.numero,'') as indi_occu
                     , o.comune as comu_occu
                     , nvl(o.telefono,'')||'&nbsp;'||nvl(o.cellulare,'') as telef_occu
                     , p.cognome as cogn_prop
                     , p.nome as nome_prop
                     , nvl(p.indirizzo,'')||'&nbsp;'||nvl(p.numero,'') as indi_prop
                     , p.comune as comu_prop
                     , nvl(p.telefono,'')||'&nbsp;'||nvl(p.cellulare,'') as telef_prop
                     , b.flag_resp
                     , e.cognome||' '||nvl(e.nome,'') as opve
                     , h.descr_utgi as dest
                     , case f.mod_funz
                       when '1' then 'Aria'
                       when '2' then 'Acqua'
                       else 'Non noto'
                       end as mod_funz
                     , nvl(f.matricola,'Non nota') as matricola
                     , nvl(f.modello,'Non noto') as modello
                     , nvl(f.matricola_bruc,'Non nota') as matricola_bruc
                     , nvl(f.modello_bruc,'Non noto') as modello_bruc
                     , nvl(iter_edit.num(f.pot_focolare_nom, 2),'&nbsp;') as pot_focolare_nom
                     , nvl(iter_edit.num(f.pot_utile_nom, 2),'&nbsp;') as pot_utile_nom
                     , nvl(iter_edit.num(f.pot_focolare_lib, 2),'&nbsp;') as pot_focolare_lib
                     , g.descr_comb
                     , case a.flag_ispes
                       when 'T' then 'S&igrave;'
                       when 'F' then 'NO'
		       when 'S' then 'Scaduto'
                       else 'Non noto'
                       end as flag_ispes
                     , case b.flag_resp
                           when 'P' then 'Proprietario'
                           when 'O' then 'Occupante'
                           when 'A' then 'Amministratore'
                           when 'I' then 'Intestatario'
                           when 'T' then 'Terzo responsabile(manutentore)'
                           else 'Non noto'
                       end                  as aimp_flag_resp_desc
                     , case b.cod_tpim
                           when 'A' then 'Singola unit&agrave; immobiliare'
                           when 'C' then 'Pi&ugrave; unit&agrave; immobiliari'
                           when '0' then 'Non noto'
                           else 'Non Noto;'
                       end                  as aimp_tipologia
                     , i.descr_cted         as aimp_categoria_edificio
                     , nvl(k.descr_cost,'&nbsp;')   as gend_descr_cost
                     , iter_edit.data(f.data_installaz) as gend_data_installaz
                     , case f.tipo_foco
                           when 'A' then 'Aperto'
                           when 'C' then 'Chiuso'
                           else 'Non Noto'
                       end                  as gend_tipo_focolare
                     , case f.tiraggio
                           when 'F' then 'Forzato'
                           when 'N' then 'Naturale'
                           else 'Non Noto'
                       end                  as gend_tiraggio
                     , nvl(f.modello,'&nbsp')    as gend_modello
                     , nvl(f.matricola,'&nbsp;') as gend_matricola
                     , case f.tipo_bruciatore
                           when 'A' then 'Atmosferico'
                           when 'P' then 'Soffiato'
                           else 'Non Noto'
                       end                  as gend_tipo_bruciatore
                     , nvl(l.descr_cost,'&nbsp;')  as gend_descr_cost_bruc
                     , nvl(f.modello_bruc,'&nbsp;') as gend_modello_bruc
                     , nvl(f.matricola_bruc,'&nbsp;') as gend_matricola_bruc
                     , nvl(iter_edit.num(f.pot_focolare_lib, 2),'&nbsp;') as gend_pot_focolare_lib_edit
                     , nvl(iter_edit.num(f.pot_utile_lib, 2),'&nbsp;')    as gend_pot_utile_lib_edit
                     , nvl(h.descr_utgi,'&nbsp;') as gend_destinazione_uso
                     , case f.locale 
                           when 'T' then 'Tecnico'
                           when 'E' then 'Esterno'
                           when 'I' then 'Interno'
                           else 'Non Noto'
                       end                  as gend_tipologia_locale
                     , nvl(j.descr_fuge,'&nbsp;') as gend_fluido_termovettore
                     , f.cod_emissione 
                     , iter_edit.data(a.new1_data_dimp) as new1_data_dimp
                     , iter_edit.data(a.new1_data_paga_dimp) as new1_data_paga_dimp
                     , case a.new1_conf_locale
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_conf_locale
                     , case a.new1_conf_accesso
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_conf_accesso
                     , case a.new1_pres_intercet
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_pres_intercet
                     , case a.new1_pres_interrut
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_pres_interrut
                     , case a.new1_asse_mate_estr
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_asse_mate_estr
                     , case a.new1_pres_mezzi
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_pres_mezzi
                     , case a.new1_pres_cartell
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_pres_cartell
                     , case a.new1_disp_regolaz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'                         
                       end as new1_disp_regolaz
                     , case a.new1_foro_presente
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_foro_presente
                     , case a.new1_foro_corretto
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_foro_corretto
                     , case a.new1_foro_accessibile
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_foro_accessibile
                     , case a.new1_canali_a_norma
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_canali_a_norma
                     , nvl(iter_edit.num(a.new1_lavoro_nom_iniz ,2),'0') as new1_lavoro_nom_iniz
                     , nvl(iter_edit.num(a.new1_lavoro_nom_fine ,2),'0') as new1_lavoro_nom_fine
                     , nvl(iter_edit.num(a.new1_lavoro_lib_iniz ,2),'0') as new1_lavoro_lib_iniz
                     , nvl(iter_edit.num(a.new1_lavoro_lib_fine ,2),'0') as new1_lavoro_lib_fine
                     , a.new1_note_manu
                     , case a.new1_dimp_pres
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_dimp_pres
                     , case a.new1_dimp_prescriz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_dimp_prescriz
                     , iter_edit.data(a.new1_data_ultima_manu) as new1_data_ultima_manu
                     , iter_edit.data(a.new1_data_ultima_anal) as new1_data_ultima_anal
                     , case a.new1_manu_prec_8a
                           when 'S' then 'Effettuata'
                           when 'N' then 'Non effettuata'
                           else 'Non noto'
                       end as new1_manu_prec_8a
                     , nvl(iter_edit.num(a.new1_co_rilevato, 2),'&nbsp;') as new1_co_rilevato
                     , case a.new1_flag_peri_8p 
                           when 'I' then 'Immediatamente'
                           when 'P' then 'Potenzialmente'
                           else 'Non noto'
                       end as new1_flag_peri_8p
                     , nvl(a.note_conf,'&nbsp;') as note_conf
                     , nvl(a.note_resp,'&nbsp;') as note_resp
                     , nvl(a.nominativo_pres,'&nbsp') as nominativo_pres
                     , f.gen_prog_est       as gend_gen_prog_est
                     , b.cod_impianto_est
                     , nvl(iter_edit.num(a.costo,2),'&nbsp') as costo
                     , q.descr_tpdu as aimp_dest_uso
                     , a.n_prot
                     , a.data_prot
                     , b.cod_responsabile
                     , a.pendenza
                     , case a.ventilaz_lib_ostruz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'
                       end as ventilaz_lib_ostruz
                     , case a.disp_reg_cont_pre
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'
                       end as disp_reg_cont_pre
                     , case a.disp_reg_cont_funz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'
                       end as disp_reg_cont_funz
                     , case a.disp_reg_clim_funz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'
                       end as disp_reg_clim_funz
                     , iter_edit.num(a.volumetria,2) as volumetria
                     , iter_edit.num(a.comsumi_ultima_stag,2) as comsumi_ultima_stag
                     , iter_edit.num(a.temp_h2o_out_1a, 2) as temp_h2o_out_1a
                     , iter_edit.num(a.temp_h2o_out_2a, 2) as temp_h2o_out_2a
                     , iter_edit.num(a.temp_h2o_out_3a, 2) as temp_h2o_out_3a
                     , iter_edit.num(a.t_aria_comb_1a, 2) as t_aria_comb_1a
                     , iter_edit.num(a.t_aria_comb_2a, 2) as t_aria_comb_2a
                     , iter_edit.num(a.t_aria_comb_3a, 2) as t_aria_comb_3a
                     , iter_edit.num(a.temp_fumi_1a, 2) as temp_fumi_1a
                     , iter_edit.num(a.temp_fumi_2a, 2) as temp_fumi_2a
                     , iter_edit.num(a.temp_fumi_3a, 2) as temp_fumi_3a
                     , iter_edit.num(a.co_1a, 2) as co_1a
                     , iter_edit.num(a.co_2a, 2) as co_2a
                     , iter_edit.num(a.co_3a, 2) as co_3a
                     , iter_edit.num(a.co2_1a, 2) as co2_1a
                     , iter_edit.num(a.co2_2a, 2) as co2_2a
                     , iter_edit.num(a.co2_3a, 2) as co2_3a
                     , iter_edit.num(a.o2_1a, 2) as o2_1a
                     , iter_edit.num(a.o2_2a, 2) as o2_2a
                     , iter_edit.num(a.o2_3a, 2) as o2_3a
                     , a.strumento
                     , a.marca_strum
                     , a.modello_strum
                     , a.matr_strum
                     , iter_edit.num(b.volimetria_risc,2) as aimp_volumetria_risc
                     , iter_edit.num(b.consumo_annuo,2) as aimp_consumo_annuo
                     , case f.dpr_660_96
                          when 'S' then 'Standard'
                          when 'B' then 'A bassa temperatura'
                          when 'G' then 'A gas a condensazione'
                           else 'Non Noto'
                       end as gend_dpr_660_96
                     , iter_edit.data(f.data_installaz) as gend_data_installazione
                     , case a.dich_conformita 
                          when 'S' then 'S&igrave;'
                          when 'N' then 'No'
                          else '&nbsp;'
                       end as dich_conformita
                     , iter_edit.data(r.data_inizio) as data_inizio_campagna
                     , iter_edit.data(r.data_fine) as data_fine_campagna
                  from coimcimp a
		     , coimaimp b
                     , coimcitt d
                     , coimopve e
                     , coimgend f
                     , coimcomb g
                     , coimcted i
                     , coimutgi h
                     , coimfuge j
                     , coimcost k
                     , coimcost l
                     , coimcomu m
                     , coimcitt n
                     , coimcitt o
                     , coimcitt p
                     , coimtpdu q
                     , coimcinc r
                 where a.cod_cimp             = :cod_cimp
                   and b.cod_impianto         = a.cod_impianto
                   and d.cod_cittadino    (+) = b.cod_responsabile
                   and e.cod_opve         (+) = a.cod_opve
                   and f.cod_impianto         = a.cod_impianto
                   and f.gen_prog         (+) = a.gen_prog
                   and g.cod_combustibile (+) = f.cod_combustibile
                   and i.cod_cted         (+) = b.cod_cted
                   and h.cod_utgi         (+) = f.cod_utgi
                   and j.cod_fuge         (+) = f.mod_funz
                   and k.cod_cost         (+) = f.cod_cost
                   and l.cod_cost         (+) = f.cod_cost_bruc
                   and m.cod_comune       (+) = b.cod_comune
                   and n.cod_cittadino    (+) = b.cod_amministratore
                   and o.cod_cittadino    (+) = b.cod_occupante
                   and p.cod_cittadino    (+) = b.cod_proprietario
                   and q.cod_tpdu         (+) = b.cod_tpdu
                   and r.data_inizio     (+) <= a.data_controllo
                   and r.data_fine       (+) >= a.data_controllo
       </querytext>
    </fullquery>

    <fullquery name="sel_docu_next">
        <querytext>
           select nextval('coimdocu_s') as cod_documento
       </querytext>
    </fullquery>

    <fullquery name="sel_docu">
        <querytext>
           select 1
             from coimdocu
            where cod_documento = :cod_documento
       </querytext>
    </fullquery>

    <partialquery name="ins_docu">
       <querytext>
                insert
                  into coimdocu 
                     ( cod_documento
                     , tipo_documento
                     , cod_impianto
                     , data_documento
                     , data_stampa
                     , tipo_soggetto
                     , cod_soggetto
                     , protocollo_02
                     , data_prot_02
                     , data_ins
                     , data_mod
                     , utente)
                values 
                     (:cod_documento
                     ,:tipo_documento
                     ,:cod_impianto
                     ,:data_controllo_db
                     ,current_date
                     ,'C'
                     ,:cod_responsabile
                     ,:n_prot
                     ,:data_prot
                     ,current_date
                     ,current_date
                     ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_docu">
       <querytext>
                   update coimdocu
                      set data_documento = current_date
                        , data_mod       = current_date
                        , utente         = :id_utente
                    where cod_documento  = :cod_documento
       </querytext>
    </partialquery>

    <fullquery name="sel_docu_contenuto">
       <querytext>
          select contenuto as docu_contenuto_check
            from coimdocu
           where cod_documento = :cod_documento
       </querytext>
    </fullquery>

    <partialquery name="upd_docu_2">
       <querytext>
                   update coimdocu
                      set contenuto     = lo_unlink(coimdocu.contenuto)
                    where cod_documento = :cod_documento
       </querytext>
    </partialquery> 

    <partialquery name="upd_docu_3">
       <querytext>
                   update coimdocu
                   set tipo_contenuto = :tipo_contenuto
                     , contenuto      = lo_import(:contenuto_tmpfile)
                 where cod_documento  = :cod_documento
       </querytext>
    </partialquery> 

    <partialquery name="upd_cimp">
       <querytext>
                   update coimcimp
                      set cod_documento = :cod_documento
                    where cod_cimp      = :cod_cimp
       </querytext>
    </partialquery> 

    <fullquery name="sel_anom">
        <querytext>
           select cod_tanom
             from coimanom
            where cod_cimp_dimp = :cod_cimp
              and tipo_anom     = '2'
       </querytext>
    </fullquery>

</queryset>
