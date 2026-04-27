begin;

/* ric01 10/09/2025 MEV regione Marche aggiunta nuovo campo per l'abilitazione giuridica degli operatori

   ric02 17/09/2025 MEV regione Marche Punto 40: creato tabella deleghe ditte di manutenzione
*/

alter table iter_operators add column abilitazione_giuridica_p boolean;

create table iter_maintainer_delegations (
       delegation_id 	  integer primary key
     , maintainer_id 	  integer not null references iter_maintainers (maintainer_id)
     , delegato_id 	  integer not null references iter_maintainers (maintainer_id)
     , start_date	  date
     , end_date 	  date
     , delegation_state   varchar(1)
     , creation_date	  date
     , creation_user	  integer
     , edit_date	  date
     , edit_user	  integer
);

end;
