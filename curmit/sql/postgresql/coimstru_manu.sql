/*===============================================================*/
/* table coimstru_manu: Strumenti manutentore                    */
/*===============================================================*/

create table coimstru_manu (
       cod_strumento varchar(8) not null,
       cod_manutentore varchar(8) not null,
       tipo_strum char(1),
       marca_strum varchar(50),
       modello_strum varchar (50),
       matr_strum varchar (50),
       dt_tar_strum date
);
create unique index coimstru_manu_00
    on coimstru_manu
     ( cod_strumento
     );
