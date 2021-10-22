
begin ;

--LucaR. Aggiunti campi per la pec sulla coimtgen  
alter table coimtgen add column indirizzo_pec    varchar(100) ;
alter table coimtgen add column nome_utente_pec  varchar(100) ;
alter table coimtgen add column password_pec     varchar(50)  ;
alter table coimtgen add column stmp_pec         varchar(50)  ;
alter table coimtgen add column porta_uscita_pec varchar(50)  ;

--LucaR. agginto campo pec sulla tabella dei Comuni
alter table coimcomu add column pec varchar(100) ;

--Simone aggiunto tabella per invii mail
\i ../coimmail.sql

insert into coimfunz
          ( nome_funz
	  , desc_funz
	  , tipo_funz
	  , dett_funz
	  , azione
	  ) values 
	  ( 'estr-mail'
	  , 'Estrazione e spedizione lettere per Racc. e Presc.'
	  , 'primario'
	  , 'coimestr-mail-filter'
	  , 'src/'
	  ) ;
						      	  
insert into coimogge 
          ( livello
      	  , scelta_1
          , scelta_2
      	  , scelta_3
          , scelta_4
      	  , tipo
          , descrizione
     	  , nome_funz )
     select a.livello
          , a.scelta_1
          , max(b.scelta_2::integer) +1
          , a.scelta_3
          , a.scelta_4
          , a.tipo
          , 'Estrazione e spedizione lettere per Racc. e Presc.'
          , 'estr-mail'
       from coimogge as a
          , coimogge as b
      where b.livello=a.livello
        and b.scelta_1 =a.scelta_1   
        and a.nome_funz ='estr' 
      group by a.livello
          , a.scelta_1
          , a.scelta_3
          , a.scelta_4
          , a.tipo;
										      
insert into coimmenu 
      ( nome_menu
      , livello
      , scelta_1
      , scelta_2
      , scelta_3
      , scelta_4
      , lvl
      , seq )
select 'system-admin'
      , livello
      , scelta_1
      , scelta_2
      , scelta_3
      , scelta_4
      , 5     
      , 4
from coimogge
where nome_funz ='estr-mail';

insert into coimfunz
          ( nome_funz
	  , desc_funz
	  , tipo_funz
	  , dett_funz
	  , azione 
	  ) values
	  ( 'estr-mail'
	  , 'Stampa mail richieste'
	  , 'secondario'
	  , 'coimstrd-mail-filter'
	  , 'src/'
	  ) ;

insert into coimfunz
          ( nome_funz
          , desc_funz
      	  , tipo_funz
          , dett_funz
      	  , azione 
          ) values
      	  ( 'estr-mail'
          , 'Invio mail'
      	  , 'secondario'
          , 'coimmail-invio'
      	  , 'src/'
          ) ;
						      	
insert into coimfunz
          ( nome_funz
          , desc_funz
      	  , tipo_funz
          , dett_funz
      	  , azione 
          ) values
      	  ( 'estr-mail-list'
          , 'Visualizzazione Mail spedite'
      	  , 'primario'
          , 'coimmail-list'
      	  , 'src/'
          ) ;

insert into coimfunz
       	  ( nome_funz
	  , desc_funz
	  , tipo_funz
	  , dett_funz
	  , azione    
	  ) values
	  ( 'estr-mail-list'
	  , 'Gestione Mail'
	  , 'secondario'
	  , 'coimmail-gest'
	  , 'src/'
	  ) ;

insert into coimogge
          ( livello
          , scelta_1
          , scelta_2
          , scelta_3
          , scelta_4
          , tipo
          , descrizione
          , nome_funz )
     select a.livello
          , a.scelta_1
          , max(b.scelta_2::integer) +1
          , a.scelta_3
          , a.scelta_4
          , a.tipo
          , 'Visualizzazione Mail spedite'
          , 'estr-mail-list'
       from coimogge as a
          , coimogge as b
      where b.livello=a.livello
        and b.scelta_1 =a.scelta_1
        and a.nome_funz ='estr'
      group by a.livello
          , a.scelta_1
          , a.scelta_3
          , a.scelta_4
          , a.tipo;

	      
insert into coimmenu
      ( nome_menu
      , livello
      , scelta_1
      , scelta_2
      , scelta_3
      , scelta_4
      , lvl
      , seq )
select 'system-admin'
      , livello
      , scelta_1
      , scelta_2
      , scelta_3
      , scelta_4
      , 5
      , 4
from coimogge
where nome_funz ='estr-mail-list';


end ;
