<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

   <partialquery name="sel_inco_si_vie">
       <querytext>
    select * 
      from (
        select /* FIRST_ROWS */ 
               a.cod_inco
             , c.cod_impianto
             , d.denominazione
             , e.descrizione as via 
             , c.numero
          from coiminco a
             , coimaimp c
             , coimcomu d
             , coimviae e
         where a.cod_cinc           = :cod_cinc
           and a.stato              = '0' 
           and c.cod_impianto       = a.cod_impianto
           and d.cod_comune      (+)= c.cod_comune
           and e on e.cod_comune (+)= c.cod_comune	
           and e.cod_via         (+)= c.cod_via
	 $where_comb
         $where_anno_inst_da    	   
         $where_anno_inst_a
 	 $where_data
  	 $where_codice
	 $where_esito
	 $where_comune
	 $where_via
	 $where_tipo_estr
         $where_area
         $order_by
         ) 
	 $limit_ora
       </querytext>
    </partialquery>

   <partialquery name="sel_inco_no_vie">
       <querytext>
    select * 
      from (
        select /* FIRST_ROWS */ 
               a.cod_inco
             , c.cod_impianto
             , d.denominazione
             , c.indirizzo as via
             , c.numero
          from coiminco a
             , coimaimp c
             , coimcomu d
         where a.cod_cinc         = :cod_cinc
           and a.stato            = '0' 
           and c.cod_impianto     = a.cod_impianto
           and d.cod_comune    (+)= c.cod_comune
	 $where_comb
         $where_anno_inst_da    	   
         $where_anno_inst_a
 	 $where_data
  	 $where_codice
	 $where_esito
	 $where_comune
	 $where_via
	 $where_tipo_estr
         $where_area
         $order_by
         ) 
	 $limit_ora
       </querytext>
    </partialquery>

    <partialquery name="upd_inco">
       <querytext>
                 update coiminco
                    set stato         = '2'
                      , cod_opve      = :f_cod_tecn
                      , data_verifica = :data_verifica
                      , ora_verifica  = :ora_verifica
                  where cod_inco      = :cod_inco
       </querytext>
    </partialquery>


   <fullquery name="sel_tecn">
       <querytext>
             select nome    as nome_verif
                  , cognome as cogn_verif
               from coimopve
              where cod_enve       = :f_cod_enve
                and cod_opve       = :f_cod_tecn
       </querytext>
    </fullquery>

    <fullquery name="sel_enve">
       <querytext>
             select ragione_01
               from coimenve
              where cod_enve       = :f_cod_enve
       </querytext>
    </fullquery>

    <fullquery name="sel_cinc">
       <querytext>
                   select cod_cinc
                        , descrizione as desc_camp
                     from coimcinc
                    where stato = '1'
       </querytext>
    </fullquery>

    <fullquery name="sel_cmar">
       <querytext>
           select cod_comune
             from coimcmar
            where cod_area = :f_cod_area
       </querytext>
    </fullquery>

    <fullquery name="sel_area_tipo_01">
       <querytext>
               select tipo_01
                 from coimarea 
                where cod_area = :f_cod_area
       </querytext>
    </fullquery>

   <fullquery name="sel_inco_disp">
       <querytext>
        select * 
          from (
             select /* FIRST_ROWS */ 
                    cod_inco as cod_inco_disp
                  , data_verifica
                  , ora_verifica
               from coiminco
              where cod_cinc       = :cod_cinc
                and cod_opve       = :f_cod_tecn
                and cod_impianto   is null
		and data_verifica  > :f_da_data_disp
              order by data_verifica
              ) 
	    where rownum <= 1
       </querytext>
    </fullquery>

    <partialquery name="del_disp">
       <querytext>
                delete
                  from coiminco
                 where cod_inco = :cod_inco_disp
       </querytext>
    </partialquery>

</queryset>
