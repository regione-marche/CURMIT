ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimtgen"
    @author          Giulio Laurenzi
    @creation-date   12/05/2004

    @param funzione  I=insert M=edit D=delete V=view

    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param extra_par Variabili extra da restituire alla lista

    @cvs-id          coimtgen-gest.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    sim06 20/01/2020 Aggiunto flag_obbligo_dati_catastali

    sim05 03/04/2018 Se cambiano i dati della email mando un messaggio perchè va agiustata la
    sim05            configurazione di postfix

    rom01 22/03/2018 Aggiunti i campi per Pec: indirizzo_pec, nome_utente_pec,
    rom01            password_pec, stmp_pec, porta_uscita_pec

    gab02 30/06/2017 Aggiunto flag_verifica_impianti

    gab01 20/02/2017 Aggiunto flag_gest_rcee_legna 

    sim04 06/09/2016 Aggiunto flag_targa

    nic03 12/02/2016 Aggiunto flag_potenza (usato per ora per PLI e regione Marche)

    nic02 04/02/2016 Aggiunto lun_num_cod_imp_est (usato per ora per la regione Marche)

    nic01 04/03/2014 Aggiunto il flag_gest_coimmode

} {
   {cod_tgen       "1"}
   {last_cod_tgen  ""}
   {funzione      "V"}
   {caller    "index"}
   {nome_funz      ""}
   {nome_funz_caller ""}
   {extra_par      ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
switch $funzione {
    "V" {set lvl 1}
    "M" {set lvl 3}
}

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars cod_tgen last_cod_tgen nome_funz extra_par]

iter_set_func_class $funzione

# Personalizzo la pagina
set link_list_script {[export_url_vars last_cod_tgen caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Dati generali"
switch $funzione {
    M {set button_label "Conferma Modifica" 
       set page_title   "Modifica $titolo"}
    D {set button_label "Conferma Cancellazione"
       set page_title   "Cancellazione $titolo"}
    I {set button_label "Conferma Inserimento"
       set page_title   "Inserimento $titolo"}
    V {set button_label "Torna alla lista"
       set page_title   "Visualizzazione $titolo"}
}


db_1row sel_aimp_count ""

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimtgen"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
switch $funzione {
   "I" {set readonly_key \{\}
        set readonly_fld \{\}
        set disabled_fld \{\}
       }
   "M" {set readonly_fld \{\}
        set disabled_fld \{\}
       }
}

form create $form_name \
-html    $onsubmit_cmd

element create $form_name valid_mod_h \
-label   "validita' modello H" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name gg_comunic_mod_h \
-label   "max GG comunicazione modello H" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name flag_ente \
-label   "Tipo ente" \
-widget   text \
-datatype text \
-html    "size 10 readonly {} class form_element" \
-optional \


element create $form_name sigla_prov \
-label   "Sigla provincia" \
-widget   text \
-datatype text \
-html    "size 4 readonly {} class form_element" \
-optional 

element create $form_name desc_comu \
-label   "Codice comune" \
-widget   text \
-datatype text \
-html    "size 40 readonly {} class form_element" \
-optional 

element create $form_name flag_viario \
-label   "flag viario" \
-widget   text \
-datatype text \
-html    "size 3 readonly {} class form_element" \
-optional 


element create $form_name gg_conferma_inco \
-label   "GG conferma incontro" \
-widget   text \
-datatype text \
-html    "size 5 maxlength 3 $readonly_fld {} class form_element" \
-optional

element create $form_name gg_scad_pag_mh \
-label   "GG scadenza pagamento modelli h" \
-widget   text \
-datatype text \
-html    "size 3 maxlength 3 $readonly_fld {} class form_element" \
-optional

element create $form_name   mesi_evidenza_mod \
-label   "mesi per evidenza modifiche" \
-widget   text \
-datatype text \
-html    "size 2 maxlength 2 $readonly_fld {} class form_element" \
-optional

element create $form_name   flag_agg_sogg \
-label   "aggiornamento soggetti" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{S&igrave; T} {No F}}

element create $form_name   flag_dt_scad \
-label   "data scadenza" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{Obbligatoria T} {{Non obbligatoria} F}}

element create $form_name   flag_agg_da_verif \
-label   "agg. da verifica" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{S&igrave; T} {No F}}

element create $form_name   flag_cod_aimp_auto \
-label   "flag codice impianto automatico" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{S&igrave; T} {No F}}

element create $form_name flag_gg_modif_mh \
-label   "GG modifica modello h" \
-widget   text \
-datatype text \
-html    "size 4 maxlength 4 $readonly_fld {} class form_element" \
-optional

element create $form_name flag_gg_modif_rv \
-label   "GG modifica rapporti di verifica" \
-widget   text \
-datatype text \
-html    "size 4 maxlength 4 $readonly_fld {} class form_element" \
-optional

element create $form_name gg_scad_pag_rv \
-label   "GG scadenza pagamento rapporti verifica" \
-widget   text \
-datatype text \
-html    "size 3 maxlength 3 $readonly_fld {} class form_element" \
-optional

element create $form_name gg_adat_anom_oblig \
-label   "flag giorni adattamento anomalie obbligatorio" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{S&igrave; T} {No F}}

element create $form_name gg_adat_anom_autom \
-label   "flag giorni adattamento anomalie automatica" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{S&igrave; T} {No F}}

element create $form_name popolaz_citt_tgen \
-label   "Popolazione abitanti ente" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name popolaz_aimp_tgen \
-label   "Popolazione impianti ente" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name max_gg_modimp \
-label   "Giorni massimi modifica stato impianti" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name flag_aimp_citt_estr \
-label   "flag dato utilizzato per calcolare gli impianti da estrarre" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{"Popolazione Abitanti" A} {"Popolazione Impianti" I}}

element create $form_name flag_stat_estr_calc \
-label   "flag calcolo gli impianti da estrarre" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{S&igrave; T} {No F}}

element create $form_name   flag_cod_via_auto \
-label   "flag codice via automatico" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{S&igrave; T} {No F}}

element create $form_name link_cap \
-label   "Link ricerca CAP" \
-widget   text \
-datatype text \
-html    "size 70 maxlength 500 $readonly_fld {} class form_element" \
-optional

element create $form_name flag_enti_compet \
-label   "flag enti competenti" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{S&igrave; T} {No F}}

element create $form_name flag_master_ente \
-label   "Sfondo col logo dell'ente" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{S&igrave; T} {No F}}

element create $form_name flag_codifica_reg \
-label   "Codice impianto creato secondo standard della regione" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{No F} {S&igrave; T}}

element create $form_name flag_pesi \
-label   "Conteggio automatico pesi all'inserimento di un modello g/h" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{S&igrave; S} {No N}}

element create $form_name flag_sanzioni \
-label   "Creazione sanzione per rapporti di verifica non a norma" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{S&igrave; S} {No N}}

element create $form_name flag_avvisi \
-label   "Stampa avviso e stampa esito da predisposizione controlli richiama modelli di stampa" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{S&igrave; S} {No N}}

element create $form_name flag_mod_gend \
-label   "Modifica generatore da inserimento/modifica modello" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{S&igrave; S} {No N}}

element create $form_name flag_asse_data \
-label   "Visualizza data partenza assegnazione (agenda)" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{S&igrave; S} {No N}}

element create $form_name flag_obbligo_canne \
-label   "Controllo tipo di canna fumaria obbligatorio" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{S&igrave; S} {No N}}

element create $form_name flag_default_contr_fumi \
-label   "Default controllo fumi" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{Effettuato S} {{Non effettuato} {N}}}

element create $form_name cod_imst_cari_manu \
-label   "stato" \
-widget   select \
-datatype text \
-html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimimst cod_imst descr_imst cod_imst]

element create $form_name cod_imst_annu_manu \
-label   "stato" \
-widget   select \
-datatype text \
-html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimimst cod_imst descr_imst cod_imst]

element create $form_name flag_bollino_obb \
-label   "flag bollino  obbligatorio" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{S&igrave; T} {No F}}

element create $form_name flag_limite_portaf \
-label   "flag_limite_portaf" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{S&igrave; S} {No N}}

element create $form_name  valore_limite_portaf \
-label   " valore_limite_portaf" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name flag_multivie \
-label   "Multivie" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{No F} {S&igrave; T}}

element create $form_name flag_stp_presso_terzo_resp \
-label   "Stampa l'indirizzo della ditta di manutenzione per il terzo responsabile" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{No F} {S&igrave; T}}

element create $form_name flag_portale \
-label   "Istanza collegata ad iter-portal?" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{No F} {S&igrave; T}}

element create $form_name flag_gest_coimmode \
-label   "Gestione dei modelli di generatore su apposita anagrafica" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{No F} {S&igrave; T}}

element create $form_name lun_num_cod_imp_est \
-label   "Lungh. del progressivo nel codice impianto" \
-widget   text \
-datatype text \
-html    "size 2 maxlength 2 $readonly_fld {} class form_element" \
-optional

element create $form_name flag_potenza \
-label   "Potenza da considerare per la fascia di potenza" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{"Potenza focolare nominale" pot_focolare_nom} {"Potenza utile nominale" pot_utile_nom}}

element create $form_name flag_gest_targa \
    -label   "Gestisci targa" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{No F} {S&igrave; T}}

#gab01
element create $form_name flag_gest_rcee_legna \
    -label   "Gestisci rcee legna" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{No F} {S&igrave; T}}

#gab02
element create $form_name flag_verifica_impianti \
    -label   "Verifica impianti da parte dell'ente" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{No f} {S&igrave; t}}

#rom01
element create $form_name flag_single_sign_on \
    -label "flag_single_sign_on" \
    -widget  select \
    datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{No f} {S&igrave; t}}


#rom01 
element create $form_name indirizzo_pec \
    -label "Indirizzo pec" \
    -widget   text \
    -datatype text \
    -html "size 40 $readonly_fld {} class form_element" \
    -optional
   
#rom01
element create $form_name nome_utente_pec \
    -label "Nome Utente pec" \
    -widget text \
    -datatype text \
    -html "size 40 $readonly_fld {} class form_element" \
    -optional

#rom01
element create $form_name password_pec \
    -label "Password pec" \
    -widget password \
    -datatype text \
    -html "size 40 $readonly_fld {} class form_element autocomplete off" \
    -optional

#rom01
element create $form_name stmp_pec \
    -label "STMP pec" \
    -widget text \
    -datatype text \
    -html "size 40 $readonly_fld {} class form_element" \
    -optional

#rom01
element create $form_name porta_uscita_pec \
    -label "Porta Uscita pec" \
    -widget text \
    -datatype text \
    -html "size 40 $readonly_fld {} class form_element" \
    -optional

#sim06
element create $form_name flag_obbligo_dati_catastali \
    -label   "Dati catastali obbligatori" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{No F} {S&igrave; T}}


element create $form_name cod_tgen  -widget hidden -datatype text -optional
element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_tgen -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione      -value $funzione
    element set_properties $form_name caller        -value $caller
    element set_properties $form_name nome_funz     -value $nome_funz
    element set_properties $form_name extra_par     -value $extra_par
    element set_properties $form_name last_cod_tgen -value $last_cod_tgen

    if {$funzione == "I"} {
      # TODO: settare eventuali default!!
        
    } else {
      # leggo riga
        if {[db_0or1row sel_tgen1 ""] == 0} {
            iter_return_complaint "Record non trovato"
	} else {
	    if {$flag_viario == "T"} {
		set flag_viario "Si"
	    } else {
		set flag_viario "No"
	    }
	}

        element set_properties $form_name cod_tgen      -value $cod_tgen
        element set_properties $form_name valid_mod_h   -value $valid_mod_h
        element set_properties $form_name gg_comunic_mod_h -value $gg_comunic_mod_h
        element set_properties $form_name flag_ente     -value $flag_ente 
        element set_properties $form_name sigla_prov    -value $sigla_prov
        element set_properties $form_name desc_comu     -value $desc_comu 
        element set_properties $form_name flag_viario   -value $flag_viario
        element set_properties $form_name gg_conferma_inco -value $gg_conferma_inco 
	element set_properties $form_name gg_scad_pag_mh  -value $gg_scad_pag_mh
	element set_properties $form_name gg_scad_pag_rv  -value $gg_scad_pag_rv
        element set_properties $form_name mesi_evidenza_mod -value $mesi_evidenza_mod
	element set_properties $form_name flag_agg_sogg -value $flag_agg_sogg
	element set_properties $form_name flag_dt_scad  -value $flag_dt_scad
	element set_properties $form_name flag_agg_da_verif -value $flag_agg_da_verif
	element set_properties $form_name flag_cod_aimp_auto -value $flag_cod_aimp_auto
	element set_properties $form_name flag_cod_via_auto -value $flag_cod_via_auto
	element set_properties $form_name flag_gg_modif_mh   -value $flag_gg_modif_mh
	element set_properties $form_name flag_gg_modif_rv   -value $flag_gg_modif_rv
	element set_properties $form_name gg_adat_anom_oblig -value $gg_adat_anom_oblig
	element set_properties $form_name gg_adat_anom_autom -value $gg_adat_anom_autom
	element set_properties $form_name popolaz_citt_tgen  -value $popolaz_citt_tgen
	element set_properties $form_name popolaz_aimp_tgen  -value $popolaz_aimp_tgen
	element set_properties $form_name flag_aimp_citt_estr -value $flag_aimp_citt_estr
	element set_properties $form_name flag_stat_estr_calc -value $flag_stat_estr_calc
	element set_properties $form_name link_cap           -value $link_cap
	element set_properties $form_name flag_enti_compet   -value $flag_enti_compet
        element set_properties $form_name flag_master_ente   -value $flag_master_ente
        element set_properties $form_name flag_codifica_reg  -value $flag_codifica_reg
        element set_properties $form_name flag_pesi          -value $flag_pesi
        element set_properties $form_name flag_sanzioni      -value $flag_sanzioni
        element set_properties $form_name flag_avvisi        -value $flag_avvisi
        element set_properties $form_name flag_mod_gend      -value $flag_mod_gend
        element set_properties $form_name flag_asse_data     -value $flag_asse_data
        element set_properties $form_name flag_obbligo_canne -value $flag_obbligo_canne
        element set_properties $form_name flag_default_contr_fumi -value $flag_default_contr_fumi
        element set_properties $form_name cod_imst_cari_manu -value $cod_imst_cari_manu
	element set_properties $form_name cod_imst_annu_manu -value $cod_imst_annu_manu
	element set_properties $form_name max_gg_modimp	-value $max_gg_modimp	
	element set_properties $form_name flag_bollino_obb	-value $flag_bollino_obb
	element set_properties $form_name flag_limite_portaf	-value $flag_limite_portaf
	element set_properties $form_name valore_limite_portaf	-value $valore_limite_portaf
	element set_properties $form_name flag_multivie 	-value $flag_multivie
	element set_properties $form_name flag_stp_presso_terzo_resp -value $flag_stp_presso_terzo_resp
	element set_properties $form_name flag_portale          -value $flag_portale
	element set_properties $form_name flag_gest_coimmode    -value $flag_gest_coimmode
	element set_properties $form_name lun_num_cod_imp_est   -value $lun_num_cod_imp_est
	element set_properties $form_name flag_potenza          -value $flag_potenza
	element set_properties $form_name flag_gest_targa       -value $flag_gest_targa
        element set_properties $form_name flag_gest_rcee_legna  -value $flag_gest_rcee_legna;#gab01
	element set_properties $form_name flag_verifica_impianti -value $flag_verifica_impianti;#gab02
	element set_properties $form_name flag_single_sign_on -value $flag_single_sign_on;#rom01
	element set_properties $form_name indirizzo_pec -value $indirizzo_pec;#rom01
	element set_properties $form_name nome_utente_pec -value $nome_utente_pec;#rom01
	element set_properties $form_name password_pec  -value $password_pec;#rom01
	element set_properties $form_name stmp_pec -value $stmp_pec;#rom01
	element set_properties $form_name porta_uscita_pec -value $porta_uscita_pec;#rom01
	element set_properties $form_name flag_obbligo_dati_catastali -value $flag_obbligo_dati_catastali;#sim06


    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_tgen            [element::get_value $form_name cod_tgen]
    set valid_mod_h         [element::get_value $form_name valid_mod_h]
    set gg_comunic_mod_h    [element::get_value $form_name gg_comunic_mod_h]
    set gg_conferma_inco    [element::get_value $form_name gg_conferma_inco]
    set gg_scad_pag_mh      [element::get_value $form_name gg_scad_pag_mh]
    set gg_scad_pag_rv      [element::get_value $form_name gg_scad_pag_rv]
    set mesi_evidenza_mod   [element::get_value $form_name mesi_evidenza_mod]
    set flag_agg_sogg       [element::get_value $form_name flag_agg_sogg]
    set flag_dt_scad        [element::get_value $form_name flag_dt_scad]
    set flag_agg_da_verif   [element::get_value $form_name flag_agg_da_verif]
    set flag_cod_aimp_auto  [element::get_value $form_name flag_cod_aimp_auto]
    set flag_cod_via_auto   [element::get_value $form_name flag_cod_via_auto]
    set flag_gg_modif_mh    [element::get_value $form_name flag_gg_modif_mh]
    set flag_gg_modif_rv    [element::get_value $form_name flag_gg_modif_rv]
    set gg_adat_anom_oblig  [element::get_value $form_name gg_adat_anom_oblig]
    set gg_adat_anom_autom  [element::get_value $form_name gg_adat_anom_autom]
    set popolaz_citt_tgen   [element::get_value $form_name popolaz_citt_tgen]
    set popolaz_aimp_tgen   [element::get_value $form_name popolaz_aimp_tgen]
    set flag_aimp_citt_estr [element::get_value $form_name flag_aimp_citt_estr]
    set flag_stat_estr_calc [element::get_value $form_name flag_stat_estr_calc]
    set link_cap            [element::get_value $form_name link_cap]
    set flag_enti_compet    [element::get_value $form_name flag_enti_compet]
    set flag_master_ente    [element::get_value $form_name flag_master_ente]
    set flag_codifica_reg   [element::get_value $form_name flag_codifica_reg]
    set flag_pesi           [element::get_value $form_name flag_pesi]
    set flag_sanzioni       [element::get_value $form_name flag_sanzioni]
    set flag_avvisi         [element::get_value $form_name flag_avvisi]
    set flag_mod_gend       [element::get_value $form_name flag_mod_gend]
    set flag_asse_data      [element::get_value $form_name flag_asse_data]
    set flag_obbligo_canne  [element::get_value $form_name flag_obbligo_canne]
    set flag_default_contr_fumi [element::get_value $form_name flag_default_contr_fumi]
    set cod_imst_cari_manu  [element::get_value $form_name cod_imst_cari_manu]
    set cod_imst_annu_manu  [element::get_value $form_name cod_imst_annu_manu]
    set max_gg_modimp          [element::get_value $form_name max_gg_modimp]
    set flag_bollino_obb       [element::get_value $form_name flag_bollino_obb]
    set flag_limite_portaf     [element::get_value $form_name flag_limite_portaf]
    set valore_limite_portaf   [element::get_value $form_name valore_limite_portaf]
    set flag_multivie          [element::get_value $form_name flag_multivie]
    set flag_stp_presso_terzo_resp [element::get_value $form_name flag_stp_presso_terzo_resp]
    set flag_portale               [element::get_value $form_name flag_portale]
    set flag_gest_coimmode         [element::get_value $form_name flag_gest_coimmode]
    set lun_num_cod_imp_est        [element::get_value $form_name lun_num_cod_imp_est]
    set flag_potenza               [element::get_value $form_name flag_potenza]
    set flag_gest_targa            [element::get_value $form_name flag_gest_targa]
    set flag_gest_rcee_legna       [element::get_value $form_name flag_gest_rcee_legna];#gab01
    set flag_verifica_impianti     [element::get_value $form_name flag_verifica_impianti];#gab02
    set flag_single_sign_on        [element::get_value $form_name flag_single_sign_on];#rom01
    set indirizzo_pec    [element::get_value $form_name indirizzo_pec];#rom01 
    set nome_utente_pec  [element::get_value $form_name nome_utente_pec];#rom01 
    set password_pec     [element::get_value $form_name password_pec];#rom01  
    set stmp_pec         [element::get_value $form_name stmp_pec];#rom01   
    set porta_uscita_pec [element::get_value $form_name porta_uscita_pec];#rom01
    set flag_obbligo_dati_catastali [element::get_value $form_name flag_obbligo_dati_catastali];#sim06

    # settaggio current_date
    db_1row sel_dual_date ""

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {

	if {$funzione == "I"} {
	    db_1row sel_tgen_count ""
	    if {$conta_a == 1} {
		element::set_error $form_name pag_std "&Egrave; possibile inserire solo un record."
		incr error_num
	    } else {
		set cod_tgen 1
	    }
	}
     	
        if {[string equal $valid_mod_h ""]} {
            element::set_error $form_name valid_mod_h "Inserire la validit&agrave; massima modello H"
            incr error_num
        } else {
            set valid_mod_h [iter_check_num $valid_mod_h 0]
            if {$valid_mod_h == "Error"} {
                element::set_error $form_name valid_mod_h "Validit&agrave; massima modello H deve essere un numero intero"
                incr error_num
            } else {
                if {[iter_set_double $valid_mod_h] >=  [expr pow(10,8)]
		||  [iter_set_double $valid_mod_h] <= -[expr pow(10,8)]} {
                    element::set_error $form_name valid_mod_h "Validit&agrave; massima modello H deve essere inferiore di 100.000.000"
                    incr error_num
                }
            }
        }
    
        if {[string equal $gg_comunic_mod_h ""]} {
            element::set_error $form_name gg_comunic_mod_h "Inserire I giorni comunicazione modello H"
            incr error_num
        } else {
	    set gg_comunic_mod_h [iter_check_num $gg_comunic_mod_h 0]
            if {$gg_comunic_mod_h == "Error"} {
                element::set_error $form_name gg_comunic_mod_h "I giorni comunicazione modello H devono essere un numero intero"
                incr error_num
            } else {
                if {[iter_set_double $gg_comunic_mod_h] >=  [expr pow(10,8)]
                ||  [iter_set_double $gg_comunic_mod_h] <= -[expr pow(10,8)]} {
                    element::set_error $form_name gg_comunic_mod_h "I giorni comunicazione modello H devono essere inferiore di 100.000.000"
                    incr error_num
                }
            }
        }
        
   

        if {[string equal $flag_limite_portaf ""]} {
            element::set_error $form_name flag_limite_portaf "Inserire"
            incr error_num
        }

        if {[string equal $valore_limite_portaf ""]
	    && $flag_limite_portaf == "S"} {
            element::set_error $form_name valore_limite_portaf "Inserire la valore limite"
            incr error_num
        } else {
	    if {![string equal $valore_limite_portaf ""]} {
		set valore_limite_portaf [iter_check_num $valore_limite_portaf 2]
		if {$valore_limite_portaf == "Error"} {
		    element::set_error $form_name valore_limite_portaf "Il valore deve essere un numerico con massimo 2 decimali"
		    incr error_num
		} else {
		    if {[iter_set_double $valore_limite_portaf] >=  [expr pow(10,8)]
			||  [iter_set_double $valore_limite_portaf] <= -[expr pow(10,8)]} {
			element::set_error $form_name valore_limite_portaf "Validit&agrave; massima modello H deve essere inferiore di 100.000.000"
			incr error_num
		    }
		}
	    }
	}
    
   
        if {![string equal $gg_conferma_inco ""]} {
	    set gg_conferma_inco [iter_check_num $gg_conferma_inco 0]
            if {$gg_conferma_inco == "Error"} {
                element::set_error $form_name gg_conferma_inco "I giorni conferma devono essere un numero intero"
                incr error_num
            } else {
                if {[iter_set_double $gg_conferma_inco] >=  [expr pow(10,3)]
                ||  [iter_set_double $gg_conferma_inco] <= -[expr pow(10,3)]} {
                    element::set_error $form_name gg_conferma_inco "I giorni conferma devono essere inferiore a 1.000"
                    incr error_num
                }
            }
        }
    
        if {![string equal $gg_scad_pag_mh ""]} {
	    set gg_scad_pag_mh [iter_check_num $gg_scad_pag_mh 0]
            if {$gg_scad_pag_mh == "Error"} {
                element::set_error $form_name gg_scad_pag_mh "I giorni scadenza pagamento devono essere un numero intero"
                incr error_num
            } else {
                if {[iter_set_double $gg_scad_pag_mh] >=  [expr pow(10,3)]
                ||  [iter_set_double $gg_scad_pag_mh] <= -[expr pow(10,3)]} {
                    element::set_error $form_name gg_scad_pag_mh "I giorni scadenza pagamento devono essere inferiore a 1.000"
                    incr error_num
                }
            }
        }
    
        if {![string equal $gg_scad_pag_rv ""]} {
	    set gg_scad_pag_rv [iter_check_num $gg_scad_pag_rv 0]
            if {$gg_scad_pag_rv == "Error"} {
                element::set_error $form_name gg_scad_pag_rv "I giorni scadenza pagamento devono essere un numero intero"
                incr error_num
            } else {
                if {[iter_set_double $gg_scad_pag_rv] >=  [expr pow(10,3)]
                ||  [iter_set_double $gg_scad_pag_rv] <= -[expr pow(10,3)]} {
                    element::set_error $form_name gg_scad_pag_rv "I giorni scadenza pagamento devono essere inferiore a 1.000"
                    incr error_num
                }
            }
        }
    
        if {![string equal $mesi_evidenza_mod ""]} {
	    set mesi_evidenza_mod [iter_check_num $mesi_evidenza_mod 0]
            if {$mesi_evidenza_mod == "Error"} {
                element::set_error $form_name mesi_evidenza_mod "I mesi per evidenza modifica devono essere un numero intero"
                incr error_num
            } else {
                if {[iter_set_double $mesi_evidenza_mod] >=  [expr pow(10,2)]
                ||  [iter_set_double $mesi_evidenza_mod] <= -[expr pow(10,2)]} {
                    element::set_error $form_name mesi_evidenza_mod "I mesi per evidenza modifica devono essere inferiore a 1.00"
                    incr error_num
                }
            }
        }

        if {![string equal $flag_gg_modif_mh ""]} {
	    set flag_gg_modif_mh [iter_check_num $flag_gg_modif_mh 0]
            if {$flag_gg_modif_mh == "Error"} {
                element::set_error $form_name flag_gg_modif_mh "I giorni devono essere un numero intero"
                incr error_num
            } else {
                if {[iter_set_double $flag_gg_modif_mh] >=  [expr pow(10,4)]
                ||  [iter_set_double $flag_gg_modif_mh] <= -[expr pow(10,4)]} {
                    element::set_error $form_name flag_gg_modif_mh "I giorni devono essere inferiori a 10.000"
                    incr error_num
                }
            }
        }
    
        if {![string equal $flag_gg_modif_rv ""]} {
	    set flag_gg_modif_rv [iter_check_num $flag_gg_modif_rv 0]
            if {$flag_gg_modif_rv == "Error"} {
                element::set_error $form_name flag_gg_modif_rv "I giorni devono essere un numero intero"
                incr error_num
            } else {
                if {[iter_set_double $flag_gg_modif_rv] >=  [expr pow(10,4)]
                ||  [iter_set_double $flag_gg_modif_rv] <= -[expr pow(10,4)]} {
                    element::set_error $form_name flag_gg_modif_rv "I giorni devono essere inferiori a 10.000"
                    incr error_num
                }
            }
        }


	if {[string equal $popolaz_citt_tgen ""]
        &&  $flag_stat_estr_calc == "T"
        &&  $flag_aimp_citt_estr == "P"
	} {
	    element::set_error $form_name popolaz_citt_tgen "Inserire"
	    incr error_num
	}

        if {![string equal $popolaz_citt_tgen ""]} {
            set popolaz_citt_tgen [iter_check_num $popolaz_citt_tgen 0]
            if {$popolaz_citt_tgen == "Error"} {
                element::set_error $form_name popolaz_citt_tgen "Deve essere un numero intero"
                incr error_num
            } else {
                if {[iter_set_double $popolaz_citt_tgen] >=  [expr pow(10,7)]
		||  [iter_set_double $popolaz_citt_tgen] <= -[expr pow(10,7)]} {
                    element::set_error $form_name popolaz_citt_tgen "Deve essere inferiore di 10.000.000"
                    incr error_num
                }
            }
        }


	if {[string equal $popolaz_aimp_tgen ""]
        &&  $flag_stat_estr_calc == "T"
        &&  $flag_aimp_citt_estr == "I"
	} {
	    element::set_error $form_name popolaz_aimp_tgen "Inserire"
	    incr error_num
	}

        if {![string equal $popolaz_aimp_tgen ""]} {
            set popolaz_aimp_tgen [iter_check_num $popolaz_aimp_tgen 0]
            if {$popolaz_aimp_tgen == "Error"} {
                element::set_error $form_name popolaz_aimp_tgen "Deve essere un numero intero"
                incr error_num
            } else {
                if {[iter_set_double $popolaz_aimp_tgen] >=  [expr pow(10,7)]
		||  [iter_set_double $popolaz_aimp_tgen] <= -[expr pow(10,7)]} {
                    element::set_error $form_name popolaz_aimp_tgen "Deve essere inferiore di 10.000.000"
                    incr error_num
                }
            }
        }

	if {![string equal $max_gg_modimp ""]} {
	    set max_gg_modimp [iter_check_num $max_gg_modimp 0]
	    if {$max_gg_modimp == "Error"} {
		element::set_error $form_name max_gg_modimp "I giorni entro cui un manutentore può annullare un impianto devono essere un numero intero"
		incr error_num
	    } else {
		if {[iter_set_double $max_gg_modimp] >=  [expr pow(10,3)]
	        ||  [iter_set_double $max_gg_modimp] <= -[expr pow(10,3)]
		} {
		    element::set_error $form_name max_gg_modimp "I giorni entro cui un manutentore può annullare un impianto devono essere inferiori a 1.000"
		    incr error_num
		}
	    }
	}	

	if {[string equal $lun_num_cod_imp_est ""]} {
	    element::set_error $form_name lun_num_cod_imp_est "Dato obbligatorio: digitare un qualsiasi numero anche se in base agli altri flag non verr&agrave; utilizzato"
	    incr error_num
	} else {
	    set lun_num_cod_imp_est [iter_check_num $lun_num_cod_imp_est 0]
	    if {$lun_num_cod_imp_est == "Error"} {
		element::set_error $form_name lun_num_cod_imp_est "Deve essere un numero intero"
		incr error_num
	    } else {
		if {[iter_set_double $lun_num_cod_imp_est] >= [expr pow(10,2)]
	        ||  [iter_set_double $lun_num_cod_imp_est] <= 0
		} {
		    element::set_error $form_name lun_num_cod_imp_est "Deve essere inferiore a 100"
		    incr error_num
		}
	    }
	}	
		
		
        # controllo se si e' attivato il codice automatico per l'impianto.
	# se si, vado a creare il sequence per il codice esterno, estraendo 
	# il numero pi� alto disponibile.
	iter_get_coimtgen
    
	set flag_cod_aimp_auto_db $coimtgen(flag_cod_aimp_auto)
	if {$flag_cod_aimp_auto_db == "F"
	&&  $flag_cod_aimp_auto    == "T"
	} {
	    db_1row selec_max_aimp ""
	    set dml_drop_sequence [db_map drop_sequence]
	    set dml_create_sequence [db_map create_sequence]
	}

	set flag_cod_via_auto_db $coimtgen(flag_cod_via_auto)
	if {$flag_cod_via_auto_db == "F"
	&&  $flag_cod_via_auto    == "T"
	} {
	    db_1row selec_max_via ""
	    set dml_drop_sequence_via [db_map drop_sequence_via]
	    set dml_create_sequence_via [db_map create_sequence_via]
	}

	if {$funzione == "I"
	&&  $error_num == 0
	&&  [db_0or1row check_tgen ""] == 1
	} {
	    # controllo univocita'/protezione da double_click
	    element::set_error $form_name cod_tgen "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
	    incr error_num
	}
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    if {$funzione eq "M" && [db_0or1row q "
                                        select 1
                                          from coimtgen  
                                         where indirizzo_pec    != :indirizzo_pec
                                            or nome_utente_pec  != :nome_utente_pec
                                            or password_pec     != :password_pec
                                            or stmp_pec         != :stmp_pec
                                            or porta_uscita_pec != :porta_uscita_pec    
                                        "]} {#sim05

	set to_addr "assistenza@oasisoftware.it"
	set cc_addr      "spesci@oasisoftware.it,lromitti@oasisoftware.it"
	set subject "MESSAGGIO DI SISTEMA: modifica parametri email PEC"
	set body "Sono state apportate delle modifiche ai parametri dell'invio PEC di [db_get_database] \r
\r
Attualmente i parametrri sono i seguenti: \r
indirizzo_pec    = $indirizzo_pec \r
nome_utente_pec  = $nome_utente_pec \r
password_pec     = $password_pec \r
stmp_pec         = $stmp_pec \r
porta_uscita_pec = $porta_uscita_pec \r\r
Avvertire Simone Pesci/Luca Romitti in modo che vadano a configurare correttamente i file /etc/postfix/passwords_maps e /etc/postfix/relayhosts_maps"
	set from_addr $to_addr

	set extra_headers [list]
    
	lappend extra_headers [list "Disposition-Notification-To" $from_addr]
	lappend extra_headers [list "Return-Receipt-To" $from_addr]
	lappend extra_headers [list "X-Confirm-reading-to" $from_addr]

	acs_mail_lite::send  -send_immediately  -valid_email  -to_addr          $to_addr  -cc_addr  $cc_addr  -bcc_addr         ""  -from_addr        $from_addr  -subject          $subject  -body             $body  -extraheaders     $extra_headers

    }

    switch $funzione {
        I {set dml_sql [db_map ins_tgen]}
        M {set dml_sql [db_map upd_tgen]}
        D {set dml_sql [db_map del_tgen]}
    }
    
  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimtgen $dml_sql
		if {[info exists dml_drop_sequence]} {
		    db_dml dml_drop_sequence $dml_drop_sequence
		}
		if {[info exists dml_create_sequence]} {
		    db_dml dml_create_sequence $dml_create_sequence
		}
		if {[info exists dml_drop_sequence_via]} {
		    db_dml dml_drop_sequence_via $dml_drop_sequence_via
		}
		if {[info exists dml_create_sequence_via]} {
		    db_dml dml_create_sequence_via $dml_create_sequence_via
		}
            }
        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
 	}
    }
    #rom01
    set id_utente [iter_get_id_utente]
    if {[db_0or1row q "select 1
                        where :id_utente like 'MA%'"
	]} {
	db_dml -dbn $flag_single_sign_on -q "update coimtgen set flag_single_sign_on = 't'"
    };#rom01

  # dopo l'inserimento posiziono la lista sul record inserito
    if {$funzione == "I"} {
        set last_cod_tgen $cod_tgen
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_tgen last_cod_tgen nome_funz extra_par caller]
    switch $funzione {
        M {set return_url   "coimtgen-gest?funzione=V&$link_gest"}
        D {set return_url   "coimtgen-gest?funzione=V&$link_gest"}
        I {set return_url   "coimtgen-gest?funzione=V&$link_gest"}
     }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
