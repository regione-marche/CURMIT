ad_page_contract {
    Add/Edit/Delete  form per la tabella "ututn"
    @author          Adhoc
    @creation-date   10/10/2003

    @param funzione  E=edit V=view
    @cvs-id          coimcpwd-gest.tcl
} {
   {funzione  "V"}
   {nome_funz ""}
   {nome_funz_caller ""}
   {id_utente ""}
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
if {$id_utente eq ""} {
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
}
set lung_id [string length $id_utente]
set prime_3 [string range $id_utente 0 2]

#if {([string equal $prime_3 "MA0"] && $lung_id == 10) || ([string equal $prime_3 "AM0"] && $lung_id == 8)} {
#    ad_returnredirect "coimcpwd-curit-gest"
#}
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

element create $form_name utn_eml \
-label   "E-Mail" \
-widget   text \
-datatype text \
-html    "size 50 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name utn_rgh \
-label   "Righe per pagina" \
-widget   select \
-options [iter_selbox_from_table coimrgh rgh_cde rgh_cde] \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional


element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name id_utente -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione  -value $funzione
    element set_properties $form_name nome_funz -value $nome_funz
     element set_properties $form_name id_utente -value $id_utente
  # leggo riga
    if {[db_0or1row get_current_values ""] == 0
    } {
        iter_return_complaint "Record non trovato"
    }

    element set_properties $form_name utn_eml -value $e_mail
    element set_properties $form_name utn_rgh -value $rows_per_page
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set utn_psw     [element::get_value $form_name utn_psw]
    set utn_psw_new [element::get_value $form_name utn_psw_new]
    set utn_psw_cnf [element::get_value $form_name utn_psw_cnf]
    set utn_eml     [element::get_value $form_name utn_eml]
    set utn_rgh     [element::get_value $form_name utn_rgh]
  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "M"
    } {
        set control_psw "f"
        if {![string is space $utn_psw]} {
            set control_psw "t"
        }
        if {![string is space $utn_psw_new]} {
            set control_psw "t"
        }
        if {![string is space $utn_psw_cnf]} {
            set control_psw "t"
        }

        if {$control_psw == "t"} {
            if {[string is space $utn_psw]} {
                element::set_error $form_name utn_psw "Inserire la password attuale"
                incr error_num
	    } else {
                if {[db_0or1row get_psw ""] == 0
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

     set lung_psw [string length $utn_psw_new]

     if {($lung_psw != 8 )} {
                element::set_error $form_name utn_psw_new "La password deve essere lunga 8 caratteri"
                incr error_num          
	    }

            if {[string is space $utn_psw_cnf]} {
                element::set_error $form_name utn_psw_cnf "Inserire la conferma della password"
                incr error_num
	    }
       
          if {$utn_psw_new == $utn_psw } {
		     element::set_error $form_name utn_psw_new "La password non puo' essere uguale alla precedente"
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

        if {[string equal $utn_eml ""]} {
            element::set_error $form_name utn_eml "Inserire E-Mail"
            incr error_num
        }

        if {[string equal $utn_rgh ""]} {
            element::set_error $form_name utn_rgh "Inserire Righe per pagina"
            incr error_num
        }
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    if {$funzione == "M"} {
        if {$control_psw == "t"} {
            set set_utn_psw ", password = :utn_psw_new"
        } else {
            set set_utn_psw ""
        }
        set dml_sql [db_map upd_uten] 

    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_ututn $dml_sql

              # sovrascrivo il cookie delle righe per pagina
                ad_set_cookie -replace t -path / iter_rows_[ns_conn location] $utn_rgh
            }
        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
 	}
    }

    set link_gest [export_url_vars utn_cde nome_funz id_utente nome_funz_caller]
    set return_url   "../main?id_utente=$id_utente"
 

#    ad_returnredirect $return_url
    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
