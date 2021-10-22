<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_inco_comu">
       <querytext>
           select a.denominazione   as comune
                , a.cod_comune
                , count(c.cod_inco) as num_inco 
	     from coimcomu a
                , coimaimp b
                , coiminco c
            where 1 = 1
           $where_comu
              and b.cod_comune   (+) =  a.cod_comune
              and c.cod_impianto (+) =  b.cod_impianto
              and c.cod_cinc     (+) = :f_campagna
	 group by a.denominazione
                , a.cod_comune
	 order by a.denominazione
                , a.cod_comune
       </querytext>
    </partialquery>

    <partialquery name="sel_inco_verif">
       <querytext>
         select b.cognome||' '||nvl(b.nome,'') as verificatore
              , b.cod_opve
	      , a.stato
	      , count(*) as num_inco 
           from coiminco a
              , coimopve b 
          where a.cod_cinc = :f_campagna 
            and b.cod_opve = a.cod_opve 
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
