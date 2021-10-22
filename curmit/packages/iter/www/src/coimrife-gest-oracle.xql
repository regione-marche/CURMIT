<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_dimp">
       <querytext>
          select iter_edit.data(a.data_controllo) as data_controllo
               , b.cod_impianto_est
               , c.cognome||' '||nvl(c.nome, '') as responsabile
               , d.cognome||' '||nvl(d.nome, '') as manu_dimp
            from coimdimp a
               , coimaimp b
               , coimcitt c
               , coimmanu d
           where a.riferimento_pag     = :f_riferimento
             and a.cod_impianto        = b.cod_impianto
             and c.cod_cittadino   (+) = b.cod_responsabile
             and d.cod_manutentore (+) = a.cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_boll">
       <querytext>
          select iter_edit.data(a.data_consegna) as data_consegna
               , b.cognome||' '||nvl(b.nome, '') as manu_boll
            from coimboll a
               , coimmanu b
           where :f_riferimento between matricola_da and matricola_a
             and b.cod_manutentore (+) = a.cod_manutentore
       </querytext>
    </fullquery>

</queryset>
