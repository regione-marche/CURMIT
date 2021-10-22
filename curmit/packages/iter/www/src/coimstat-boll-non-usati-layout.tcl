ad_page_contract {

    @creation-date   14.06.2012

    @param funzione  V=view

    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @                 serve se lista e' uno zoom che permetti aggiungi.

    @cvs-id          coimstat-boll-non-usati-layout.tcl

    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    gac01 23/05/2018 Fatto in modo di velocizzare il programma per evitare che vada in time out

    rom01 30/11/2017 Corretto in modo che la stampa non faccia più visualizzare i bollini non
    rom01            utilizzati che sono stati trasferiti a un altro manutentore.
    
    sim02 16/06/2017 Velocizzato la stampa.
    
    sim01 21/12/2015 Corretto in modo che la stampa tenga in considerazione i prefissi dei 
    sim01            bollettini nel caso in cui stiamo operando su UCIT
    
    nic01 05/02/2015 Come chiesto da UCIT, bisogna fare il controllo anche sull'istanza
    nic01            collegata (per ora cablo, in futuro, fare tabella istanze collegate).
} {
    {f_manu_cogn       ""}
    {f_manu_nome       ""}
    {f_data1           ""}
    {f_data2           ""}
    {cod_manutentore   ""}
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
if {![string is space $nome_funz]} {
    set lvl        1
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
} else {
    # se la lista viene chiamata da un cerca, allora nome_funz non viene passato
    # e bisogna reperire id_utente dai cookie
    #set id_utente [ad_get_cookie iter_login_[ns_conn location]]
    set id_utente [iter_get_id_utente]
    if {$id_utente eq ""} {
	set login [ad_conn package_url]
	iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
	return 0
    }
}
set link_filter [export_ns_set_vars url]

# imposto variabili usate nel programma:
set sysdate_edit  [iter_edit_date [iter_set_sysdate]]

iter_get_coimtgen;#nic01

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# imposto le condizioni di estrazione
if {$cod_manutentore ne ""} {
    set where_cod_manu "and cod_manutentore= :cod_manutentore"
} else {
    set where_cod_manu ""
}
#if {[string equal $f_data1 ""]} {
#    set f_data1 "19000101"
#    set data1_ok "01/01/1900"
#} else {
#    set data1_ok [iter_edit_date $f_data1]
#}
#if {[string equal $f_data2 ""]} {
#    set f_data2 "21001231"
#    set data2_ok "12/31/2100"
#} else {
#    set data2_ok [iter_edit_date $f_data2]
#}
#set where_data_consegna "and data_consegna between :f_data1 and :f_data2"
set where_data_consegna ""

# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]
set logo_dir      [iter_set_logo_dir]

# imposto il nome dei file
set nome_file    "Stampa bollini applicati"
set nome_file    [iter_temp_file_name $nome_file]
set file_html    "$spool_dir/$nome_file.html"
set file_pdf     "$spool_dir/$nome_file.pdf"
set file_pdf_url "$spool_dir_url/$nome_file.pdf"

set titolo       "Stampa statistica bollini non applicati"
set button_label "Stampa"
set page_title   "Stampa statistica bollini non applicati"
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller] 

set root        [ns_info pageroot]
set stampa      ""

iter_get_coimdesc
set ente              $coimdesc(nome_ente)
set ufficio           $coimdesc(tipo_ufficio)
set indirizzo_ufficio $coimdesc(indirizzo)
set telefono_ufficio  $coimdesc(telefono)
set assessorato       $coimdesc(assessorato)

# Titolo della stampa
db_1row query "select coalesce(cognome, '')||' '||coalesce(nome, '') as manutentore from coimmanu where cod_manutentore = :cod_manutentore"
append stampa "<br><br>
               <hr>
               <b>STATISTICA BOLLINI NON APPLICATI: MANUTENTORE $cod_manutentore - $manutentore</b>
               <hr>
               <br>
               <center><table border=0 width=70%>"

# Costruisco descrittivi tabella (creata la tabella)
set inizio "S"
#create table coimboll_temp (cod_bollini integer, cod_manutentore varchar(8), costo_unitario numeric(6,2), matricola varchar(10) not null);

# azzero la tabella di appoggio
db_dml query "delete from coimboll_temp"

set dbn_ente_collegato "";#nic01
if {$coimtgen(ente) eq "PUD"} {#nic01
    set dbn_ente_collegato "iterprgo";#nic01
} elseif {$coimtgen(ente) eq "PGO"} {#nic01
    set dbn_ente_collegato "iterprud";#nic01
};#nic01

if {$dbn_ente_collegato ne ""} {#gac01 aggiunta if e suo contenuto
    
    db_dml -dbn $dbn_ente_collegato q "delete from coimboll_temp2"
    
}
 
db_foreach query "
    select cod_bollini, cod_manutentore, nr_bollini
         , matricola_da, matricola_a, nr_bollini_resi
         , costo_unitario as costo_unitario_boll
         , case cod_tpbo
           when '1' then 'G'
           when '2' then 'F1'
           when '3' then 'F2'
           when '4' then 'E'
           end                as tipo_bollino --sim01
      from coimboll
     where 1 = 1
    $where_cod_manu
    $where_data_consegna
  order by costo_unitario
" {

    if {$dbn_ente_collegato ne ""} {#gac01 aggiunta if e suo contenuto
	
	db_dml -dbn $dbn_ente_collegato q "insert into coimboll_temp2 
                                                ( cod_manutentore_temp
                                                , matricola_da_temp
                                                , matricola_a_temp
                                                ) values (
                                                 :cod_manutentore
                                                ,:matricola_da
                                                ,:matricola_a)"
    }


    set conta_1 1
    if {$conta_1 == 1} {
	set matricola $matricola_da
    }
   
    # inserisco nella tabella temporanea tutti i numeri bollino consegnati a quel manutentore
    set matricola_ciclo $matricola;#sim01
    while {$matricola_ciclo <= $matricola_a} {
	incr conta_1
	
	if {$coimtgen(ente) eq "PUD" || $coimtgen(ente) eq "PGO" || $coimtgen(ente) eq "PPN"} {#sim01 Aggiunta if ed il suo contenuto
	    set matricola [db_string query "select lpad(:matricola_ciclo,6,0)"]
            set matricola $tipo_bollino$matricola
	} else {
	    set matricola $matricola_ciclo
	}
	
	if {![db_0or1row query "
	      select 1
                from   coimboap p 
               where --p.cod_bollini = :cod_bollini
              -- and 
                    :matricola between p.matr_da and p.matr_a
                limit 1"]
	} {#rom01
	    
	    db_dml query "insert into coimboll_temp values (:cod_bollini, :cod_manutentore, :costo_unitario_boll, :matricola)"
	};#rom01
	# Aggiungo 1 alla data precedente
	#sim01 set matricola [expr $matricola + 1]
	set matricola_ciclo [expr $matricola_ciclo + 1];#sim01
	
    }
}

if {$dbn_ente_collegato ne ""} {#nic01 (aggiunta tutta questa if)
    
    db_foreach -dbn $dbn_ente_collegato query "
    select cod_bollini, cod_manutentore, nr_bollini
         , matricola_da, matricola_a, nr_bollini_resi
         , costo_unitario as costo_unitario_boll
         , case cod_tpbo
           when '1' then 'G'
           when '2' then 'F1'
           when '3' then 'F2'
           when '4' then 'E'
           end               as tipo_bollino --sim01
      from coimboll
      left join coimboll_temp2                    --gac01
        on cod_manutentore = cod_manutentore_temp --gac01
       and matricola_da    = matricola_da_temp    --gac01
       and matricola_a     = matricola_a_temp     --gac01
     where 1 = 1
      and cod_manutentore_temp is null --gac01
    $where_cod_manu
    $where_data_consegna
  order by costo_unitario
    " {
	
	set conta_1 1
	if {$conta_1 == 1} {
	    set matricola $matricola_da
	}
	
	# inserisco nella tabella temporanea tutti i numeri bollino consegnati a quel manutentore
	# nic01 (se non sono gia' presenti)
	set matricola_ciclo $matricola;#sim01
	while {$matricola_ciclo <= $matricola_a} {
	    incr conta_1
	    
	    set matricola [db_string query "select lpad(:matricola_ciclo,6,0)"];#sim01
	    set matricola $tipo_bollino$matricola;#sim01
	    
	    if {![db_0or1row query "
                select 1
                  from coimboll_temp 
                 where cod_manutentore = :cod_manutentore
                   and matricola       = :matricola
                 limit 1"]
	    } {
	
		if {![db_0or1row query " 
		  select 1                                 
                    from coimboap p 
                   where -- p.cod_bollini = :cod_bollini
                    -- and 
                         :matricola between p.matr_da and p.matr_a
                     limit 1"]
		} {#rom01

		    db_dml query "insert into coimboll_temp values (:cod_bollini, :cod_manutentore, :costo_unitario_boll, :matricola)"
		};#rom01

	    }
	    
	    # Aggiungo 1 alla matricola precedente
	    #sim01 set matricola [expr $matricola + 1]
	    set matricola_ciclo [expr $matricola_ciclo + 1];#sim01
	    
	}
    }
};#nic01

#sim02 cancello dalla tabella i bollini già usati sulla istanza in cui mi trovo, in modo da ciclare su meno record.
db_dml q "delete from coimboll_temp
           where matricola in ( 
                select t.matricola
                  from coimdimp d
                     , coimboll_temp t
                 where d.cod_manutentore = t.cod_manutentore
                   and (trim(d.riferimento_pag) = t.matricola))";#sim02

#gac01 faccio una lista delle matricole rimaste sulla coimboll_temp
set ls_matricola1 [db_list q "select matricola 
                                from coimboll_temp"];#gac01

#gac01 faccio una lista delle matricole rimaste sulla coimboll_temp che si trovano sull'istanza collegata e che sono gia
#gac01 state usate
set ls_matricola2 [db_list -dbn $dbn_ente_collegato q "select riferimento_pag 
                                                         from coimdimp
                                                        where riferimento_pag in ('[join $ls_matricola1 ',']')"];#gac01

#gac01 cancello dalla tabella coimboll_temp i bollini già usati sulla seconda istanza, in modo da ciclare su meno record.
db_dml q "delete from coimboll_temp
           where matricola in ('[join $ls_matricola2 ',']')";#gac01


# ciclo sulla tabella e vedo se trovo l'impianto con il numero corrispondente
set lista_boll_temp [db_list_of_lists query "select cod_bollini, cod_manutentore, costo_unitario, matricola from coimboll_temp order by costo_unitario, matricola"]

set riga_stampa ""
set costo_unitario_save ""
set prima_riga "t"

foreach item $lista_boll_temp {
    util_unlist $item cod_bollini cod_manutentore costo_unitario_boll matricola
    
    if {$costo_unitario_save eq ""} {
	set costo_unitario_save $costo_unitario_boll
	append stampa "<tr>
                         <td align=center>&nbsp;</td>
                       </tr>
                       <tr>
                         <td align=center><b>Euro $costo_unitario_boll</b></td>
                       </tr>"
    }
    if {$costo_unitario_save != $costo_unitario_boll} {
	append stampa "<tr>
                         <td align=center>$riga_stampa</td>
                       </tr>
                       <tr>
                         <td align=center>&nbsp;</td>
                       </tr>
                       <tr>
                         <td align=center><b>Euro $costo_unitario_boll</b></td>
                       </tr>"
	
	set costo_unitario_save $costo_unitario_boll
	set riga_stampa ""
	set prima_riga "t"
    }
    
    # visto che quando rilasciano il bollino di solito aggiungono G, F1, F2, E e 0 al numero di matricola,
    # aggiungiamo questi prefissi alla ricerca in modo da ridurre il margine d'errore ...
    #sim01 set matricolag  G[db_string query "select lpad(:matricola,6,0)"]
    #sim01 set matricolaf1 F1[db_string query "select lpad(:matricola,6,0)"]
    #sim01 set matricolaf2 F2[db_string query "select lpad(:matricola,6,0)"]
    #sim01 set matricolae  E[db_string query "select lpad(:matricola,6,0)"]
    
    #sim02 controllo che non serve più perchè eliminati prima con la delete
    #sim02 if {![db_0or1row query "
    #sim02     select 1
    #sim02       from coimdimp 
    #sim02      where cod_manutentore = :cod_manutentore
    #sim02        and (trim(riferimento_pag) = :matricola) --sim01
       
    #sim02           limit 1"]
    #sim02} {
#gac01	if {$dbn_ente_collegato eq ""
#gac01        || (   $dbn_ente_collegato ne ""
#gac01	    && ![db_0or1row -dbn $dbn_ente_collegato query "
#gac01               select 1
#gac01                 from coimdimp
#gac01                where cod_manutentore = :cod_manutentore
#gac01                  and (   trim(riferimento_pag) = :matricola --sim01
#gac01                                       )
#gac01                limit 1"]
#gac01            )
#gac01	} {#nic01
    if {$prima_riga eq "t"} {
	set prima_riga "f"
	append riga_stampa "$matricola"
    } else {
	append riga_stampa " - $matricola"
    }
#gac01	};#nic01
    #sim02}
}

append stampa "<tr>
                <td align=center>$riga_stampa</td>
              </tr>
            </table>
          </center>"

# creo file temporaneo html
set file_id [open $file_html w]
fconfigure $file_id -encoding iso8859-1
puts  $file_id $stampa
close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer D / --quiet --landscape --bodyfont arial --left 1cm --right 1cm --top 0cm --bottom  0cm -f $file_pdf $file_html]

ns_unlink $file_html
ad_return_template
