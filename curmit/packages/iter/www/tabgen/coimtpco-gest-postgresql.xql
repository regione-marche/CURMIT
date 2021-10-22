<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_cost">
       <querytext>
                   select cod_tpco
		        , descr_tpco 
		     from coimtpco
		    where cod_tpco = :cod_tpco 
                  order by descr_tpco
       </querytext>
    </fullquery>

    <fullquery name="sel_tpco_aimp">
       <querytext>
           select 1 as aimps
	   from coimgend
	   where cod_tpco = :cod_tpco
	   group by aimps
       </querytext>
    </fullquery>

    <partialquery name="ins_tpco">
       <querytext>
                   insert into 
		      coimtpco (cod_tpco
                              , descr_tpco
			      , utente
			      , data_ins
			      , data_mod)
	               values (:cod_tpco
		              ,:descr_tpco
			      ,:id_utente
			      ,:current_date
			      ,:current_date)
        
       </querytext>
    </partialquery>

    <partialquery name="upd_tpco">
       <querytext>
                   update coimtpco
		      set descr_tpco = :descr_tpco
                        , utente     = :id_utente
                        , data_mod   = :current_date
                    where cod_tpco   = :cod_tpco
        
       </querytext>
    </partialquery>

    <partialquery name="del_tpco">
       <querytext>
                   delete
		     from coimtpco
		    where cod_tpco   = :cod_tpco
                    
       </querytext>
    </partialquery>
 
    <fullquery name="sel_dual_date">
       <querytext>
                   select to_char(current_date, 'yyyymmdd') as current_date 
       </querytext>
    </fullquery>

    <fullquery name="check_tpco">
       <querytext>
                   select 1
		     from coimtpco
		    where upper(descr_tpco)  = upper(:descr_tpco)
		   $where_cod  
       </querytext>
    </fullquery>

    <fullquery name="sel_tpco_s">
       <querytext>
                   select nextval ('coimtpco_s') as cod_tpco
       </querytext>
    </fullquery>

</queryset>
