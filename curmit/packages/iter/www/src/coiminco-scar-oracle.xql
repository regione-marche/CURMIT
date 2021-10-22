<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_inco_si_vie">
       <querytext>
        select a.cod_inco
             , c.cod_impianto
             , nvl(b.indirizzo,'')||' '||
               nvl(b.numero,'') as indirizzo_sogg
	     , nvl(b.indirizzo,'')||' '||
               nvl(b.numero,'') as indir
             , b.cap           as cap_sogg
             , b.comune        as comune_sogg
             , b.provincia     as provincia_sogg
             , b.telefono      as telefono
             , b.note          as note
             , b.localita      as localita
             , nvl(e.descr_topo,'')||' '||
               nvl(e.descrizione,'')||' '||
               nvl(c.numero,'') as indirizzo_ext
             , c.numero 
             , nvl(b.cognome,'')||' '||
               nvl(b.nome, '') as resp
             , c.cap
             , d.denominazione as comune
          from coiminco a
	     , coimaimp c 
             , coimcitt b
             , coimcomu d
             , coimviae e
         where a.cod_cinc          = :cod_cinc
           and a.stato             = '0'    
 	   and c.cod_impianto      = a.cod_impianto
           and b.cod_cittadino (+) = c.cod_responsabile
           and d.cod_comune    (+) = c.cod_comune
           and e.cod_comune    (+) = c.cod_comune
           and e.cod_via       (+) = c.cod_via
	 $where_comb
         $where_anno_inst_da    	   
         $where_anno_inst_a
 	 $where_data
  	 $where_codice
         $where_enve
	 $where_tecn
	 $where_esito
	 $where_comune
	 $where_via
	 $where_tipo_estr
         order by b.cognome, b.nome, a.cod_inco
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_no_vie">
       <querytext>
        select a.cod_inco
             , c.cod_impianto
             , nvl(b.indirizzo,'')||' '||
               nvl(b.numero,'') as indirizzo_sogg
	     , nvl(b.indirizzo,'')||' '||
               nvl(b.numero,'') as indir
             , b.cap           as cap_sogg
             , b.comune        as comune_sogg
             , b.provincia     as provincia_sogg
             , b.telefono      as telefono
             , b.note          as note
             , b.localita      as localita
             , nvl(c.toponimo,'')||' '||
               nvl(c.indirizzo,'')||' '||
               nvl(c.numero,'') as indirizzo_ext
             , c.numero 
             , nvl(b.cognome,'')||' '||
               nvl(b.nome, '')  as resp
             , c.cap            as cap
             , d.denominazione  as comune
          from coiminco a
	     , coimaimp c 
             , coimcitt b
             , coimcomu d
         where a.cod_cinc          = :cod_cinc
           and a.stato             = '0'    
 	   and c.cod_impianto  (+) = a.cod_impianto
           and b.cod_cittadino (+) = c.cod_responsabile
           and d.cod_comune    (+) = c.cod_comune
	 $where_comb
         $where_anno_inst_da    	   
         $where_anno_inst_a
 	 $where_data
  	 $where_codice
         $where_enve
	 $where_tecn
	 $where_esito
	 $where_comune
	 $where_via
	 $where_tipo_estr
         order by b.cognome, b.nome, a.cod_inco
       </querytext>
    </fullquery>

    <partialquery name="upd_inco">
       <querytext>
                 update coiminco
                    set stato = '1'
                  where cod_inco in ($in_cod_inco)
       </querytext>
    </partialquery>

    <partialquery name="upd_inco2">
       <querytext>
                 update coiminco
                    set stato    = '1'
                      , cod_opve = :f_cod_tecn
                  where cod_inco in ($in_cod_inco)
       </querytext>
    </partialquery>


   <fullquery name="sel_tecn">
       <querytext>
             select nome    as nome_verif
                  , cognome as cogn_verif
               from coimopve
              where cod_enve       = :f_cod_enve
                and cod_opve       = :f_cod_tecn
       </querytext>
    </fullquery>

    <fullquery name="sel_enve">
       <querytext>
             select ragione_01
               from coimenve
              where cod_enve       = :f_cod_enve
       </querytext>
    </fullquery>

</queryset>
