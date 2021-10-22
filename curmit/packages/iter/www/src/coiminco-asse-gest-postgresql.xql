<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

   <partialquery name="sel_inco_si_vie">
       <querytext>
            select a.cod_inco
             , c.cod_impianto
             , c.flag_tipo_impianto
             , d.denominazione
             , e.descrizione as via 
             , lpad(c.numero, 8,'0')
          from coiminco a
	 inner join coimaimp c on c.cod_impianto  = a.cod_impianto
    left outer join coimcomu d on d.cod_comune    = c.cod_comune
    left outer join coimviae e on e.cod_comune    = c.cod_comune	
                              and e.cod_via       = c.cod_via
         where a.cod_cinc        = :cod_cinc
           and a.stato           = '0' 
	 $where_comb
        $where_tipo_imp
        $where_anno_inst_da    	   
        $where_anno_inst_a
 	 $where_data
  	 $where_codice
	 $where_esito
	 $where_comune
	 $where_via
	 $where_tipo_estr
        $where_area
        $where_cout
         $order_by
         $limit_pos
       </querytext>
    </partialquery>

   <partialquery name="sel_inco_no_vie">
       <querytext>
            select a.cod_inco
             , c.cod_impianto
             , d.denominazione
             , c.indirizzo as via
             , lpad(c.numero, 8,'0')
          from coiminco a
	 inner join coimaimp c on c.cod_impianto  = a.cod_impianto
    left outer join coimcomu d on d.cod_comune    = c.cod_comune
         where a.cod_cinc        = :cod_cinc
           and a.stato           = '0' 
	 $where_comb
        $where_tipo_imp
        $where_anno_inst_da    	   
        $where_anno_inst_a
 	 $where_data
  	 $where_codice
	 $where_esito
	 $where_comune
	 $where_via
	 $where_tipo_estr
         $where_area
        $whwre_cout
         $order_by
         $limit_pos
       </querytext>
    </partialquery>

    <partialquery name="upd_inco">
       <querytext>
                 update coiminco
                    set stato         = '2'
                      , cod_opve      = :f_cod_tecn
                      , data_verifica = :data_verifica
                      , ora_verifica  = :ora_verifica
                      , data_assegn  = current_date
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
                   select descrizione as desc_camp
                     from coimcinc
                    where cod_cinc = :cod_cinc
                      and stato = '1'
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
             select cod_inco as cod_inco_disp
                  , data_verifica
                  , ora_verifica
               from coiminco
              where cod_cinc       = :cod_cinc
                and cod_opve       = :f_cod_tecn
                and cod_impianto   is null
		and data_verifica  >= :f_da_data_disp
              order by data_verifica
              limit 1
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
