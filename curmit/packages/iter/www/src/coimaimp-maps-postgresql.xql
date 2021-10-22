<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
    <fullquery name="default_notion">
       <querytext>
              select gb_x as orig_x
                    ,gb_y as orig_y
                    ,delta
                    ,google_key as google_api_key
                 from coimtgen
       </querytext>
    </fullquery>

   <fullquery name="sel_point">
       <querytext>
              select a.cod_impianto
                    , a.gb_x
                    , a.gb_y
                    , v.descr_topo
                    , v.descrizione as indirizzo
                    , a.numero
                    , a.localita
                    , c.denominazione as comune
                    , p.denominazione as provincia
                    , trim(a.flag_coordinate) as flagxy
                 from coimaimp a
                  left outer join coimviae v left outer join coimcomu c on v.cod_comune = c.cod_comune on a.cod_via = v.cod_via
                    , coimprov p
                where a.cod_impianto = :cod_impianto
                  and a.cod_provincia = p.cod_provincia
       </querytext>
    </fullquery>

    <fullquery name="sel_coord">
       <querytext>
       select 
           gb_x as lat
	 , gb_y as lon
	 from 
	   coimaimp 
	where 
	   cod_impianto=:cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="insert_coord">
       <querytext>
       update coimaimp 
          set gb_x=:lat
            , gb_y=:lon 
            , flag_coordinate = :new_state
        where cod_impianto=:cod_impianto
       </querytext>
    </fullquery>

</queryset>
