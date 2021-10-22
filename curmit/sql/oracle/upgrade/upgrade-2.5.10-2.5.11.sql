-- Nicola, 04/06/2014 per adeguamento al dpr74

begin;

-- Nuovo record di coimimst creato da Sandro.
-- Uso una tecnica particolare per evitare l'inserimento se il record esiste gia'.
-- insert into coimimst values ('U','ImpiantoChiuso', null);
insert
  into coimimst (cod_imst, descr_imst)
select *
  from (select 'U'::char as cod_imst, 'ImpiantoChiuso'::varchar
       ) a
 where not exists (select 1
                     from coimimst b
                    where b.cod_imst = a.cod_imst);

-- Aggiunti nuovi parametri:
-- password_gg_durata i   nteger default 91 Durata della password in giorni (default 91)
-- password_gg_preavviso integer default 81 N. di giorni dopo il cambio password dopo i quali viene dato il preavviso che la password e' in scadenza (default 81).

end;
