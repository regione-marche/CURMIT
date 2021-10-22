<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="ins_inco">
       <querytext>
                   insert 
                     into coiminco
                        ( cod_inco
		        , tipo_estrazione
                        , cod_cinc
			, cod_impianto
			, data_estrazione
			, stato
			, data_ins
			, data_mod
			, utente
                        , note
                        , tipo_lettera
                        )
                   values
                        (:cod_inco
		        ,:tipo_estrazione
                        ,:cod_cinc
		        ,:cod_impianto
		        ,:current_date
		        ,:stato
		        ,:current_date
		        ,:current_date
		        ,:id_utente
                        ,:note
                        ,:tipo_lettera
                        )
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_s">
       <querytext>
                   select nextval('coiminco_s') as cod_inco
       </querytext>
    </fullquery>

    <fullquery name="sel_cinc">
       <querytext>
                   select descrizione as desc_camp
                     from coimcinc
                    where cod_cinc = :cod_cinc
       </querytext>
    </fullquery>

    <fullquery name="sel_inco">
       <querytext>
                   select '1'
                     from coiminco
                    where cod_cinc     = :cod_cinc
                      and cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_sogg">
       <querytext>
                   select cod_responsabile
                        , cod_occupante
                     from coimaimp
                    where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_citt_telefono">
       <querytext>
                   select telefono
                     from coimcitt  
                    where cod_cittadino = :cod_cittadino
       </querytext>
    </fullquery>

    <fullquery name="sel_tpes">
       <querytext>
                   select descr_tpes
                     from coimtpes
                    where cod_tpes = :tipo_estrazione
		    order by cod_tpes
       </querytext>
    </fullquery>

</queryset>
