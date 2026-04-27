<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

   <fullquery name="sel_fornt">
      <querytext>
            select 
	         REPLACE(REPLACE(natura_giurid, E'\r', ''), E'\n', '')          as natura_giurid
	       , REPLACE(REPLACE(utente_cogn_rag_soc, E'\r', ''), E'\n', '')    as utente_cogn_rag_soc
	       , REPLACE(REPLACE(utente_nome, E'\r', ''), E'\n', '')            as utente_nome
	       , REPLACE(REPLACE(utente_cf, E'\r', ''), E'\n', '')              as utente_cf
	       , REPLACE(REPLACE(utente_piva, E'\r', ''), E'\n', '')            as utente_piva
	       , REPLACE(REPLACE(toponimo_tipo, E'\r', ''), E'\n', '')          as toponimo_tipo
	       , REPLACE(REPLACE(toponimo_nome, E'\r', ''), E'\n', '')          as toponimo_nome
	       , REPLACE(REPLACE(toponimo_civico, E'\r', ''), E'\n', '')        as toponimo_civico
	       , REPLACE(REPLACE(toponimo_cap::text, E'\r', ''), E'\n', '')           as toponimo_cap
	       , REPLACE(REPLACE(comune_nome, E'\r', ''), E'\n', '')            as comune_nome
	       , REPLACE(REPLACE(comune_istat, E'\r', ''), E'\n', '')           as comune_istat
	       , REPLACE(REPLACE(catasto_sezione, E'\r', ''), E'\n', '')        as catasto_sezione
	       , REPLACE(REPLACE(catasto_foglio, E'\r', ''), E'\n', '')         as catasto_foglio
	       , REPLACE(REPLACE(catasto_particella, E'\r', ''), E'\n', '')     as catasto_particella
	       , REPLACE(REPLACE(catasto_subalterno, E'\r', ''), E'\n', '')     as catasto_subalterno
	       , REPLACE(REPLACE(pdr, E'\r', ''), E'\n', '')                    as pdr
	       , REPLACE(REPLACE(pod, E'\r', ''), E'\n', '')                    as pod
	       , REPLACE(REPLACE(stato_pdr, E'\r', ''), E'\n', '')              as stato_pdr
	       , REPLACE(REPLACE(matr_contatore, E'\r', ''), E'\n', '')         as matr_contatore
	       , REPLACE(REPLACE(contratto_tipo, E'\r', ''), E'\n', '')         as contratto_tipo
	       , REPLACE(REPLACE(combustibile_tipo::text, E'\r', ''), E'\n', '')      as combustibile_tipo
	       , REPLACE(REPLACE(combustibile_consumo, E'\r', ''), E'\n', '')                    as combustibile_consumo
	       , REPLACE(REPLACE(combustibile_um::text, E'\r', ''), E'\n', '')                         as combustibile_um
	       , REPLACE(REPLACE(combustibile_anno, E'\r', ''), E'\n', '')                       as combustibile_anno
	       , REPLACE(REPLACE(cr.description, E'\r', ''), E'\n', '')                          as description
	       , REPLACE(REPLACE(to_char(cr.publish_date,'DD/MM/YYYY'), E'\r', ''), E'\n', '')   as publish_date
	       , REPLACE(REPLACE(g.group_name, E'\r', ''), E'\n', '')                            as ente_riferimento
	       , REPLACE(REPLACE(d.name, E'\r', ''), E'\n', '')                                  as name_distributor
	       , REPLACE(REPLACE(to_char(cr.publish_date,'YYYY'), E'\r', ''), E'\n', '')         as anno_rif

            from iter_supplies_sync s
               , attachments        a
               , cr_items           ci
               , cr_revisions       cr
               , iter_comuni        c
               , groups             g
               , iter_instances     i
               , iter_distributors  d
               , iter_combustibili b
           where s.distributor_id      = a.object_id
             and a.item_id             = s.item_id
             and s.item_id             = a.item_id
             and ci.item_id            = s.item_id
             and ci.live_revision      = cr.revision_id
             and UPPER(s.comune_nome)         = UPPER(c.denominazione)
             and c.body_id             = g.group_id
             and g.group_id            = i.instance_id
             and s.distributor_id      = d.distributor_id
             and b.codice_combustibile = s.combustibile_tipo
	     $where_anno_rif
	     $where_name_distributor
	     $where_f_comune
	     $where_f_combustibile
	     $where_competente
       </querytext>
    </fullquery>

</queryset>
