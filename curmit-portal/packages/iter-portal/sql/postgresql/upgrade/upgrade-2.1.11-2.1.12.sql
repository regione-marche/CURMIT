
begin;

--campo aggiunto per la visualizzazione del manutentore nell'elenco dell'ente
alter table iter_maintainers add column visualizza_company boolean not null default 't' ;

end;
