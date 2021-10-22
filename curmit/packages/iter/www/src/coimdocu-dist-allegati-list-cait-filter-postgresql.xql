<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

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
    
    <fullquery name="sel_ammi_nome">
       <querytext>
            select cognome as cognome_ammi,
                   nome as nome_ammi
              from coimcitt
             where cod_cittadino = :cod_legale_rapp
       </querytext>
    </fullquery>
    
    <partialquery name="sel_ammi">
       <querytext>
            select cod_cittadino as cod_ammi_db
              from coimcitt
             where upper(cognome) $eq_cognome
               and upper(nome)    $eq_nome
               and cod_cittadino like 'AM%'
       </querytext>
    </partialquery>

</queryset>
