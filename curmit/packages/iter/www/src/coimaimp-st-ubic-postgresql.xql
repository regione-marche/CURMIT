<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>


    <fullquery name="sel_aimp">
       <querytext>
          select a.localita
               , a.numero
               , a.cod_via
               , a.scala
               , a.esponente
               , a.piano
               , a.interno
               , a.cod_comune
               , a.cod_qua
               , a.cod_urb
               , a.cod_provincia
               , a.cap
--               , a.cod_catasto
               , a.toponimo 
               , a.indirizzo 
	       , a.palazzo
               , iter_edit_data(a.data_installaz)  as data_variaz
               , coalesce(a.cod_tpdu, '') as cod_tpdu
               , iter_edit_num(to_number(a.gb_x,'99.999999999999999999'),10) as gb_x
               , iter_edit_num(to_number(a.gb_y,'99.999999999999999999'),10) as gb_y
	       $indirizzo
               from coimaimp_st a
               $coimviae $where_viae 
              where a.cod_impianto = :cod_impianto
                and a.st_progressivo = :st_progressivo
       </querytext>
    </fullquery>

    <partialquery name="sel_aimp_coimviae1">
       <querytext>
	    left outer join coimviae b on b.cod_via    = a.cod_via	 
	                              and b.cod_comune = a.cod_comune
       </querytext>
    </partialquery>

    <partialquery name="sel_aimp_coimviae2">
       <querytext>
            
       </querytext>
    </partialquery>

    <partialquery name="sel_aimp_coimviae3">
       <querytext>
            , coalesce(b.descrizione, '') as descr_via
            , coalesce(b.descr_topo, '') as descr_topo
       </querytext>
    </partialquery>

    <fullquery name="sel_aimp_db">
       <querytext>
          select localita                 as db_localita
               , numero                   as db_numero
               , cod_via                  as db_cod_via
               , scala                    as db_scala
               , esponente                as db_esponente
               , piano                    as db_piano
               , interno                  as db_interno
               , cod_comune               as db_cod_comune
               , cod_qua                  as db_cod_qua
               , cod_urb                  as db_cod_urb
               , cod_provincia            as db_cod_provincia
               , cap                      as db_cap
               , coalesce(cod_tpdu, '')   as db_cod_tpdu
               , toponimo                 as db_descr_topo
               , indirizzo                as db_descr_via
	       , palazzo                  as db_palazzo
               from coimaimp_st 
              where cod_impianto = :cod_impianto
                and a.st_progressivo = :st_progressivo
       </querytext>
    </fullquery>

    <fullquery name="sel_stub_check">
       <querytext>
        select '1'
          from coimstub
         where cod_impianto    = :cod_impianto
           and data_fin_valid  = :data_fin_valid
       </querytext>
    </fullquery>

    <fullquery name="recup_date">
       <querytext>
        select iter_edit_data (current_date)     as data_ini_valid
              ,               (current_date - 1) as data_fin_valid
       </querytext>
    </fullquery>

    <fullquery name="sel_viae">
       <querytext>
             select cod_via 
               from coimviae
              where cod_comune  = :cod_comune
                and descrizione = upper(:descr_via)
                and descr_topo  = upper(:descr_topo)
       </querytext>
    </fullquery>

    <fullquery name="recup_comune_qua">
       <querytext>
             select cod_qua
                  , cod_comune
               from coimcqua
              where 1 = 1
                and cod_qua     = :cod_qua
                and cod_comune  = :cod_comune
       </querytext>
    </fullquery>

    <fullquery name="recup_comune_urb">
       <querytext>
             select cod_urb 
                  , cod_comune
               from coimcurb
              where 1 = 1
                and cod_urb     = :cod_urb
                and cod_comune  = :cod_comune
       </querytext>
    </fullquery>

    <fullquery name="sel_max_data">
       <querytext>
             select to_char(max(data_fin_valid), 'YYYYMMDD')  as data_max_valid
               from coimstub
              where 1 = 1
                and cod_impianto  = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sottrai_data">
       <querytext>
        select to_date(:data_ini_valid, 'YYYYMMDD') - 1 as data_fin_valid
       </querytext>
    </fullquery>

    <fullquery name="aggiungi_data">
       <querytext>
        select iter_edit_data(to_date(:data_max_valid, 'yyyymmdd') + 1) as data_max_valid
       </querytext>
    </fullquery>

    <fullquery name="ultima_mod">
       <querytext>
        select iter_edit_data(max(data_fin_valid) + 1) as data_variaz 
          from coimstub 
         where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

</queryset>
