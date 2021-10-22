-- Nicola 22/05/2014

begin;

-- Aggiunte nuove colonne alla tabella coimuten per gestione della nuova interfaccia grafica
-- per i menù
alter table coimuten add flag_menu_yui       boolean not null default 't';
alter table coimuten add flag_alto_contrasto boolean not null default 'f';


-- Aggiunta di coimaimp.flag_tipo_impianto per adeguamento al dpr 74
alter table coimaimp add flag_tipo_impianto varchar(01);
alter table coimaimp add mappale            varchar(20);
alter table coimaimp add denominatore       varchar(20);
alter table coimaimp add subalterno         varchar(20);


create index coimaimp_14
    on coimaimp
     ( flag_tipo_impianto
     );

update coimaimp set flag_tipo_impianto = 'R';

update coimaimp set flag_tipo_impianto = 'T' where cod_combustibile = '7';


-- Aggiunta di coimcinc.flag_tipo_impianto per adeguamento al dpr 74
alter table coimcinc add flag_tipo_impianto varchar(01);


end;
