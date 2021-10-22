<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="get_cod_movi">
       <querytext>
          select cod_movi
            from coimmovi
           where riferimento = :cod_prvv
             and tipo_movi   = 'PR'
       </querytext>
    </fullquery>

    <fullquery name="sel_movi_next">
       <querytext>
             select coimmovi_s.nextval as cod_movi
               from dual
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
                     )
                values
                     (:cod_movi
                     ,:tipo_movi
                     ,:cod_impianto
                     ,:data_scad
                     ,sysdate
                     ,:importo
                     ,:tipo_pag
                     ,:cod_prvv
                     ,:data_pag
                     ,'Provvedimento cod.'||' '||$cod_prvv||' del '||:data_corrente_ed
                     ,:id_utente
                     ,:data_corrente
                     )
       </querytext>
    </partialquery>

    <fullquery name="sel_date">
       <querytext>
                   select to_char(sysdate, 'yyyymmdd') as data_corrente
                        , to_char(sysdate, 'dd/mm/yyyy') as data_corrente_ed
                     from dual
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
                   set causale = :causale
                     , cod_impianto = :cod_impianto
                     , data_provv = :data_provv
                     , cod_documento = :cod_documento
                     , nota = :nota
                     , data_mod     = :data_corrente
                     , utente       = :id_utente
                 where cod_prvv = :cod_prvv
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
                  , iter_edit.data(data_provv) as data_provv
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
           select coimprvv_s.nextval as cod_prvv
             from dual
       </querytext>
    </fullquery>

    <fullquery name="sel_docu_next">
        <querytext>
           select coimdocu_s.nextval as cod_documento
             from dual
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
                        ( :cod_documento
                        , :tipo_documento
                        , :cod_impianto
                        , :data_documento
                        , sysdate
                        , 'C'
                        , :cod_responsabile
                        , :data_corrente
                        , :data_corrente
                        , :id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_docu">
       <querytext>
                   update coimdocu
                      set data_documento = :data_documento
                        , data_mod       = :data_corrente
                        , utente         = :id_utente
                    where cod_documento  = :cod_documento
       </querytext>
    </partialquery>

    <partialquery name="upd_docu_2">
       <querytext>
                   update coimdocu
                      set tipo_contenuto = :tipo_contenuto
                        , contenuto      = empty_blob()
                    where cod_documento  = :cod_documento
                returning contenuto
                     into :1
       </querytext>
    </partialquery> 

    <fullquery name="sel_aimp">
       <querytext>
                select nvl(b.descr_topo,'')||' '||nvl(b.descrizione,'')||' '||nvl(a.numero,'') as indir
                     , nvl(c.cognome,'')||' '||nvl(c.nome,'') as nome_resp
                     , nvl(d.cognome,'')||' '||nvl(d.nome,'') as nome_prop
                     , nvl(e.cognome,'')||' '||nvl(e.nome,'') as nome_occu
                     , a.cod_responsabile
                  from coimaimp a
                     , coimviae b
                     , coimcitt c
                     , coimcitt d
                     , coimcitt e
                 where a.cod_impianto      = :cod_impianto
                   and b.cod_via       (+) = a.cod_via
                   and b.cod_comune    (+) = a.cod_comune
                   and c.cod_cittadino (+) = a.cod_responsabile
                   and d.cod_cittadino (+) = a.cod_proprietario
                   and e.cod_cittadino (+) = a.cod_occupante
       </querytext>
    </fullquery>

</queryset>
