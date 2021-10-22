ad_page_contract {
    @author          Paolo Formizzi Adhoc
    @creation-date   23/04/2004

    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param extra_par Variabili extra da restituire alla lista

    @cvs-id          coimestr-gest.tcl

    USER   DATA       MODIFICHE
    ====== ========== =======================================================================
    rom01  13/07/2018 Ricevo e passo il filtro f_invio_comune, se l'utente clicca il bottone
    rom01             senza aver selezionato almeno un impianto lo blocco.

    gab01 29/06/2018  Ricevo e passo i filtri flag_racc e flag_pres.

    nic01  13/02/2014 Su richiesta di Sandro, si permette di inserire piu' incontri di tipo
    nic01             Mancata ispezione (tipo_estrazione = 10).

} {
    {last_cod_impianto ""}
    {caller       "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""}
    {extra_par         ""}
    {flag_racc         ""}
    {flag_pres         ""}
    {f_invio_comune    ""}
    tipo_estrazione
    cod_cinc
    conferma:optional,multiple
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}



# Controlla lo user
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

if {[db_0or1row sel_cinc ""] == 0} {
    iter_return_complaint "Campagna non trovata"
}

# Personalizzo la pagina
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
set link_filter  [export_url_vars caller nome_funz]&[iter_set_url_vars $extra_par]

set ls_cod_inco "";#rom01

set current_date [iter_set_sysdate]
set stato        0
set ctr_scritti  0

iter_get_coimtgen
set flag_ente $coimtgen(flag_ente)
set sigla_prov $coimtgen(sigla_prov)

if {$flag_ente == "P" && $sigla_prov == "LI"} {
    if {$tipo_estrazione == "1"||$tipo_estrazione == "3"} {
	set tipo_lettera "C"
    } else {
	set tipo_lettera "A"
    }	
} else {
    set tipo_lettera ""
}

if {[exists_and_not_null conferma]} {
    with_catch error_msg {
	db_transaction {
	    foreach {cod_impianto} $conferma {
	#nic01	if {[db_0or1row sel_inco ""] == 0}
		if {$tipo_estrazione == 10
		|| [db_0or1row sel_inco ""] == 0
		} {;#nic01
		    # preparo le note in cui deve comparire il telefono
		    # del responsabile e dell'occupante
		    set note         ""
		    if {[db_0or1row sel_aimp_sogg ""] == 1} {
			set cod_cittadino $cod_responsabile
			if {![string is space $cod_cittadino] && [db_0or1row sel_citt_telefono ""] == 1} {
			    if {![string is space $telefono]} {
				set note "Telefono responsabile: $telefono. "
			    }
			}
			set cod_cittadino $cod_occupante
			if { $cod_occupante != $cod_responsabile && ![string is space $cod_cittadino] && [db_0or1row sel_citt_telefono ""] == 1} {
			    if {![string is space $telefono]} {
				append note "Telefono occupante: $telefono."
			    }
			}
		    }

		    incr ctr_scritti
		    db_1row sel_inco_s ""
		    db_dml  ins_inco   ""

		    append ls_cod_inco " $cod_inco";#rom01

		}
	    }
	}
    } {
	iter_return_complaint "Spiacente, ma il DBMS ha restituito il
        seguente messaggio di errore <br><b>$error_msg</b><br>
        Contattare amministratore di sistema e comunicare il messaggio
        d'errore. Grazie."
    }
} else {#rom01 aggiunta else e suo contenuto
    iter_return_complaint "Per procedere all'invio &egrave; necessario selezionare almeno un Impianto."
}

#if {$flag_ente  == "P"
#&&  $sigla_prov == "TN"
#} {
#    switch $tipo_estrazione {
#	"1" {set page_title "Estrazione Impianti &lt; 35kW con contratto (5%)"}
#	"2" {set page_title "Estrazione Impianti &gt; 35kW con contratto"}
#	"3" {set page_title "Estrazione Impianti senza contratto"}
#	"4" {set page_title "Estrazione Impianti da definire"}
#    }
#} else {
#    switch $tipo_estrazione {
#	"1" {set page_title "Estrazione Impianti &lt; 35kW dichiarati (5%)"}
#	"2" {set page_title "Estrazione Impianti &lt; 35kW dichiarati (mod.H scad.)"}
#	"3" {set page_title "Estrazione Impianti &gt; 35kW dichiarati"}
#	"4" {set page_title "Estrazione Impianti non dichiarati"}
#	"5" {set page_title "Estrazione Impianti da definire"}
#	default {set page_title "Estrazione Impianti"}
#    }
#}

set page_title "Estrazione "
db_1row sel_tpes ""
append page_title $descr_tpes

if {$ctr_scritti == 0} {
    set scritti "Nessun impianto da controllare inserito"
} else {
    set scritti "Numero di impianti da controllare: $ctr_scritti"
}

if {$nome_funz_caller eq "estr-mail"} {#rom01 if e suo contenuto
    set nome_funz $nome_funz_caller
    #rom01 aggiunto nell'export_url_vars f_invio_comune
    #gab01 aggiunti nell'export_url_vars flag_racc e flag_pres
    set return_url "coimstrd-mail-filter?[export_url_vars nome_funz ls_cod_inco flag_racc flag_pres f_invio_comune]"
    ad_returnredirect $return_url
    ad_script_abort
};#rom01

ad_return_template
