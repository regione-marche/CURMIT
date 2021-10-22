begin;

--gestione del nuovi programmi per il 284 e il 286

insert into coimfunz
values (
    'dimp'
   ,'gestione allegato 284'
   ,'secondario'
   ,'coimnove-284-gest'
   ,'src/'
);
		
insert into coimfunz
values (
    'dimp'
   ,'stampa allegato 284'
   ,'secondario'
   ,'coimnove-284-layout'
   ,'src/'
);
		

insert into coimfunz
values (
    'dimp'
   ,'gestione allegato 286'
   ,'secondario'
   ,'coimnove-286-gest'
   ,'src/'
);

insert into coimfunz
values (
    'dimp'
   ,'stampa allegato 286'
   ,'secondario'
   ,'coimnove-286-layout'
   ,'src/'
);
		

alter table coimnoveb add column flag_tracciato varchar(10);

alter table coimnoveb add column polveri_totali            decimal(18,2);
alter table coimnoveb add column monossido_carbonio        decimal(18,2);
alter table coimnoveb add column ossidi_azoto              decimal(18,2);
alter table coimnoveb add column ossidi_zolfo              decimal(18,2);
alter table coimnoveb add column carbonio_organico_totale  decimal(18,2);
alter table coimnoveb add column composti_inorganici_cloro decimal(18,2);
alter table coimnoveb add column flag_uni_13284            char(1);
alter table coimnoveb add column flag_uni_14792            char(1);
alter table coimnoveb add column flag_uni_15058            char(1);
alter table coimnoveb add column flag_uni_10393            char(1);
alter table coimnoveb add column flag_uni_12619            char(1);
alter table coimnoveb add column flag_uni_1911             char(1);
alter table coimnoveb add column flag_elettrochimico       char(1);
alter table coimnoveb add column flag_normativa_previgente char(1);
	  

end;
