/*==============================================================*/
/* table coimviae_cnt : viario                                      */
/*==============================================================*/

create table coimviae_cnt
     ( cod_via           varchar(08)    not null
    -- se viario per provincia
     , cod_comune        varchar(08)
     , descrizione       varchar(50)    not null
     , descr_topo        varchar(50)    not null
     , descr_estesa      varchar(50)
     );

create unique index coimviae_cnt_00
    on coimviae_cnt
     ( cod_comune
     , cod_via
     );

create unique index coimviae_cnt_01
    on coimviae_cnt
     ( cod_comune
     , descr_estesa
     , descr_topo
     );

create function coimviae_cnt_upper_pr() returns opaque as '
declare
begin
    new.cod_via          := upper(new.cod_via);
    new.descr_topo       := upper(new.descr_topo);
    new.descrizione      := upper(new.descrizione);
    new.descr_estesa     := upper(new.descr_estesa);
    return new;
end;
' language 'plpgsql';

create trigger coimviae_cnt_upper_tr
    before insert or update on coimviae_cnt
    for each row
        execute procedure coimviae_cnt_upper_pr();
