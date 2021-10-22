ad_page_contract {
    @creation-date   10/05/2004

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coiminco-filter.tcl     
} {
   {f_riferimento     ""}
   {caller       "index"}
   {funzione         "V"}
   {nome_funz         ""}
   {nome_funz_caller  ""}   
}  -properties {
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

set link_filter [export_ns_set_vars url]

set titolo       "Riferimento pagamento bollino"
set page_title   "Riferimento pagamento bollino"
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller] 

set lista_imp [list]
set maschera ""

db_foreach sel_dimp "" {

    set data_consegna_tot ""
    set manu_boll_tot ""
    set primo_rec "t"
    set manu_boll ""
    set data_consegna ""
#    db_foreach sel_boll "" {
#	if {$primo_rec == "f"} {
#	    append data_consegna_tot " - "
#	    append manu_boll_tot " - "
#	}
#	set primo_rec "f"
#	append data_consegna_tot $data_consegna
#	append manu_boll_tot $manu_boll
#    }

    append maschera "<table width=100%>
                       <tr><td colspan=3>&nbsp;</td></tr>
                       <tr><td align=right width=40%>Data dichiarazione:</td>
                           <td width=2%>&nbsp;</td>
                           <td><b>$data_controllo</b></td>
                       </tr>
                       <tr><td align=right>Codice Impianto:</td>
                           <td>&nbsp;</td>
                           <td><b>$cod_impianto_est</b></td>
                       </tr>
                       <tr><td align=right>Responsabile Impianto:</td>
                           <td>&nbsp;</td>
                           <td><b>$responsabile</b></td>
                       </tr>
                       <tr><td align=right>Manutentore da dichiarazione:</td>
                           <td>&nbsp;</td>
                           <td><b>$manu_dimp</b></td>
                       </tr>
                       <tr><td align=right>Manutentore da acquisto bollini:</td>
                           <td>&nbsp;</td>
                           <td><b>$manu_boll</b></td>
                       </tr>
                       <tr><td align=right>Data aquisto bollini:</td>
                           <td>&nbsp;</td>
                           <td><b>$data_consegna</b></td>
                       </tr>
                 </table>"

    lappend lista_imp [list $cod_impianto_est]
    set flag_trovato "S"
    
} if_no_rows {

    set data_consegna_tot ""
    set manu_boll_tot ""
    set primo_rec "t"
#ns_log notice "giorgio          select a.data_consegna
#               , b.cognome||' '||coalesce(b.nome, '') as manu_boll
#            from coimboll a
# left outer join coimmanu b on b.cod_manutentore = a.cod_manutentore          
#           where to_number($f_riferimento, '99999999999999999999') between to_number(a.matricola_da, '99999999999999999999') and to_number(a.matricola_a, '99999999999999999999')"

#    db_foreach sel_boll "" {
#	if {$primo_rec == "f"} {
#	    append data_consegna_tot " - "
#	    append manu_boll_tot " - "
#	}
#	set primo_rec "f"
#	append data_consegna_tot $data_consegna
#	append manu_boll_tot $manu_boll
#    }

    if {[exists_and_not_null manu_boll]} {
	append maschera "<table width=100%>
                               <tr><td>&nbsp;</td></tr>
                               <tr><td align=center>Il bollino non è ancora stato utilizzato dal manutentore <b>$manu_boll_tot</b></td></tr>
                               <tr><td align=center>Data aquisto bollini <b>$data_consegna_tot</b></td>
                               </tr>
                         </table>"
    } else {
	append maschera "<table width=100%>
                               <tr><td colspan=2>&nbsp;</td></tr>
                               <tr><td colspan=2 align=center>Codice bollino non trovato</td></tr>
                         </table>"
    }
    set flag_trovato "N"
}

set link_aimp "coimaimp-list?nome_funz=[iter_get_nomefunz coimaimp-list]&[export_url_vars nome_funz_caller f_riferimento]"

ad_return_template
