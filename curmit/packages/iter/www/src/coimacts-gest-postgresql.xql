<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="upd_acts">
       <querytext>
                update coimacts
                   set stato          = :stato
                     , note           = :note
                     , data_mod       =  current_date
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
                  , iter_edit_data(data_caric)       as data_caric
                  , cod_documento
                  , iter_edit_num(caricati + scartati, 0) as tot
                  , iter_edit_num(caricati, 0)       as caricati
                  , iter_edit_num(scartati, 0)       as scartati
                  , iter_edit_num(invariati, 0)      as invariati
                  , iter_edit_num(da_analizzare, 0)  as da_analizzare
                  , iter_edit_num(importati_aimp, 0) as importati_aimp
                  , iter_edit_num(chiusi_forzat, 0)  as chiusi_forzat
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
