-- 
--
-- Create tables for maps 
--
-- 

-- Stores geo info about any entity, even if it's not an acs_object, using as position_id
-- the primary key of the object being mapped
create table maps_positions (
   position_id 		    integer primary key, 
   -- entity 
   name 		    varchar not null, 
   address		    varchar not null,
   -- anchor tag to the add-edit script (MUST be syntactically correct!)
   edit_url                 varchar not null,
   -- geo
   lat			    varchar not null, 
   lng 			    varchar not null, 
   center 		    varchar,
   zoom 		    integer
);

-- errori bulk geocoding
create table maps_positions_errors (
    position_id	            integer primary key,
    status                  varchar,
    address                 varchar
);
