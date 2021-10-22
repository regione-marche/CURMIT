/*==============================================================*/
/* table coimprvv: tabella provvedimenti sanzionatori           */
/* l'inserimento del provvedimento deve generare un documento   */
/*==============================================================*/

create table coimprvv
     ( cod_prvv         varchar(08)
     , causale          char(2) not null
-- MC = mancato pagamento, SN sanzione per inadempienze sull'impianto
-- GE = generico       
     , cod_impianto     varchar(08) not null 
     , data_provv       date        not null 
--  data del provvedimento 
     , cod_documento    varchar(8)
     , nota             varchar(4000)
-- testo descrittivo da stampare contenente le motivazioni esplicite
     , utente           varchar(10) 
     , data_ins         date
     , data_mod         date
     );

create unique index coimprvv_00
    on coimprvv
     ( cod_prvv
     ); 

create   index coimprvv_01
    on coimprvv
     ( cod_impianto
     , cod_prvv
     ); 

