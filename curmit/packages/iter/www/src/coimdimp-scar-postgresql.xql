<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_tabs">
       <querytext>
           select nome_colonna
             from coimtabs
            where nome_tabella = 'iterman'
            order by ordinamento
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp_aimp">
       <querytext>
           select cod_dimp
                , $query_cols
             from coimdimp a
  left outer join coimmanu d on d.cod_manutentore = a.cod_manutentore
                , coimaimp b
  left outer join coimcitt e on e.cod_cittadino = b.cod_responsabile
  left outer join coimcitt f on f.cod_cittadino = b.cod_occupante
  left outer join coimcitt g on g.cod_cittadino = b.cod_proprietario
  left outer join coimcitt h on h.cod_cittadino = b.cod_intestatario
  left outer join coimcomu o on o.cod_comune    = b.cod_comune
  left outer join coimprov q on q.cod_provincia = b.cod_provincia
                , coimgend c
  left outer join coimcomb i on i.cod_combustibile = c.cod_combustibile
  left outer join coimcost n on n.cod_cost         = c.cod_cost
  left outer join coimcost p on p.cod_cost         = c.cod_cost_bruc
            where b.cod_impianto  = a.cod_impianto
              and a.cod_impianto  = c.cod_impianto
              and c.gen_prog      = a.gen_prog
           $where_manu
           $where_data_ins
           $where_data_controllo
        $order_by
       </querytext>
    </fullquery>

    <fullquery name="sel_manu">
       <querytext>
           select cognome    as manu_cognome
                , nome       as manu_nome
                , indirizzo  as manu_indirizzo
                , cap        as manu_cap
                , localita   as manu_localita
                , comune     as manu_comune
                , provincia  as manu_provincia
                , telefono   as manu_telefono
             from coimmanu
            where cod_manutentore = :manu_cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_manu">
       <querytext>
           select cognome    as manu_cognome
                , nome       as manu_nome
                , indirizzo  as manu_indirizzo
                , cap        as manu_cap
                , localita   as manu_localita
                , comune     as manu_comune
                , provincia  as manu_provincia
                , telefono   as manu_telefono
             from coimmanu
            where cod_manutentore = :manu_cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_anom">
       <querytext>
           select cod_tanom
             from coimanom
            where cod_cimp_dimp = :cod_dimp
              and flag_origine = 'MH'
       </querytext>
    </fullquery>

</queryset>
