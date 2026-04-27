ad_page_contract {

    @author Antonio Pisano
    
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================================================
    innes 23/05/2018 Innesto da iter-dev a iter-portal-dev. Tutte le query verranno eseguite
    innes            passando il dbn che riceviamo dalla pagina di filtro. Abbiamo gestito il
    innes            dbn anche per le proc iter_get_coimtgen e iter_get_coimdesc.
    innes            Aggiunti i parametri targa e dbn_iter.

    gac01 29/11/2017 modificato potenza termica nominale utile, nella seconda pagina di stampa metto la pot. termica 
    gac01            nominale utile al posto della potenza termica nominale complessiva

} {
    {cod_dope_aimp ""}
    
    {nome_funz ""}
    {flag_ins ""}
    {targa    ""}
    {dbn_iter ""}
}

# Controlla lo user
#innesif {![string is space $nome_funz]} {
#innes    set lvl        1
#innes    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
#innes} else {
  # se la lista viene chiamata da un cerca, allora nome_funz non viene passato
  # e bisogna reperire id_utente dai cookie
  # set id_utente [ad_get_cookie iter_login_[ns_conn location]]
#innes    set id_utente [iter_get_id_utente]
#innes}

set img_url [iter_set_logo_dir]
set img_checked   "${img_url}/checked.bmp"
set img_unchecked "${img_url}/unchecked.bmp"

# Estraggo i dati della dichiarazione
if {![db_0or1row -dbn $dbn_iter query "
  select 
      cod_dope_aimp,
      cod_documento,
      cod_impianto,
      flag_tipo_impianto,
      cognome_dichiarante,
      nome_dichiarante,
      flag_dichiarante,
      cod_manutentore,
      flag_tipo_tecnico,
      (select descr_utgi from coimutgi
        where cod_utgi = d.cod_utgi) as utilizzo,
      pot_nom_risc,
      pot_nom_raff,
      num_generatori,
      (select descr_comb from coimcomb
        where cod_combustibile = d.cod_combustibile) as combustibile,
      cod_combustibile,
      toponimo,
      indirizzo,
      cod_via,
      localita,
      numero,
      esponente,
      scala,
      piano,
      interno,
      cod_comune,
      cod_distr,
      cod_responsabile,
      flag_resp,
      flag_doc_tecnica,
      flag_istr_tecniche,
      flag_man_tecnici,
      flag_reg_locali,
      flag_norme_uni_cei,
      altri_doc,
      data_dich as data_dich_db,
      iter_edit_data(data_dich) as data_dich
    from coimdope_aimp d
  where cod_dope_aimp = :cod_dope_aimp
"]} {
    iter_return_complaint "Dati Dichiarazione non trovati"
    return
}

# Faccio in questo punto il controllo sull'utente perche' c'e' bisogno del cod_impianto
set login_cohesion_marche_p [parameter::get_from_package_key -package_key iter-portal -parameter login_cohesion_marche_p];#innes

set login_cittadino_p [parameter::get_from_package_key -package_key iter-portal -parameter login_cittadino_p];#innes

if {$login_cohesion_marche_p eq "1"} {#innes: aggiunta if, else e loro contenuto
    set codice_fiscale [iter::check_login_cohesion -nome_array_output array_cohesion -dbn_iter $dbn_iter -cod_impianto $cod_impianto]
    # Se in futuro ci sara' bisogno di altri campi useremo i valori di array_cohesion
} else {
    if {$login_cittadino_p} {
	set user_id [iter::script_init_cittadino]
    }
}

set id_utente "";#innes (dove e' rimasto l'utilizzo di id_utente, non serve)


# Voglio salvare il documento...
if {$flag_ins eq "S"} {
    # non esiste, lo salvo come nuovo
    if {$cod_documento eq ""} {
        set sw_insert_coimdocu "t"
    # dovrebbe esistere. Lo verifico e nel caso lo salvo
    } else {
        if {[db_0or1row -dbn $dbn_iter query "
            select 1
              from coimdocu
             where cod_documento = :cod_documento"]
	} {
	    set sw_insert_coimdocu "f"
    	} else {
	    set sw_insert_coimdocu "t"
	}
    }
}

# Dati dell'impianto
db_1row -dbn $dbn_iter query "
    select cod_impianto_est
    from coimaimp
    where cod_impianto = :cod_impianto"

# Nome del fornitore di energia
set fornitore_energia ""
if {[db_0or1row -dbn $dbn_iter query "
    select ragione_01, ragione_02
    from coimdist where cod_distr = :cod_distr"]} {
    set fornitore_energia "$ragione_01 $ragione_02"
}

# Nominativo del responsabile
db_1row -dbn $dbn_iter query "
    select cognome as cognome_resp,
           nome as nome_resp
    from coimcitt
    where cod_cittadino = :cod_responsabile"

# Dati topografici dell'impianto
db_1row -dbn $dbn_iter query "
    select i.indirizzo     as indirizzo_imp,
           numero          as numero_imp,
           esponente       as esponente_imp,
           scala           as scala_imp,
           piano           as piano_imp,
           interno         as interno_imp,
           c.denominazione as comune_imp,
           p.sigla         as provincia_imp
        from coimaimp i,
             coimcomu c,
             coimprov p
        where i.cod_comune = c.cod_comune
          and p.cod_provincia = c.cod_provincia
          and i.cod_impianto = :cod_impianto"

# Altri dati del manutentore/dichiarante
db_1row -dbn $dbn_iter query "
    select nome    as nome_manu,
           cognome as cognome_manu,
           cod_piva,
           localita_reg,
           reg_imprese,
           indirizzo as indirizzo_manu,
           telefono,
           fax,
           email,
           comune    as comune_manu,
           provincia as provincia_manu,
           flag_a,
           flag_b,
           flag_c,
           flag_d,
           flag_e,
           flag_f,
           flag_g
        from coimmanu
    where cod_manutentore = :cod_manutentore"

# Estraggo i dati dell'ente per la stampa
#innesiter_get_coimtgen
iter_get_coimtgen -dbn $dbn_iter;#innes
set flag_viario  $coimtgen(flag_viario)
set flag_ente    $coimtgen(flag_ente)
set cod_prov     $coimtgen(cod_provincia)
set sigla_prov   $coimtgen(sigla_prov)
set denom_comune $coimtgen(denom_comune)

db_1row -dbn $dbn_iter sel_desc "
  select nome_ente, 
         indirizzo    as indirizzo_ente, 
         tipo_ufficio as tipo_ufficio_ente
    from coimdesc"

set html ""
# Codice per creare l'HTML di una pagina
set create_page_cmd {
    set code [template::adp_compile -file [ad_conn file]]
    append html [template::adp_eval code]
    append html "<!-- PAGE BREAK -->"
}

set pagina_corrente 1

set rows_per_page 32
set rows 0
set key ""
# Queste sono tutte le operazioni sull'impianto.
# Per poter mostrare il numero di pagine in cui siamo, prima mi 
# scorro tutte le righe calcolandomi quante pagine usciranno.
db_multirow -dbn $dbn_iter operazioni_tot query "
    select 
          o.gen_prog, 
          iter_edit_data(data_installaz) as data_installaz, 
          flag_attivo,
          iter_edit_num(oi.pot_nom_raff,2) as pot_nom_raff,
          iter_edit_num(oi.pot_nom_risc,2) as pot_nom_risc,
          iter_edit_num(g.pot_utile_nom,2) as pot_utile_nom, --gac01
          modello,
          matricola,
          (select descr_cost 
            from coimcost 
          where cod_cost = g.cod_cost) as fabbricante,
          operazione,
          frequenza,
          (select sigla from coimflre
            where cod_flre = g.cod_flre) as fluido_refrigerante
      from coimdope_gend o,
           coimdope_aimp oi,
           coimgend g
  where o.gen_prog       = g.gen_prog
    and oi.cod_dope_aimp = o.cod_dope_aimp
    and oi.cod_impianto  = g.cod_impianto
    and o.cod_dope_aimp = :cod_dope_aimp
   order by gen_prog asc" {
   # Considero che per l'intestazione di ogni generatore...
   if {$key ne $gen_prog} {
        set key $gen_prog
        # ...mi vadano 2 righe per il caldo
        if {$flag_tipo_impianto eq "R"} {
            incr rows 2
        # ...e 4 per il freddo
        } else {
            incr rows 4
        }
    }
    
    # ...e 1 riga per ogni operazione.
    incr rows
    
    if {$rows >= $rows_per_page} {
        incr pagina_corrente
        set rows 0
    }
}

# pagine di interventi + la prima pagina
set tot_pagine [expr {$pagina_corrente + 1}]

set pagina_corrente 1
set rows 0

# Creo la prima pagina, contenente la dichiarazione
eval $create_page_cmd
incr pagina_corrente

# Da qui creero' le pagine contenenti l'elenco operazioni

# Dopo aver calcolato il numero totale di pagine, procedo
# a travasarle una per una in una multirow temporanea,
# che conterra' solo le righe stampate nella pagina
# corrente.
set colonne [template::multirow columns operazioni_tot]
set variabili \$[join $colonne " \$"]
# La creo dalla definizione di quella grossa...
eval "template::multirow create operazioni $colonne"
template::multirow foreach operazioni_tot {
    # ...e la riempio con valori di quella grossa...
    eval "multirow append operazioni $variabili"
    incr rows
    if {$rows >= $rows_per_page} {
        # ...creo l'html di questa pagina e lo accodo al resto
        eval $create_page_cmd
        # ...quindi azzero la multirow temporanea.
        eval "template::multirow create operazioni $colonne"
        incr pagina_corrente
        set rows 0
    }
}

# Accodo l'ultima pagina
eval $create_page_cmd


set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]

# save rml in a temporary file
set filename "coimdope-aimp-${id_utente}"
set filename [iter_temp_file_name $filename]
set file_html "$spool_dir/$filename.html"
set file_pdf  "$spool_dir/$filename.pdf"

set wfd [open $file_html w]
fconfigure $wfd -encoding "iso8859-15"
set html [encoding convertto "iso8859-15" $html]
puts $wfd $html
close $wfd

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --fontsize 8 --left 1cm --right 1cm --top 0cm --bottom 0cm -f $file_pdf $file_html]
ns_unlink $file_html

if {$flag_ins eq "S"} {
    db_transaction {
        # Se e' un nuovo documento
        if {$sw_insert_coimdocu eq "t"} {
            set contenuto     ""
            set cod_documento [db_string -dbn $dbn_iter query "select nextval('coimdocu_s')"]
            # DE = 'Dich. freq. ed elenco oper.'
            set tipo_documento "DE"
            db_dml -dbn $dbn_iter query "
               insert
                 into coimdocu
                    ( cod_documento
                    , tipo_documento
                    , cod_impianto
                    , data_documento
                    , data_stampa
                    , protocollo_02
                    , data_prot_02
                    , tipo_soggetto
                    , cod_soggetto
                    , data_ins
                    , utente
           ) values ( :cod_documento
                    , :tipo_documento
                    , :cod_impianto
                    , :data_dich_db
                    , current_date
                    , null
                    , null
                    , 'C'
                    , :cod_responsabile
                    , current_date
                    , :id_utente
                )"

            # Inserisco il riferimento al documento sulla dichiarazione
            db_dml -dbn $dbn_iter query "
            update coimdope_aimp
               set cod_documento = :cod_documento 
             where cod_dope_aimp = :cod_dope_aimp"
        } else {
	    # E' un documento gia' esistente

            db_dml -dbn $dbn_iter query "
            update coimdocu
               set data_documento = :data_dich_db
                 , data_stampa    = current_date
                 , data_mod       = current_date
                 , utente         = :id_utente
             where cod_documento  = :cod_documento"

            db_1row -dbn $dbn_iter query "
            select contenuto
              from coimdocu
             where cod_documento = :cod_documento"

	    # Se avevo del contenuto salvato, 
	    # prima lo elimino dai large objects
	    if {$contenuto ne ""} {
		db_dml -dbn $dbn_iter query "
                update coimdocu
                   set contenuto     = lo_unlink(coimdocu.contenuto)
                 where cod_documento = :cod_documento"
	    }
        }
        
        # Ed infine salvo il nuovo pdf nella tabella
        set tipo_contenuto [ns_guesstype $file_pdf]
        db_dml -dbn $dbn_iter query "
        update coimdocu
           set tipo_contenuto = :tipo_contenuto
             , contenuto      = lo_import(:file_pdf)
         where cod_documento  = :cod_documento"
    }
}

ad_returnredirect "$spool_dir_url/$filename.pdf"
ad_script_abort
