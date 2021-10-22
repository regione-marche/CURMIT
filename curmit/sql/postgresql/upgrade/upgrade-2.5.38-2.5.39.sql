-- Simone 27/06/2016

begin;


--Aggiunti campi per gestione del campo targa      
alter table coimtgen add flag_gest_targa  char(1)  not null default 'F';

alter table coimaimp add targa varchar(16); 

insert into coimtabs 
     ( nome_tabella  
     , nome_colonna  
     , denominazione 
     , tipo_dato     
     , dimensione    
     , obbligatorio  
     , default_value 
     , range_value   
     , ordinamento  )
 values (
       'rcee1'
     , 'targa'
     , 'Targa'
     , 'varchar'
     , 16
     , 'N'
     , null
     , null
     , 2370);


end;
