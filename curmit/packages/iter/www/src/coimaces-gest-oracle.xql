<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="upd_aces">
       <querytext>
                update coimaces
                   set stato_01 = :new_stato
                     , data_mod =  sysdate
                     , utente   = :id_utente 
                 where cod_aces = :cod_aces
       </querytext>
    </partialquery>

    <fullquery name="sel_acts">
       <querytext>
                select a.cod_acts
                     , iter_edit.num(a.invariati, 0)      as ctr_invariati
                     , iter_edit.num(a.da_analizzare, 0)  as ctr_da_analizzare
                     , iter_edit.num(a.importati_aimp, 0) as ctr_importati
                     , iter_edit.num(a.chiusi_forzat, 0)  as ctr_chiusi
                  from coimacts a
                     , coimaces b
                 where cod_aces    = :cod_aces
                   and b.cod_acts  = a.cod_acts
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
                     , data_mod       =  sysdate
                     , utente         = :id_utente
                 where cod_acts       = :cod_acts
       </querytext>
    </partialquery>


</queryset>
