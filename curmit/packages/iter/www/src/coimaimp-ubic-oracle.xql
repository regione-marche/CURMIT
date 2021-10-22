<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="upd_aimp">
       <querytext>
                update coimaimp
                   set localita        = :localita   
                     , cod_via         = :cod_via
                     , numero          = :numero
                     , esponente       = :esponente
                     , scala           = :scala
                     , piano           = :piano
                     , interno         = :interno
                     , cod_comune      = :cod_comune
                     , cod_qua         = :cod_qua
                     , cod_urb         = :cod_urb
                     , toponimo        = :descr_topo
                     , indirizzo       = :descr_via
                     , cod_provincia   = :cod_provincia
                     , cap             = :cap       
                     , cod_tpdu        = :cod_tpdu
                     , gb_x            = :gb_x
                     , gb_y            = :gb_y
                     , data_mod        = sysdate
                     , utente          = :id_utente                 
                     , foglio          = :foglio
                     , mappale         = :mappale
                     , subalterno      = :subalterno
                     , denominatore    = :denominatore
                     , cat_catastale   = :cat_catastale
		     , cod_cted          = :cod_cted --rom01
                 where cod_impianto = :cod_impianto
       </querytext>
    </partialquery>


    <partialquery name="del_aimp">
       <querytext>
                 update coimaimp
                   set localita        = null
                     , cod_via         = null
                     , numero          = null
                     , esponente       = null
                     , scala           = null
                     , piano           = null
                     , interno         = null
                     , cod_comune      = null
                     , cod_qua         = null
                     , cod_urb         = null
                     , cap             = null
                     , cod_tpdu        = null
                     , toponimo        = null
                     , indirizzo       = null
                     , gb_x            = null
                     , gb_y            = null
                     , foglio          = null
                     , mappale         = null
                     , subalterno      = null
                     , denominatore    = null
                     , cat_catastale   = null
                     , data_mod        = sysdate
                     , utente          = :id_utente                 
                 where cod_impianto = :cod_impianto
       </querytext>
    </partialquery>

    <partialquery name="ins_stub">
       <querytext>
                insert
                  into coimstub 
                     ( cod_impianto
                     , data_fin_valid
                     , localita
                     , cod_via
                     , toponimo
                     , indirizzo
                     , numero
                     , esponente
                     , scala
                     , piano 
                     , interno
                     , cod_comune
                     , cod_qua
                     , cod_urb
                     , cod_provincia
                     , cap
                     , cod_tpdu
                     , data_ins           
                     , utente)             
                values
                     (:cod_impianto
                     ,:data_fin_valid
                     ,:db_localita
                     ,:db_cod_via
                     ,:db_descr_topo
                     ,:db_descr_via
                     ,:db_numero
                     ,:db_esponente
                     ,:db_scala
                     ,:db_piano 
                     ,:db_interno
                     ,:db_cod_comune
                     ,:db_cod_qua
                     ,:db_cod_urb
                     ,:db_cod_provincia
                     ,:db_cap
                     ,:db_cod_tpdu
                     , sysdate  
                     ,:id_utente)   
       </querytext>
    </partialquery>

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
               , a.foglio
               , a.mappale
               , a.subalterno
               , a.denominatore
               , a.cat_catastale
               , a.toponimo 
               , a.indirizzo
               , iter_edit.data(a.data_installaz)  as data_variaz 
               , nvl(a.cod_tpdu, '') as cod_tpdu
               , iter_edit.num(to_number(a.gb_x,'99.999999999999999999'),10) as gb_x
               , iter_edit.num(to_number(a.gb_y,'99.999999999999999999'),10) as gb_y
	       , a.cod_cted --rom01
	       $indirizzo
               from coimaimp a
               $coimviae 
              where a.cod_impianto = :cod_impianto
	      $where_viae   
       </querytext>
    </fullquery>

    <partialquery name="sel_aimp_coimviae1">
       <querytext>
	    , coimviae b
       </querytext>
    </partialquery>

    <partialquery name="sel_aimp_coimviae2">
       <querytext>
            and b.cod_via    (+) = a.cod_via	
	    and b.cod_comune (+) = a.cod_comune 
       </querytext>
    </partialquery>

    <partialquery name="sel_aimp_coimviae3">
       <querytext>
         , nvl(b.descrizione, '') as descr_via
         , nvl(b.descr_topo, '') as descr_topo
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
               , nvl(cod_tpdu, '')   as db_cod_tpdu
               , toponimo                 as db_descr_topo
               , indirizzo                as db_descr_via
               from coimaimp 
              where cod_impianto = :cod_impianto
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
        select iter_edit.data (sysdate)     as data_ini_valid
              ,               (sysdate - 1) as data_fin_valid
          from dual
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
          from dual
       </querytext>
    </fullquery>

    <fullquery name="aggiungi_data">
       <querytext>
        select iter_edit.data(to_date(:data_max_valid, 'yyyymmdd') + 1) as data_max_valid
          from dual
       </querytext>
    </fullquery>

    <fullquery name="ultima_mod">
       <querytext>
        select iter_edit.data(max(data_fin_valid) + 1) as data_variaz 
          from coimstub 
         where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>


</queryset>
