begin;

create or replace view mis_fast_scripts as 
    select s.*
         , o.*
         , tree_level(o.tree_sortkey) -2 as level
    from mis_scripts s, acs_objects o
    where s.script_id = o.object_id;

update mis_scripts set
    description = 'Anagrafiche'
where script_id = (select script_id from mis_fast_scripts where title = 'mis-base');

update mis_scripts set
    description = 'Magazzino'
where script_id = (select script_id from mis_fast_scripts where title = 'mis-wh');

update mis_scripts set
    description = 'Acquisti'
where script_id = (select script_id from mis_fast_scripts where title = 'mis-purc');

update mis_scripts set
    description = 'Vendite'
where script_id = (select script_id from mis_fast_scripts where title = 'mis-sales');

update mis_scripts set
    description = 'Amministrazione'
where script_id = (select script_id from mis_fast_scripts where title = 'mis-acct');

update mis_scripts set
    description = 'Cespiti'
where script_id = (select script_id from mis_fast_scripts where title = 'mis-assets');

update mis_scripts set
    description = 'Progetti'
where script_id = (select script_id from mis_fast_scripts where title = 'mis-proj');

update mis_scripts set
    description = 'Distinta Base'
where script_id = (select script_id from mis_fast_scripts where title = 'mis-bom');

update mis_scripts set
    description = 'Gestione Soci'
where script_id = (select script_id from mis_fast_scripts where title = 'mis-clubs');

update acs_objects set
    security_inherit_p = 'f'
where object_id = (select script_id from mis_fast_scripts where title = 'mis-base');

update acs_objects set
    security_inherit_p = 'f'
where object_id = (select script_id from mis_fast_scripts where title = 'mis-wh');

update acs_objects set
    security_inherit_p = 'f'
where object_id = (select script_id from mis_fast_scripts where title = 'mis-purc');

update acs_objects set
    security_inherit_p = 'f'
where object_id = (select script_id from mis_fast_scripts where title = 'mis-sales');

update acs_objects set
    security_inherit_p = 'f'
where object_id = (select script_id from mis_fast_scripts where title = 'mis-acct');

update acs_objects set
    security_inherit_p = 'f'
where object_id = (select script_id from mis_fast_scripts where title = 'mis-assets');

update acs_objects set
    security_inherit_p = 'f'
where object_id = (select script_id from mis_fast_scripts where title = 'mis-proj');

update acs_objects set
    security_inherit_p = 'f'
where object_id = (select script_id from mis_fast_scripts where title = 'mis-bom');

update acs_objects set
    security_inherit_p = 'f'
where object_id = (select script_id from mis_fast_scripts where title = 'mis-clubs');

end;
