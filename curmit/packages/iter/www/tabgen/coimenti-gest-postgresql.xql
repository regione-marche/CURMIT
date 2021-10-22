<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_enti">
       <querytext>
                insert
                  into coimenti 
                     ( cod_enre
                     , cod_ente
                     , denominazione
                     , indirizzo
                     , numero
                     , cap
                     , localita
                     , comune
                     , provincia
                     , cod_area)
                values 
                     (:cod_enre
                     ,:cod_ente
                     ,:denominazione
                     ,:indirizzo
                     ,:numero
                     ,:cap
                     ,:localita
                     ,:comune
                     ,:provincia
                     ,:cod_area)
       </querytext>
    </partialquery>

    <partialquery name="upd_enti">
       <querytext>
                update coimenti
                   set denominazione = :denominazione
                     , indirizzo = :indirizzo
                     , numero = :numero
                     , cap = :cap
                     , localita = :localita
                     , comune = :comune
                     , provincia = :provincia
                     , cod_area = :cod_area
                 where cod_enre = :cod_enre
                   and cod_ente = :cod_ente
       </querytext>
    </partialquery>

    <partialquery name="del_enti">
       <querytext>
                delete
                  from coimenti
                 where cod_enre = :cod_enre
                   and cod_ente = :cod_ente
       </querytext>
    </partialquery>

    <fullquery name="sel_enti">
       <querytext>
             select cod_enre
                  , cod_ente
                  , denominazione
                  , indirizzo
                  , numero
                  , cap
                  , localita
                  , comune
                  , provincia
                  , cod_area
               from coimenti
              where cod_enre = :cod_enre
                and cod_ente = :cod_ente
       </querytext>
    </fullquery>

    <fullquery name="sel_enti_denom_check">
       <querytext>
        select '1'
          from coimenti
         where denominazione = :denominazione
       </querytext>
    </fullquery>

    <fullquery name="sel_enti_max_cod_ente">
       <querytext>
           select max(to_number(cod_ente, '99999999'))
             from coimenti
	    where cod_enre = :cod_enre
       </querytext>
    </fullquery>
    <fullquery name="sel_enti_denominenre">
       <querytext>
	   select denominazione as enre_denominazione
	   from coimenre
	   where cod_enre = :cod_enre
       </querytext>
    </fullquery>
</queryset>
