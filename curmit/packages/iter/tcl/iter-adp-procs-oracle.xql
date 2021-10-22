<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="iter_set_rows_per_page.sel_rgh_2">
       <querytext>
                  select nvl(min(rgh_cde),10) as rows_per_page
                    from coimrgh
       </querytext>
    </fullquery>

    <fullquery name="iter_rows_per_page.sel_rgh">
       <querytext>
               select rgh_cde
                 from coimrgh
             order by rgh_cde
       </querytext>
    </fullquery>

    <fullquery name="iter_context_bar.sel_ogg2_2">
       <querytext>
                    select livello
                         , scelta_1
                         , scelta_2
                         , scelta_3
                         , scelta_4
                         , descrizione as desc_menu
                      from coimogge
                     where livello = :livello
                     $where_scelta
       </querytext>
    </fullquery>

    <fullquery name="iter_context_bar.sel_ogg2">
       <querytext>
            select livello
                 , scelta_1
                 , scelta_2
                 , scelta_3
                 , scelta_4
                 , descrizione as desc_funz
              from coimogge
             where nome_funz = :nome_funz
       </querytext>
    </fullquery>

    <fullquery name="iter_links_form.sel_count_gend">
       <querytext>
           select count(*) as conta_gend 
             from coimgend
	    where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="iter_links_form.sel_count_todo">
       <querytext>
           select count(*) conta_todo
             from coimtodo
            where cod_impianto = :cod_impianto
	      and flag_evasione = 'N'
       </querytext>
    </fullquery>

    <fullquery name="iter_links_form.sel_cod_gend">
       <querytext>
           select gen_prog
             from coimgend
	    where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="iter_tab_form.get_dat_aimp_si_vie">
       <querytext>
           select a.cod_impianto_est
                , a.localita
                , a.cod_amag
                , b.denominazione as comune
                , c.descrizione as via
                , c.descr_topo as topo
                , a.numero
                , a.esponente
                , a.scala
                , a.piano
                , a.interno
                , a.cap
                , nvl(d.cognome, '')||' '||nvl(d.nome, '') as resp
                , nvl(e.cognome, '')||' '||nvl(e.nome,'') as occup
                , decode (
                    (((select add_months(sysdate, :mesi_evidenza_mod) 
                         from dual) - a.data_mod)
                - abs((select add_months(sysdate, :mesi_evidenza_mod)
                         from dual) - a.data_mod))
                    , 0, 'F'
                    , decode (
                        a.data_mod, a.data_ins, 'F'                
                        , decode (
                             (a.data_mod - a.data_ins)-abs(a.data_mod - a.data_ins)
                             , 0, 'T'
                             , 'F'
                          )
                      )
                  ) as swc_mod
                , iter_edit.data(a.data_mod) as data_mod_edit
                , a.utente
             from coimaimp a
                , coimcomu b 
                , coimviae c 
                , coimcitt e  
                , coimcitt d
            where a.cod_impianto  = :cod_impianto
              and d.cod_cittadino (+) = a.cod_responsabile
              and b.cod_comune    (+) = a.cod_comune
              and c.cod_comune    (+) = a.cod_comune
              and c.cod_via       (+) = a.cod_via 
              and e.cod_cittadino (+) = a.cod_occupante
       </querytext>
    </fullquery>

    <fullquery name="iter_tab_form.get_dat_aimp_no_vie">
       <querytext>
           select a.cod_impianto_est
                , a.localita
                , a.cod_amag
                , b.denominazione as comune
                , a.indirizzo as via
                , a.toponimo as topo
                , a.numero
                , a.esponente
                , a.scala
                , a.piano
                , a.interno
                , a.cap
                , nvl(d.cognome, '')||' '||nvl(d.nome, '') as resp
                , nvl(e.cognome, '')||' '||nvl(e.nome,'') as occup
                , decode (
                    (((select add_months(sysdate, :mesi_evidenza_mod) 
                         from dual) - a.data_mod)
                - abs((select add_months(sysdate, :mesi_evidenza_mod)
                         from dual) - a.data_mod))
                    , 0, 'F'
                    , decode (
                        a.data_mod, a.data_ins, 'F'                
                        , decode (
                             (a.data_mod - a.data_ins)-abs(a.data_mod - a.data_ins)
                             , 0, 'T'
                             , 'F'
                          )
                      )
                  ) as swc_mod
                , iter_edit.data(a.data_mod) as data_mod_edit
                , a.utente
             from coimaimp a
                , coimcomu b 
                , coimcitt e  
                , coimcitt d
            where a.cod_impianto  = :cod_impianto
              and d.cod_cittadino (+) = a.cod_responsabile
              and b.cod_comune    (+) = a.cod_comune
              and e.cod_cittadino (+) = a.cod_occupante
       </querytext>
    </fullquery>

    <fullquery name="iter_tab_form.sel_uten">
       <querytext>
           select nvl(cognome,'')||' '||nvl(nome,'') as uten_desc
             from coimuten
            where id_utente = :utente
       </querytext>
    </fullquery>

    <fullquery name="iter_tab_form_palm.get_dat_aimp">
       <querytext>
           select a.cod_impianto_est
                , a.localita
                , a.cod_amag
                , b.denominazione as comune
                , c.descrizione as via
                , c.descr_topo as topo
                , a.numero
                , a.esponente
                , a.scala
                , a.piano
                , a.interno
                , a.cap
                , nvl(d.cognome, '')||' '||nvl(d.nome, '') as resp
                , nvl(e.cognome, '')||' '||nvl(e.nome,'') as occup
             from coimaimp a
                , coimcomu b 
                , coimviae c 
                , coimcitt e  
                , coimcitt d
            where a.cod_impianto  = :cod_impianto
              and d.cod_cittadino (+) = a.cod_responsabile
              and b.cod_comune    (+) = a.cod_comune
              and c.cod_via       (+) = a.cod_via 
              and e.cod_cittadino (+) = a.cod_occupante
       </querytext>
    </fullquery>

    <fullquery name="iter_tab_area.get_dat_area">
       <querytext>
           select cod_area
                , tipo_01
                , tipo_02
                , descrizione
             from coimarea
            where cod_area = :cod_area          
       </querytext>
    </fullquery>

    <fullquery name="iter_tab_aces.get_dat_test">
       <querytext>
          select  iter_edit.data(a.data_caric) as data_caric
                , a.cod_documento              as cod_documento
                , b.cod_aces_est               as cod_utenza
                , b.cod_combustibile
		, b.natura_giuridica
                , decode (b.natura_giuridica
                         , 'F', 'Fisica'
                         , 'G', 'Giuridica'
                         , ''
                         ) as natura_giuridica_edit
                , b.cognome
                , b.nome
                , b.indirizzo
                , b.numero
                , b.esponente
                , b.scala
                , b.piano
                , b.interno
                , b.cap
                , b.localita
                , b.comune
                , b.provincia
                , b.cod_fiscale_piva
                , decode (b.stato_01
                         , 'N', 'Nuovo record'
                         , 'E', 'Esistente'
                         , 'I', 'Invariato sugli impianti'
                         , 'D', 'Da analizzare'
                         , 'S', 'Record scartato'
                         , 'P', 'Esportato sugli impianti' 
                         , ''
                         ) as stato_aces
                , b.note
                , c.ragione_01   as descr_distributore
                , d.descr_comb   as descr_comb
             from coimaces b
                , coimcomb d
                , coimacts a
                , coimdist c
            where b.cod_aces             = :cod_aces
              and a.cod_acts             = b.cod_acts
              and d.cod_combustibile (+) = b.cod_combustibile
              and c.cod_distr        (+) = a.cod_distr
       </querytext>
    </fullquery>


    <fullquery name="iter_tab_aces.get_dat_comu">
       <querytext>
          select  cod_comune
             from coimcomu
            where denominazione  = :comune
       </querytext>
    </fullquery>

    <fullquery name="iter_link_inco.sel_dati_inco">
       <querytext> 
           select a.stato
                , a.esito
                , a.cod_impianto
                , b.stato as stato_aimp
             from coiminco a
                , coimaimp b
            where a.cod_inco = :cod_inco
              and b.cod_impianto = a.cod_impianto
       </querytext> 
    </fullquery>

    <fullquery name="iter_link_inco.sel_cimp_count">
       <querytext>
           select count(*)
             from coimcimp
            where cod_inco = :cod_inco
       </querytext>
    </fullquery>

    <fullquery name="iter_links_form.sel_docu_count">
       <querytext>
           select count(*) as count_docu
             from coimdocu
            where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="iter_tab_rgen.get_dat_rgen">
       <querytext>
           select cod_rgen
                , descrizione
             from coimrgen
            where cod_rgen = :cod_rgen          
       </querytext>
    </fullquery>


</queryset>
