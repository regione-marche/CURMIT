<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="upd_aces">
       <querytext>
                update coimaces
                   set stato_01 = :new_stato
                     , data_mod =  current_date
                     , utente   = :id_utente 
                 where cod_aces = :cod_aces
       </querytext>
    </partialquery>

    <fullquery name="sel_acts">
       <querytext>
                select a.cod_acts
                     , iter_edit_num(a.invariati, 0)      as ctr_invariati
                     , iter_edit_num(a.da_analizzare, 0)  as ctr_da_analizzare
                     , iter_edit_num(a.importati_aimp, 0) as ctr_importati
                     , iter_edit_num(a.chiusi_forzat, 0)  as ctr_chiusi
                  from coimacts a
            inner join coimaces b
                    on b.cod_acts = a.cod_acts
                 where cod_aces = :cod_aces
       </querytext>
    </fullquery>

    <partialquery name="upd_acts">
       <querytext>
                update coimacts
                   set invariati      = :invariati
                     , da_analizzare  = :da_analizzare
                     , importati_aimp = :importati_aimp
                     , chiusi_forzat  = :chiusi_forzat
                     , stato          = :stato_acts
                     , data_mod       =  current_date
                     , utente         = :id_utente
                 where cod_acts       = :cod_acts
       </querytext>
    </partialquery>


</queryset>
