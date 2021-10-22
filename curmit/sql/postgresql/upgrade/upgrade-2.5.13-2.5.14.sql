-- Nicola, 26/06/2014 per dpr 74

begin;

alter table coimdimp add rct_modulo_termico varchar(08);

-- Sistemo i dati che sono finiti nei campi sbagliati a causa dell'errore ora corretto su
-- coimdimp-rct-gest (RCEE TIPO 1 - GRUPPI TERMICI - flag_tracciato = 'R1')

-- Ho preferito farli a mano previo select di controllo, li lascio solo per documentazione
--update coimdimp
--   set rct_modulo_termico = rct_rend_min_legge::integer::varchar
-- where flag_tracciato = 'R1';

--update coimdimp
--   set rct_rend_min_legge = rend_combust
-- where flag_tracciato = 'R1';

end;
