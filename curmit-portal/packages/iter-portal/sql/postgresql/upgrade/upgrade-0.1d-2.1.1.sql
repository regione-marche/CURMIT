-- Nicola 03/12/2013

begin;

-- Storico rappresentanti legali delle ditte di manutenzione
create table iter_hist_representatives
     ( hist_representative_id integer   not null primary key
     , maintainer_id         integer   not null references iter_maintainers(maintainer_id)
    -- end_date = data fine validità
     , end_date              date      not null
     , representative_id     integer   not null references iter_parties(party_id)
     , creation_user         integer            references users(user_id)
     , creation_timestamp    timestamp not null default current_timestamp
     , editing_user          integer            references users(user_id)
     , editing_timestamp     timestamp
     );

create unique index iter_hist_representatives_idx_01
    on iter_hist_representatives
     ( maintainer_id
     , end_date
     );

comment on table iter_hist_representatives is 'Tabella di storico rappresentanti legali delle ditte di manutenzione';

comment on column iter_hist_representatives.end_date is 'Data fine validità';


end;
