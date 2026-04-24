<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="ins_fatt">
       <querytext>
                insert
                  into coimfatt 
                     ( cod_fatt
                     , data_fatt
                     , num_fatt
                     , cod_sogg
                     , tipo_sogg
                     , imponibile
                     , perc_iva
                     , flag_pag
                     , data_ins
                     , matr_da
                     , matr_a
                     , n_bollini
                     , mod_pag
                     , nota
                     , id_utente
                     , data_scadenza)
                values 
                     (:cod_fatt
                     ,:data_fatt
                     ,:num_fatt
                     ,:cod_sogg
                     ,:tipo_sogg
                     ,:imponibile
                     ,:perc_iva
                     ,:flag_pag
                     , sysdate
                     ,:matr_da
                     ,:matr_a
                     ,:n_bollini
                     ,:mod_pag
                     ,:nota
                     ,:id_utente
                     ,:data_scadenza)
       </querytext>
    </partialquery>

    <fullquery name="sel_cod_fatt">
       <querytext>
            select coimfatt_s.nextval as cod_fatt
              from dual
       </querytext>
    </fullquery>

    <partialquery name="upd_fatt">
       <querytext>
                update coimfatt
                   set data_fatt  = :data_fatt
                     , num_fatt   = :num_fatt
                     , cod_sogg   = :cod_sogg
                     , imponibile = :imponibile
                     , perc_iva   = :perc_iva
                     , flag_pag   = :flag_pag
                     , data_mod   = sysdate
                     , matr_da    = :matr_da
                     , matr_a     = :matr_a
                     , n_bollini  = :n_bollini
                     , mod_pag    = :mod_pag
                     , nota       = :nota
                     , data_scadenza = :data_scadenza
                 where cod_fatt = :cod_fatt
       </querytext>
    </partialquery>

    <partialquery name="del_fatt">
       <querytext>
                delete
                  from coimfatt
                 where cod_fatt = :cod_fatt
       </querytext>
    </partialquery>

    <fullquery name="sel_fatt">
       <querytext>
             select iter_edit.data(a.data_fatt)     as data_fatt
                  , iter_edit_data(data_scadenza)   as data_scadenza
                  , a.num_fatt
                  , a.cod_sogg
                  , a.tipo_sogg
                  , b.name as manutentore
                  , c.nome as nome_citt
                  , c.cognome as cognome_citt
                  , iter_edit.num(a.imponibile, 2)  as imponibile
                  , iter_edit.num(a.perc_iva, 2)    as perc_iva
                  , a.imponibile                    as imponibile_calc
                  , iter_edit_num(a.importo, 2)     as importo
                  , a.flag_pag
                  , a.matr_da
                  , a.matr_a
                  , a.n_bollini
                  , a.mod_pag
                  , a.nota
               from coimfatt a
                  , iter_maintainers b
                  , coimcitt c
              where cod_fatt = :cod_fatt
                 and b.iter_code (+) = a.cod_sogg
                 and c.cod_cittadino (+) = a.cod_sogg
       </querytext>
    </fullquery>

    <fullquery name="sel_fatt_check">
       <querytext>
        select '1'
          from coimfatt
         where cod_fatt = :cod_fatt
       </querytext>
    </fullquery>

    <fullquery name="sel_boll">
       <querytext>
             select cod_bollini
                  , iter_edit.num(a.nr_bollini, 0) as nr_bollini
                  , costo_unitario
                  , a.matricola_da
                  , a.matricola_a
                  , a.pagati
                  , a.cod_manutentore
                  , b.name as manutentore
               from coimboll a
		  , iter_maintainers b
              where a.cod_bollini   = :cod_bollini
                and b.iter_code (+) = a.cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp">
       <querytext>
             select nome as nome_citt
                  , cognome as cognome_citt
               from coimcitt
               where cod_cittadino = :cod_responsabile
       </querytext>
    </fullquery>

   <fullquery name="sel_num_check">
       <querytext>
        select '1'
          from coimfatt
         where to_char(data_fatt, 'yyyy') =  to_char(to_date(:data_fatt,'yyyymmdd'), 'yyyy')
           and num_fatt = :num_fatt
         $where_mod
       </querytext>
    </fullquery>

    <fullquery name="sel_sogg_manu">
       <querytext>
             select iter_code as cod_sogg_db
               from iter_maintainers
              where name  $eq_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_sogg_citt">
       <querytext>
             select cod_cittadino as cod_sogg_db
               from coimcitt
              where cognome   $eq_manutentore
       </querytext>
    </fullquery>


</queryset>
