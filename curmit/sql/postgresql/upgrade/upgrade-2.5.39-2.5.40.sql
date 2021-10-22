-- Simone 12/09/2016

begin;

\i ../coimtrat_aria_aimp.sql
create sequence coimtrat_aria_aimp_s start 1;

\i ../coimrecu_calo_aimp.sql
create sequence coimrecu_calo_aimp_s start 1;

\i ../coimvent_aimp.sql
create sequence coimvent_aimp_s start 1;

insert into coimfunz values ('impianti','Gestione Unita di trattamento aria'  ,'secondario','coimtrat-aria-aimp-gest' ,'src','');
insert into coimfunz values ('impianti','Gestione Recuperatori di calore'  ,'secondario','coimrecu-calo-aimp-gest' ,'src','');
insert into coimfunz values ('impianti','Gestione Impianti di ventilazione'  ,'secondario','coimvent-aimp-gest' ,'src','');

alter table coimcomu add flag_viario_manutentore char(1) not null default 'T';

alter table coimcomu
  add constraint chk_flag_viario_manutentore
check (flag_viario_manutentore in ('T', 'F'));

end;
