ad_page_contract {
    Esportazione Modelli H

    @author                  Nicola Mortoni
    @creation-date           16/05/2006

    @param nome_funz         identifica l'entrata di menu,
                             serve per le autorizzazioni

    @cvs-id coimdimp-scar.tcl

} {
   {nome_funz         ""}

   {f_cod_manu        ""}
   {f_data_ins_iniz   ""}
   {f_data_ins_fine   ""}
   {f_data_controllo_iniz ""}
   {f_data_controllo_fine ""}
}

# Controlla lo user
if {![string is space $nome_funz]} {
    set lvl        1
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
}

set swc_formato "csv"

# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]

# imposto il nome dei file
set nome_file     "Modelli H"
set nome_file     [iter_temp_file_name $nome_file]
set file_path     "$spool_dir/$nome_file.$swc_formato"
set file_url      "$spool_dir_url/$nome_file.$swc_formato"

# apro file temporaneo
set file_id [open $file_path w]
# dichiaro di scrivere in formato iso West European
fconfigure $file_id -encoding iso8859-1

set primo_rec "t"

set query_cols ""
set file_cols ""
db_foreach sel_tabs "" {
    lappend file_cols  $nome_colonna

    if {![string equal $primo_rec "t"]} {
       append query_cols " , "
    }

    switch $nome_colonna {
	"data_scadenza"            { set nome_colonna "data_scadenza" }
	"data_utile_inter"         { set nome_colonna "data_utile_inter" }
	"data_controllo"           { set nome_colonna "data_controllo" }
	"data_installazione_aimp"  { set nome_colonna "b.data_installaz as data_installazione_aimp" }
	"flag_status_g"            { set nome_colonna "null as $nome_colonna" }
	"gen_prog"                 { set nome_colonna "a.gen_prog" }
	"combustibile"             { set nome_colonna "i.descr_comb as combustibile" }
	"scarico_fumi_gend"        { set nome_colonna "c.cod_emissione as scarico_fumi_gend" }
	"tiraggio_gend"            { set nome_colonna "c.tiraggio as tiraggio_gend" }
	"fluido_termovettore_gend" { set nome_colonna "c.mod_funz as fluido_termovettore_gend" }
	"data_costruzione_gend"    { set nome_colonna "c.data_costruz_gen as data_costruzione_gend" }
        "marc_effic_energ"         { set nome_colonna "c.marc_effic_energ" }
        "cod_manutentore"          { set nome_colonna "a.cod_manutentore" }
        "cognome_manu"             { set nome_colonna "d.cognome as cognome_manu" }
        "nome_manu"                { set nome_colonna "d.nome as nome_manu" }
        "indirizzo_manu"           { set nome_colonna "d.indirizzo as indirizzo_manu" }
        "comune_manu"              { set nome_colonna "d.comune as comune_manu" }
        "telefono_manu"            { set nome_colonna "d.telefono as telefono_manu" }
        "cap_manu"                 { set nome_colonna "d.cap as cap_manu" }
        "cod_fiscale_manu"         { set nome_colonna "d.cod_fiscale as cod_fiscale_manu" }
        "nome_resp"                { set nome_colonna "e.nome as nome_resp" }
        "cognome_resp"             { set nome_colonna "e.cognome as cognome_resp" }
        "indirizzo_resp"           { set nome_colonna "e.indirizzo as indirizzo_resp" }
        "comune_resp"              { set nome_colonna "e.comune as comune_resp" }
        "provincia_resp"           { set nome_colonna "e.provincia as provincia_resp" }
        "natura_giuridica_resp"    { set nome_colonna "e.natura_giuridica as natura_giuridica_resp" }
        "cap_resp"                 { set nome_colonna "e.cap as cap_resp" }
        "cod_fiscale_resp"         { set nome_colonna "e.cod_fiscale as cod_fiscale_resp" }
        "telefono_resp"            { set nome_colonna "e.telefono as telefono_resp" }
        "nome_occu"                { set nome_colonna "f.nome as nome_occu" }
        "cognome_occu"             { set nome_colonna "f.cognome as cognome_occu" }
        "indirizzo_occu"           { set nome_colonna "f.indirizzo as indirizzo_occu" }
        "comune_occu"              { set nome_colonna "f.comune as comune_occu" }
        "provincia_occu"           { set nome_colonna "f.provincia as provincia_occu" }
        "natura_giuridica_occu"    { set nome_colonna "f.natura_giuridica as natura_giuridica_occu" }
        "cap_occu"                 { set nome_colonna "f.cap as cap_occu" }
        "cod_fiscale_occu"         { set nome_colonna "f.cod_fiscale as cod_fiscale_occu" }
        "telefono"                 { set nome_colonna "f.telefono as telefono" }
        "nome_prop"                { set nome_colonna "g.nome as nome_prop" }
        "cognome_prop"             { set nome_colonna "g.cognome as cognome_prop" }
        "indirizzo_prop"           { set nome_colonna "g.indirizzo as indirizzo_prop" }
        "comune_prop"              { set nome_colonna "g.comune as comune_prop" }
        "provincia_prop"           { set nome_colonna "g.provincia as provincia_prop" }
        "natura_giuridica_prop"    { set nome_colonna "g.natura_giuridica as natura_giuridica_prop" }
        "cap_prop"                 { set nome_colonna "g.cap as cap_prop" }
        "cod_fiscale_prop"         { set nome_colonna "g.cod_fiscale as cod_fiscale_prop" }
        "telefono_pop"             { set nome_colonna "g.telefono as telefono_pop" }
        "nome_int"                 { set nome_colonna "h.nome as nome_int" }
        "cognome_int"              { set nome_colonna "h.cognome as cognome_int" }
        "indirizzo_int"            { set nome_colonna "h.indirizzo as indirizzo_int" }
        "comune_int"               { set nome_colonna "h.comune as comune_int" }
        "provincia_int"            { set nome_colonna "h.provincia as provincia_int" }
        "natura_giuridica_int"     { set nome_colonna "h.natura_giuridica as natura_giuridica_int" }
        "cap_int"                  { set nome_colonna "h.cap as cap_int" }
        "cod_fiscale_int"          { set nome_colonna "h.cod_fiscale as cod_fiscale_int" }
        "telefono_int"             { set nome_colonna "h.telefono as telefono_int" }
        "potenza_utile_nom"        { set nome_colonna "a.potenza as potenza_utile_nom" }
	"potenza_foc_nom"          { set nome_colonna "c.pot_focolare_nom as potenza_foc_nom" }
	"volimetria_risc"          { set nome_colonna "a.volimetria_risc as volimetria_risc" }
	"consumo_annuo"            { set nome_colonna "a.consumo_annuo as consumo_annuo" }
	"data_ins"                 { set nome_colonna "a.data_ins as data_ins" }
	"data_mod"                 { set nome_colonna "a.data_mod as data_mod" }
	"utente_ins"               { set nome_colonna "a.utente_ins" }
	"anomalie_dimp"            { set nome_colonna "null as anomalie_dimp" }
	"localita"                 { set nome_colonna "b.localita" }
	"indirizzo"                { set nome_colonna "b.indirizzo" }
	"civico"                   { set nome_colonna "b.numero as civico" }
	"comune"                   { set nome_colonna "o.denominazione as comune" }
	"provincia"                { set nome_colonna "q.sigla as provincia" }
	"cap"                      { set nome_colonna "b.cap" }
	"marca"                    { set nome_colonna "n.descr_cost as marca" }
	"cod_cost_bruc"            { set nome_colonna "p.descr_cost as cod_cost_bruc" }
        "tiraggio"                 { set nome_colonna "a.tiraggio as tiraggio" }
        "stato"                    { set nome_colonna "b.stato" }
        "data_rottamaz"            { set nome_colonna "b.data_rottamaz" }
        "data_installaz"           { set nome_colonna "c.data_installaz" }
        "data_rottamaz_gen"        { set nome_colonna "c.data_rottamaz as data_rottamaz_gen" }
        "flag_attivo"              { set nome_colonna "c.flag_attivo as flag_attivo" }
    }

    append query_cols $nome_colonna
    set primo_rec "f"
}

lappend file_cols  "cod_provincia"
lappend file_cols  "cod_comune"
lappend file_cols  "cod_via"
lappend file_cols  "flag_ente"
lappend file_cols  "comune_ente"
lappend file_cols  "provincia_ente"

append query_cols ", b.cod_provincia"
append query_cols ", b.cod_comune"
append query_cols ", b.cod_via"

# imposto la query SQL e la dicitura dei criteri di selezione
set criteri_selezione "Selezione effettuata alle [iter_set_systime] del [iter_edit_date [iter_set_sysdate]] di tutti i modelli H"

# imposto la condizione SQL per manutentore
if {![string is space $f_cod_manu]} {
    set manu_cod_manutentore $f_cod_manu
    if {[db_0or1row sel_manu ""] == 0} {
	set manu_cognome ""
	set manu_nome    ""
    }
    append criteri_selezione " del manutentore $manu_cognome $manu_nome"

    set where_manu "and a.cod_manutentore = :f_cod_manu"
} else {
    set where_manu ""
}

# se richiesta selezione per data_ins
set where_data_ins ""
if {![string equal $f_data_ins_iniz ""]} {
    set f_data_ins_iniz_edit       [iter_edit_date $f_data_ins_iniz]
    append criteri_selezione " da data inserimento $f_data_ins_iniz_edit"

    # dato che oracle memorizza anche l'ora, sono costretto a fare cosi':
    append f_data_ins_iniz " 00:00:00"
    append where_data_ins  "
    and a.data_ins >= to_date(:f_data_ins_iniz,'yyyymmdd hh24:mi:ss')"
}
if {![string equal $f_data_ins_fine ""]} {
    set f_data_ins_fine_edit      [iter_edit_date $f_data_ins_fine]
    append criteri_selezione " a data inserimento $f_data_ins_fine_edit"

    # dato che oracle memorizza anche l'ora, sono costretto a fare cosi':
    append f_data_ins_fine " 23:59:59"
    append where_data_ins  "
    and a.data_ins <= to_date(:f_data_ins_fine,'yyyymmdd hh24:mi:ss')"
}

# se richiesta selezione per data_controllo
set where_data_controllo ""
if {![string equal $f_data_controllo_iniz ""]} {
    set f_data_controllo_iniz_edit [iter_edit_date $f_data_controllo_iniz]
    append criteri_selezione   " da data controllo $f_data_controllo_iniz_edit"

    # questa volta non serve l'ora perche' data_controllo viene inserita senza
    append where_data_controllo  "
    and a.data_controllo >= :f_data_controllo_iniz"
}
if {![string equal $f_data_controllo_fine ""]} {
    set f_data_controllo_fine_edit [iter_edit_date $f_data_controllo_fine]
    append criteri_selezione    " a data controllo $f_data_controllo_fine_edit"

    # questa volta non serve l'ora perche' data_controllo viene inserita senza
    append where_data_controllo  "
    and a.data_controllo <= :f_data_controllo_fine"
}
# imposto il criterio di ordinamento

# per oracle sono obbligato a fare una to_char, per postgres posso evitare
# e puo' essere meglio per il suo ottimizzatore.
if {[iter_get_parameter database] == "postgres"} {
    set def_data_ins_per_order_by "a.data_ins"
} else {
    set def_data_ins_per_order_by "to_char(a.data_ins,'yyyy-mm-dd')"
}

if {[string equal $f_data_ins_iniz ""]
&&  [string equal $f_data_ins_fine ""]
&& (   ![string equal $f_data_controllo_iniz ""]
    || ![string equal $f_data_controllo_fine ""])
} {
    set  order_by "
         order by a.flag_tracciato
                , a.data_controllo
                , $def_data_ins_per_order_by
                , b.cod_impianto_est"
} else {
    set  order_by "
         order by a.flag_tracciato
                , $def_data_ins_per_order_by
                , a.data_controllo
                , b.cod_impianto_est"
}

# scrivo la dicitura dei criteri di selezione
set criteri_selezione_list [list $criteri_selezione]
# uso la proc perche' i file csv hanno caratterstiche 'particolari'
iter_put_csv $file_id criteri_selezione_list

# reperisco una volta per tutte i dati della tabella dei dati generali
iter_get_coimtgen
set tipo_ente   $coimtgen(flag_ente)
db_1row sel_ente "select cod_prov , cod_comu from coimtgen"

# inizio del ciclo
set sw_primo_rec     "t"

db_foreach sel_dimp_aimp "" {

    set flag_ente $tipo_ente
    set comune_ente $cod_comu
    set provincia_ente $cod_prov

    set anomalie_dimp ""
    set prima_anom "t"
    db_foreach sel_anom "" {
	if {![string equal $prima_anom "t"]} {
	    append anomalie_dimp ","
	}
	append anomalie_dimp $cod_tanom
	set prima_anom "f"
    }

    set file_col_list ""
    foreach column_name $file_cols {

	lappend file_col_list [set $column_name]
    }
    iter_put_csv $file_id file_col_list |

} if_no_rows {
    set msg_err      "Nessun allegato selezionato con i criteri utilizzati"
    set msg_err_list [list $msg_err]
    iter_put_csv $file_id msg_err_list
}

# chiudo file csv
close $file_id


# visualizzo il file creato
#ns_returnfile 200 text/plain $file_path
#ns_returnfile 200 application/csv $file_path
# questa e' la migliore se sul proprio pc si sceglie di aprire i file csv
# sempre con blocco note e non con xls
# tra l'altro e' possibile fare direttamente sul link 'salva oggetto con nome'
ad_returnredirect $file_url
ad_script_abort
