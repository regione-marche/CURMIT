begin;

/* LUCA R. 02/11/2020 Alla tabella coimdimp_stn mancava la colonna co_fumi_secchi_ppn  presente invece in coimdimp.
                      Questo causava l'errore nell'inserimento dell'RCEE Sostitutivo che storna l'RCEE normale.
                      Anche se la funzione e' poco utilizzata le 2 tabelle devono sempre essere uguali per evitare problemi.
*/

alter table coimdimp_stn add column co_fumi_secchi_ppm decimal(10,4);

end;
