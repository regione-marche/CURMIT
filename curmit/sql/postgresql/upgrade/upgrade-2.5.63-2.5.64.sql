begin;

--Funzioni per inserimento degli impianti semplificati e degli rcee del freddo semplificati
insert into coimfunz
values ('isrt_manu_semp','Inserisci nuovo Impianto','primario', 'coimaimp-isrt-manu-semp-chose','src/',null) ;

insert into coimfunz
values ('isrt_manu_semp','Inserisci nuovo Impianto','secondario', 'coimaimp-isrt-manu-semp','src/',null) ;

insert into coimfunz
values ('isrt_manu_semp','Inserisci nuovo Impianto','secondario', 'coimaimp-isrt-manu-semp-fr','src/',null) ;

insert into coimfunz
values ('isrt_manu_semp','Inserisci nuovo Impianto','secondario', 'coimaimp-isrt-manu-semp-te','src/',null) ;

insert into coimfunz
values ('isrt_manu_semp','Inserisci nuovo Impianto','secondario', 'coimaimp-isrt-manu-semp-co','src/',null) ;

insert into coimogge
values ('2','11','93','0','0','funzione','Inserisci nuovo Impianto semplificato','isrt_manu_semp');

--la query summa coimmenu verrà lanciata manualmente perchè le nuove funzioni servono solo per le Marche
--insert into coimmenu
--values ('system-admin','2','11','93','0','0','5','7');


insert into coimfunz values ('dimp','Nuovi allegati freddo','secondario','coimdimp-fr-nowallet-gest','src/',null);


end;
