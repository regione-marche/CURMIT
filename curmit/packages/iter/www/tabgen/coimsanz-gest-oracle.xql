<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="ins_tari">
       <querytext>
                insert
                  into coimtari 
                     ( tipo_costo
                     , cod_potenza
                     , data_inizio
                     , importo)
                values 
                     (:tipo_costo
                     ,:cod_potenza
                     ,:data_inizio
                     ,:importo)
       </querytext>
    </partialquery>

    <partialquery name="upd_tari">
       <querytext>
                update coimtari
                   set importo      = :importo
                 where tipo_costo = :tipo_costo
                   and cod_potenza = :cod_potenza
                   and data_inizio = :data_inizio
       </querytext>
    </partialquery>

    <partialquery name="del_tari">
       <querytext>
                delete
                  from coimtari
                 where tipo_costo = :tipo_costo
                   and cod_potenza = :cod_potenza
                   and data_inizio = :data_inizio
       </querytext>
    </partialquery>

    <fullquery name="sel_tari">
       <querytext>
             select a.tipo_costo
                  , a.cod_potenza
                  , iter_edit.data(a.data_inizio) as data_inizio
                  , iter_edit.num(a.importo, 2) as importo
		  , decode (a.tipo_costo
                     , '1' , 'Autocertificazione'
                     , '2' , 'Verifica'
                     , '3' , 'Verifica generatore aggiuntivo'
                     , '4' , 'Sanzioni per inadempienze tecniche'
                     , '5' , 'Mancata verifica'
                    ) as tipo_costo_dett
                  , b.descr_potenza as cod_potenza_dett
               from coimtari a
                  , coimpote b
              where a.tipo_costo =  :tipo_costo
                and a.cod_potenza = :cod_potenza
                and a.data_inizio = :data_inizio
                and b.cod_potenza = a.cod_potenza
       </querytext>
    </fullquery>

    <fullquery name="sel_tari_check">
       <querytext>
        select '1'
          from coimtari
         where tipo_costo = :tipo_costo
           and cod_potenza = :cod_potenza
           and data_inizio = :data_inizio
       </querytext>
    </fullquery>

</queryset>
