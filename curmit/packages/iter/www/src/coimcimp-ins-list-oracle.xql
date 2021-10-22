<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>



    <partialquery name="sel_aimp_vie">
       <querytext>
      select a.cod_impianto
           , a.numero
           , c.denominazione       as comune
           , nvl(d.descr_topo,'')||' '||
             nvl(d.descrizione,'')||
             case
               when a.numero is null then ''
               else ', '||a.numero
             end ||
             case
               when a.esponente is null then ''
               else '/'||a.esponente
             end ||
             case
               when a.scala is null then ''
               else ' S.'||a.scala
             end ||
             case
               when a.piano is null then ''
               else ' P.'||a.piano
             end ||
             case
               when a.interno is null then ''
               else ' In.'||a.interno
             end
                           as indir
           , d.descrizione as via
           , f.descr_imst as stato
           , nvl(b.cognome,' ')||' '||nvl(b.nome,' ')   as resp
           , b.cognome 
           , b.nome 
           , b.cod_fiscale   as cod_fiscale
        from coimaimp a
           , coimcitt b
           , coimcomu c
	   , coimviae d
           , coimimst f
       where b.cod_cittadino $citt_join_ora = a.cod_responsabile
         and c.cod_comune    (+) = a.cod_comune
         and d.cod_comune    (+) = a.cod_comune	
         and d.cod_via       (+) = a.cod_via
         and f.cod_imst          = a.stato
       $where_word
       $where_nome
       $where_comune
       $where_via
         and a.stato <> 'L'
 $ordinamento
       </querytext>
    </partialquery>


    <partialquery name="sel_aimp_no_vie">
       <querytext>
      select a.cod_impianto
           , a.numero
           , c.denominazione       as comune
           , nvl(a.toponimo,'')||' '||
             nvl(a.indirizzo,'')||
             case
               when a.numero is null then ''
               else ', '||a.numero
             end ||
             case
               when a.esponente is null then ''
               else '/'||a.esponente
             end ||
             case
               when a.scala is null then ''
               else ' S.'||a.scala
             end ||
             case
               when a.piano is null then ''
               else ' P.'||a.piano
             end ||
             case
               when a.interno is null then ''
               else ' In.'||a.interno
             end
                         as indir
           , a.indirizzo as via
           , f.descr_imst as stato
           , nvl(b.cognome,' ')||' '||nvl(b.nome,' ')   as resp
           , b.cognome 
           , b.nome 
        from coimaimp a
           , coimcitt b
           , coimcomu c
           , coimimst f 
       where b.cod_cittadino $citt_join_ora = a.cod_responsabile
         and c.cod_comune    (+) = a.cod_comune
         and f.cod_imst          = a.stato
       $where_word
       $where_nome
       $where_comune
       $where_via
         and a.stato <> 'L'
    $ordinamento

       </querytext>
    </partialquery>

    <fullquery name="sel_aimp_dati">
       <querytext>
           select c.cod_comune    as f_comune
                , c.denominazione as denom_comune
                , d.descr_topo    as desc_topo1
                , d.descrizione   as desc_via1
                , a.toponimo      as desc_topo2
                , a.indirizzo     as desc_via2
                , d.cod_via       as f_cod_via
                , b.cognome       as f_resp_cogn
                , b.nome          as f_resp_nome
             from coimaimp a
                , coimcitt b
                , coimcomu c
	        , coimviae d
            where b.cod_cittadino $citt_join_ora = a.cod_responsabile
             and c.cod_comune    (+) = a.cod_comune
             and d.cod_comune    (+) = a.cod_comune	
             and d.cod_via       (+) = a.cod_via
             and a.cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_stato">
       <querytext>
            select stato as stato_aimp
              from coimaimp
             where cod_impianto = :codice_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_viae">
       <querytext>
             select cod_via
               from coimviae
              where cod_comune  = :f_comune
                and descr_topo  = upper(:f_desc_topo)
                and descrizione = upper(:f_desc_via)
       </querytext>
    </fullquery>

    <fullquery name="sel_funz_insdimp">
       <querytext>
             select nome_funz as nome_funz_insidimp
               from coimfunz
              where nome_funz like 'insdimp%'
       </querytext>
    </fullquery>


</queryset>
