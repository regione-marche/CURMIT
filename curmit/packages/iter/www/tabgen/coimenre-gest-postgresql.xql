<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_enre">
       <querytext>
                insert
                  into coimenre 
                     ( cod_enre
                     , denominazione
                     , indirizzo
                     , numero
                     , cap
                     , localita
                     , comune
                     , provincia
                     , denominazione2
                     , tipo_soggetto)
                values 
                     (:cod_enre
                     ,:denominazione
                     ,:indirizzo
                     ,:numero
                     ,:cap
                     ,:localita
                     ,:comune
                     ,:provincia
                     ,:denominazione2
                     ,:tipo_soggetto)
       </querytext>
    </partialquery>

    <partialquery name="upd_enre">
       <querytext>
                update coimenre
                   set denominazione  = :denominazione
                     , indirizzo      = :indirizzo
                     , numero         = :numero
                     , cap            = :cap
                     , localita       = :localita
                     , comune         = :comune
                     , provincia      = :provincia
                     , denominazione2 = :denominazione2
                 where cod_enre       = :cod_enre
       </querytext>
    </partialquery>

    <partialquery name="del_enre">
       <querytext>
                delete
                  from coimenre
                 where cod_enre = :cod_enre
       </querytext>
    </partialquery>

    <fullquery name="sel_enre">
       <querytext>
             select cod_enre
                  , denominazione
                  , indirizzo
                  , numero
                  , cap
                  , localita
                  , comune
                  , provincia
                  , denominazione2
               from coimenre
              where cod_enre = :cod_enre
       </querytext>
    </fullquery>

    <fullquery name="sel_enre_check">
       <querytext>
        select '1'
          from coimenre
         where cod_enre = :cod_enre
       </querytext>
    </fullquery>

    <fullquery name="sel_enre_count">
       <querytext>
        select count(*) as count_enre
          from coimenre
         where denominazione = :denominazione
        $where_cod
       </querytext>
    </fullquery>

    <fullquery name="sel_enti_count">
        <querytext>
             select count(*) as conta_enti
               from coimenti
              where cod_enre           = :cod_enre
       </querytext>
    </fullquery>

    <fullquery name="check_cod">
        <querytext>
             select 1
               from coimtpsg
              where tipo_soggetto = :key
       </querytext>
    </fullquery>

    <partialquery name="ins_tpsg">
       <querytext>
                insert
                  into coimtpsg 
                     ( tipo_soggetto
                     , descrizione)
                values 
                     (:tipo_soggetto
                     ,:denominazione)
       </querytext>
    </partialquery>

    <fullquery name="sel_tpsg">
       <querytext>
                select tipo_soggetto
                  from coimenre
                 where cod_enre = :cod_enre
       </querytext>
    </fullquery>


    <partialquery name="del_tpsg">
       <querytext>
                delete from coimtpsg
		 where tipo_soggetto = :tipo_soggetto

       </querytext>
    </partialquery>


</queryset>
