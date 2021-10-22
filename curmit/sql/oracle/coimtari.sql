/*==============================================================*/
/* table coimtari: tariffario costi controlli,autocertificazioni,sanzioni ecc*/
/*==============================================================*/

create table coimtari
     ( tipo_costo     number(08)    not null
-- 1 = autocertificazione, 2 = verifica, 3 = verifica generatore aggiuntivo
-- 4 = sanzioni per inadempienze tecniche 
     , cod_potenza    varchar2(08)  not null
     , data_inizio    date          not null
     , importo        number(9,2)   not null
     , cod_listino    varchar2(08)
     , flag_tariffa_impianti_vecchi boolean  not null default 'f'
     , anni_fine_tariffa_base       number(2,0)
     , tariffa_impianti_vecchi      number(9,2)
     ) tablespace &ts_dat;

create unique index coimtari_00
    on coimtari
     ( tipo_costo
      ,cod_potenza
      ,data_inizio
     ) tablespace &ts_idx;
