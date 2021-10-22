<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_anom">
       <querytext>
           select prog_anom
	           , cod_tanom 
		     , iter_edit_data(dat_utile_inter) as dat_utile_inter
             from coimanom 
            where cod_cimp_dimp = :cod_dimp
	          and flag_origine  = 'MH'
         order by to_number(prog_anom,'99999999')
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp_esito">
       <querytext>
           select flag_status
                , flag_pericolosita 
             from coimdimp
            where cod_dimp = :cod_dimp
       </querytext>
    </fullquery>

    <fullquery name="sel_anom_count">
       <querytext>
        select count(*) as conta_anom
          from coimanom
         where cod_cimp_dimp = :cod_dimp
	    and flag_origine  = 'MH'
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp">
       <querytext>
             select a.cod_dimp
                  , iter_edit_data(a.data_controllo) as data_controllo
                  , a.cod_manutentore
                  , a.osservazioni
                  , a.raccomandazioni
                  , a.prescrizioni
                  , b.cognome   as cognome_manu
                  , b.nome      as nome_manu
               from coimdimp a
               left outer join coimmanu b on b.cod_manutentore  = a.cod_manutentore
              where cod_dimp = :cod_dimp
       </querytext>
    </fullquery>

    <fullquery name="sel_tano_desc">
       <querytext>
             select cod_tano||' - '||coalesce(descr_breve,'') as  descrizione_anom
               from coimtano
              where cod_tano = :cod_tanom
       </querytext>
    </fullquery>



</queryset>
