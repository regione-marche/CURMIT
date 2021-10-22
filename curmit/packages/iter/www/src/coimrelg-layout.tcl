ad_page_contract {

    @author          Giulio Laurenzi
    @creation-date   08/03/2004

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @cvs-id          coimrelg-layout.tcl
} {
    {nome_funz         ""}
    {nome_funz_caller  ""}
    {cod_relg          ""}
    {last_data_rel     ""}
    {last_ente_istat   ""}
} -properties {
}

set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]

# imposto il nome dei file
set nome_file        "stampa relazione biennale"
set nome_file        [iter_temp_file_name $nome_file]
set file_html        "$spool_dir/$nome_file.html"
set file_pdf         "$spool_dir/$nome_file.pdf"
set file_pdf_url     "$spool_dir_url/$nome_file.pdf"

set file_id     [open $file_html w]
fconfigure $file_id -encoding iso8859-1

# creo le lista delle classi, sotto classi, potenze, periodi, combustibile,
# con relative descrizioni

set lista_id_pot  { {1 {&lt; 35 kW}} {2 {da 35 kW a 116 kW}} {3 {&gt; 116 kW a 350 kW}} {4 {oltre 350 kW}}}
set lista_id_per  {{1 {prima del 1990}} {2 {1990-2000}} {3 {oltre il 2000}}}
set lista_id_comb {{1 {gas naturale}} {2 {GPL}} {3 {gasolio}} {5 {altro}} }
set lista_clsnc { {{} {}} {5 {Numero di verifiche effettuate nella campagna ripartite per:}} {1 {Non conformit&agrave; sul risparmio energetico in valore assoluto ripartiti per:}} {2 {Non conformit&agrave; ad altre disposizioni in valore assoluto in impianti &lt; 35kW ripartiti per:}} {3 {Non conformit&agrave; ad altre disposizioni in valore assoluto in impianti &gt;= 35 kW ripartiti per:}} {4 {Altre non conformit&agrave; ad altre disposizioni e/o disposizioni amm.ve in valore assoluto ripartite per:}} }
set lista_stcls1 { {{} {}} {1 8a)} {2 8b)} {3 8c)} {4 8d)}}
set lista_stcls2 { {} {1 A1} {2 A2} {3 A3} {4 A4} {5 A5} {6 A6} {7 A7} {8 A8} {9 A9} {10 A10} {11 A11} {12 A12} {13 A13} {14 A14} {15 A15} {16 A16} {17 A17} {18 A18}}
set lista_stcls3 {{} {1 C1} {2 C2} {3 C3} {4 C4} {5 C5} {6 C6} {7 C7} {8 C8} {9 C9} {10 C10} {11 C11} {12 C12} {13 C13} {14 C14}}

if {[db_0or1row sel_relg ""] == 0} {
    iter_return_complaint "Relazione Biennale non trovata"
}

if {[string equal $npiva_ader_conv ""]} {
    set npiva_ader_conv "&nbsp;"
}
if {[string equal $npiva_ass_acc_reg ""]} {
    set npiva_ass_acc_reg "&nbsp;"
}
if {[string equal $nimp_tot_aut_ente ""]} {
    set nimp_tot_aut_ente "&nbsp;"
}
if {[string equal $nimp_tot_centr_ente ""]} {
    set nimp_tot_centr_ente "&nbsp;"
}
if {[string equal $nimp_tot_telerisc_ente ""]} {
    set nimp_tot_telerisc_ente "&nbsp;"
}

# routine di calcoli per la classe 1
set calc_cls1 {
    # suddivisione per potenza
    foreach elemento $lista_id_pot {
	set id_pot [lindex $elemento 0]
	if {[info exists clsnc_pot($id_pot)] == 1} {
	    set clsnc_tot [expr $clsnc_tot + $clsnc_pot($id_pot)]
	}
	if {$id_pot == 1} {
            if {[info exists clsnc_pot($id_pot)] == 1} {
		set clsnc_min35 $clsnc_pot($id_pot)
	    } else {
		set clsnc_min35 0
	    }
	}
    }
    
    set clsnc_maj35 [expr $clsnc_tot - $clsnc_min35]

    # suddivisione per potenza e periodo
    db_foreach sel_relt_id_clsnc_pot_per "" {
	set clsnc_pot_per($id_pot,$id_per) $n
    }
    # suddivisione per potenza e combustibile
    db_foreach sel_relt_id_clsnc_pot_comb "" {
	set clsnc_pot_comb($id_pot,$id_comb) $n
    }  
}

# routine di calcoli per la classe 2
set calc_cls2 {

    set id_pot 1
    foreach elemento $lista_id_per {
	set id_per [lindex $elemento 0]
	if {[info exists clsnc_per($id_per)] == 1} {
	    set clsnc_tot [expr $clsnc_tot + $clsnc_per($id_per)]
	}
    }

    # calcolo della percentuale
    db_1row sel_relt_id_clsnc_v_5_1 ""
    if {[info exists clsnc_pot($id_pot)] == 1} {
	set clsnc_perc [expr 100.00 * $clsnc_tot]
	set clsnc_perc [expr $clsnc_perc / $tot_verif]
	set clsnc_perc [iter_edit_num $clsnc_perc 2]
    } else {
	set clsnc_perc ""
    }
}
# routine di calcoli per la classe 3
set calc_cls3 {
    # suddivisione per potenza
    set tot_verif_maj35 0
    foreach elemento $lista_id_pot {
	set id_pot [lindex $elemento 0]
        db_1row sel_relt_id_clsnc_v_5_1 ""
	set tot_verif_maj35 [expr $tot_verif_maj35 + $tot_verif]
	if {[info exists clsnc_pot($id_pot)] == 1
	&&  $id_pot != 1
	} {
	    set clsnc_tot [expr $clsnc_tot + $clsnc_pot($id_pot)]
	}
    }  

    # calcolo percentuale
    if {$tot_verif_maj35 > 0} {
	set clsnc_perc [expr 100.00 * $clsnc_tot]
	set clsnc_perc [expr $clsnc_perc / $tot_verif_maj35]
	set clsnc_perc [iter_edit_num $clsnc_perc 2]
    } else {
	set clsnc_perc ""
    }

    # suddivisione per potenza e periodo
    db_foreach sel_relt_id_clsnc_pot_per "" {
	set clsnc_pot_per($id_pot,$id_per) $n
    }
    # suddivisione per potenza e combustibile
    db_foreach sel_relt_id_clsnc_pot_comb "" {
	set clsnc_pot_comb($id_pot,$id_comb) $n
    }
}
# routine di calcoli per la classe 4
set calc_cls4 {

    # calcolo totali
    set clsnc_min35 0
    foreach elemento $lista_id_pot {
	set id_pot [lindex $elemento 0]
	if {[info exists clsnc_pot_d($id_pot)] == 1} {
	    set clsnc_tot [expr $clsnc_tot + $clsnc_pot_d($id_pot)]
	}
	if {$id_pot == 1
	&&  [info exists clsnc_pot_d($id_pot)] == 1
	} {
	    set clsnc_min35 $clsnc_pot_d($id_pot)
	}
    }
    
    set clsnc_maj35 [expr $clsnc_tot - $clsnc_min35]
   
    # suddivisione per potenza e periodo
    db_foreach sel_relt_id_clsnc_pot_per_d "" {
	set clsnc_pot_per($id_pot,$id_per) $n
    }

    # suddivisione per potenza e combustibile
    db_foreach sel_relt_id_clsnc_pot_comb_d "" {
	set clsnc_pot_comb($id_pot,$id_comb) $n
    }
}

# routine di calcoli per la classe 5
set calc_cls5 {

    # calcolo totalie
    foreach elemento $lista_id_pot {
	set id_pot [lindex $elemento 0]
	db_1row sel_relt_id_clsnc_v_5_1 ""
	set clsnc_tot [expr $clsnc_tot + $tot_verif]
	set clsnc_pot($id_pot) $tot_verif
	if {$id_pot == 1} {
	    set clsnc_min35 $tot_verif
	}
    }   
    set clsnc_maj35 [expr $clsnc_tot - $clsnc_min35] 

    # generatori - suddivisione per potenza
    set id_stclsnc 1  
    db_foreach sel_relt_id_clsnc_pot_gend "" {
	set clsnc_pot_gend($id_pot) $n
    }
    # suddivisione per potenza e periodo
    db_foreach sel_relt_id_clsnc_pot_per "" {
	set clsnc_pot_per($id_pot,$id_per) $n
    }
    # suddivisione per potenza e combustibile
    db_foreach sel_relt_id_clsnc_pot_comb "" {
	set clsnc_pot_comb($id_pot,$id_comb) $n
    }  

}

# routine di stampa per la classe 1
set layout_cls1 { 
    append stampa "
        </table>
        <!-- PAGE BREAK -->
        <table width=100% border=1 cellpadding=3 cellspacing=0>
        <tr>
           <td colspan=7 align=center bgcolor=#D6D6D6><b>RISULTATI DELLE VERIFICHE</b></td>
        </tr>
        <tr>
            <td width=5%  align=center>$n_tabella</td>
            <td width=5%  align=center>$n_tabella2</td>
            <td width=90% align=left colspan=5>$descr_risultati_verifiche</td>
        </tr>
        <tr>
            <td align=center rowspan=17>&nbsp;</td>
            <td align=center rowspan=17>$num_stcls</td>
            <td width=50% align=left colspan=3>$descr_totale $descr_anom</td>
            <td width=40% align=left colspan=2>$clsnc_tot</td>
        </tr>
        <tr>
            <td align=left colspan=3>Numero totale impianti &lt;35 kW non conformi $descr_anom</td>
            <td align=left colspan=2>$clsnc_min35</td>
        </tr>
        <tr>
            <td align=left colspan=3>Numero totale impianti &gt;=35 kW non conformi $descr_anom</td>
            <td align=left colspan=2>$clsnc_maj35</td>
        </tr>
        <tr>
            <td align=left colspan=5>suddivisione per classi di potenza (per impianti &gt;= 35 kW):</td>
        </tr>
        <tr>
           <td width=18% rowspan=2>&nbsp;</td>
        "
    # suddivisione per potenza
    foreach elemento $lista_id_pot {
	set descr_pot [lindex $elemento 1]
	append stampa "<td align=center width=18%>$descr_pot</td>"
    }
    append stampa "</tr><tr>"
    
    foreach elemento $lista_id_pot {
	set id_pot [lindex $elemento 0]
	if {$id_pot == 1} {
	    append stampa "<td bgcolor=#D6D6D6>&nbsp;</td>"
	} else {
	    if {[info exists clsnc_pot($id_pot)] == 1} {
		append stampa "<td align=left>N. $clsnc_pot($id_pot)</td>"
	    } else {
		append stampa "<td align=left>N.</td>"
	    }
	}
    }
    
    # suddivisione per potenza e periodo 
    append stampa "
        <tr>
            <td align=left colspan=5>suddivisione per anno di installazione/ristrutturazione dell'impianto (per impianti &gt;=35kW)</td>
        </tr>
        <tr>
        <td>&nbsp</td>
        "

    foreach elemento $lista_id_pot {
	set desc_pot [lindex $elemento 1]
	append stampa "<td align=center>$desc_pot</td>"
    }
    append stampa "</tr>"
    
    foreach elemento $lista_id_per {
	set id_per [lindex $elemento 0]
	set desc_per [lindex $elemento 1]
	append stampa "<tr><td align=center>$desc_per</td>"
	foreach elemento2 $lista_id_pot {
	    set id_pot [lindex $elemento2 0]
	    if {[info exists clsnc_pot_per($id_pot,$id_per)] == 1} {
		append stampa "<td align=left>N. $clsnc_pot_per($id_pot,$id_per)</td>"
	    } else {
		append stampa "<td align=left>N.</td>"
	    }
	}
	append stampa "</tr>"
    }

    # suddivisione per potenza e combustibile
    append stampa "
        <tr>
            <td align=left colspan=5>suddivisione per tipo combustibile dell'impianto: </td>
        </tr>
        <tr>
        <td>&nbsp</td>
        "
    foreach elemento $lista_id_pot {
	set desc_pot [lindex $elemento 1]
	append stampa "<td align=center>$desc_pot</td>"
    }
    append stampa "</tr>"
    
    foreach elemento $lista_id_comb {
	set id_comb [lindex $elemento 0]
	set desc_per [lindex $elemento 1]
	append stampa "<tr><td align=center>$desc_per</td>"
	foreach elemento2 $lista_id_pot {
	    set id_pot [lindex $elemento2 0]
	    if {[info exists clsnc_pot_comb($id_pot,$id_comb)] == 1} {
		append stampa "<td align=left>N. $clsnc_pot_comb($id_pot,$id_comb)</td>"
	    } else {
		append stampa "<td align=left>N.</td>"
	    }
	}
	append stampa "</tr>"
    }

}

# routine di stampa per la classe 2
set layout_cls2 { 
    # con il seguente if imposto il salto di pagina
    if {$id_stclsnc == 1
    ||  $id_stclsnc == 9
    ||  $id_stclsnc == 17
    } {
	append stampa "
        </table>
        <!-- PAGE BREAK -->
        <table width=100% border=1 cellpadding=1 cellspacing=0>
        <tr>
           <td colspan=5 align=center bgcolor=#D6D6D6><b>RISULTATI DELLE VERIFICHE</b></td>
        </tr>
        <tr>
            <td width=5%  align=center>$n_tabella</td>
            <td width=5%  align=center>$n_tabella2</td>
            <td width=90% align=left colspan=3>$descr_risultati_verifiche</td>
        </tr>
        <tr>
            <td align=center rowspan=49>&nbsp;</td>
            <td align=center valign=top rowspan=6>$num_stcls</td>"

	set sav_stcl $id_stclsnc
    } else {
	append stampa "<tr>"
	if {$sav_stcl != $id_stclsnc} {
	    append stampa "<td align=center valign=top rowspan=6>$num_stcls</td>"
	}
    }
    append stampa "
            <td width=67% colspan=2 align=left>$descr_totale $descr_anom</td>
            <td width=33% colspan=1 align=left>$clsnc_tot</td>
        </tr>
        <tr>
            <td align=left colspan=2>Percentuale impianti $descr_fascia non conformi codice $descr_anom </td>
            <td align=left colspan=1>$clsnc_perc &#037;</td>
        </tr>
        <tr>
            <td align=left colspan=3>suddivisione per anno di installazione del generatore:</td>
        </tr>
        "
    # suddivisione per periodo
    foreach elemento $lista_id_per {
	set id_per [lindex $elemento 0]
	set desc_per [lindex $elemento 1]
	append stampa "<tr><td align=center colspan=1 width=15%>$desc_per"
	if {$id_pot == 1
	&&  [info exists clsnc_per($id_per)] == 1
	} {
	    append stampa "<td align=left colspan=2 width=85%>N. $clsnc_per($id_per)</td>"
	} else {
	    append stampa "<td align=left colspan=2 width=85%>N.</td>"
	}
	append stampa "</tr>"
    }
}

# routine di stampa per la classe 3
set layout_cls3 { 
    # con il seguente if imposto il salto di pagina
    if {$id_stclsnc == 1
    ||  $id_stclsnc == 3
    ||  $id_stclsnc == 5
    ||  $id_stclsnc == 7
    ||  $id_stclsnc == 9
    ||  $id_stclsnc == 11
    ||  $id_stclsnc == 13
    } {
	append stampa "
        </table>
        <!-- PAGE BREAK -->
        <table width=100% border=1 cellpadding=3 cellspacing=0>
        <tr>
           <td colspan=6 align=center bgcolor=#D6D6D6><b>RISULTATI DELLE VERIFICHE</b></td>
        </tr>
        <tr>
            <td width=5%  align=center>$n_tabella</td>
            <td width=5%  align=center>$n_tabella2</td>
            <td width=90% align=left colspan=4>$descr_risultati_verifiche</td>
        </tr>
        <tr>
            <td align=center rowspan=49>&nbsp;</td>
            <td align=center valign=top rowspan=16>$num_stcls</td>"

	set sav_stcl $id_stclsnc
    } else {
	append stampa "<tr>"
	if {$sav_stcl != $id_stclsnc} {
	    append stampa "<td align=center valign=top rowspan=16>$num_stcls</td>"
	}
    }
    append stampa "
            <td width=45% colspan=2 align=left>$descr_totale $descr_anom</td>
            <td width=45% colspan=2 align=left>$clsnc_tot</td>
        </tr>
        <tr>
            <td align=left colspan=2>Percentuale impianti $descr_fascia non conformi codice $descr_anom </td>
            <td align=left colspan=2>$clsnc_perc &#037;</td>
        </tr>
        <tr>
            <td align=left colspan=4>suddivisione per classi di potenza (per impianti &gt;= 35 kW):</td>
        </tr>
        <tr>
           <td width=22.5% rowspan=2>&nbsp;</td>
        "
    # suddivisione per potenza
    foreach elemento $lista_id_pot {
	set descr_pot [lindex $elemento 1]
	set id_pot [lindex $elemento 0]
	if {$id_pot != 1} {
	    append stampa "<td align=center width=22.5%>$descr_pot</td>"
	}
    }
    append stampa "</tr><tr>"
    
    foreach elemento $lista_id_pot {
	set id_pot [lindex $elemento 0]
	if {$id_pot != 1} {
	    if {[info exists clsnc_pot($id_pot)] == 1} {
		append stampa "<td align=left>N. $clsnc_pot($id_pot)</td>"
	    } else {
		append stampa "<td align=left>N.</td>"
	    }
	}
    }
    
    # suddivisione per potenza e periodo
    append stampa "
        <tr>
            <td align=left colspan=4>suddivisione per anno di installazione/ristrutturazione dell'impianto: </td>
        </tr>
        <tr>
        <td>&nbsp</td>
        "

    foreach elemento $lista_id_pot {
	set desc_pot [lindex $elemento 1]
	set id_pot [lindex $elemento 0]
	if {$id_pot != 1} {
	    append stampa "<td align=center>$desc_pot</td>"
	}
    }
    append stampa "</tr>"
    
    foreach elemento $lista_id_per {
	set id_per [lindex $elemento 0]
	set desc_per [lindex $elemento 1]
	append stampa "<tr><td align=center>$desc_per</td>"
	foreach elemento2 $lista_id_pot {
	    set id_pot [lindex $elemento2 0]
	    if {$id_pot != 1} {
		if {[info exists clsnc_pot_per($id_pot,$id_per)] == 1} {
		    append stampa "<td align=left>N. $clsnc_pot_per($id_pot,$id_per)</td>"
		} else {
		    append stampa "<td align=left>N.</td>"
		}
	    }
	}
	append stampa "</tr>"
    }

    # suddivisione per potenza e combustibile
    append stampa "
        <tr>
            <td align=left colspan=4>suddivisione per tipo combustibile dell'impianto: </td>
        </tr>
        <tr>
        <td>&nbsp</td>
        "

    foreach elemento $lista_id_pot {
	set desc_pot [lindex $elemento 1]
	set id_pot [lindex $elemento 0]
	if {$id_pot != 1} {
	    append stampa "<td align=center>$desc_pot</td>"
	}
    }
    append stampa "</tr>"
    
    foreach elemento $lista_id_comb {
	set id_comb [lindex $elemento 0]
	set desc_comb [lindex $elemento 1]
	append stampa "<tr><td align=center>$desc_comb</td>"
	foreach elemento2 $lista_id_pot {
	    set id_pot [lindex $elemento2 0]
	    if {$id_pot != 1} {
		if {[info exists clsnc_pot_comb($id_pot,$id_comb)] == 1} {
		    append stampa "<td align=left>N. $clsnc_pot_comb($id_pot,$id_comb)</td>"
		} else {
		    append stampa "<td align=left>N.</td>"
		}
	    }
	}
	append stampa "</tr>"
    }

}

# routine di stampa per la classe 4
set layout_cls4 { 

    append stampa "
        </table>
        <!-- PAGE BREAK -->
        <table width=100% border=1 cellpadding=3 cellspacing=0>
        <tr>
           <td colspan=7 align=center bgcolor=#D6D6D6><b>RISULTATI DELLE VERIFICHE</b></td>
        </tr>
        <tr>
            <td width=5%  align=center>$n_tabella</td>
            <td width=5%  align=center>$n_tabella2</td>
            <td width=90% align=left colspan=5>$descr_risultati_verifiche</td>
        </tr>
        <tr>
            <td align=center rowspan=17>&nbsp;</td>
            <td align=center rowspan=17>&nbsp;</td>
            <td width=50% align=left colspan=3>$descr_totale</td>
            <td width=40% align=left colspan=2>$clsnc_tot</td>
        </tr>
        <tr>
            <td align=left colspan=3>Numero totale impianti &lt;35 kW non conformi</td>
            <td align=left colspan=2>$clsnc_min35</td>
        </tr>
        <tr>
            <td align=left colspan=3>Numero totale impianti &gt;=35 kW non conformi</td>
            <td align=left colspan=2>$clsnc_maj35</td>
        </tr>
        <tr>
            <td align=left colspan=5>suddivisione per classi di potenza (per impianti &gt;= 35 kW):</td>
        </tr>
        <tr>
           <td width=18% rowspan=2>&nbsp;</td>
        "
    # suddivisione per potenza
    foreach elemento $lista_id_pot {
	set descr_pot [lindex $elemento 1]
	append stampa "<td align=center width=18%>$descr_pot</td>"
    }
    append stampa "</tr><tr>"
    
    foreach elemento $lista_id_pot {
	set id_pot [lindex $elemento 0]
	if {$id_pot == 1} {
	    append stampa "<td bgcolor=#D6D6D6>&nbsp;</td>"
	} else {
	    if {[info exists clsnc_pot($id_pot)] == 1} {
		append stampa "<td align=left>N. $clsnc_pot($id_pot)</td>"
	    } else {
		append stampa "<td align=left>N.</td>"
	    }
	}
    }
    
    # suddivisione per potenza e perido
    append stampa "
        <tr>
            <td align=left colspan=5>suddivisione per anno di installazione/ristrutturazione dell'impianto (per impianti &gt;=35kW)</td>
        </tr>
        <tr>
        <td>&nbsp</td>
        "

    foreach elemento $lista_id_pot {
	set desc_pot [lindex $elemento 1]
	append stampa "<td align=center>$desc_pot</td>"
    }
    append stampa "</tr>"
    
    foreach elemento $lista_id_per {
	set id_per [lindex $elemento 0]
	set desc_per [lindex $elemento 1]
	append stampa "<tr><td align=center>$desc_per</td>"
	foreach elemento2 $lista_id_pot {
	    set id_pot [lindex $elemento2 0]
	    if {[info exists clsnc_pot_per($id_pot,$id_per)] == 1} {
		append stampa "<td align=left>N. $clsnc_pot_per($id_pot,$id_per)</td>"
	    } else {
		append stampa "<td align=left>N.</td>"
	    }
	}
	append stampa "</tr>"
    }

    # suddivisione per potenza e combustibile
    append stampa "
        <tr>
            <td align=left colspan=5>suddivisione per tipo combustibile dell'impianto: </td>
        </tr>
        <tr>
        <td>&nbsp</td>
        "
    foreach elemento $lista_id_pot {
	set desc_pot [lindex $elemento 1]
	append stampa "<td align=center>$desc_pot</td>"
    }
    append stampa "</tr>"
    
    foreach elemento $lista_id_comb {
	set id_comb [lindex $elemento 0]
	set desc_per [lindex $elemento 1]
	append stampa "<tr><td align=center>$desc_per</td>"
	foreach elemento2 $lista_id_pot {
	    set id_pot [lindex $elemento2 0]
	    if {[info exists clsnc_pot_comb($id_pot,$id_comb)] == 1} {
		append stampa "<td align=left>N. $clsnc_pot_comb($id_pot,$id_comb)</td>"
	    } else {
		append stampa "<td align=left>N.</td>"
	    }
	}
	append stampa "</tr>"
    }

}

# routine di stampa per la classe 5
set layout_cls5 { 
    append stampa "
        </table>
        <!-- PAGE BREAK -->
        <table width=100% border=1 valign=top cellpadding=3 cellspacing=0>
        <tr>
           <td colspan=7 align=center bgcolor=#D6D6D6><b>LE VERIFICHE</b></td>
        </tr>
        <tr>
            <td width=5%  align=center>$n_tabella</td>
            <td width=5%  align=center>$n_tabella2</td>
            <td width=90% align=left colspan=5>$descr_risultati_verifiche</td>
        </tr>
        <tr>
            <td align=center rowspan=22>&nbsp;</td>
            <td align=center rowspan=5>1</td>
            <td width=50% align=left colspan=3>Numero totale impianti verificati</td>
            <td width=40% align=left colspan=2>$clsnc_tot</td>
        </tr>
        <tr>
            <td align=left colspan=3>Numero totale impianti verificati &lt;35 kW            <td align=left colspan=2>$clsnc_min35</td>
        </tr>
        <tr>
            <td align=left colspan=3>Di cui autodichiarati</td>
            <td align=left colspan=2>&nbsp;</td>
        </tr>
        <tr>
            <td align=left colspan=3>Di cui autodichiarati</td>
            <td align=left colspan=2>&nbsp;</td>
        </tr>
        <tr>
            <td align=left colspan=3>Numero totale impianti verificati &gt;=35 kW</td>
            <td align=left colspan=2>$clsnc_maj35</td>
        </tr>
        <tr>
            <td align=center valign=top rowspan=3>2</td>
            <td align=left colspan=5>suddivisione per classi di potenza (per impianti &gt;= 35 kW):</td>
        </tr>
        <tr>
           <td width=18%  rowspan=2>&nbsp;</td>
        "
    # suddivisione per potenza
    foreach elemento $lista_id_pot {
	set descr_pot [lindex $elemento 1]
	set id_pot    [lindex $elemento 0]
	append stampa "<td align=center width=18%>$descr_pot</td>"
    }
    append stampa "</tr><tr>"
    
    foreach elemento $lista_id_pot {
	set id_pot [lindex $elemento 0]
	if {$id_pot == 1} {
	    append stampa "<td bgcolor=#D6D6D6>&nbsp;</td>"
	} else {
	    if {[info exists clsnc_pot($id_pot)] == 1} {
		append stampa "<td align=left>N. $clsnc_pot($id_pot)</td>"
	    } else {
		append stampa "<td align=left>N.</td>"
	    }
	}
    }
    
    # suddivisione per potenza (generatori)
    append stampa "
        <tr>
            <td align=center valign=top rowspan=3>3</td>
            <td align=left colspan=5>suddivisione per classi di potenza del generatore (per impianti &gt;= 35 kW):</td>
        </tr>
        <tr>
           <td width=18% rowspan=2>&nbsp;</td>
        "
    foreach elemento $lista_id_pot {
	set descr_pot [lindex $elemento 1]
	set id_pot    [lindex $elemento 0]
	append stampa "<td align=center width=18%>$descr_pot</td>"
    }
    append stampa "</tr><tr>"
    
    foreach elemento $lista_id_pot {
	set id_pot [lindex $elemento 0]
	if {$id_pot == 1} {
	    append stampa "<td bgcolor=#D6D6D6>&nbsp;</td>"
	} else {
	    if {[info exists clsnc_pot_gend($id_pot)] == 1} {
		append stampa "<td align=left>N. $clsnc_pot_gend($id_pot)</td>"
	    } else {
		append stampa "<td align=left>N.</td>"
	    }
	}
    }
    
    # calcolo il numero di rowspan in caso venga modificata la lista dei  
    # periodi
    set length_per [llength $lista_id_per]
    incr length_per 2

    # suddifisione per potenza e periodo
    append stampa "
        <tr>
           <td align=center valign=top rowspan=$length_per>4</td>
           <td align=left colspan=5>suddivisione per anno di installazione del generatore</td>
        </tr>
        <tr>
        <td>&nbsp</td>
        "

    foreach elemento $lista_id_pot {
	set desc_pot [lindex $elemento 1]
	append stampa "<td align=center>$desc_pot</td>"
    }
    append stampa "</tr>"
    
    foreach elemento $lista_id_per {
	set id_per [lindex $elemento 0]
	set desc_per [lindex $elemento 1]
	append stampa "<tr><td align=center>$desc_per</td>"
	foreach elemento2 $lista_id_pot {
	    set id_pot [lindex $elemento2 0]
	    if {[info exists clsnc_pot_per($id_pot,$id_per)] == 1} {
		append stampa "<td align=left>N. $clsnc_pot_per($id_pot,$id_per)</td>"
	    } else {
		append stampa "<td align=left>N.</td>"
	    }
	}
	append stampa "</tr>"
    }

    # calcolo il numero di rowspan in caso venga modificata la lista dei  
    # combustibili 
    set length_comb [llength $lista_id_comb]
    incr length_comb 2

    # suddivisione per potenza e combutibile
     append stampa "
        <tr>
            <td align=center valign=top rowspan=$length_comb>5</td>
            <td align=left colspan=5>suddivisione per tipo combustibile dell'impianto: </td>
        </tr>
        <tr>
        <td>&nbsp</td>
        "
    foreach elemento $lista_id_pot {
	set desc_pot [lindex $elemento 1]
	append stampa "<td align=center>$desc_pot</td>"
    }
    append stampa "</tr>"
    
    foreach elemento $lista_id_comb {
	set id_comb [lindex $elemento 0]
	set desc_per [lindex $elemento 1]
	append stampa "<tr><td align=center>$desc_per</td>"
	foreach elemento2 $lista_id_pot {
	    set id_pot [lindex $elemento2 0]
	    if {[info exists clsnc_pot_comb($id_pot,$id_comb)] == 1} {
		append stampa "<td align=left>N. $clsnc_pot_comb($id_pot,$id_comb)</td>"
	    } else {
		append stampa "<td align=left>N.</td>"
	    }
	}
	append stampa "</tr>"
    }

}

# routine di calcolo sulle classi 
set risultati_verifiche {

    if {$id_clsnc != 4 
    &&  $id_clsnc != 5
    } {
	db_foreach sel_relt_id_clsnc_pot  "" {
	    set clsnc_pot($id_pot) $n
	}
    }

    set clsnc_tot 0
    switch $id_clsnc {
	1 { eval $calc_cls1} 
	2 { set id_pot 1
	    db_foreach sel_relt_id_clsnc_per  "" {
	        set clsnc_per($id_per) $n
	    }	    
            eval $calc_cls2
          }
	3 { eval $calc_cls3}
	4 { db_foreach sel_relt_id_clsnc_pot_d  "" {
	        set clsnc_pot_d($id_pot) $n
	    }
            eval $calc_cls4
          }
	5 { eval $calc_cls5}
    }

    # qui eseguo questa foreach per ricavare la descrizione perche' 
    # non ho mantenuto l'ordine preciso delle classi: ho posizionato
    # la classe 5 per prima perche' nella stampa viene presentata per prima.
    set descr_risultati_verifiche ""
    foreach elemento $lista_clsnc {
	set id_clsnc_list [lindex $elemento 0]
	if {$id_clsnc_list == $id_clsnc } {
	    set descr_risultati_verifiche [lindex $elemento 1]
	}
    }
    if {$id_clsnc != 4
    &&  $id_clsnc != 5
    } {
	set descr_anom [lindex $lista_stcls $id_stclsnc]
	set descr_anom [lindex $descr_anom 1]
    }

    if {$id_clsnc != 1} {
	set num_stcls $id_stclsnc
    } else {
	set num_stcls "&nbsp;"
    }

    switch $id_clsnc {
	1 { eval $layout_cls1} 
	2 { eval $layout_cls2}
	3 { eval $layout_cls3}
	4 { eval $layout_cls4}
	5 { eval $layout_cls5}
    }

    # azzero gli array
    if {[info exists clsnc_pot_per]} {
	unset clsnc_pot_per
    }
    if {[info exists clsnc_pot_comb]} {
	unset clsnc_pot_comb
    }
    if {[info exists clsnc_pot]} {
	unset clsnc_pot
    }
    if {[info exists clsnc_per]} {
	unset clsnc_per
    }
    if {[info exists clsnc_pot_d]} {
	unset clsnc_pot_d
    }
    if {[info exists clsnc_pot_gend]} {
	unset clsnc_pot_gend
    }
}


# inizio creazione della stampa
set stampa "
<!-- FOOTER LEFT   \"Applicazione D.P.R. 412/93 - 551/99\"-->
<!-- FOOTER RIGHT  \"Pagina \$PAGE(1) di \$PAGES(1)\"-->
<table width=100% border=1 cellpadding=3 cellspacing=0>
<tr>
   <td colspan=4 align=left><b><u>8.2 SCHEDA RELAZIONE BIENNALE</u></b></td>
</tr>
<tr>
   <td colspan=4 align=center><b><u>Data Inizio Relazione:</u></b> $data_rel</td>
</tr>
<tr>
   <td colspan=4 align=center><b><u>Responsabile del Procedimento</u></b> $resp_proc</td>
</tr>
<tr>
   <td colspan=4 align=center bgcolor=#D6D6D6><big><b>GENERALITA'</b></big></td>
</tr>
<tr>
    <td width=5% align=center>A</td>
    <td width=5% align=center>&nbsp;</td>
    <td width=30% align=left>Ente di Controllo</td>
    <td width=65% align=left>Codice Istat $ente_istat</td>
</tr>
<tr>
    <td align=center>E</td>
    <td align=center>&nbsp;</td>
    <td align=left>N.impianti stimati</td>
    <td align=left>Autonomi $nimp_tot_aut_ente &nsbp; Centralizzati $nimp_tot_centr_ente &nsbp; Teleriscaldamento(1) $nimp_tot_telerisc_ente</td>
</tr>
<tr>
    <td colspan=4 align=left><small>1.Indicare il numero di sottocentrali</small></td>
</tr>
</table>
<!-- PAGE BREAK -->
<table width=100% border=1 cellpadding=3 cellspacing=0>
<tr>
   <td colspan=4 align=center bgcolor=#D6D6D6><b>CONVENZIONE CON ASSOCIAZIONI DI CATEGORIA</b></td>
</tr>
<tr>
    <td width=5% align=center>2</td>
    <td width=5% align=center>1</td>
    <td width=30% align=left>Esiste? </td>
    <td width=65% align=left>Anno di sottoscrizione (in vigore) $conv_ass_categ</td>
</tr>
<tr>
    <td width=5% align=center rowspan=3>&nbsp;</td>
    <td width=5% align=center>2</td>
    <td width=30% align=left>E' conforme alla D.G.R. 7/7568 del 21 dicembre 2001? </td>
    <td width=65% align=left>$conf_dgr7_7568</td>
</tr>
<tr>
    <td width=5% align=center>3</td>
    <td width=30% align=left>Numero della P.Iva (inteso come numero di societ&agrave; o societ&agrave individuali) aderenti alla convenzione</td>
    <td width=65% align=left>$npiva_ader_conv</td>
</tr>
<tr>
    <td width=5% align=center>4</td>
    <td width=30% align=left>Numero delle P.Iva (inteso come numero di societ&agrave; o societ&agrave; individuali) iscritte alle Associazioni di Categoria firmatarie dell'Accordo Regionale</td>
    <td width=65% align=left>$npiva_ass_acc_reg</td>
</tr>
</table>
<!-- PAGE BREAK -->
<table width=100% border=1 cellpadding=3 cellspacing=0>
<tr>
   <td colspan=4 align=center bgcolor=#D6D6D6><b>AUTODICHIARAZIONE <small>( RIFERITA A IMPIANTI TERMICI < 35kW )</small></b></td>
</tr>
<tr>
    <td width=5% align=center>3</td>
    <td width=5% align=center>1</td>
    <td width=30% align=left>E' stata deliberata e attuata? </td>
    <td width=65% align=left>$delib_autodic</td>
</tr>
<tr>
    <td width=5% align=center rowspan=3>&nbsp;</td>
    <td width=5% align=center>3</td>
    <td width=30% align=left>Sono stati posti termini per la presenzazione? (se diversi da quanto indicato nella D.G.R. 7/7568 del 21 dicembre 2001 indicare i termini e l'efficacia</td>
    <td width=65% align=left>
        <table width=100%>
        <tr>
            <td align=left>Periodo di riferimento:</td>
            <td align=left>data inizio $rifer_datai</td>
            <td align=left>data fine $rifer_dataf</td>
        </tr>
        <tr>
            <td align=left>Periodo di validit&agrave;:</td>
            <td align=left>data inizio $valid_datai</td>
            <td align=left>data fine $valid_dataf</td>
        </tr>
        </table>
    </td>
</tr>
<tr>
    <td width=5% align=center>4</td>
    <td width=30% align=left>Quante ne sono pervenute? (espressa in numero totale) </td>
    <td width=65% align=center>N. $ntot_autodic_perv</td>
</tr>
<tr>
    <td width=5% align=center>5</td>
    <td width=30% align=left>Numero di autodichiarazioni pervenute con prescrizioni</td>
    <td width=65% align=center>N. $ntot_prescrizioni</td>
</tr>
</table>
<!-- PAGE BREAK -->
<table width=100% border=1 cellpadding=3 cellspacing=0>
<tr>
   <td colspan=4 align=center bgcolor=#D6D6D6><b>GLI ISPETTORI</b></td>
</tr>
<tr>
    <td width=5% align=center>4</td>
    <td width=5% align=center rowspan=3>1</td>
    <td width=30% align=left rowspan=3>A chi sono affidati i controlli?</td>
    <td width=65% align=left>Ispettori interni<small>*</small> N. $n_ver_interni</td>
</tr>
<tr>
    <td rowspan=4>&nbsp;</td>
    <td>Ispettori esterni<small>*</small> N. $n_ver_esterni</td>
</tr>
<tr>
    <td>Societ&agrave; terze<small>*</small> N. _____________</td>
</tr>
<tr>
    <td width=5% align=center>2</td>
    <td width=30% align=left>Chi ha accertato l'idoneit&agrave; tecnica degli ispettori? </td>
    <td width=65% align=left>
        <table width=100% cellpadding=0 cellspacing=0>
        <tr>
            <td align=left width=50%>Accertamento Enea N. $n_accert_enea</td>
            <td aling=left width=50%>Altro soggetto N. $n_accert_altri</td>
        </tr>
        </table>
    </td>
</tr>
<tr>
    <td width=5% align=center>3</td>
    <td width=30% align=left>Elenco nominativo degli ispettori operanti nel biennio (allegare un file a parte con l'elenco degli ispettori con p.iva, codice enea, nome, cognome etc.) </td>
    <td width=65% align=left>
    <table>
       <tr>
           <td align=center>Cognome</td>  
           <td align=center>Nome</td>
           <td align=center>P.Iva/cod.fiscale</td>
           <td align=center>Cod.attestato ENEA</td> 
       </tr>
       <tr>
           <td align=center>________________ </td>
           <td align=center>________________ </td>
           <td align=center>________________ </td>
           <td align=center>________________ </td>
       </tr>
    </table>
    </td>
</tr>
<tr>
    <td colspan=4><small>* La somma dei valori di ogni anno</small></td>
</tr>
"

# inizio il ciclo per la classe
foreach classe $lista_clsnc {
    set id_clsnc [lindex $classe 0]
    if {![string equal $id_clsnc ""]} {
	# imposto i titoli per le diverse classi
	switch $id_clsnc {
	    1 {set lista_stcls $lista_stcls1
	       set n_tabella 6
	       set descr_totale "Numero totale impianti non conformi"
	      }
	    2 {set lista_stcls $lista_stcls2
	       set n_tabella  7
	       set n_tabella2 1
	       set descr_fascia "&lt; 35 kW"
	       set descr_totale "Numero totale impianti $descr_fascia non conformi codice "
	      }
	    3 {set lista_stcls $lista_stcls3
	       set n_tabella  7
	       set n_tabella2 2
               set descr_fascia "&gt; 35 kW"
	       set descr_totale "Numero totale impianti $descr_fascia non conformi codice"
	      }
	    4 {set n_tabella  7
	       set n_tabella2 3 
	       set descr_totale "Numero totale impianti non conformi"
	      }
	    5 {set n_tabella  5
		set n_tabella2 "&nbsp;"
	       set descr_totale "Numero di verifiche effettuate nella campagna ripartite per:"
	      }
	}
	# per la classe 4 e 5 non devo suddividere per sottoclasse 
	if {$id_clsnc == 4
        ||  $id_clsnc == 5
	} {
	    eval $risultati_verifiche
	} else {
	    foreach st_classe $lista_stcls {
		set id_stclsnc [lindex $st_classe 0]
		if {![string equal $id_stclsnc ""]} {
		    if {$id_clsnc == 1} {
			set n_tabella2 $id_stclsnc
		    }
		    eval $risultati_verifiche
		}
	    }
	}
    }
}

# per le inadempienze amministrative non abbiamo i dati, di conseguenza imposto
# i titoli e i valori li lascio vuoti ed eseguo "layout_cls4" perche' 
# l'impostazione della tabella e' uguale a quella della classe 4

set n_tabella  7
set n_tabella2 4 
set descr_totale "Numero totale impianti non conformi"
set descr_risultati_verifiche "Inadempienze amministrative ad altre disposizioni in valore assoluto ripartiti per:"
set num_stcls "&nbsp;"
set clsnc_tot "&nbsp;"
set clsnc_min35 "&nbsp;"
set clsnc_maj35 "&nbsp;"
eval $layout_cls4

# calcoli per il riassunto finale
set tot_nc 0
set tot_nc_min35 0
db_foreach sel_relt_nc_tot "" {
    if {$id_pot == 1} {
	set tot_nc_min35 $n
    } 
    set tot_nc [expr $tot_nc + $n]
}
set tot_nc_maj35 [expr $tot_nc - $tot_nc_min35]

append stampa "
    </table>
    <!-- PAGE BREAK -->
    <table width=100% border=1 cellpadding=3 cellspacing=0>
    <tr>
        <td colspan=4 align=center bgcolor=#D6D6D6><b>RISULTATI DELLE VERIFICHE</b></td>
    </tr>
    <tr>
        <td width=5% align=center valign=top rowspan=4>7</td>
        <td width=5% align=center valign=top rowspan=4>5</td>
        <td width=90% align=left colspan=2>Riepilogo degli impianti non conformi riparati per:</td>
    </tr>
    <tr>
        <td width=67% colspan=1 align=left>Numero totale impianti non conformi</td>
        <td width=33% colspan=1>$tot_nc</td>
    </tr>
    <tr>
        <td width=67% colpan=2 align=left>Numero totale impianti &lt; 35 kW non conformi</td>
        <td width=33% colspan=1>$tot_nc_min35</td>
    </tr>
    <tr>
        <td width=67% colpan=2 align=left>Numero totale impianti &gt;= 35 kW non conformi</td>
        <td width=33% colspan=1>$tot_nc_maj35</td>
    </tr>
    <tr><td align=center colspan=4><big><u>*L E G E N D A</u></big></td></tr>
    <tr>
        <td>&nbsp</td>
        <td valign=top align=left>1.</td>
        <td colspan=2>ISTAT 4 - Impianto centralizzato atto a riscaldare tutti gli alloggi presenti nell'edificio, ma localizzato furoi dalla singola abitazione, per esempio, nei locali di servizio dell'edificio (cantine seminterrati ecc..) viene considerato centralizzato anche in un impianto collegato ad una rete cittadina di teleriscaldamento.</td>
    </tr>
    <tr>
        <td>&nbsp</td>
        <td valign=top align=left>2.</td>
        <td colspan=2>ISTAT 5 - Impianto fisso autonomo atto a riscaldare una singola abitazione e normalmente localizzato nel suo interno o nelle sue adiacenze ( ad es. la caldaia può trovarsi in un vano interno apposito, oppure sul balcone/terrazza; i pannelli solari possono trovarsi sul tetto, e così via), e il cui uso è gestito autonomamente.</td>
    </tr>
    <tr>
        <td>&nbsp</td>
        <td valign=top align=left>3.</td>
        <td colspan=2>Nella compilazione dei riquadri inerenti i risultati delle verifiche, nell'indicare le percentuali, ci si riferisce al numero degli impianti/generatori verificati di quella classe di potenza, tipo di combustibile ed anno di installazione (punti 5.1, 5.2, 5.3, 5.4, 5.6), con esclusione degli impianti di teleriscaldamento.</td>
    </td>
    </tr>
"

puts $file_id  $stampa
close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --fontsize 9 --left 1cm --right 1cm --top 0.1cm --footer ... --bottom 0.1cm -f $file_pdf $file_html]

ns_unlink $file_html
ad_returnredirect $file_pdf_url
ad_script_abort
