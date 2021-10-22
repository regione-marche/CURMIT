begin;

--parametro che indica se i dati catastalo devono essere obbligatori
alter table coimtgen add flag_obbligo_dati_catastali char(1) not null default 'F';

end;
