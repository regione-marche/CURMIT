/*==============================================================*/
/* table coimviae : viario                                      */
/*==============================================================*/

create table coimviae
     ( cod_via           varchar(08)    not null
    -- se viario per provincia
     , cod_comune        varchar(08)
     , descrizione       varchar(50)    not null
     , descr_topo        varchar(50)    not null
     , descr_estesa      varchar(50)
-- Aggiunte in base ai nuovi cap per via delle grandi città
     , cap               varchar(5)
     , da_numero         varchar(5)
     , a_numero          varchar(5)
     , cod_via_new       varchar(08)
     , disattiva         char(01)
     , cod_qua           varchar(08)
     , cod_zona          varchar(08) -- 2016-05-02
     );

create unique index coimviae_00
    on coimviae
     ( cod_comune
     , cod_via
     );

create unique index coimviae_01
    on coimviae
     ( cod_comune
     , descr_estesa
     , descr_topo
     );

create function coimviae_upper_pr() returns opaque as '
declare
begin
    new.cod_via          := upper(new.cod_via);
    new.descr_topo       := upper(new.descr_topo);
    new.descrizione      := upper(new.descrizione);
    new.descr_estesa     := upper(new.descr_estesa);
    return new;
end;
' language 'plpgsql';

create trigger coimviae_upper_tr
    before insert or update on coimviae
    for each row
        execute procedure coimviae_upper_pr();
