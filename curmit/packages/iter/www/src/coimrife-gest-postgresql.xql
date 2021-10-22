<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_dimp">
       <querytext>
          select iter_edit_data(a.data_controllo) as data_controllo
               , b.cod_impianto_est
               , c.cognome||' '||coalesce(c.nome, '') as responsabile
               , d.cognome||' '||coalesce(d.nome, '') as manu_dimp
            from coimdimp a
 left outer join coimmanu d on d.cod_manutentore = a.cod_manutentore
               , coimaimp b
 left outer join coimcitt c on c.cod_cittadino = b.cod_responsabile
           where a.riferimento_pag = :f_riferimento
             and a.cod_impianto = b.cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_boll">
       <querytext>
          select a.data_consegna
               , b.cognome||' '||coalesce(b.nome, '') as manu_boll
            from coimboll a
 left outer join coimmanu b on b.cod_manutentore = a.cod_manutentore          
           where :f_riferimento between a.matricola_da and a.matricola_a
       </querytext>
    </fullquery>

</queryset>
