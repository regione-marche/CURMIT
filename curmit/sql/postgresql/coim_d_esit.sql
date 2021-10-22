/*====================================================================*/
/* table coim_d_esit:                                                 */
/*====================================================================*/

create table coim_d_esit
     ( progressivo	  integer	not null primary key
     , data_elaborazione  date
     , flag_tracciato     char(1)
     );