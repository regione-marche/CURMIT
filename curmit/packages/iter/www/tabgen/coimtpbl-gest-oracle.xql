<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="del_tpbl">
       <querytext>
                   delete
                     from coimtpbl
                    where cod_tipo_bol = :cod_tipo_bol
       </querytext>
    </partialquery>

    <partialquery name="upd_tpbl">
       <querytext>
                   update coimtpbl
                      set cod_potenza     = :cod_potenza
                        , descrizione     = :descrizione
                        , data_fine_valid = :data_fine_valid
                    where cod_tipo_bol    = :cod_tipo_bol
       </querytext>
    </partialquery>

    <partialquery name="ins_tpbl">
       <querytext>
                   insert
                     into coimtpbl
                        ( descrizione
                        , cod_potenza
                        , data_fine_valid)
                   values 
                        (:descrizione
                        ,:cod_potenza
                        ,:data_fine_valid)
       </querytext>
    </partialquery>

    <fullquery name="sel_tpbl">
       <querytext>
                    select cod_tipo_bol
                         , descrizione
                         , cod_potenza
                         , iter_edit_data(data_fine_valid) as data_fine_valid
                      from coimtpbl
                     where cod_tipo_bol = :cod_tipo_bol
       </querytext>
    </fullquery>

</queryset>
