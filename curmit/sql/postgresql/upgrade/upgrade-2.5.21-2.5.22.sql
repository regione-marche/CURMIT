
begin;

--Sandro 10/06/2015 Nuove colonne per nuovo rapporto di ispezione per firenze
alter table coimcimp add delega_pres          char(1);
alter table coimcimp add controllo_cucina     char(1);
alter table coimcimp add norm_7a              char(1);
alter table coimcimp add norm_9a              char(1);
alter table coimcimp add norm_9b              char(1);
alter table coimcimp add norm_9c              char(1);
alter table coimcimp add deve_non_messa_norma char(1);
alter table coimcimp add deve_non_rcee        char(1);
alter table coimcimp add rimanere_funzione    char(1);
alter table coimcimp add pagamento_effettuato char(1);
alter table coimcimp add check_sostituzione   char(1);
alter table coimcimp add check_scambiatori    char(1);
alter table coimcimp add check_eccesso_aria   char(1);
alter table coimcimp add check_altro          char(1);

end;
