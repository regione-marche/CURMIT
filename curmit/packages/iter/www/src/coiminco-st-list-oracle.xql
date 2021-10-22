<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_cinc_count">
       <querytext>
                   select count(*) as conta
                     from coimcinc
                    where stato = '1'
       </querytext>
    </fullquery>

    <fullquery name="sel_cinc">
       <querytext>
                   select cod_cinc
                        , descrizione as desc_camp
                     from coimcinc
                    where stato = '1'
       </querytext>
    </fullquery>

    <partialquery name="descrizione_enve_opve">
        <querytext>
          , h.ragione_01||' - '||g.cognome||' '||nvl(g.nome,'')  as descr_enve
        </querytext>
    </partialquery>

    <partialquery name="descrizione_opve">
        <querytext>
         , g.cognome||' '||nvl(g.nome,'')  as descr_enve
	</querytext>
    </partialquery>

    <partialquery name="sel_inco_si_vie">
       <querytext>
    select *
      from (
        select /* FIRST_ROWS */
               a.cod_inco
             , a.cod_impianto
             , c.cod_impianto_est
             , iter_edit.data(a.data_verifica) as data_verifica_teo_edit
             , a.ora_verifica
             , i.descr_inst    as desc_stato
             , d.denominazione as comune
             , nvl(e.descr_topo,'')||' '||
               nvl(e.descrizione,'')||' '||
               nvl(c.numero,'')                         as indirizzo_ext
             , nvl(b.cognome, '')||' '||nvl(b.nome, '') as resp
             , e.descrizione as indirizzo
             , b.cognome
             , b.nome
             , b.telefono
             , decode (a.stato
                      , '2' , (decode (a.data_verifica 
                                      , null , ''
                                 , (decode (a.ora_verifica
                                        , null , 'Riserva'
                                        , 'Effettivo'))))
                    , '')
                as tipo_app
             , decode (a.tipo_lettera
                    , 'A' , 'Aperta'
                    , 'C' , 'Chiusa'
		    , ''
               ) as tipo_lettera_desc
             , f.descrizione as descr_camp
              $desc_enve
          from coiminco a
	     , coimaimp c
             , coimcitt b
             , coimcinc f
             , coimopve g
             , coimenve h
             , coimcomu d
             , coimviae e
             , coiminst i
         where c.cod_impianto      = a.cod_impianto
           and b.cod_cittadino $ora_join_coimcitt = c.cod_responsabile
           and f.cod_cinc          = a.cod_cinc
           and g.cod_opve      $ora_join_coimopve = a.cod_opve
           and h.cod_enve      $ora_join_coimenve = g.cod_enve
           and d.cod_comune    (+) = c.cod_comune
           and e.cod_comune    (+) = c.cod_comune
           and e.cod_via       (+) = c.cod_via
           and i.cod_inst          = a.stato
        $where_cond
        $where_last_si_vie
        $where_area
      order by e.descrizione
             , a.cod_inco
    )
    where rownum <= $rows_per_page

       </querytext>
    </partialquery>

    <partialquery name="sel_inco_no_vie">
       <querytext>
    select *
      from (
        select /* FIRST_ROWS */
               a.cod_inco
             , a.cod_impianto
             , c.cod_impianto_est
             , iter_edit.data(a.data_verifica) as data_verifica_teo_edit
             , a.ora_verifica
             , i.descr_inst    as desc_stato
             , d.denominazione as comune
             , nvl(c.toponimo,'')||' '||
               nvl(c.indirizzo,'')||' '||
               nvl(c.numero,'') as indirizzo_ext
             , nvl(b.cognome, '')||' '||nvl(b.nome, '') as resp
             , b.cognome
             , b.nome
             , b.telefono
             , c.indirizzo as indirizzo
              , decode (a.tipo_lettera
                    , 'A' , 'Aperta'
                    , 'C' , 'Chiusa'
		    , ''
                ) as tipo_lettera_desc
              , decode (a.stato
                    , '2' , (decode (a.data_verifica 
                                 , null , ''
                                 , (decode (a.ora_verifica
                                        , null , 'Riserva'
                                        , 'Effettivo'))))
                    else '')
                as tipo_app
             , f.descrizione as descr_camp
              $desc_enve
          from coiminco a
	     , coimaimp c 
             , coimcitt b
             , coimcinc f
             , coimopve g
             , coimenve h
             , coimcomu d
             , coiminst i
         where c.cod_impianto      = a.cod_impianto
           and b.cod_cittadino $ora_join_coimcitt = c.cod_responsabile
           and f.cod_cinc          = a.cod_cinc
           and g.cod_opve $ora_join_coimopve = a.cod_opve
           and h.cod_enve $ora_join_coimenve = g.cod_enve
           and d.cod_comune    (+) = c.cod_comune
           and i.cod_inst          = a.stato
        $where_cond
        $where_last_no_vie
        $where_area
      order by c.indirizzo
             , a.cod_inco
    )
    where rownum <= $rows_per_page
       </querytext>
    </partialquery>

    <fullquery name="sel_inco_count">
       <querytext>
        select iter_edit.num(count(*),0) as num_rec
          from coiminco a
	     , coimaimp c
             , coimcitt b
             , coimopve g
             , coimenve h
         where c.cod_impianto  = a.cod_impianto
           and b.cod_cittadino $ora_join_coimcitt = c.cod_responsabile
           and g.cod_opve      $ora_join_coimopve = a.cod_opve
           and h.cod_enve      $ora_join_coimenve = g.cod_enve
        $where_cond
       </querytext>
    </fullquery>

    <fullquery name="sel_cod_enve">
        <querytext>
	   select cod_enve 
             from coimopve 
	    where cod_opve = :f_cod_tecn
	</querytext>
    </fullquery>

    <fullquery name="sel_cmar">
       <querytext>
           select cod_comune
             from coimcmar
            where cod_area = :f_cod_area
       </querytext>
    </fullquery>

    <fullquery name="sel_area_tipo_01">
       <querytext>
               select tipo_01
                 from coimarea 
                where cod_area = :f_cod_area
       </querytext>
    </fullquery>


</queryset>
