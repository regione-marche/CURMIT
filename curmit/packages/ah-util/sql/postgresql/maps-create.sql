--
-- Create tables for maps 
--

CREATE TABLE ah_maps (
  map_id		integer primary key,
  parent_id 		integer,
  name 			varchar(50) NOT NULL,
  package_id 		integer NOT NULL
);

CREATE TABLE ah_maps_position (
   position_id 		integer primary key, 
   map_id 		integer NOT NULL REFERENCES ah_maps(map_id), 
   name 		varchar(50) NOT NULL, 
   lat 			varchar(30) NOT NULL, 
   lng 			varchar(30) NOT NULL, 
   center 		varchar(50),
   zoom 		integer,
   text_info		text, 
   type                 varchar(100),
   object_id            integer
);

CREATE TABLE ah_maps_objects (
   object_type 		varchar(1000) REFERENCES acs_object_types(object_type),
   package_id 		integer REFERENCES apm_packages(package_id),
   color 		varchar(30),
   PRIMARY KEY (object_type, package_id)
);

select acs_object_type__create_type(
        'ah_maps',
        'Oasisoftware Maps',
        'Oasisoftware Maps',
        'acs_object',
        'ah_maps',
        'map_id',
        null,
        'f',
        null,
        'ah_maps__title'
);

select acs_object_type__create_type(
        'ah_maps_position',
        'Oasisoftware Maps Position',
        'Oasisoftware Maps Positions',
        'acs_object',
        'ah_maps_position',
        'position_id',
        null,
        'f',
        null,
        'ah_maps_position__title'
);

CREATE OR REPLACE FUNCTION ah_maps__new(integer, integer, varchar, integer, timestamptz, integer, varchar, integer)
  RETURNS integer AS
'
declare
    p_map_id                    alias for $1;
    p_parent_id                 alias for $2;
    p_name                      alias for $3;
    p_package_id                alias for $4;
    p_creation_date             alias for $5;
    p_creation_user             alias for $6;
    p_creation_ip               alias for $7;
    p_context_id                alias for $8;
    v_map_id                    ah_maps.map_id%TYPE;
begin
    v_map_id := acs_object__new (
                           p_map_id,
                           ''ah_maps'',
                           p_creation_date,
                           p_creation_user,
                           p_creation_ip,
                           p_context_id,
                           ''t'');

    INSERT INTO ah_maps (map_id,parent_id,name,package_id)
    VALUES (v_map_id,p_parent_id,p_name,p_package_id);

    return v_map_id;
end;'
  LANGUAGE 'plpgsql' VOLATILE;                   

CREATE OR REPLACE FUNCTION ah_maps_position__new(integer, integer, varchar, varchar, varchar, varchar, varchar, integer, timestamptz, integer, varchar, integer, varchar, integer)
  RETURNS integer AS
'
declare
    p_position_id               alias for $1;
    p_map_id                    alias for $2;
    p_name                      alias for $3;
    p_positionY                 alias for $4;
    p_positionX                 alias for $5;
    p_text_info                 alias for $6;
    p_type                      alias for $7;
    p_object_id                 alias for $8;
    p_creation_date             alias for $9;
    p_creation_user             alias for $10;
    p_creation_ip               alias for $11;
    p_context_id                alias for $12;
    p_center			alias for $13;
    p_zoom			alias for $14;
    v_position_id               ah_maps_position.position_id%TYPE;
begin

    v_position_id := acs_object__new (
                           p_position_id,
                           ''maps_position'',
                           p_creation_date,
                           p_creation_user,
                           p_creation_ip,
                           p_context_id,
                           ''t'');

    INSERT INTO maps_position (position_id,map_id,name,lat,lng,text_info,type,object_id,center,zoom)
    VALUES (v_position_id,p_map_id,p_name,p_positionY,p_positionX,p_text_info,p_type,p_object_id,p_center,p_zoom);

    return v_position_id;
end;'
  LANGUAGE 'plpgsql';  

CREATE OR REPLACE FUNCTION ah_maps_position__edit(integer, varchar, varchar, varchar, varchar,varchar,integer)
  RETURNS integer AS
'
declare
    p_position_id               alias for $1;
    p_name                      alias for $2;
    p_lat           		alias for $3;
    p_lng                 	alias for $4;
    p_text_info                 alias for $5;
    p_center			alias for $6;
    p_zoom			alias for $7;
begin

    UPDATE ah_maps_position SET 
        name      = p_name,
        lat       = p_lat, 
        lng       = p_lng, 
        text_info = p_text_info,
	center    = p_center,
	zoom      = p_zoom
    WHERE position_id = p_position_id;

    return p_position_id;
end;'
  LANGUAGE 'plpgsql';
 
CREATE OR REPLACE FUNCTION ah_maps_position__del(integer)
  RETURNS integer AS
'
declare
    p_position_id               alias for $1;
    v_position_id               ah_maps_position.position_id%TYPE;
begin
    perform acs_object__delete(p_position_id);

    return 0;

end;'
  LANGUAGE 'plpgsql' VOLATILE;  

--Removal functions
CREATE OR REPLACE FUNCTION ah_maps__maps_dtrg() RETURNS TRIGGER AS 
'
DECLARE

BEGIN
	DELETE FROM ah_maps_position
	WHERE map_id = old.map_id;

	RETURN new;
END;'
 LANGUAGE 'plpgsql';

CREATE TRIGGER ah_maps_dtrg BEFORE DELETE ON ah_maps
FOR EACH ROW EXECUTE PROCEDURE ah_maps__maps_dtrg();

CREATE OR REPLACE FUNCTION ah_maps__remove(INTEGER) RETURNS BOOLEAN AS
'
DECLARE
	p_map_id				alias for $1;
BEGIN
	DELETE FROM ah_maps
	WHERE map_id = p_map_id;

	RETURN 1;
END;'
 LANGUAGE 'plpgsql';
