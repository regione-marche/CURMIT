-- ---------------------------------------------------------
--
-- mis_script acs object
--
-- ---------------------------------------------------------
select acs_object_type__create_type ( 
       'mis_script',        -- object_type
       'Script',            -- pretty_name
       'Scripts',           -- pretty_plural
       'acs_object',        -- supertype 
       'mis_scripts',       -- table_name
       'script_id',         -- id_column
       null,                -- package_name (default)
       'f',	            -- abstract_p (default)
       null,	            -- type_extension_table (default)
       null		    -- name_method (default)
);


-- tabella dei programmi
-- notare che il nome del programma (title) e il parent gerarchico del programma (context_id)
-- sono gestiti nella tabella acs_objects
CREATE TABLE mis_scripts (
	script_id	 integer PRIMARY KEY NOT NULL CONSTRAINT mis_scripts_script_id_fkey REFERENCES acs_objects (object_id),
        description      text,
	original_author	 integer CONSTRAINT mis_scripts_fk1 REFERENCES users (user_id),
	maintainer	 integer CONSTRAINT mis_scripts_fk2 REFERENCES users (user_id),
	is_active_p	 boolean,
	is_executable_p	 boolean
);

create view mis_fast_scripts as 
    select s.*
         , o.*
         , tree_level(o.tree_sortkey) -2 as level
    from mis_scripts s, acs_objects o
    where s.script_id = o.object_id;
