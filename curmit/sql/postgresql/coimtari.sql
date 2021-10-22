/*==============================================================*/
/* table coimtari: tariffario costi controlli,autocertificazioni,sanzioni ecc*/
/*==============================================================*/

create table coimtari
     ( tipo_costo     integer       not null
-- 1 = autocertificazione, 2 = verifica, 3 = verifica generatore aggiuntivo
-- 4 = sanzioni per inadempienze tecniche 
     , cod_potenza    varchar(8)    not null
     , data_inizio    date          not null
     , importo        numeric(9,2)  not null
     , cod_listino    varchar(8)    
     , flag_tariffa_impianti_vecchi boolean      not null default 'f' 
     , anni_fine_tariffa_base       numeric(2,0)
     , tariffa_impianti_vecchi      numeric(9,2)
     );

create unique index coimtari_00
    on coimtari
     ( tipo_costo
      ,cod_potenza
      ,data_inizio
     );
