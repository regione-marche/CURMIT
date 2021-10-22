<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_inco_comu">
       <querytext>
           select coalesce(c.denominazione,' ') as comune
                , c.cod_comune
                , count(a.cod_inco) as num_inco
             from coiminco a
  left outer join coimaimp b on b.cod_impianto = a.cod_impianto
  left outer join coimcomu c on c.cod_comune = b.cod_comune
            $where_comu
            where a.cod_cinc = :f_campagna
	 group by c.denominazione
                , c.cod_comune
	 order by c.denominazione
                , c.cod_comune
       </querytext>
    </partialquery>

    <partialquery name="sel_inco_verif">
       <querytext>
         select coalesce(b.cognome, '')||' '||coalesce(b.nome,'') as verificatore
              , b.cod_opve
	      , a.stato
	      , count(*) as num_inco 
           from coiminco a
left outer join coimopve b on b.cod_opve = a.cod_opve 
          where a.cod_cinc = :f_campagna 
       group by	b.cognome
              , b.nome
              , b.cod_opve
              , a.stato 
       order by b.cognome
              , b.nome
              , b.cod_opve 
       </querytext>
    </partialquery>
    
    <fullquery name="sel_cinc_controlli_prev">
        <querytext>
          select controlli_prev
            from coimcinc
           where cod_cinc = :f_campagna
        </querytext>
    </fullquery>

    <fullquery name="sel_comu">
        <querytext>
          select $popolazione as pop_comune
            from coimcomu
           where cod_comune = :cod_comune
        </querytext>
    </fullquery>

    <fullquery name="sel_inst">
        <querytext>
            select cod_inst
		 , descr_inst
              from coiminst
	     where cod_inst > 1
	 </querytext>
    </fullquery>

</queryset>
