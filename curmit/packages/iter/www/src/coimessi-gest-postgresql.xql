<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_dual_date">
       <querytext>
                   select to_char(current_date, 'yyyymmdd') as current_date 
       </querytext>
    </fullquery>

    <partialquery name="ins_inco">
       <querytext>
                   insert 
                     into coiminco
                        ( cod_inco
                        , cod_cinc
		        , tipo_estrazione
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
                        ,:cod_cinc
		        ,:tipo_estrazione
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
    </partialquery>

    <fullquery name="sel_inco_s">
       <querytext>
                   select nextval('coiminco_s') as cod_inco
       </querytext>
    </fullquery>

    <fullquery name="sel_cinc_count">
       <querytext>
                   select count(*) as conta
                     from coimcinc
                    where stato = '1'
       </querytext>
    </fullquery>

    <fullquery name="sel_cinc">
       <querytext>
                   select cod_cinc
                        , descrizione as desc_camp
                     from coimcinc
                    where stato = '1'
       </querytext>
    </fullquery>

    <fullquery name="sel_count_inco">
       <querytext>
                   select count(*) as conta_inco
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

</queryset>
