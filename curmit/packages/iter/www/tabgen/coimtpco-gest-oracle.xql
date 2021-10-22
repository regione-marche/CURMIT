<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_cost">
       <querytext>
                   select cod_cost
		        , descr_cost 
		     from coimcost
		    where cod_cost = :cod_cost 
       </querytext>
    </fullquery>

    <partialquery name="ins_cost">
       <querytext>
                   insert into 
		      coimcost (cod_cost
                              , descr_cost
			      , utente
			      , data_ins
			      , data_mod)
	               values (:cod_cost
		              ,:descr_cost
			      ,:id_utente
			      ,:current_date
			      ,:current_date)
        
       </querytext>
    </partialquery>

    <partialquery name="upd_cost">
       <querytext>
                   update coimcost
		      set descr_cost = :descr_cost
                        , utente     = :id_utente
                        , data_mod   = :current_date
                    where cod_cost   = :cod_cost
        
       </querytext>
    </partialquery>

    <partialquery name="del_cost">
       <querytext>
                   delete
		     from coimcost
		    where cod_cost   = :cod_cost
                    
       </querytext>
    </partialquery>
 
    <fullquery name="sel_dual_date">
       <querytext>
                   select to_char(sysdate, 'yyyymmdd') as current_date
                     from dual
       </querytext>
    </fullquery>

    <fullquery name="check_cost">
       <querytext>
                   select 1
		     from coimcost
		    where upper(descr_cost)  = upper(:descr_cost)
		   $where_cod  
       </querytext>
    </fullquery>

    <fullquery name="sel_cost_s">
       <querytext>
                   select coimcost_s.nextval as cod_cost
                     from dual
       </querytext>
    </fullquery>
  
</queryset>
