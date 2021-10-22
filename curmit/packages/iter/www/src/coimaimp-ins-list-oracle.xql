<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>


    <fullquery name="sel_comu">
       <querytext>
            select denominazione as denom_comune
              from coimcomu
             where cod_comune = :f_comune
       </querytext>
    </fullquery>

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
           , e.descr_imst as stato
           , nvl(b.cognome,' ')||' '||nvl(b.nome,' ')   as resp
           , b.cognome 
           , b.nome 
           , b.cod_fiscale   as cod_fiscale
        from coimaimp a
           , coimcitt b
           , coimcomu c
	   , coimviae d
	   , coimimst e
       where b.cod_cittadino $citt_join_ora = a.cod_responsabile
         and c.cod_comune    (+) = a.cod_comune
         and d.cod_comune    (+) = a.cod_comune	
         and d.cod_via       (+) = a.cod_via
         and e.cod_imst          = a.stato
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
           , e.descr_imst as stato
           , nvl(b.cognome,' ')||' '||nvl(b.nome,' ')   as resp
           , b.cognome 
           , b.nome 
        from coimaimp a
           , coimcitt b
           , coimcomu c 
           , coimimst e
       where b.cod_cittadino $citt_join_ora = a.cod_responsabile
         and c.cod_comune    (+) = a.cod_comune
         and e.cod_imst          = a.stato
       $where_word
       $where_nome
       $where_comune
       $where_via
        and a.stato <> 'L'
    $ordinamento
       </querytext>
    </partialquery>

    <fullquery name="sel_aimp_stato">
       <querytext>
            select stato as stato_aimp
              from coimaimp
             where cod_impianto = :codice_impianto
       </querytext>
    </fullquery>


</queryset>
