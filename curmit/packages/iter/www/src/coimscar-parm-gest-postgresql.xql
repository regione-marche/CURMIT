<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
    <fullquery name="sel_parm">
       <querytext>
        select gruppo
             , chiave
             , descrizione
             , tab_prov
          from coimparm
      order by gruppo
             , chiave
       </querytext>
    </fullquery>

    <fullquery name="del_parm">
       <querytext>
        delete from coimparm
       </querytext>
    </fullquery>

    <fullquery name="ins_comb">
       <querytext>
        insert into coimparm (
                        gruppo
                      , chiave
                      , descrizione
                      , tab_prov)
               (select 'cod_combustibile'
                     , cod_combustibile
                     , descr_comb
                     , 'coimcomb'
                  from coimcomb)
       </querytext>
    </fullquery>

    <fullquery name="ins_tppr">
       <querytext>
        insert into coimparm (
                        gruppo
                      , chiave
                      , descrizione
                      , tab_prov)
               (select 'cod_tppr'
                     , cod_tppr
                     , descr_tppr
                     , 'coimtppr'
                  from coimtppr)
       </querytext>
    </fullquery>

    <fullquery name="ins_pote">
       <querytext>
        insert into coimparm (
                        gruppo
                      , chiave
                      , descrizione
                      , tab_prov)
               (select 'cod_potenza'
                     , cod_potenza
                     , descr_potenza
                     , 'coimpote'
                  from coimpote)
       </querytext>
    </fullquery>

    <fullquery name="ins_tpim">
       <querytext>
        insert into coimparm (
                        gruppo
                      , chiave
                      , descrizione
                      , tab_prov)
               (select 'cod_tpim'
                     , cod_tpim
                     , descr_tpim
                     , 'coimtpim'
                  from coimtpim)
       </querytext>
    </fullquery>

    <fullquery name="ins_cted">
       <querytext>
        insert into coimparm (
                        gruppo
                      , chiave
                      , descrizione
                      , tab_prov)
               (select 'cod_cted'
                     , cod_cted
                     , descr_cted
                     , 'coimcted'
                  from coimcted)
       </querytext>
    </fullquery>

    <fullquery name="ins_cost">
       <querytext>
        insert into coimparm (
                        gruppo
                      , chiave
                      , descrizione
                      , tab_prov)
               (select 'cod_cost'
                     , cod_cost
                     , descr_cost
                     , 'coimcost'
                  from coimcost)
       </querytext>
    </fullquery>

    <fullquery name="ins_tpem">
       <querytext>
        insert into coimparm (
                        gruppo
                      , chiave
                      , descrizione
                      , tab_prov)
               (select 'cod_emissione'
                     , cod_emissione
                     , descr_emissione
                     , 'coimtpem'
                  from coimtpem)
       </querytext>
    </fullquery>

    <fullquery name="ins_utgi">
       <querytext>
        insert into coimparm (
                        gruppo
                      , chiave
                      , descrizione
                      , tab_prov)
               (select 'cod_utgi'
                     , cod_utgi
                     , descr_utgi
                     , 'coimutgi'
                  from coimutgi)
       </querytext>
    </fullquery>

    <fullquery name="ins_fuge">
       <querytext>
        insert into coimparm (
                        gruppo
                      , chiave
                      , descrizione
                      , tab_prov)
               (select 'cod_fuge'
                     , cod_fuge
                     , descr_fuge
                     , 'coimfuge'
                  from coimfuge)
       </querytext>
    </fullquery>

    <fullquery name="ins_enve">
       <querytext>
        insert into coimparm (
                        gruppo
                      , chiave
                      , descrizione
                      , tab_prov)
               (select 'cod_enve'
                     , cod_enve
                     , ragione_01
                     , 'coimenve'
                  from coimenve
                $where_enve)
       </querytext>
    </fullquery>

    <fullquery name="ins_opve">
       <querytext>
        insert into coimparm (
                        gruppo
                      , chiave
                      , descrizione
                      , tab_prov)
               (select 'cod_opve'
                     , cod_opve
                     , coalesce(cognome, '')||' '||coalesce(nome, '') as descr_opve
                     , 'coimopve'
                  from coimopve
                $where_opve)
       </querytext>
    </fullquery>

    <fullquery name="ins_tano">
       <querytext>
        insert into coimparm (
                        gruppo
                      , chiave
                      , descrizione
                      , tab_prov)
               (select 'cod_tano'
                     , cod_tano
                     , descr_tano
                     , 'coimtano'
                  from coimtano)
       </querytext>
    </fullquery>

    <fullquery name="sel_opve">
       <querytext>
          select cognome
               , nome
            from coimopve
           where cod_opve = :f_cod_tecn
       </querytext>
    </fullquery>

</queryset>

