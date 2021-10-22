
begin;

--Sandro 10/06/2015 Nuove colonne per nuovo rapporto di ispezione per firenze
alter table coimcimp add ass_perdite_comb char(1);
alter table coimcimp alter column new1_co_rilevato type numeric(7,2);

end;
