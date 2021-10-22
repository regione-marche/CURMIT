<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_cogn_nome_manu">
       <querytext>
          cognome||' '||nvl(nome,'')
       </querytext>
    </partialquery>

    <fullquery name="sel_manu_convenzionati">
       <querytext>
          select substr(coalesce(cognome,'')||' '||coalesce(nome,''),1,50) as nominativo_manu
               , cod_manutentore as cod_manu
            from coimmanu
           where flag_convenzionato = 'S'
           order by cognome, nome
       </querytext>
    </fullquery>


</queryset>
