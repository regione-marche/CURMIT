<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_date">
       <querytext>
                   select to_char(sysdate, 'yyyymmdd') as data_corrente
                     from dual
       </querytext>
    </fullquery>

    <partialquery name="ins_movi">
       <querytext>
                insert
                  into coimmovi 
                     ( cod_movi
                     , tipo_movi
                     , cod_impianto
                     , data_scad
                     , data_compet
                     , importo
                     , importo_pag
                     , data_pag
                     , tipo_pag
                     , nota
                     , data_ins
                     , data_mod
                     , utente)
                values 
                     (:cod_movi
                     ,:tipo_movi
                     ,:cod_impianto
                     ,:data_scad
                     ,:data_compet
                     ,:importo
                     ,:importo_pag
                     ,:data_pag
                     ,:tipo_pag
                     ,:nota
                     ,:data_corrente
                     ,:data_corrente
                     ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_movi">
       <querytext>
                update coimmovi
                   set tipo_movi    = :tipo_movi
                     , data_scad    = :data_scad
                     , data_compet  = :data_compet
                     , importo      = :importo
                     , importo_pag  = :importo_pag
                     , data_pag     = :data_pag
                     , tipo_pag     = :tipo_pag
                     , nota         = :nota
                     , data_mod     = :data_corrente
                     , utente       = :id_utente
                 where cod_movi     = :cod_movi
       </querytext>
    </partialquery>

    <partialquery name="del_movi">
       <querytext>
                delete
                  from coimmovi
                 where cod_movi = :cod_movi
       </querytext>
    </partialquery>

    <fullquery name="sel_movi">
       <querytext>
             select cod_movi
                  , tipo_movi
                  , cod_impianto
                  , iter_edit.data(data_scad) as data_scad
                  , iter_edit.num(importo, 2) as importo
                  , iter_edit.num(importo_pag, 2) as importo_pag
                  , iter_edit.data(data_pag) as data_pag
                  , iter_edit.data(data_compet) as data_compet
                  , tipo_pag
                  , nota
               from coimmovi
              where cod_movi = :cod_movi
       </querytext>
    </fullquery>

    <fullquery name="sel_movi_check">
       <querytext>
        select '1'
          from coimmovi
         where cod_movi = :cod_movi
       </querytext>
    </fullquery>

    <fullquery name="sel_movi_next">
        <querytext>
           select coimmovi_s.nextval as cod_movi
             from dual
       </querytext>
    </fullquery>

    <fullquery name="sel_current_date">
        <querytext>
           select to_char(sysdate, 'dd/mm/yyyy') as current_date
             from dual
       </querytext>
    </fullquery>

</queryset>
