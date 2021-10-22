<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="get_nome_manu">
       <querytext>
       select cognome as f_manu_cogn
            , nome    as f_manu_nome
         from coimmanu
        where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_viae">
       <querytext>
             select cod_via
               from coimviae
              where cod_comune  = :f_comune
                and descr_topo  = upper(:f_desc_topo)
                and descrizione = upper(:f_desc_via)
       </querytext>
    </fullquery>

    <fullquery name="sel_manu">
       <querytext>
             select cod_manutentore as cod_manu_db
               from coimmanu
              where upper(cognome)   $eq_cognome
                and upper(nome)      $eq_nome
       </querytext>
    </fullquery>

</queryset>
