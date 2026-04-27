begin;

/* ROM 20/11/2023 Aggiunto campo per path disciplinare bollini per Napoli */

alter table iter_maintainers add column path_disciplinare_bollini varchar(250);

end;
