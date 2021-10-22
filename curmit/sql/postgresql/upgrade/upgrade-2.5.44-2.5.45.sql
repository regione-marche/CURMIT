-- Simone 10/03/2017

begin;

--Aggiunto patentino sui manutentori
alter table coimmanu add patentino_fgas                    boolean not null default 'f';

end;
