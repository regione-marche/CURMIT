/*==============================================================*/
/* table coimprvv: tabella provvedimenti sanzionatori           */
/* l'inserimento del provvedimento deve generare un documento   */
/*==============================================================*/

create table coimprvv
     ( cod_prvv         varchar2(08)
     , causale          varchar2(2) not null
-- MC = mancato pagamento, SN sanzione per inadempienze sull'impianto
-- GE = generico       
     , cod_impianto     varchar2(08) not null 
     , data_provv       date        not null 
--  data del provvedimento 
     , cod_documento    varchar2(8)
     , nota             varchar2(4000)
-- testo descrittivo da stampare contenente le motivazioni esplicite
     , utente           varchar2(10) 
     , data_ins         date
     , data_mod         date
     ) tablespace &ts_dat;

create unique index coimprvv_00
    on coimprvv
     ( cod_prvv
     ) tablespace &ts_idx;

create   index coimprvv_01
    on coimprvv
     ( cod_impianto
     , cod_prvv
     ) tablespace &ts_idx;
