<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_inco">
       <querytext>
        select   iter_edit_data(data_verifica) as data_verifica
	       , ora_verifica as ora_verifica
	       , cod_cinc as cod_cinc
               , cod_comune
	from coiminco a
           , coimaimp b
	where cod_inco = :cod_inco
          and a.cod_impianto = b.cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_cinc">
       <querytext>
                   select descrizione as desc_camp
                        , to_char(data_inizio, 'yyyymmdd') as dt_inizio_cinc
                        , to_char(data_fine, 'yyyymmdd') as dt_fine_cinc
                     from coimcinc
                    where cod_cinc = :cod_cinc
       </querytext>
    </fullquery>

    <partialquery name="upd_inco">
       <querytext>
           update coiminco
	      set   data_verifica = :data_verifica
	          , ora_verifica  = :ora_verifica
		  , data_mod      = :current_date
		  , utente        = :id_utente
	      where cod_inco = :cod_inco
       </querytext>
    </partialquery>

</queryset>
