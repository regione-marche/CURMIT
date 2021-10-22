-- Sandro, 30/06/2014 per Comune di Rimini ma può andare bene anche per gli altri clienti

begin;

alter table coimaimp add cod_distributore_el varchar(08);
alter table coimaimp add pdr                 varchar(20);
alter table coimaimp add pod                 varchar(20); 

alter table coimcitt add stato_citt          char(01) not null default 'A'; --A=Attivo, N=Non attivo

alter table coimdist add tipo_energia        char(01); --E=Elettrica, T=Termica T, G=Elettrica/Termica

end;
