<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>


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
                , coalesce(d.descr_topo,'')||' '||
                  coalesce(d.descrizione,'')||
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
                , coalesce(b.cognome,' ')||' '||coalesce(b.nome,' ')   as resp
                , b.cognome 
                , b.nome
             from coimimst e
                , coimaimp a
   $citt_join_pos coimcitt b on b.cod_cittadino = a.cod_responsabile
  left outer join coimcomu c on c.cod_comune    = a.cod_comune
  left outer join coimviae d on d.cod_comune    = a.cod_comune
              and d.cod_via       = a.cod_via
            where e.cod_imst = a.stato
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
                , coalesce(a.toponimo,'')||' '||
                  coalesce(a.indirizzo,'')||
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
                , coalesce(b.cognome)||' '||coalesce(b.nome,' ')   as resp
                , b.cognome 
                , b.nome 

             from coimimst e
                , coimaimp a
   $citt_join_pos coimcitt b on b.cod_cittadino = a.cod_responsabile
  left outer join coimcomu c on c.cod_comune    = a.cod_comune
            where e.cod_imst = a.stato
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
