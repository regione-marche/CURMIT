
begin;

-- Sandro per nuove col pres_certificazione e certificazione
alter table coimaimp add pres_certificazione                      char(1);
alter table coimaimp add certificazione                           varchar(80);


-- Simone 19/11/2014 per nuove colonne per sezione trattamento acqua (trat_acqua)

insert
  into coimfunz
     ( nome_funz
     , desc_funz
     , tipo_funz
     , dett_funz
     , azione
     )
values 
     ( 'impianti'
     , 'Trattamento acqua'
     , 'secondario'
     , 'coimaimp-tratt-acqua-gest'
     , 'src/'
     );

alter table coimaimp add tratt_acqua_contenuto                    numeric(10,2);
alter table coimaimp add tratt_acqua_durezza                      numeric(9,2);
alter table coimaimp add tratt_acqua_clima_tipo                   char(1);
alter table coimaimp add tratt_acqua_clima_addolc                 numeric(9,2);
alter table coimaimp add tratt_acqua_clima_prot_gelo              char(1);
alter table coimaimp add tratt_acqua_clima_prot_gelo_eti          numeric(9,2);
alter table coimaimp add tratt_acqua_clima_prot_gelo_eti_perc     numeric(9,2);
alter table coimaimp add tratt_acqua_clima_prot_gelo_pro          numeric(9,2);
alter table coimaimp add tratt_acqua_clima_prot_gelo_pro_perc     numeric(9,2);
alter table coimaimp add tratt_acqua_calda_sanit_tipo             char(1);
alter table coimaimp add tratt_acqua_calda_sanit_addolc           numeric(9,2);
alter table coimaimp add tratt_acqua_raff_assente                 char(1);
alter table coimaimp add tratt_acqua_raff_tipo_circuito           char(1);
alter table coimaimp add tratt_acqua_raff_origine                 char(1);
alter table coimaimp add tratt_acqua_raff_filtraz_flag            char(1);
alter table coimaimp add tratt_acqua_raff_filtraz_1               char(1);
alter table coimaimp add tratt_acqua_raff_filtraz_2               char(1);
alter table coimaimp add tratt_acqua_raff_filtraz_3               char(1);
alter table coimaimp add tratt_acqua_raff_filtraz_4               char(1);
alter table coimaimp add tratt_acqua_raff_tratt_flag              char(1);
alter table coimaimp add tratt_acqua_raff_tratt_1                 char(1);
alter table coimaimp add tratt_acqua_raff_tratt_2                 char(1);
alter table coimaimp add tratt_acqua_raff_tratt_3                 char(1);
alter table coimaimp add tratt_acqua_raff_tratt_4                 char(1);
alter table coimaimp add tratt_acqua_raff_tratt_5                 char(1);
alter table coimaimp add tratt_acqua_raff_cond_flag               char(1);
alter table coimaimp add tratt_acqua_raff_cond_1                  char(1);
alter table coimaimp add tratt_acqua_raff_cond_2                  char(1);
alter table coimaimp add tratt_acqua_raff_cond_3                  char(1);
alter table coimaimp add tratt_acqua_raff_cond_4                  char(1);
alter table coimaimp add tratt_acqua_raff_cond_5                  char(1);
alter table coimaimp add tratt_acqua_raff_cond_6                  char(1);
alter table coimaimp add tratt_acqua_raff_spurgo_flag             char(1);
alter table coimaimp add tratt_acqua_raff_spurgo_cond_ing         numeric(10,2);
alter table coimaimp add tratt_acqua_raff_spurgo_tara_cond        numeric(10,2);

end;


