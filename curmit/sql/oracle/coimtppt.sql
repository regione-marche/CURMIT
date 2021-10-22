/*====================================================================*/
/* table coimtppt:                                                    */
/*====================================================================*/

create table coimtppt
     ( cod_tppt           varchar2(08)
     , descr_est          varchar2(4000)
     , descr              varchar2(50)     
     , progressivo        integer
) tablespace &ts_dat;
