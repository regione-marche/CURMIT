/*==============================================================*/
/* table coimopdi: disponibilita' standard verificatori         */
/*==============================================================*/

create table coimopdi
     ( cod_opve         varchar2(08) not null
     , prog_disp        number(02) not null
     , ora_da           varchar2(08)
     , ora_a            varchar2(08)
     ) tablespace &ts_dat;

create unique index coimopdi_00
    on coimopdi
     ( cod_opve
     , prog_disp
     ) tablespace &ts_idx;

