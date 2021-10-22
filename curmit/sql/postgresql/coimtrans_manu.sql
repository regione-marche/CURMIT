/*==============================================================*/
/* table coimtrans_manu			                        */
/*==============================================================*/

create table coimtrans_manu
     ( id_transazione   varchar(8)       not null
      ,cod_dimp         varchar(8)       not null
      ,num_gen          numeric(8,0)			
      ,rimborso_reg     numeric(9,2)              
      ,costo_bollino    numeric(9,2)              
      ,azione           character(1)              
      ,data_ora         timestamp with time zone  
      ,utente           varchar(10)   );

create unique index coimtrans_manu_00
    on coimtrans_manu
     ( id_transazione     
     );

create index coimtrans_manu_01
    on coimtrans_manu
     ( cod_dimp      
     );
