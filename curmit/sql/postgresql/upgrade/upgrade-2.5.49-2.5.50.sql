-- Gabriele 30/06/2017

begin;

-- Per togliere il menù Inserimento scheda impianto -Riscaldamento bisogna farlo manualmente dalla gestione menù


-- Aggiunto nuovo campo alla coimtgen

alter table coimtgen add flag_verifica_impianti boolean default 'f';

-- Aggiungo record alla tebella coimimst

insert into coimimst values ('F','Da controllare','');
insert into coimimst values ('E','Respinto','');


end;
