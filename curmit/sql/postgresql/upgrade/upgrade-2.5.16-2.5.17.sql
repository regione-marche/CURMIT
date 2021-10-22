-- Simone 11/09/2014

begin;

-- Codice impianto principale, Simone 2014-09-11
alter table coimaimp add cod_impianto_princ varchar(08); 

create index coimaimp_15
    on coimaimp
     ( cod_impianto_princ
     ); 

-- Categoria catastale (per Rimini), Sandro 2014-09-16
alter table coimaimp add cat_catastale      varchar(20);

end;
