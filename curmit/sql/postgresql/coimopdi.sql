/*==============================================================*/
/* table coimopdi: disponibilita' standard verificatori         */
/*==============================================================*/

create table coimopdi
     ( cod_opve         varchar(08) not null
     , prog_disp        numeric(02) not null
     , ora_da           varchar(08)
     , ora_a            varchar(08)
     );

create unique index coimopdi_00
    on coimopdi
     ( cod_opve
     , prog_disp
     );

