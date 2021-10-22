ad_page_contract {
    Add/Edit/Delete  form per la tabella "ututn"
    @author          Adhoc
    @creation-date   10/10/2003

    @param funzione  E=edit V=view
    @cvs-id          coimcpwd-gest.tcl
} {
   {funzione  "M"}
   {nome_funz ""}
   {nome_funz_caller ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
# uniche funzioni ammesse: V/E
set lvl 1
if {$funzione == "M"
||  $funzione == "V"
} {
    set lvl 1
} else {
    set lvl 9
}
#set id_utente [ad_get_cookie iter_login_[ns_conn location]]
set id_utente [iter_get_id_utente]

# se non ho trovato il cookie, id_utente e' vuoto e significa che
# l'utente non ha effettuato il login
if {[string equal $id_utente ""]} {
    iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
    return 0
}

set lung_id [string length $id_utente]
set prime_3 [string range $id_utente 0 2]
if {([string equal $prime_3 "MA0"] && $lung_id == 10) || ([string equal $prime_3 "AM0"] && $lung_id == 8)} {
} else {
    ad_returnredirect "coimcpwd-gest"
}
# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
set main_directory [ad_conn package_url]
set link "$main_directory/main"
set main_directory   [ad_conn package_url]
set titolo           "Profilo Personale"
switch $funzione {
    M {set button_label "Modifica"
       set page_title   "Modifica $titolo"}
    V {set button_label "Torna al menu"
       set page_title   "Visualizzazione $titolo"}
}

set context_bar  [iter_context_bar [list $link "Home"] $page_title]


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimcpwd"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
switch $funzione {
   "M" {set readonly_fld \{\}
        set disabled_fld \{\}
       }
}

form create $form_name \
-html    $onsubmit_cmd

element create $form_name utn_psw \
-label   "Password attuale" \
-widget   password \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name utn_psw_new \
-label   "Nuova Password" \
-widget   password \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional \

element create $form_name utn_psw_cnf \
-label   "Conferma Password" \
-widget   password \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional \

element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name nome_funz -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione  -value $funzione
    element set_properties $form_name nome_funz -value $nome_funz
  # leggo riga
    if {[db_0or1row query "select password as utn_psw
             , e_mail
             , rows_per_page
          from coimuten
         where id_utente = :id_utente"] == 0
    } {
        iter_return_complaint "Record non trovato"
    }

}

if {[form is_valid $form_name]} {

  # form valido dal punto di vista del templating system

    set utn_psw     [element::get_value $form_name utn_psw]
    set utn_psw_new [element::get_value $form_name utn_psw_new]
    set utn_psw_cnf [element::get_value $form_name utn_psw_cnf]
  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "M"
    } {


            if {[string is space $utn_psw]} {
                element::set_error $form_name utn_psw "Inserire la password attuale"
                incr error_num
	    } else {
                if {[db_0or1row query "select password as db_psw
        from coimuten
       where id_utente = :id_utente"] == 0
                ||  $db_psw != $utn_psw
                } {
                    element::set_error $form_name utn_psw "Password errata"
                    incr error_num
                }
            }

            if {[string is space $utn_psw_new]} {
                element::set_error $form_name utn_psw_new "Inserire la nuova password"
                incr error_num          
	    }

            if {[string is space $utn_psw_cnf]} {
                element::set_error $form_name utn_psw_cnf "Inserire la conferma della password"
                incr error_num
	    }
            
            if {![string is space $utn_psw_new] 
            &&  ![string is space $utn_psw_cnf]
            } {
		if {$utn_psw_cnf != $utn_psw_new} {
                    element::set_error $form_name utn_psw_cnf "La conferma della password non &egrave corretta"
                    incr error_num
		}
	    }


    }

    if {$error_num > 0} {
        ad_return_template
        return
    }


  # Lancio la query di manipolazione dati contenute in dml_sql
        with_catch error_msg {
            db_transaction {
                db_dml query "update coimuten
               set password = :utn_psw_new
             where id_utente = :id_utente"



            }
        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
 	}

set filout [open /var/lib/aolserver/itercmmi/packages/iter/www/una-tantum/cambio-pwd.txt w]

set data [ad_httpget -url http://itercm.bustoarsizio.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "itercmba : |$result(page)|$result(status)|"
set data [ad_httpget -url http://itercm.bergamo.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "itercmbg : |$result(page)|$result(status)|"
set data [ad_httpget -url http://itercm.brescia.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "itercmbs : |$result(page)|$result(status)|"
set data [ad_httpget -url http://itercm.cinisellobalsamo.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "itercmcb : |$result(page)|$result(status)|"
set data [ad_httpget -url http://itercm.colognomonzese.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "itercmcm : |$result(page)|$result(status)|"
set data [ad_httpget -url http://itercm.como.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "itercmco : |$result(page)|$result(status)|"
set data [ad_httpget -url http://itercm.cremona.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "itercmcr : |$result(page)|$result(status)|"
set data [ad_httpget -url http://itercm.gallarate.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "itercmga : |$result(page)|$result(status)|"
set data [ad_httpget -url http://itercm.lecco.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "itercmlc : |$result(page)|$result(status)|"
set data [ad_httpget -url http://itercm.legnano.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "itercmle : |$result(page)|$result(status)|"
set data [ad_httpget -url http://itercm.lodi.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "itercmlo : |$result(page)|$result(status)|"
set data [ad_httpget -url http://itercm.monza.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "itercmmb : |$result(page)|$result(status)|"
set data [ad_httpget -url http://itercm.milano.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "itercmmi : |$result(page)|$result(status)|"
set data [ad_httpget -url http://itercm.padernodugnano.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "itercmpd : |$result(page)|$result(status)|"
set data [ad_httpget -url http://itercm.pavia.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "itercmpv : |$result(page)|$result(status)|"
set data [ad_httpget -url http://itercm.rho.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "itercmro : |$result(page)|$result(status)|"
set data [ad_httpget -url http://itercm.seregno.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "itercmse : |$result(page)|$result(status)|"
set data [ad_httpget -url http://itercm.sestosangiovanni.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "itercmsg : |$result(page)|$result(status)|"
set data [ad_httpget -url http://itercm.sondrio.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "itercmso : |$result(page)|$result(status)|"
set data [ad_httpget -url http://itercm.varese.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "itercmva : |$result(page)|$result(status)|"
set data [ad_httpget -url http://itercm.vigevano.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "itercmvi : |$result(page)|$result(status)|"
set data [ad_httpget -url http://iterpr.bergamo.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "iterprbg : |$result(page)|$result(status)|"
set data [ad_httpget -url http://iterpr.brescia.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "iterprbs : |$result(page)|$result(status)|"
set data [ad_httpget -url http://iterpr.como.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "iterprco : |$result(page)|$result(status)|"
set data [ad_httpget -url http://iterpr.cremona.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "iterprcr : |$result(page)|$result(status)|"
set data [ad_httpget -url http://iterpr.lecco.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "iterprlc : |$result(page)|$result(status)|"
set data [ad_httpget -url http://iterpr.lodi.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "iterprlo : |$result(page)|$result(status)|"
set data [ad_httpget -url http://iterpr.milano.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "iterprmi : |$result(page)|$result(status)|"
set data [ad_httpget -url http://iterpr.mantova.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "iterprmn : |$result(page)|$result(status)|"
set data [ad_httpget -url http://iterpr.pavia.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "iterprpv : |$result(page)|$result(status)|"
set data [ad_httpget -url http://iterpr.sondrio.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "iterprso : |$result(page)|$result(status)|"
set data [ad_httpget -url http://iterpr.varese.curit.it/iter/una-tantum/upd-pwd?new_pwd=$utn_psw_new&id_utente=$id_utente -timeout 50]
array set result $data
puts $filout "iterprva : |$result(page)|$result(status)|"
    set link_gest [export_url_vars utn_cde nome_funz nome_funz_caller]
    switch $funzione {
        M {set return_url   "coimcpwd-gest?funzione=V&$link_gest"}
        V {set return_url   "../main"}
    }

    ad_returnredirect "../main"
    ad_script_abort
}

ad_return_template
