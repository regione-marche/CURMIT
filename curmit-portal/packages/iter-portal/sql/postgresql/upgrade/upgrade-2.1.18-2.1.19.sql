begin;

/* but01 05/03/2024  MEV3 Regione Marche Punto 1: creazione della tabella iter_toponimi  */
\i ../iter_toponimi.sql
\copy  iter_toponimi from ../toponimi-2024-03-06.csv   using delimiters ';' with null as ''

/* but02 08/03/2024 MEV3 Regione Marche Punto 3:
   but02            I dati saranno obbligatori in base a al nuovo campo RETE/EXTRA RETE*/

ALTER TABLE iter_distributors ADD COLUMN f_rete_o_extrarete char(1);

/* but03 11/03/2024  MEV3 Regione Marche Punto 2: creazione della tabella iter_contratti  */
\i ../iter_contratti.sql

-- CHIEDERE A SANDRO SE I CONTRATTI USATI DA REGIONE AMRCHE SONO UGUALI A QUELLI DEGLI ALTRI ENTI !!!!
-- CHIEDERE A SANDRO ANCHE CHE DESCRIZIONE VA MESSA PER OGNI CODICE DI CONTRATTO.
--but01 SU RICHIESTA DI SANDRO I CONTRATI USATI SONO SOLO PER REGIONE MARCHE HO MESSO NEL UPGRADE I VECHIE VALORI DI CONTRATTI
--but01 SU RICHIESTA DI SANDRO LA DESCRIZIONE VA MESSA PER OGNI CODICE DI CONTRATTO DEVE ESSERE VUOTA PER REGIONE AMRCHE.

/*insert into iter_contratti (codice_contratto, tipo_contratto) values ('C1', 'Riscaldamento');
insert into iter_contratti (codice_contratto, tipo_contratto) values ('C2', 'Uso cottura cibi e/e produzione di acqua calda sanitaria');
insert into iter_contratti (codice_contratto, tipo_contratto) values ('C3', 'Riscaldamento individuale + uso cottura cibi e/e produzione di acqua calda sanitaria');
insert into iter_contratti (codice_contratto, tipo_contratto) values ('C4', 'Uso condizionamente');
insert into iter_contratti (codice_contratto, tipo_contratto) values ('C5', 'Uso condizionamente + riscaldamente');
insert into iter_contratti (codice_contratto, tipo_contratto) values ('T1', 'Uso tecnologico(artigianale industriale)');
insert into iter_contratti (codice_contratto, tipo_contratto) values ('T2',  'Uso tecnologico + riscaldamente');
insert into iter_contratti (codice_contratto, tipo_contratto) values ('C6', 'Altro: Energia elettrica e Teleriscaldamento');*/
insert into iter_contratti values('C1A1','');
insert into iter_contratti values('C1B1','');
insert into iter_contratti values('C1C1','');
insert into iter_contratti values('C1D1','');
insert into iter_contratti values('C1E1','');
insert into iter_contratti values('C1F1','');
insert into iter_contratti values('C2X1','');
insert into iter_contratti values('C3A1','');
insert into iter_contratti values('C3B1','');
insert into iter_contratti values('C3C1','');
insert into iter_contratti values('C3D1','');
insert into iter_contratti values('C3E1','');
insert into iter_contratti values('C3F1','');
insert into iter_contratti values('C4X1','');
insert into iter_contratti values('C5A1','');
insert into iter_contratti values('C5B1','');
insert into iter_contratti values('C5C1','');
insert into iter_contratti values('C5D1','');
insert into iter_contratti values('C5E1','');
insert into iter_contratti values('C5F1','');
insert into iter_contratti values('T1X1','');
insert into iter_contratti values('T1X2','');
insert into iter_contratti values('T1X3','');
insert into iter_contratti values('T2A1','');
insert into iter_contratti values('T2B1','');
insert into iter_contratti values('T2C1','');
insert into iter_contratti values('T2D1','');
insert into iter_contratti values('T2E1','');
insert into iter_contratti values('T2F1','');
insert into iter_contratti values('T2A2','');
insert into iter_contratti values('T2B2','');
insert into iter_contratti values('T2C2','');
insert into iter_contratti values('T2D2','');
insert into iter_contratti values('T2E2','');
insert into iter_contratti values('T2F2','');
insert into iter_contratti values('T2A3','');
insert into iter_contratti values('T2B3','');
insert into iter_contratti values('T2C3','');
insert into iter_contratti values('T2D3','');
insert into iter_contratti values('T2E3','');
insert into iter_contratti values('T2F3','');


/* but04 11/03/2024  MEV3 Regione Marche Punto 4: creazione della tabella iter_combustibili  */
\i ../iter_combustibili.sql

insert into iter_combustibili (codice_combustibile, tipo_combustibile) values (1, 'Gas naturale');
insert into iter_combustibili (codice_combustibile, tipo_combustibile) values (2, 'Gpl');
insert into iter_combustibili (codice_combustibile, tipo_combustibile) values (3, 'Gasolio');
insert into iter_combustibili (codice_combustibile, tipo_combustibile) values (4, 'Olio combustibile');
insert into iter_combustibili (codice_combustibile, tipo_combustibile) values (5, 'Propane');
insert into iter_combustibili (codice_combustibile, tipo_combustibile) values (6, 'Butano');
insert into iter_combustibili (codice_combustibile, tipo_combustibile) values (7, 'Biogas');
insert into iter_combustibili (codice_combustibile, tipo_combustibile) values (8, 'Aria propanata');
insert into iter_combustibili (codice_combustibile, tipo_combustibile) values (9, 'Kerosene');
insert into iter_combustibili (codice_combustibile, tipo_combustibile) values (10, 'Olio vegetale');
insert into iter_combustibili (codice_combustibile, tipo_combustibile) values (11, 'Biodiesel');
insert into iter_combustibili (codice_combustibile, tipo_combustibile) values (12, 'Energia Elletrica');
insert into iter_combustibili (codice_combustibile, tipo_combustibile) values (13, 'Teleriscaldamento');
insert into iter_combustibili (codice_combustibile, tipo_combustibile) values (14, 'Altro');

\i ../iter_supplies_sync.sql

end;
