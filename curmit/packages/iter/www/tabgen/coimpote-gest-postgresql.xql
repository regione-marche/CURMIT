<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_pote">
       <querytext>
                   select descr_potenza
			, iter_edit_num(potenza_max, 2) as potenza_max
			, iter_edit_num(potenza_min, 2) as potenza_min
                        , flag_tipo_impianto
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
			      , data_mod
                              , flag_tipo_impianto)
	               values ( upper(:cod_potenza)
		              , upper(:descr_potenza)
			      ,:potenza_max
			      ,:potenza_min
			      ,:id_utente
                     	      ,current_date
                     	      ,current_date
                              ,:flag_tipo_impianto)
       </querytext>
    </partialquery>

    <partialquery name="upd_pote">
       <querytext>
                   update coimpote
		      set descr_potenza = upper(:descr_potenza)
                        , potenza_max   = :potenza_max
			, potenza_min   = :potenza_min 
			, utente        = :id_utente
			, data_mod      = current_date
                        , flag_tipo_impianto = :flag_tipo_impianto
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
  
    <fullquery name="sel_pote_check">
       <querytext>
        select '1'
        	from coimpote
         	where $contr_cod
         	((:potenza_min between potenza_min and potenza_max and :potenza_max >= potenza_max)
         	or (:potenza_min <= potenza_min and :potenza_max between potenza_min and potenza_max)
         	or (:potenza_min between potenza_min and potenza_max and :potenza_max between potenza_min and potenza_max)
         	or (:potenza_min < potenza_min and :potenza_max > potenza_max )) and flag_tipo_impianto = :flag_tipo_impianto
         	limit 1
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_check">
       <querytext>
        select '1'
          from coimaimp
         where cod_potenza = :cod_potenza
        limit 1
       </querytext>
    </fullquery>

    <fullquery name="check_pote">
       <querytext>
         select '1'
		     from coimpote
		    where upper(descr_potenza) = upper(:descr_potenza)
		    $where_cod
		    and flag_tipo_impianto = :flag_tipo_impianto  --rom01
		</querytext>
    </fullquery>

</queryset>7
