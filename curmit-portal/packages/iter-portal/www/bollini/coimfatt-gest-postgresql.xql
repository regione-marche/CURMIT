<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_fatt">
       <querytext>
           insert into coimfatt 
                     ( cod_fatt
                     , data_fatt
                     , num_fatt
                     , cod_sogg
                     , tipo_sogg
                     , imponibile
                     , importo
                     , perc_iva
                     , flag_pag
                     , data_ins
                     , matr_da
                     , matr_a
                     , n_bollini
                     , mod_pag
                     , nota
                     , id_utente
                     , desc_fatt
                     , importo_pag
                     , data_pag
                     , spe_legali
                     , spe_postali
                     , data_scadenza
                     , flag_split_payment --sim04
)
                values 
                     (:cod_fatt
                     ,:data_fatt
                     ,:num_fatt
                     ,:cod_sogg
                     ,:tipo_sogg
                     ,:imponibile
                     ,:importo
                     ,:perc_iva
                     ,:flag_pag
                     , current_date
                     ,:matr_da
                     ,:matr_a
                     ,:n_bollini
                     ,:mod_pag
                     ,:nota
                     ,:id_utente
                     ,:desc_fatt
                     ,:importo_pag
                     ,:data_pag
                     ,:spe_legali
                     ,:spe_postali
                     ,:data_scadenza
                     ,:flag_split_payment --sim04
)
       </querytext>
    </partialquery>

    <fullquery name="sel_cod_fatt">
       <querytext>
            select nextval('coimfatt_s') as cod_fatt
       </querytext>
    </fullquery>

    <partialquery name="upd_fatt">
       <querytext>
                update coimfatt
                   set data_fatt   = :data_fatt
                     , num_fatt    = :num_fatt
                     , cod_sogg    = :cod_sogg
                     , imponibile  = :imponibile
                     , importo     = :importo
                     , perc_iva    = :perc_iva
                     , flag_pag    = :flag_pag
                     , data_mod    = current_date
                     , matr_da     = :matr_da
                     , matr_a      = :matr_a
                     , n_bollini   = :n_bollini
                     , mod_pag     = :mod_pag
                     , nota        = :nota
                     , desc_fatt   = :desc_fatt
                     , importo_pag = :importo_pag
                     , data_pag    = :data_pag
                     , spe_legali  = :spe_legali
                     , spe_postali = :spe_postali
                     , data_scadenza = :data_scadenza
                     , flag_split_payment = :flag_split_payment --sim04
                 where cod_fatt    = :cod_fatt
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
             select iter_edit_data(data_fatt)       as data_fatt
                  , iter_edit_data(data_scadenza)   as data_scadenza
                  , a.num_fatt
                  , a.cod_sogg
                  , a.tipo_sogg
                  , coalesce(b.name, t.name)        as manutentore_manu
                  , c.nome                          as nome_citt
                  , c.cognome                       as cognome_citt
                  , iter_edit_num(a.imponibile, 2)  as imponibile
                  , iter_edit_num(a.importo, 2)     as importo
                  , iter_edit_num(a.perc_iva, 2)    as perc_iva
                  , a.imponibile                    as imponibile_calc
                  , a.importo                       as importo_calc
                  , a.flag_pag
                  , a.matr_da
                  , a.matr_a
                  , a.n_bollini
                  , a.mod_pag
                  , a.nota
                  , a.desc_fatt
                  , iter_edit_num(a.spe_legali,2)   as spe_legali
                  , iter_edit_num(a.spe_postali,2)  as spe_postali
                  , iter_edit_data(a.data_pag)      as data_pag_edit
                  , iter_edit_num(a.importo_pag, 2) as importo_pag_edit
                  , a.flag_split_payment   --sim04
               from coimfatt a
          left join iter_maintainers b on b.iter_code           = a.cod_sogg
          left join iter_maint_2     t on t.maint_2_id::varchar = a.cod_sogg
          left join coimcitt         c on c.cod_cittadino       = a.cod_sogg
              where cod_fatt = :cod_fatt
       </querytext>
    </fullquery>

    <fullquery name="sel_fatt_check">
       <querytext>
        select '1'
          from coimfatt
         where cod_fatt = :cod_fatt
       </querytext>
    </fullquery>

     <fullquery name="sel_num_fatt">
       <querytext>
        select max(to_number(num_fatt, '9999999999')) as num_fatt from coimfatt where id_utente <> '1522'
       </querytext>
    </fullquery>


    <fullquery name="sel_boll">
       <querytext>
             select cod_bollini
                  , iter_edit_num(a.nr_bollini, 0) as nr_bollini
                  , costo_unitario
                  , a.matricola_da
                  , a.matricola_a
                  , a.pagati
                  , a.cod_manutentore
                  , b.name as manutentore
                  , a.data_consegna
               from coimboll         a
          left join iter_maintainers b on b.iter_code           = a.cod_manutentore
          left join iter_maint_2     t on t.maint_2_id::varchar = a.cod_manutentore
              where a.cod_bollini = :cod_bollini
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

    <fullquery name="sel_aimp_est">
       <querytext>
             select cod_impianto_est
               from coimaimp
               where cod_impianto = :cod_impianto
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
              where name   $eq_manutentore
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
