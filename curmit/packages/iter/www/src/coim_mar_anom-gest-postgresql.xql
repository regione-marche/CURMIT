<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_anom">
       <querytext>
             select cod_d_tano
                  , iter_edit_data(data_controllo) as data_controllo
                  , descr_breve
                  , iter_edit_data(data_invio_lettera) as data_invio_lettera
               from coim_d_anom
              where cod_d_tano = :cod_d_tano
                and cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

</queryset>
