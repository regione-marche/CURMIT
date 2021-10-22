/*==============================================================*/
/* table coimgend_stesso_ambiente: tabella che collega i generatori che lavorano sullo nello stesso ambiente  */
/*==============================================================*/

create table coimgend_stesso_ambiente
     ( cod_stesso_ambiente    varchar(08)   not null 
     , cod_impianto           varchar(08)   not null
     , gen_prog               numeric(08)   not null
     , cod_impianto_collegato varchar(08)   not null
     , gen_prog_collegato     numeric(08)   not null
     );

create unique index coimgend_stesso_ambiente_00
    on coimgend_stesso_ambiente
     ( cod_stesso_ambiente
     );

