-- Nicola 07/06/2016

begin;

--Aggiungo parametro per visualizzazione Estratto conto (dalla lista manutentori)
alter table coimtgen add flag_visualizza_ec char(1) default 'F';

alter table coimdimp     add data_prox_manut date; 
alter table coimdimp_stn add data_prox_manut date; 

  insert
    into coimutgi
       ( cod_utgi
       , descr_utgi
       , data_ins
       , data_mod
       , utente
       , descr_e_utgi
       )
values ('C'
       ,'Cond.estivo/Riscaldamento'
       ,current_date
       ,null
       ,'sandro'
       ,'Cond.estivo/Riscaldamento'
       );

end;
