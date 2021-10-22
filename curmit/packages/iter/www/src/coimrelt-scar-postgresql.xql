<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_relg">
       <querytext>
           select to_char(data_rel,'dd-Mon-yyyy')       as data_rel
                , ente_istat
                , nome_file_tec
             from coimrelg
            where cod_relg = :cod_relg
       </querytext>
    </fullquery>

    <fullquery name="sel_relt">
       <querytext>
           select sezione
                , id_clsnc
                , id_stclsnc
                , obj_refer
                , id_pot
                , id_per
                , id_comb
                , n
             from coimrelt
            where cod_relg = :cod_relg
         order by sezione   desc
                , obj_refer desc
                , id_clsnc
                , id_stclsnc
                , id_pot
                , id_per
                , id_comb
       </querytext>
    </fullquery>

</queryset>
