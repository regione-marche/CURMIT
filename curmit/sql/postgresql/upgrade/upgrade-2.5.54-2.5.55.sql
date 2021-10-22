
begin;
insert into coimfunz
          ( nome_funz
          , desc_funz
          , tipo_funz
          , dett_funz
          , azione
          ) values
          ( 'fatt-isp'
          , 'Fatture Ispezioni'
          , 'primario'
          , 'coimmov-fatt-filter'
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
          , 'Fatture Ispezioni'
          , 'fatt-isp'
       from coimogge as a
          , coimogge as b
      where b.livello=a.livello
        and b.scelta_1 =a.scelta_1
        and a.nome_funz ='mov2'
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
where nome_funz ='fatt-isp';


insert into coimfunz
          ( nome_funz
          , desc_funz
          , tipo_funz
          , dett_funz
          , azione
          ) values
          ( 'fatt-isp'
          , 'Lista Fatture Ispezioni'
          , 'secondario'
          , 'coimmov-fatt-list'
          , 'src/'  
          ) ;

alter table coimmovi add column cod_fatt varchar(8);

insert into coimfunz
          ( nome_funz
          , desc_funz
          , tipo_funz
          , dett_funz
          , azione
          ) values
          ( 'fatt-isp'
          , 'Lista Fatture Ispezioni'
          , 'secondario'
          , 'coimmov-fatt-gest'
          , 'src/'  
          ) ;
insert into coimfunz
          ( nome_funz
          , desc_funz
          , tipo_funz
          , dett_funz
          , azione
          ) values
          ( 'fatt-isp-multi'
          , 'Ristampa Fatture Ispezioni'
          , 'primario'
          , 'coimfatt-isp-filter-multi'
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
	  , 'Ristampa Fatture Ispezioni'
          , 'fatt-isp-multi'
       from coimogge as a
          , coimogge as b
      where b.livello=a.livello
        and b.scelta_1 =a.scelta_1
        and a.nome_funz ='mov2'
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
where nome_funz ='fatt-isp-multi';

insert into coimfunz
          ( nome_funz
          , desc_funz
          , tipo_funz
          , dett_funz
          , azione
          ) values
          ( 'fatt-isp-multi'
          , 'Ristampa Fatture Ispezioni'
          , 'secondario'
          , 'coimfatt-isp-layout-multi'
          , 'src/'  
          ) ;	    

insert into coimfunz
          ( nome_funz
          , desc_funz
          , tipo_funz
          , dett_funz
          , azione
          ) values
          ( 'fatt-isp'
          , 'Stampa Fatture Ispezioni'
          , 'secondario'
          , 'coimfatt-isp-stmp'
          , 'src/'  
          ) ;

end;
