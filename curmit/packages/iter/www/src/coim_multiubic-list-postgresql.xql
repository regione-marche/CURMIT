<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_multiubic_si_vie">
       <querytext>
           select cod_ubicazione
                , b.denominazione as comune
                , c.descr_topo||' '||c.descrizione as indirizzo
                , a.numero as civico
                , a.localita
             from coim_multiubic a
  left outer join coimcomu b on b.cod_comune = a.cod_comune
  left outer join coimviae c on c.cod_via    = a.cod_via
            where a.cod_impianto = :cod_impianto
           $where_last
         order by indirizzo
       </querytext>
    </partialquery>

    <partialquery name="sel_multiubic_no_vie">
       <querytext>
           select cod_ubicazione
                , b.denominazione as comune
                , a.toponimo||' '||a.indirizzo as indirizzo
                , a.numero as civico
                , a.localita
             from coim_multiubic a
  left outer join coimcomu b on b.cod_comune = a.cod_comune
            where a.cod_impianto = :cod_impianto
           $where_last
         order by indirizzo
       </querytext>
    </partialquery>

</queryset>
