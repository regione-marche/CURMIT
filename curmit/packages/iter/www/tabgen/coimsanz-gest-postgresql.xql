<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_sanz_s">
       <querytext>
                   select nextval ('coimsanz_s') as id_sanzione
       </querytext>
    </fullquery>

    <partialquery name="ins_sanz">
       <querytext>
                insert
                  into coimsanz
                     ( id_sanzione
                     , cod_sanzione
                     , descr_breve
                     , descr_estesa
                     , importo_min
                     , importo_max
                     , tipo_soggetto)
                values 
                     ( :id_sanzione
                     , :cod_sanzione
                     , :descr_breve
                     , :descr_estesa
                     , :importo_min
                     , :importo_max
                     , :tipo_soggetto)
       </querytext>
    </partialquery>

    <partialquery name="upd_sanz">
       <querytext>
                update coimsanz
                   set cod_sanzione = :cod_sanzione
                     , descr_breve = :descr_breve
                     , descr_estesa = :descr_estesa
                     , importo_min = :importo_min
                     , importo_max = :importo_max
                     , tipo_soggetto = :tipo_soggetto
                 where cod_sanzione = :cod_sanzione
       </querytext>
    </partialquery>

    <partialquery name="del_sanz">
       <querytext>
                delete
                  from coimsanz
                 where cod_sanzione = :cod_sanzione
       </querytext>
    </partialquery>

    <fullquery name="sel_sanz">
       <querytext>
         select cod_sanzione
              , descr_breve
              , descr_estesa
              , iter_edit_num(importo_min, 2) as importo_min
              , iter_edit_num(importo_max, 2) as importo_max
              , tipo_soggetto
           from coimsanz
          where cod_sanzione = :cod_sanzione
       </querytext>
    </fullquery>

    <fullquery name="sel_sanz_check">
       <querytext>
        select '1'
          from coimsanz
         where cod_sanzione = :cod_sanzione
       </querytext>
    </fullquery>

    <fullquery name="sel_movi_check">
       <querytext>
        select '1'
          from coimmovi
         where cod_sanzione = :cod_sanzione
       </querytext>
    </fullquery>

</queryset>
