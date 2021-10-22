/*=============================================================================================================*/
/* table coimoper : operazioni possibili da selezionare per inserire/modificare le dichiarazioni di frequenza  */
/*=============================================================================================================*/


create table coimoper ( 
    cod_operazione     integer not null, 
    descr_operazione   varchar (200) not null,
    data_ins           date,
    data_mod           date,
    user_inserimento   varchar (20),
    user_modifica      varchar (20)	                   
);

create unique index coimoper_00
    on coimoper
     ( cod_operazione
     );
     
create sequence coimoper_s start 1;
