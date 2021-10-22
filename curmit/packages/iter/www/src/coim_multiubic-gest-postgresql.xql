<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_cod_ubic">
       <querytext>
		select nextval('coim_multiubic_s') as cod_ubicazione
       </querytext>
    </fullquery>


    <partialquery name="ins_ubic">
       <querytext>
                insert into coim_multiubic
                       values
                     ( :cod_ubicazione
                     , :cod_impianto
                     , :cod_via
                     , :cod_comune
                     , :descr_topo
                     , :descr_via
                     , :numero
                     , :esponente
                     , :scala
                     , :piano
                     , :interno
                     , :localita
                     , :cap
                     , :id_utente
                     , current_date )
       </querytext>
    </partialquery>


    <partialquery name="upd_ubic">
       <querytext>
                update coim_multiubic
                   set localita        = :localita   
                     , cod_via         = :cod_via
                     , numero          = :numero
                     , esponente       = :esponente
                     , scala           = :scala
                     , piano           = :piano
                     , interno         = :interno
                     , cod_comune      = :cod_comune
                     , toponimo        = :descr_topo
                     , indirizzo       = :descr_via
                     , cap             = :cap       
                     , data_mod        = current_date
                     , utente          = :id_utente                 
                 where cod_ubicazione = :cod_ubicazione
       </querytext>
    </partialquery>


    <partialquery name="del_ubic">
       <querytext>
             delete from coim_multiubic
                 where cod_ubicazione = :cod_ubicazione
       </querytext>
    </partialquery>

    <fullquery name="sel_viae">
       <querytext>
             select cod_via 
               from coimviae
              where cod_comune  = :cod_comune
                and descrizione = upper(:descr_via)
                and descr_topo  = upper(:descr_topo)
                and cod_via_new is null
       </querytext>
    </fullquery>

    <partialquery name="sel_ubic_si_vie">
       <querytext>
           select cod_impianto
                , b.denominazione as comune
                , c.descrizione as descr_via
                , c.descr_topo
                , a.numero
                , a.esponente
                , a.scala
                , a.piano
                , a.interno
                , a.localita
                , a.cod_comune
                , a.cap
                , a.cod_via
             from coim_multiubic a
  left outer join coimcomu b on b.cod_comune = a.cod_comune
  left outer join coimviae c on c.cod_via    = a.cod_via
                             and c.cod_comune = a.cod_comune
            where a.cod_ubicazione = :cod_ubicazione
         order by indirizzo
       </querytext>
    </partialquery>

    <partialquery name="sel_ubic_no_vie">
       <querytext>
           select cod_impianto
                , b.denominazione as comune
                , a.toponimo as descrc_topo
                , a.indirizzo as descr_via
                , a.numero
                , a.esponente
                , a.scala
                , a.piano
                , a.interno
                , a.localita
                , a.cod_comune
                , a.cap
                , a.cod_via
             from coim_multiubic a
  left outer join coimcomu b on b.cod_comune = a.cod_comune
            where a.cod_ubicazione = :cod_ubicazione
         order by indirizzo
       </querytext>
    </partialquery>

</queryset>
