-- Nicola 14/06/2016

begin;

alter table iter_maintainers add pec varchar(150);

drop view iter_maintainers_view;

create view iter_maintainers_view as
        select m.*, 
               ah_edit_num(op_number, 0) as op_number_pretty, 
               ah_edit_num(an_number, 0) as an_number_pretty, 
               ah_edit_num(de_number, 0) as de_number_pretty, 
               ah_edit_num(capital, 2) as capital_pretty, 
               case 
                 when m.role = '0' then 'Installatore' 
                 when m.role = '0' then 'Manutentore' 
                 else 'Installatore/Manutentore' 
               end as role_pretty, 
               p.name as rep_name, 
               p.first_name as rep_first_name, 
               p.address1 as rep_address1, 
               p.city as rep_city, 
               p.address2 as rep_address2, 
               p.province as rep_province, 
               p.zipcode as rep_zipcode, 
               p.fiscal_code as rep_fiscal_code
          from iter_maintainers m
             , iter_parties     p
         where m.representative_id = p.party_id;

end;
