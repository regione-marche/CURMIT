-- Deletion script

-- delete mis_script  objects
create function inline_0 ()
returns integer as '
declare
    v_object RECORD;
begin
        for v_object in select object_id from acs_objects where object_type = ''mis_script'' order by object_id desc
        LOOP
                PERFORM acs_object__delete(v_object.object_id);
        end loop;
    return 0;
end;
' language 'plpgsql';

select inline_0();
drop function inline_0();

-- drop table
drop table mis_scripts cascade;

-- drop mis_script type
select acs_object_type__drop_type('mis_script', 't');

-- remove children
select acs_privilege__remove_child('admin','exec');

-- drop privilege
select acs_privilege__drop_privilege('exec');

-- drop function ah_edit_num(float, integer);
