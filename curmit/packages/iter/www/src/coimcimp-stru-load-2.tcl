ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimcimp"
    @author          Adhoc
    @creation-date   03/05/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimcimp-gest.tcl
} {
    
   {cod_cimp         ""}
   {last_cod_cimp    ""}
   {funzione        "V"}
   {caller      "index"}
   {nome_funz        ""}
   {nome_funz_caller ""}
   {extra_par        ""}
   {cod_impianto     ""}
   {url_aimp         ""} 
   {url_list_aimp    ""}
   {gen_prog         ""}
   {flag_cimp        ""}
   {extra_par_inco   ""}
   {cod_inco         ""}
   {flag_inco        ""}
   {flag_tracciato   ""}
   {dry_run_p "f"}
    csv_file
    csv_file.tmpfile:tmpfile

} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}


# Controlla lo user

switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}

#set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]


iter_get_coimtgen
set flag_ente    $coimtgen(flag_ente)
set denom_comune $coimtgen(denom_comune)
set sigla_prov   $coimtgen(sigla_prov)
set link         [export_ns_set_vars "url"]

set page_title   "Carica Misure rilevate dallo strumento"
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

set buttons [list [list "$page_title" new]]

set context [list [list list-temp {Lista Fatture non protocollate}] $page_title]

# Get the name of the uploaded data file
set unix_file_name ${csv_file.tmpfile}

# Open file
set datafilefp   [open $unix_file_name r] ;# input file


# Leggo (e scarto) la prima riga, che contiene l'intestazione.
set line_status [gets $datafilefp elements]


set fields "temp comb o2_xa_pretty co2_xa_pretty qs cov co_1a_pretty con valvola nov non no2v no2n so2v so2n temp_fumi_xa_pretty temp_h2o_out_1a_pretty tiraggio_pretty trug et_pretty lambda h2 cond"

set decode_command "util_unlist \$elements $fields"

set count         0  ;# lines count
set errors        0  ;# wrong lines
set success_count 0  ;# loaded lines

# frammento html che conterrà eventuali errori
set error_descr   ""

db_transaction {

    set o2_1a 0
    set o2_2a 0
    set o2_3a 0
    set co2_1a 0
    set co2_2a 0
    set co2_3a 0
    set co_1a 0
    set temp_fumi_1a 0
    set temp_fumi_2a 0
    set temp_fumi_3a 0
    set temp_h2o_out_1a 0
    set tiraggio 0
    set et 0
    # Continue reading the file till the end
    while {[gets $datafilefp elements] != -1} {

        set elements [split $elements ";"]

        incr count
	#Prendo in considerazione solo le righe di misurazione 1, 120 e 140 (salto altre 5 righe oltre alla prima riga letta precedentemente) 
	if {$count ne "5" && $count ne "125" && $count ne "145"} {
	    continue
	}
        set error_p       0  ;# one line error flag

        # Decode all fields
        eval $decode_command


        # Check all the fields
	set o2_xa [ah::check_num $o2_xa_pretty 1]
	if {$o2_xa eq "Error"} {
	    set o2_xa 0
	}
	if {$count eq "5"} {
	    set o2_1a $o2_xa
	} elseif {$count eq "125"} {
	    set o2_2a $o2_xa
	} elseif {$count eq "145"} {
	    set o2_3a $o2_xa
	}
	set co2_xa [ah::check_num $co2_xa_pretty 1]
	if {$co2_xa eq "Error"} {
	    set co2_xa 0
	}
	if {$count eq "5"} {
	    set co2_1a $co2_xa
	} elseif {$count eq "125"} {
	    set co2_2a $co2_xa
	} elseif {$count eq "145"} {
	    set co2_3a $co2_xa
	}
	set co_1a [ah::check_num $co_1a_pretty 1]
	if {$co_1a eq "Error"} {
	    set co_1a 0
	}
	set temp_fumi_xa [ah::check_num $temp_fumi_xa_pretty 1]
	if {$temp_fumi_xa eq "Error"} {
	    set temp_fumi_xa 0
	}
	if {$count eq "5"} {
	    set temp_fumi_1a $temp_fumi_xa
	} elseif {$count eq "125"} {
	    set temp_fumi_2a $temp_fumi_xa
	} elseif {$count eq "145"} {
	    set temp_fumi_3a $temp_fumi_xa
	}
	set temp_h2o_out_1a [ah::check_num $temp_h2o_out_1a_pretty 1]
	if {$temp_h2o_out_1a eq "Error"} {
	    set temp_h2o_out_1a 0
	}
	set tiraggio [ah::check_num $tiraggio_pretty 1]
	if {$tiraggio eq "Error"} {
	    set tiraggio 0
	}
	set et [ah::check_num $et_pretty 1]
	if {$et eq "Error"} {
	    set et 0
	}
    }

    if {!$error_p} {
	if {!$dry_run_p} {
	    db_dml query "update coimcimp set
                                         o2_1a = :o2_1a
                                        ,o2_2a = :o2_2a
                                        ,o2_3a = :o2_3a
                                        ,co2_1a = :co2_1a
                                        ,co2_2a = :co2_2a
                                        ,co2_3a = :co2_3a
                                        ,co_1a = :co_1a
                                        ,temp_fumi_1a = :temp_fumi_1a
                                        ,temp_fumi_2a = :temp_fumi_2a
                                        ,temp_fumi_3a = :temp_fumi_3a
                                        ,temp_h2o_out_1a = :temp_h2o_out_1a
                                        ,tiraggio = :tiraggio
                                        ,et = :et
                                    where cod_cimp = :cod_cimp"
	}
	# line is completed, increase counter
	incr success_count
	
    } else {
	incr errors
    }
	
}
    
if {$errors > 0} {
    ad_return_complaint $errors $error_descr
    ad_script_abort
}

close $datafilefp

