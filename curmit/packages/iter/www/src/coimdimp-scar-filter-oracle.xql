<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_manu_nome">
       <querytext>
           select cognome as f_manu_cogn
                , nome    as f_manu_nome
             from coimmanu
            where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_manu">
       <querytext>
           select cod_manutentore as cod_manu_db
             from coimmanu
            where upper(cognome) $eq_cognome
              and upper(nome)    $eq_nome
       </querytext>
    </fullquery>

</queryset>
