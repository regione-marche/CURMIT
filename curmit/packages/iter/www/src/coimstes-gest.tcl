ad_page_contract {
    Lista tabella "coiminco"

    @author                  Giulio Laurenzi
    @creation-date           12/09/2005
    @param nome_funz         identifica l'entrata di menu,
                             serve per le autorizzazioni
    @cvs-id coimstco-aimp-gest.tcl 
} {
     nome_funz
    {nome_funz_caller  ""}
    {f_campagna        ""}
    {f_tipo_stat       ""}
}  -properties {
    page_title:onevalue
    context_bar:onevalue
}

# Controlla lo user
set lvl        1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

iter_get_coimtgen
set flag_ente           $coimtgen(flag_ente)
set flag_stat_estr_calc $coimtgen(flag_stat_estr_calc)
set flag_aimp_citt_estr $coimtgen(flag_aimp_citt_estr)

set page_title  "Riepilogo situazione incontri"
set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

switch $f_tipo_stat {
    "C" {
      	# devo estrarre solo i comuni della provincia o il comune interessato
	  if {$flag_ente == "P"} {
	      set cod_provincia $coimtgen(cod_provincia)
	      set where_comu   "and c.cod_provincia = :cod_provincia"
	  } else {
	      set cod_comune    $coimtgen(cod_comu)
	      set where_comu   "and c.cod_comune    = :cod_comune"
  	  }
	  set sel_inco_count [db_map sel_inco_comu] 
 	  if {$flag_stat_estr_calc == "T"} {
	      set table "<table border=1 cellpadding=0 cellspacing=0>
                         <tr>
                            <th>Comune</th>
                            <th>Incontri<br>estratti</th>
                            <th>Incontri<br>previsti</th>
                         </tr>" 
	  } else {
	      set table "<table border=1 cellpadding=0 cellspacing=0>
                         <tr>
                            <th>Comune</th>
                            <th>Incontri<br>estratti</th>
                         </tr>" 
	  }
    }
    "V" {
	# preparo la query che verra' lanciata piu' avanti
	set sel_inco_count [db_map sel_inco_verif] 
	# preparo la testata della table html
	set table "<table border=1 cellpadding=0 cellspacing=0>
                   <tr><th>Ispettore</th>"
                     
	# costruzione dinamica colonne della table html
	# ed inizializzazione del totale incontri per stato (cioe' per colonna)
	# creo una lista di tutti i cod_inst in modo da non dover rifare
	# piu' questa query

	# prevedo una colonna ed un totale per gli incontri in stato null
	# sono le disponibilita' del verificatore
	append table     "<th>Disponibilit&agrave;</th>"
	set tot_inco_stato()   0
	set list_cod_inst     ""
	lappend list_cod_inst ""
	db_foreach sel_inst {} {
	    append table "<th>$descr_inst</th>"
	    set tot_inco_stato($cod_inst) 0
	    lappend list_cod_inst         $cod_inst
	}
	append table "<th>Totale<br/>incontri estratti</th></tr>"
    }
}

set tot_inco 0
if {$f_tipo_stat == "C"
&&  $flag_stat_estr_calc == "T"
} {
    if {[db_0or1row sel_cinc_controlli_prev ""] == 0} {
	set controlli_prev 0
    }
    switch $flag_aimp_citt_estr {
	"A" {set popolazione "popolaz_citt" 
	     set pop_ente $coimtgen(popolaz_citt_tgen)
            }
	"I" {set popolazione "popolaz_aimp" 
	     set pop_ente $coimtgen(popolaz_aimp_tgen)
            }
    }
}

set array_index 0
db_foreach sel_inco_count $sel_inco_count {
    switch $f_tipo_stat {
	"C" {      
   	      if {$flag_stat_estr_calc == "T"} {
	          set num_da_estrarre_ed 0
  	          if {[db_0or1row sel_comu ""] == 0} {
		      set pop_comune ""
	          }
	          if {![string equal $pop_ente ""]} {
		      set coefficente     [expr ($pop_comune *1.00000)/$pop_ente]
		      set num_da_estrarre [expr $coefficente * $controlli_prev]
		      set num_da_estrarre_ed [iter_edit_num $num_da_estrarre 0]
	          } else {
		      set num_da_estrarre "0"
	          }
  	          append table "<tr>
                             <td>$comune</td>
                             <td align=right>$num_inco</td>
                             <td align=right>$num_da_estrarre_ed</td>
                            </tr>"
	      } else {
  	          append table "<tr>
                             <td>$comune</td>
                             <td align=right>$num_inco</td>
                            </tr>"
	      }
	}
	"V" {
	    set array_verificatore($array_index) $verificatore
	    set array_cod_opve($array_index)     $cod_opve
	    set array_stato($array_index)        $stato
	    set array_num_inco($array_index)     $num_inco
	    incr array_index

	}
    }
    set tot_inco [expr $tot_inco + $num_inco]
}

if {$f_tipo_stat == "V"} {
    # ciclo per stampare una riga per ogni verificatore
    # ed una colonna per il numero incontri per ogni stato
    set loop_index 0
    while {$loop_index < $array_index} {
	set save_cod_opve     $array_cod_opve($loop_index)
	set save_verificatore $array_verificatore($loop_index)

	# inizializzo l'array che serve per memorizzare il numero incontri
	# per ogni stato (la query precedente potrebbe non aver estratto
	# tutti gli stati
	foreach cod_inst $list_cod_inst {
	    set ctr_inco($cod_inst) 0
	}

	while {$loop_index < $array_index
	    && $array_cod_opve($loop_index) == $save_cod_opve
	} {
	    # valorizzo il numero di incontri per ogni stato
	    set cod_inst            $array_stato($loop_index)
	    set ctr_inco($cod_inst) $array_num_inco($loop_index)
	    incr loop_index
	}

	set tot_inco_verificatore 0
	append table "<tr><td>$save_verificatore</td>"
	foreach cod_inst $list_cod_inst {
	    append table "<td align=right>[iter_edit_num $ctr_inco($cod_inst) 0]</td>"
	    set tot_inco_stato($cod_inst) [expr $ctr_inco($cod_inst) + $tot_inco_stato($cod_inst)]
	    set tot_inco_verificatore     [expr $tot_inco_verificatore + $ctr_inco($cod_inst)]
	} 
	append table "<td align=right><b>[iter_edit_num $tot_inco_verificatore 0]</b></td></tr>"
    }
}
  
set tot_inco_edit [iter_edit_num $tot_inco 0]

if {$f_tipo_stat == "C"
&&  $flag_stat_estr_calc == "T"
} {
    set tot_prev_edit [iter_edit_num $controlli_prev]
    append table "
              <tr> 
                  <td><b>Totale</b></td>
                  <td align=right><b>$tot_inco_edit</b></td>
                  <td align=right><b>$tot_prev_edit</b></td> 
              </tr>
              </table>"
} else {
    append table "
              <tr> 
                  <td><b>Totale</b></td>
                  "
    foreach name [lsort [array names tot_inco_stato]] {
	append table "<td align=right><b>[iter_edit_num $tot_inco_stato($name) 0]</b></td>"
		 }
    append table "<td align=right><b>$tot_inco_edit</b></td></tr></table>"

}
db_release_unused_handles
ad_return_template 
