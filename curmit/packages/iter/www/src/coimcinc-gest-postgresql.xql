<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_cinc_2">
       <querytext>
             select stato
               from coimcinc
              where cod_cinc = :cod_cinc
       </querytext>
    </fullquery>

    <fullquery name="sel_cinc">
       <querytext>
             select cod_cinc
                  , descrizione
                  , iter_edit_data(data_inizio) as data_inizio
                  , iter_edit_data(data_fine) as data_fine
                  , stato
                  , note
                  , iter_edit_num(controlli_prev,0) as controlli_prev
                  , flag_tipo_impianto
               from coimcinc
              where cod_cinc = :cod_cinc
       </querytext>
    </fullquery>

    <fullquery name="sel_desc">
       <querytext>
                  select 1 
                    from coimcinc
                   where upper(descrizione) = upper(:descrizione)
                  $where_cod
       </querytext>
    </fullquery>

    <fullquery name="sel_dual_cod">
       <querytext>
          select nextval('coimcinc_s') as cod_cinc
       </querytext>
    </fullquery>

    <partialquery name="ins_cinc">
       <querytext>
                insert
                  into coimcinc 
                     ( cod_cinc
                     , stato
                     , descrizione
                     , data_inizio
                     , data_fine
                     , note
                     , controlli_prev
                     , flag_tipo_impianto)
                values
                     (:cod_cinc
                     ,:stato
                     ,:descrizione
                     ,:data_inizio
                     ,:data_fine
                     ,:note
                     ,:controlli_prev
                     ,:flag_tipo_impianto)
       </querytext>
    </partialquery>

    <partialquery name="mod_cinc">
       <querytext>
                update coimcinc
                   set descrizione    = :descrizione
                     , stato          = :stato
                     , data_inizio    = :data_inizio
                     , data_fine      = :data_fine
                     , note           = :note
                     , controlli_prev = :controlli_prev
                     , flag_tipo_impianto = :flag_tipo_impianto
                 where cod_cinc       = :cod_cinc
       </querytext>
    </partialquery>

    <partialquery name="del_cinc">
       <querytext>
                delete
                  from coimcinc
                 where cod_cinc = :cod_cinc
       </querytext>
    </partialquery>

    <partialquery name="del_inco">
       <querytext>
                delete
                  from coiminco
                 where cod_cinc = :cod_cinc
       </querytext>
    </partialquery>

    <fullquery name="sel_cinc_count">
       <querytext>
                select count(*) as conta
                  from coimcinc
                 where stato = '1'
                $where_cod
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_count">
       <querytext>
                select count(*) as ctr_inco
                  from coiminco
                 where cod_cinc = :cod_cinc
                   and stato not in ('0', '5')
       </querytext>
    </fullquery>

</queryset>
