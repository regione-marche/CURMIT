<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_d_anom">
       <querytext>
                insert
                  into coim_d_anom 
                     ( cod_cimp_dimp
                     , prog_anom
                     , tipo_anom
                     , cod_tanom
                     , dat_utile_inter
		     , flag_origine)
                values 
                     (:cod_cimp_dimp
                     ,:prog_anom
                     ,:tipo_anom
                     ,:cod_tanom
                     ,:dat_utile_inter
		     ,:flag_origine)
       </querytext>
    </partialquery>

    <partialquery name="upd_d_anom">
       <querytext>
                update coim_d_anom
                   set cod_tanom       = :cod_tanom
                     , dat_utile_inter = :dat_utile_inter
                 where cod_cimp_dimp   = :cod_cimp_dimp
                   and prog_anom       = :prog_anom
		   and flag_origine    = :flag_origine
       </querytext>
    </partialquery>

    <partialquery name="del_d_anom">
       <querytext>
                delete
                  from coim_d_anom
                 where cod_cimp_dimp = :cod_cimp_dimp
                   and prog_anom     = :prog_anom
		   and flag_origine  = :flag_origine
       </querytext>
    </partialquery>

    <fullquery name="sel_d_anom">
       <querytext>
             select a.cod_cimp_dimp
                  , a.prog_anom
                  , a.cod_tanom
                  , iter_edit_data(a.dat_utile_inter) as dat_utile_inter
		  , b.descr_breve as desc_tano
               from coim_d_anom a
	          , coim_d_tano b
              where a.cod_cimp_dimp = :cod_cimp_dimp
                and a.prog_anom     = :prog_anom
		and a.flag_origine  = :flag_origine
		and b.cod_tano      = a.cod_tanom
       </querytext>
    </fullquery>

    <fullquery name="sel_d_anom_check">
       <querytext>
        select '1'
          from coim_d_anom
         where cod_cimp_dimp = :cod_cimp_dimp
           and cod_tanom     = :cod_tanom
	   and flag_origine  = :flag_origine
       </querytext>
    </fullquery>

    <fullquery name="sel_d_prog">
       <querytext>
            select coalesce(max(to_number(prog_anom, '99999990') ),0) + 1 as prog_anom
              from coim_d_anom
             where cod_cimp_dimp = :cod_cimp_dimp
	       and flag_origine  = :flag_origine
       </querytext>
    </fullquery>

    <fullquery name="sel_d_tano">
       <querytext>
             select descr_tano
	          , flag_scatenante
               from coim_d_tano
              where cod_tano = :cod_tanom
       </querytext>
    </fullquery>

    <fullquery name="sel_todo_count">
       <querytext>
             select count(*) as conta
               from coimtodo
              where cod_cimp_dimp = :cod_cimp_dimp
                and tipologia     = :tipologia
       </querytext>
    </fullquery>

    <fullquery name="sel_todo">
       <querytext>
             select cod_todo
                  , note
               from coimtodo
              where cod_cimp_dimp = :cod_cimp_dimp
                and tipologia     = :tipologia
	        and note          = :descr_tano
       </querytext>
    </fullquery>

    <fullquery name="sel_todo_next">
        <querytext>
           select nextval('coimtodo_s') as cod_todo
       </querytext>
    </fullquery>

    <partialquery name="ins_todo">
       <querytext>
                insert
                  into coimtodo 
                     ( cod_todo
                     , cod_impianto
                     , cod_cimp_dimp
                     , tipologia
                     , note
                     , flag_evasione
                     , data_evento
                     , data_scadenza
                     , data_ins
                     , utente)
                values 
                     (:cod_todo
                     ,:cod_impianto
                     ,:cod_cimp_dimp
                     ,:tipologia
                     ,:note
                     ,:flag_evasione
                     ,current_date
                     ,:dat_utile_inter
                     ,current_date
                     ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_todo">
       <querytext>
                update coimtodo
                   set data_scadenza = :dat_utile_inter 
                     , data_mod      = current_date
                     , utente        = :id_utente
                 where cod_todo = :cod_todo
       </querytext>
    </partialquery>

    <partialquery name="del_todo">
       <querytext>
           delete 
             from coimtodo
             where cod_todo = :cod_todo
       </querytext>
    </partialquery>

    <fullquery name="check_todo">
        <querytext>
           select cod_todo
             from coimtodo
            where cod_impianto  = :cod_impianto
              and tipologia     = :tipologia
              and cod_cimp_dimp = :cod_cimp_dimp
	      and substr(note,1,3) = :cod_tanom
       </querytext>
    </fullquery>

    <partialquery name="upd_dimp">
        <querytext>
           update coimdimp
              set flag_status = :esito
                , flag_pericolosita = :flag_pericolosita
            where cod_dimp = :cod_cimp_dimp
        </querytext>
    </partialquery>

    <partialquery name="upd_cimp">
        <querytext>
           update coimcimp
              set esito_verifica = :esito
                , flag_pericolosita = :flag_pericolosita
            where cod_cimp = :cod_cimp_dimp
        </querytext>
    </partialquery>

    <fullquery name="sel_cimp_pericolosita">
        <querytext>
           select flag_pericolosita
             from coimcimp
            where cod_cimp = :cod_cimp_dimp
        </querytext>
    </fullquery>

    <fullquery name="sel_dimp_pericolosita">
        <querytext>
           select flag_pericolosita
             from coimdimp
            where cod_dimp = :cod_cimp_dimp
        </querytext>
    </fullquery>

    <fullquery name="sel_d_tano_scatenante">
        <querytext>
           select b.flag_scatenante
             from coim_d_anom a
                , coim_d_tano b
            where a.cod_cimp_dimp = :cod_cimp_dimp
	      and a.cod_tanom    <> :cod_tanom
	      and a.flag_origine  = :flag_origine
	      and b.cod_tano      = a.cod_tanom
        </querytext>
    </fullquery>

    <fullquery name="sel_cimp_data_controllo">
        <querytext>
            select data_controllo
	      from coimcimp
             where cod_cimp   = :cod_cimp_dimp
        </querytext>
    </fullquery>

    <fullquery name="sel_dimp_data_controllo">
        <querytext>
            select data_controllo
	      from coimdimp
             where cod_dimp   = :cod_cimp_dimp
        </querytext>
    </fullquery>

    <fullquery name="sel_d_tano_gg_adattamento">
        <querytext>
              select gg_adattamento
                from coim_d_tano
	       where cod_tano = :cod_tanom
        </querytext>
    </fullquery>

</queryset>
