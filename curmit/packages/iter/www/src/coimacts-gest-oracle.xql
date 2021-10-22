<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="upd_acts">
       <querytext>
                update coimacts
                   set stato          = :stato
                     , note           = :note
                     , data_mod       =  sysdate
                     , utente         = :id_utente
                 where cod_acts       = :cod_acts
       </querytext>
    </partialquery>

    <partialquery name="del_acts">
       <querytext>
                delete
                  from coimacts
                 where cod_acts = :cod_acts
       </querytext>
    </partialquery>

    <partialquery name="del_docu">
       <querytext>
                delete
                  from coimdocu
                 where cod_documento = :cod_documento
       </querytext>
    </partialquery>

    <partialquery name="del_aces">
       <querytext>
                delete
                  from coimaces
                 where cod_acts = :cod_acts
       </querytext>
    </partialquery>

    <fullquery name="sel_acts">
       <querytext>
             select cod_acts
                  , cod_distr
                  , iter_edit.data(data_caric)       as data_caric
                  , cod_documento
                  , iter_edit.num(caricati + scartati, 0) as tot
                  , iter_edit.num(caricati, 0)       as caricati
                  , iter_edit.num(scartati, 0)       as scartati
                  , iter_edit.num(invariati, 0)      as invariati
                  , iter_edit.num(da_analizzare, 0)  as da_analizzare
                  , iter_edit.num(importati_aimp, 0) as importati_aimp
                  , iter_edit.num(chiusi_forzat, 0)  as chiusi_forzat
                  , stato
                  , percorso_file
                  , note
               from coimacts
              where cod_acts = :cod_acts
       </querytext>
    </fullquery>

    <fullquery name="sel_acts_check">
       <querytext>
        select '1'
          from coimacts
         where cod_acts = :cod_acts
       </querytext>
    </fullquery>

</queryset>
