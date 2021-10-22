<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="edit_date_dual">
       <querytext>
       select iter_edit.data(:f_data_evas_da) as data_evas_da_ed
            , iter_edit.data(:f_data_evas_a) as data_evas_a_ed
         from dual
       </querytext>
    </fullquery>

    <fullquery name="edit_num_dual">
       <querytext>
       select iter_edit.num(:f_potenza_da, 2) as potenza_da_ed
            , iter_edit.num(:f_potenza_a,  2) as potenza_a_ed
         from dual
       </querytext>
    </fullquery>

    <fullquery name="get_desc_comb">
       <querytext>
       select descr_comb 
         from coimcomb
        where cod_combustibile = :f_cod_combustibile
       </querytext>
    </fullquery>

    <fullquery name="get_desc_tpim">
       <querytext>
       select descr_tpim as descr_tpim
         from coimtpim
        where cod_tpim = :f_cod_tpim
       </querytext>
    </fullquery>

    <fullquery name="sel_desc_comu">
       <querytext>
       select denominazione as desc_comu
         from coimcomu
        where cod_comune = :f_cod_comune
       </querytext>
    </fullquery>

    <fullquery name="get_todo_si_vie">
       <querytext>
       select b.cod_impianto_est as cod_imp
            , a.note
            , nvl(c.cognome,'')||' '|| 
              nvl(c.nome,'') as resp
            , nvl(d.descr_topo,'')||' '||
              nvl(d.descrizione,'')||' '||
              nvl(b.numero,'') as indirizzo
            , e.denominazione as comune
            , f.descrizione as tipologia
	 from coimtodo a
            , coimaimp b 
            , coimcitt c 
            , coimviae d  
            , coimcomu e 
            , coimtpdo f
            , coimanom g
            , coimanrg i
            , coimrgen l
        where b.cod_impianto  = a.cod_impianto
          and g.cod_cimp_dimp = a.cod_cimp_dimp
          and f.cod_tpdo          = a.tipologia 
          and c.cod_cittadino (+) = b.cod_responsabile
          and d.cod_comune    (+) = b.cod_comune
          and d.cod_via       (+) = b.cod_via
          and e.cod_comune    (+) = b.cod_comune
          and l.cod_rgen      (+) = i.cod_rgen
          and i.cod_tano      (+) = g.cod_tanom
        $where_comune
        $where_tipologia
        $where_evasione
        $where_data
        $where_potenza
        $where_comb
        $where_tpim	
        $where_rgen
	order by e.denominazione
       </querytext>
    </fullquery>

    <fullquery name="get_todo_no_vie">
       <querytext>
       select b.cod_impianto_est as cod_imp 
            , a.note
            , nvl(c.cognome,'')||' '||
              nvl(c.nome,'') as resp
            , nvl(b.toponimo, '')||' '||
              nvl(b.indirizzo, '')||' '||
              nvl(b.numero, '') as indirizzo
            , e.denominazione as comune
            , f.descrizione as tipologia
	 from coimtodo a
            , coimaimp b 
            , coimcitt c 
            , coimcomu e
            , coimtpdo f
            , coimanrg i
            , coimrgen l
        where b.cod_impianto  = a.cod_impianto
          and g.cod_cimp_dimp = a.cod_cimp_dimp
          and f.cod_tpdo      = a.tipologia
          and c.cod_cittadino (+) = b.cod_responsabile
          and e.cod_comune    (+) = b.cod_comune 
          and l.cod_rgen      (+) = i.cod_rgen
          and i.cod_tano      (+) = g.cod_tanom
        $where_comune
        $where_tipologia
        $where_evasione
        $where_data
        $where_potenza
        $where_comb
        $where_tpim
        $where_rgen	
	order by e.denominazione
       </querytext>
    </fullquery>

    <fullquery name="estrai_data">
       <querytext>
       select iter_edit.data(sysdate) as data_time
         from dual
       </querytext>
    </fullquery>

</queryset>
