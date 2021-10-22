<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_viae">
       <querytext>
             select cod_via
               from coimviae
              where cod_comune  = :f_comune
                and descr_topo  = upper(:f_desc_topo)
                and descrizione = upper(:f_desc_via)
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_cod_est">
       <querytext>
             select cod_impianto_est as cod_impianto_est_old
               from coimaimp
              where cod_impianto  = :cod_impianto_old
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
