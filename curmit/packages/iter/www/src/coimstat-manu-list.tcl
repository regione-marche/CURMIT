ad_page_contract {
    Lista tabella "coimdimp"

    @author                  Giulio Laurenzi
    @creation-date           22/04/2005
    @param nome_funz         identifica l'entrata di menu,
                             serve per le autorizzazioni
    @cvs-id coimstat-manu-list
} {
     nome_funz
    {nome_funz_caller  ""}
    {da_data           ""} 
    {a_data            ""}
    {f_manu_cogn       ""}
    {f_manu_nome       ""}
    {f_cod_manu         ""}
}  -properties {
    page_title:onevalue
    context_bar:onevalue
}

# Controlla lo user
set lvl        1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
#######
set stampa ""

set data1_ok [iter_edit_date $da_data]
set data2_ok [iter_edit_date $a_data]

# imposto il nome dei file

iter_get_coimdesc
set ente              $coimdesc(nome_ente)
set ufficio           $coimdesc(tipo_ufficio)
set indirizzo_ufficio $coimdesc(indirizzo)
set telefono_ufficio  $coimdesc(telefono)
set assessorato       $coimdesc(assessorato)
# Titolo della stampa
set stampa " <table width=100%>
              <tr>
                  <td width=100% align=center>
                  <table><tr>
                    <td align=center><b>$ente</b></td>
                  </tr><tr>
                     <td align=center>$ufficio</td>
                  </tr><tr>
                     <td align=center>$assessorato</td>
                  </tr><tr>
                     <td align=center><small>$indirizzo_ufficio</small></td>
                  </tr><tr>
                     <td align=center><small>$telefono_ufficio</small></td>
                  </tr></td>
                  </table></tr></table> 
"
set testata "<blockquote>"
 append stampa table
append stampa "<p align=center><big>Dichiarazioni inserite da $f_manu_cogn $f_manu_nome da $da_data a $a_data</p></big>"
append stampa "<p align=center><big></p></big>"
append stampa "</font>"
#########

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set page_title  "Numero Modelli"
set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

if {![string equal $da_data ""]} {
    set where_da_data "and to_char(a.data_ins,'yyyymmdd') >= :da_data"
} else {
    set where_da_data ""
}
if {![string equal $a_data ""]} {
    set where_a_data  "and to_char(a.data_ins,'yyyymmdd') <= :a_data"
} else {
    set where_a_data  ""
}

set table "<center>
           <table border=1 cellpadding=5 cellspacing=0>
           <tr>
               <td align=center><b>Data inserimento</b></td>
               <td align=center><b>Modello</b></td>
               <td align=center><b>Utente di inserimento</b></td>
               <td align=center><b>Numero modelli</b></td>
           </tr>"

set table_trac ""
set table_uten ""
set data_ins1 ""
set flag_tracciato1 ""
set count_righe_data 0
set count_righe_trac 0
set count 0
db_foreach sel_conta_dimp "select count(*) as conta_dimp
                                , iter_edit_data(data_ins) as data_ins
                                , data_ins as data_ins_order
                                , coalesce(flag_tracciato, 'H') as flag_tracciato
                                , coalesce(utente_ins, '&nbsp;') as utente_ins
                             from coimdimp
                            where cod_manutentore= :f_cod_manu
                              and data_ins between :da_data and :a_data
                         group by data_ins, flag_tracciato, utente_ins
                         order by data_ins_order desc, flag_tracciato, utente_ins
" {

	incr count
    if {![string equal $data_ins1 ""]
	&& $data_ins1 != $data_ins} {
	append table "<tr><td rowspan=$count_righe_data>$data_ins1</td>"
	if {[string equal $table_trac ""]} {
	    append table "<td rowspan=$count_righe_trac>$flag_tracciato1</td>"
	    append table $table_uten
	} else {
	    append table $table_trac
	    if {![string equal $table_trac ""]} {
		append table "<tr>"
	    }
	    append table "<td >$flag_tracciato1</td>"
	    append table $table_uten
	}
	set table_trac ""
	set table_uten ""
	set data_ins1 $data_ins
	set flag_tracciato1 ""
        set count_righe_data 1
	set count_righe_trac 0
    } else {
        incr count_righe_data
	set data_ins1 $data_ins
    }

    if {$flag_tracciato1 != $flag_tracciato
	&& ![string equal $flag_tracciato1 ""]} {
	if {![string equal $table_trac ""]} {
	    append table_trac "<tr>"
	}
	append table_trac "<td rowspan=$count_righe_trac>$flag_tracciato1</td>"
	
	append table_trac $table_uten
	set table_uten ""
	set flag_tracciato1 $flag_tracciato
	set count_righe_trac 1
    } else {
	incr count_righe_trac
	set flag_tracciato1 $flag_tracciato
#dpr74
        if {[string equal $flag_tracciato1 "G"]} {
         set flag_tracciato1  "G - Risc."    
        }

       if {[string equal $flag_tracciato1 "H"]} {
        set flag_tracciato1  "H - Risc."    
       }

       if {[string equal $flag_tracciato1 "F"]} {
         set flag_tracciato1  "F - Risc."    
       }


       if {[string equal $flag_tracciato1 "C"]} {
         set flag_tracciato1  "C - Cog."    
       }

      if {[string equal $flag_tracciato1 "T"]} {
        set flag_tracciato1  "T - Tel."    
      }

      if {[string equal $flag_tracciato1 "F"]} {
        set flag_tracciato1  "F - Raff."    
      }
#dpr74
    }

    if {![string equal $table_uten ""]} {
	append table_uten "<tr>"
    }
    append table_uten "<td>$utente_ins</td>
                       <td>$conta_dimp</td></tr>"

}

if {$count > 0} {
append table "<tr><td rowspan=$count_righe_data>$data_ins</td>"
append table $table_trac
if {![string equal $table_trac ""]} {
    append table "<tr>"
}
#dpr74
if {[string equal $flag_tracciato1 "G"]} {
      set flag_tracciato1  "G - Risc."    
}

if {[string equal $flag_tracciato1 "H"]} {
      set flag_tracciato1  "H - Risc."    
}

if {[string equal $flag_tracciato1 "F"]} {
      set flag_tracciato1  "F - Risc."    
}


if {[string equal $flag_tracciato1 "C"]} {
      set flag_tracciato1  "C - Cog."    
}

if {[string equal $flag_tracciato1 "T"]} {
      set flag_tracciato1  "T - Tel."    
}

if {[string equal $flag_tracciato1 "F"]} {
      set flag_tracciato1  "F - Raff."    
}
#dpr74

append table "<td rowspan=$count_righe_trac>$flag_tracciato1</td>"
append table $table_uten
}
append table "</table></center>"
	

	
append table "
<tr><td>&nbsp;</td></tr>
<tr><td align=center><b>Dichiarazioni inserite da $f_manu_cogn $f_manu_nome da $data1_ok a $data2_ok</b></td></tr>"

# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]
set logo_dir      [iter_set_logo_dir]

# imposto il nome dei file
set nome_file        "stampa statistica manutentori"
set nome_file        [iter_temp_file_name $nome_file]
set file_html        "$spool_dir/$nome_file.html"
set file_pdf         "$spool_dir/$nome_file.pdf"
set file_pdf_url     "$spool_dir_url/$nome_file.pdf"

set   file_id  [open $file_html w]
fconfigure $file_id -encoding iso8859-1
puts  $file_id $table
close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --landscape  --quiet --bodyfont arial --left 0cm --right 0cm --top 2cm --bottom 2cm -f $file_pdf $file_html]

ns_unlink $file_html

db_release_unused_handles
ad_return_template 
