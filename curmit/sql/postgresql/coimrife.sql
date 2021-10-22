/*==============================================================*/
/* table coimrife: tabella delle persone di riferimento         */
/*==============================================================*/

create table coimrife
     ( cod_impianto          varchar(08)  not null 
     , ruolo                 char(01)     not null        
-- ruolo:  P= proprietario, O= occupante, A= amministratore, R= responsabile, T= intestatario, M= manutentore, I= installatore, D= distributore, G= progettista
--         
     , data_fin_valid        date         not null
     , cod_soggetto          varchar(08)  not null        
     , data_ins         date
     , data_mod         date
     , utente           varchar(10)  
     );

create unique index coimrife_00
    on coimrife
     ( cod_impianto
     , ruolo
     , data_fin_valid
     );

