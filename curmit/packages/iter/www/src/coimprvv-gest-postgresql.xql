<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="get_cod_movi">
       <querytext>
          select cod_movi
            from coimmovi
           where riferimento = :cod_prvv
             and id_caus = (select s.id_caus from coimcaus s where s.codice = 'PR')
       </querytext>
    </fullquery>

    <fullquery name="sel_movi_next">
       <querytext>
             select nextval('coimmovi_s') as cod_movi
        </querytext>
    </fullquery>


    <partialquery name="ins_movi">
       <querytext>
                insert
                  into coimmovi
                     ( cod_movi
                     , tipo_movi
                     , cod_impianto
                     , data_scad
                     , data_compet
                     , importo
                     , tipo_pag
                     , riferimento
                     , data_pag
                     , nota
                     , utente
                     , data_ins
                     , id_caus)
                values
                     (:cod_movi
                     ,:tipo_movi
                     ,:cod_impianto
                     ,:data_scad
                     ,current_date
                     ,:importo
                     ,:tipo_pag
                     ,:cod_prvv
                     ,:data_pag
                     ,'Provvedimento cod.'||' '||$cod_prvv||' del '||:data_corrente_ed
                     ,:id_utente
                     ,:data_corrente
                     ,:id_caus)
       </querytext>
    </partialquery>


    <fullquery name="sel_date">
       <querytext>
                   select to_char(current_date, 'yyyymmdd') as data_corrente
                        , to_char(current_date, 'dd/mm/yyyy') as data_corrente_ed
       </querytext>
    </fullquery>

    <partialquery name="ins_prvv">
       <querytext>
                insert
                  into coimprvv 
                     ( cod_prvv
                     , causale
                     , cod_impianto
                     , data_provv
                     , cod_documento
                     , nota
                     , data_ins
                     , data_mod
                     , utente)
                values 
                     (:cod_prvv
                     ,:causale
                     ,:cod_impianto
                     ,:data_provv
                     ,:cod_documento
                     ,:nota
                     ,:data_corrente
                     ,:data_corrente
                     ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_prvv">
       <querytext>
                update coimprvv
                   set causale       = :causale
                     , cod_impianto  = :cod_impianto
                     , data_provv    = :data_provv
                     , cod_documento = :cod_documento
                     , nota          = :nota
                     , data_mod      = :data_corrente
                     , utente        = :id_utente
                 where cod_prvv      = :cod_prvv
       </querytext>
    </partialquery>

    <partialquery name="del_prvv">
       <querytext>
                delete
                  from coimprvv
                 where cod_prvv = :cod_prvv
       </querytext>
    </partialquery>

    <fullquery name="sel_prvv">
       <querytext>
             select cod_prvv
                  , causale
                  , cod_impianto
                  , iter_edit_data(data_provv) as data_provv
                  , cod_documento
                  , nota
               from coimprvv
              where cod_prvv = :cod_prvv
       </querytext>
    </fullquery>

    <fullquery name="sel_prvv_check">
       <querytext>
        select '1'
          from coimprvv
         where cod_prvv = :cod_prvv
       </querytext>
    </fullquery>

    <fullquery name="sel_prvv_next">
        <querytext>
           select nextval('coimprvv_s') as cod_prvv
       </querytext>
    </fullquery>

    <fullquery name="sel_docu_next">
        <querytext>
           select nextval('coimdocu_s') as cod_documento
       </querytext>
    </fullquery>

    <fullquery name="sel_docu">
        <querytext>
           select 1
             from coimdocu
            where cod_documento = :cod_documento
       </querytext>
    </fullquery>

    <partialquery name="ins_docu">
       <querytext>
                insert
                  into coimdocu 
                     ( cod_documento
                     , tipo_documento
                     , cod_impianto
                     , data_documento
                     , data_stampa
                     , tipo_soggetto
                     , cod_soggetto
                     , data_ins
                     , data_mod
                     , utente)
                values 
                     (:cod_documento
                     ,:tipo_documento
                     ,:cod_impianto
                     ,current_date
                     ,current_date
                     ,'C'
                     ,:cod_responsabile
                     ,current_date
                     ,current_date
                     ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_docu">
       <querytext>
                   update coimdocu
                      set data_documento = current_date
                        , data_mod       = current_date
                        , utente         = :id_utente
                    where cod_documento  = :cod_documento
       </querytext>
    </partialquery>

    <fullquery name="sel_docu_contenuto">
       <querytext>
          select contenuto as docu_contenuto_check
            from coimdocu
           where cod_documento = :cod_documento
       </querytext>
    </fullquery>

    <partialquery name="upd_docu_2">
       <querytext>
                   update coimdocu
                      set contenuto     = lo_unlink(coimdocu.contenuto)
                    where cod_documento = :cod_documento
       </querytext>
    </partialquery> 

    <partialquery name="upd_docu_3">
       <querytext>
                   update coimdocu
                   set tipo_contenuto = :tipo_contenuto
                     , contenuto      = lo_import(:contenuto_tmpfile)
                 where cod_documento  = :cod_documento
       </querytext>
    </partialquery> 

    <fullquery name="sel_aimp">
       <querytext>
                select coalesce(b.descr_topo,'')||' '||coalesce(b.descrizione,'')||' '||coalesce(a.numero,'') as indir
                     , coalesce(c.cognome,'')||' '||coalesce(c.nome,'') as nome_resp
                     , coalesce(d.cognome,'')||' '||coalesce(d.nome,'') as nome_prop
                     , coalesce(e.cognome,'')||' '||coalesce(e.nome,'') as nome_occu
                     , a.cod_responsabile 
                  from (coimaimp a
                        left outer join coimviae b on b.cod_via = a.cod_via
                                                  and b.cod_comune = a.cod_comune
                        left outer join coimcitt c on c.cod_cittadino = a.cod_responsabile
                        left outer join coimcitt d on d.cod_cittadino = a.cod_proprietario
                        left outer join coimcitt e on e.cod_cittadino = a.cod_occupante)
                 where a.cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

</queryset>
