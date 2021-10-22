<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
    
    <fullquery name="sel_dual_date">
       <querytext>
                   select to_char(current_date, 'yyyymmdd') as current_date  
       </querytext>
    </fullquery>

 
    <fullquery name="sel_area_s">
       <querytext>
                   select nextval ('coimarea_s') as cod_area
       </querytext>
    </fullquery>
 
    <fullquery name="sel_area">
       <querytext>
                   select descrizione
	             from coimarea
		    where cod_area = :cod_area
       </querytext>
    </fullquery>

    <partialquery name="ins_area">
       <querytext>
                   insert into 
		      coimarea (cod_area
                              , tipo_01
			      , descrizione
			      , data_ins
			      , data_mod
			      , utente)
	               values (:cod_area
                              ,:tipo_01
			      ,:descrizione
			      ,:current_date
			      ,:current_date
			      ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_area">
       <querytext>
                   update coimarea
		      set descrizione = :descrizione
                    where cod_area    = :cod_area
   
       </querytext>
    </partialquery>

    <partialquery name="del_area">
       <querytext>
                   delete
		     from coimarea
		    where cod_area = :cod_area
    
       </querytext>
    </partialquery>
  

    <fullquery name="sel_area_1">
       <querytext>
                   select 1
		     from coimarea
		    where cod_area           <> :cod_area
		      and upper(descrizione) =  upper(:descrizione)
       </querytext>
    </fullquery>

    <fullquery name="count_manu">
       <querytext>
           select count(*) as count_manu
             from coimmtar
            where cod_area = :cod_area
       </querytext>
    </fullquery>

    <fullquery name="count_tecn">
       <querytext>
           select count(*) as count_tecn
             from coimtcar
            where cod_area = :cod_area
       </querytext>
    </fullquery>

    <fullquery name="count_comu">
       <querytext>
           select count(*) as count_comu
             from coimcmar
            where cod_area = :cod_area
       </querytext>
    </fullquery>

    <fullquery name="count_uten">
       <querytext>
           select count(*) as count_uten
             from coimutar
            where cod_area = :cod_area
       </querytext>
    </fullquery>

    <partialquery name="sel_cmar">
       <querytext>
select a.cod_area
     , a.cod_comune
     , coalesce (b.denominazione, '')  as denominazione
  from coimcmar a left outer join
       coimcomu b
    on b.cod_comune = a.cod_comune
 where a.cod_area = :cod_area
order by upper(b.denominazione), a.cod_comune
       </querytext>

    </partialquery>
    <partialquery name="del_cmar">
       <querytext>
                delete
                  from coimcmar
                 where cod_area    = :cod_area
                   and cod_comune  = :comu_canc
       </querytext>
    </partialquery>

</queryset>
