<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_pote">
       <querytext>
                   select descr_potenza
			, iter_edit.num(potenza_max, 2) as potenza_max
			, iter_edit.num(potenza_min, 2) as potenza_min
		     from coimpote
		    where cod_potenza = :cod_potenza

       </querytext>
    </fullquery>

    <partialquery name="ins_pote">
       <querytext>
                   insert into 
		      coimpote (cod_potenza
                              , descr_potenza
			      , potenza_max
                              , potenza_min
			      , utente
			      , data_ins
			      , data_mod)
	               values ( upper(:cod_potenza)
		              , upper(:descr_potenza)
			      ,:potenza_max
			      ,:potenza_min
			      ,:id_utente
                     	      ,sysdate
                     	      ,sysdate)
       </querytext>
    </partialquery>

    <partialquery name="upd_pote">
       <querytext>
                   update coimpote
		      set descr_potenza = upper(:descr_potenza)
                        , potenza_max   = :potenza_max
			, potenza_min   = :potenza_min 
			, utente        = :id_utente
			, data_mod      = sysdate
                    where cod_potenza   = :cod_potenza
        
       </querytext>
    </partialquery>

    <partialquery name="del_pote">
       <querytext>
                   delete
		     from coimpote
		    where cod_potenza   = :cod_potenza
   
       </querytext>
    </partialquery>
  
    <fullquery name="check_pote">
       <querytext>
                   select 1
		     from coimpote
		    where upper(descr_potenza) = upper(:descr_potenza)
		   $where_cod 
       </querytext>
    </fullquery>
    <fullquery name="sel_pote_check">
       <querytext>
        select '1'
          from coimpote
         where cod_potenza = :cod_potenza
       </querytext>
    </fullquery>


</queryset>
