/*====================================================================*/
/* table coimtpnu:                                                    */
/*====================================================================*/

create table coimtpnu
     ( cod_tpnu           varchar2(08)
     , descr              varchar2(50)
     , descr_est          varchar2(4000)
     , progressivo        integer
) tablespace &ts_dat;

create unique index coimtpnu_00
    on coimtpnu
     ( cod_tpnu
     ) tablespace &ts_idx;