<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>


    <fullquery name="sel_join_opve_zona">
       <querytext>
     select d.cod_opve as cod_opve_zona
       from coimtcar d
          , coimcmar c
          , coimaimp b
          , coiminco a
      where a.cod_inco     = :cod_inco
        and b.cod_impianto = a.cod_impianto
        and c.cod_comune   = b.cod_comune
        and d.cod_area     = c.cod_area
       </querytext>
    </fullquery>    


    <partialquery name="sel_opve">
       <querytext>
    select a.cod_opve
          $ordine1
         , iter_edit.data(a.data_verifica) as data
         , a.data_verifica
         , a.ora_verifica
         , b.cognome
         , b.nome
         , a.cod_impianto
         , decode (a.cod_impianto 
             , null , ''
             , (select d.denominazione 
                     from coimaimp c
                        , coimcomu d
                    where c.cod_impianto = a.cod_impianto
                      and d.cod_comune   = c.cod_comune)
            ) as comune
      from coiminco a
         , coimopve b
     where b.cod_enve = :cod_enve
       and a.cod_opve = b.cod_opve
       and a.data_verifica is not null
       and a.data_verifica between :data_inizio_cinc and :data_fine_cinc
       and (a.stato is null or a.stato <> '5')
     $where_opve
     $where_data
     $where_ora
     $where_opve_area_1

    union

    select a.cod_opve
           $ordine2
         , iter_edit.data(a.data_verifica) as data
         , a.data_verifica
         , a.ora_verifica
         , b.cognome
         , b.nome
         , a.cod_impianto
         , decode (a.cod_impianto 
             , null , ''
             ,    (select d.denominazione 
                     from coimaimp c
                        , coimcomu d
                    where c.cod_impianto = a.cod_impianto
                      and d.cod_comune   = c.cod_comune)
           ) as comune
      from coiminco a
         , coimopve b
     where b.cod_enve = :cod_enve
       and a.cod_opve = b.cod_opve
       and a.data_verifica is not null
       and a.data_verifica between :data_inizio_cinc and :data_fine_cinc
       and (a.stato is null or a.stato <> '5')
     $where_opve
     $where_data
     $where_ora
     $where_opve_area_2

    union

    select b.cod_opve
           $ordine3
         , null as data
         , to_date('9999-12-31','yyyy-mm-dd') as data_verifica
         , '99:99' as ora_verifica
         , b.cognome
         , b.nome
         , '' as cod_impianto
         , '' as comune
      from coimopve b
     where b.cod_enve = :cod_enve
     $order_by

       </querytext>
    </partialquery>

    <fullquery name="sel_enve">
       <querytext>
                 select ragione_01||' '||nvl(ragione_02,'') as nome_enve
                   from coimenve
                  where cod_enve = :cod_enve
       </querytext>
    </fullquery>

    <fullquery name="sel_cinc">
       <querytext>
                   select cod_cinc
                        , data_inizio as data_inizio_cinc
                        , data_fine   as data_fine_cinc
                     from coimcinc
                    where stato = '1'
       </querytext>
    </fullquery>

</queryset>
