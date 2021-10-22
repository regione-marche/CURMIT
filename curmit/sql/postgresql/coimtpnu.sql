/*====================================================================*/
/* table coimtpnu:                                                    */
/*====================================================================*/

create table coimtpnu
     ( cod_tpnu           varchar(08)
     , descr              varchar(50)
     , descr_est          text
     , progressivo        integer
     );

create unique index coimtpnu_00
    on coimtpnu
     ( cod_tpnu
     );