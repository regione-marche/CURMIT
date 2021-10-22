create or replace function ah_edit_num(float, integer) returns varchar as '
declare
   nume       alias for $1;
   deci       alias for $2;
   ws_max_val float := 999999999999999.9999999999;
   ws_min_val float := -99999999999999.9999999999;
   risultato  varchar;
   edit_deci  varchar;
begin
   if deci > 10
   then
      return ''Error: max 10 decimali'';
   end if;

   if nume > ws_max_val
   or nume < ws_min_val
   then
      return ''Error: max 14 cifre intere'';
   end if;

   if deci < 1
   or deci is null
   then
      edit_deci := '''';
   else
      edit_deci := ''d''||rpad(''0'',deci,''0'');
   end if;

   risultato := to_char(nume, ''999g999g999g999g990''||edit_deci);
   risultato := translate (risultato,'','',''!'');
   risultato := translate (risultato,''.'','','');
   risultato := translate (risultato,''!'',''.'');
   risultato := trim (risultato);

   return risultato;

end;' language 'plpgsql';

create or replace function ah_edit_num(numeric, integer) returns varchar as '
declare
   nume       alias for $1;
   deci       alias for $2;
   ws_max_val float := 999999999999999.9999999999;
   ws_min_val float := -99999999999999.9999999999;
   risultato  varchar;
   edit_deci  varchar;
begin
   if deci > 10
   then
      return ''Error: max 10 decimali'';
   end if;

   if nume > ws_max_val
   or nume < ws_min_val
   then
      return ''Error: max 14 cifre intere'';
   end if;

   if deci < 1
   or deci is null
   then
      edit_deci := '''';
   else
      edit_deci := ''d''||rpad(''0'',deci,''0'');
   end if;

   risultato := to_char(nume, ''999g999g999g999g990''||edit_deci);
   risultato := translate (risultato,'','',''!'');
   risultato := translate (risultato,''.'','','');
   risultato := translate (risultato,''!'',''.'');
   risultato := trim (risultato);

   return risultato;

end;' language 'plpgsql';

create or replace function ah_replace (varchar, varchar, varchar) returns varchar as '
declare
    string      alias for $1;
    sub         alias for $2;
    replacement alias for $3;
    -- xxxxxxxxxxx[MATCH]xxxxxxxxxxxx
    --           | end_before
    --                   | start_after
    match integer;
    end_before integer;
    start_after integer;
    string_replaced varchar;
    string_remainder varchar;
begin
    string_remainder := string;
    string_replaced := '''';
    match := position(sub in string_remainder);

    while match > 0 loop
        end_before := match - 1;
        start_after := match + length(sub);
        string_replaced := string_replaced || substr(string_remainder, 1, end_before) || replacement;
        string_remainder := substr(string_remainder, start_after);
        match := position(sub in string_remainder);
    end loop;
    string_replaced := string_replaced || string_remainder;

    return string_replaced;
end;
' LANGUAGE 'plpgsql';

create or replace function ah_group__member_p (integer, integer, boolean)
returns boolean as '
declare
  p_party_id               alias for $1;  
  p_group_id               alias for $2;
  p_cascade_membership     alias for $3;
begin
  if p_cascade_membership  then
    return count(*) > 0
      from group_member_map
      where group_id = p_group_id and
            member_id = p_party_id;
  else
    return count(*) > 0
      from acs_rels rels
    where  rels.rel_type = ''membership_rel''
	   and rels.object_id_one = p_group_id
           and rels.object_id_two = p_party_id;
  end if;
end;' language 'plpgsql' stable;

-- calculates net price rounded to two decimal pos
create or replace function ah_net_price(numeric, numeric, numeric, numeric, numeric, numeric, numeric) returns numeric as '
declare
   v_price      alias for $1;
   v_dsc1       alias for $2;
   v_dsc2       alias for $3;
   v_dsc3       alias for $4;
   v_dsc4       alias for $5;
   v_dsc5       alias for $6;
   v_dsc6       alias for $7;

   price      numeric(17, 5);
   dsc1       numeric(5, 2);
   dsc2       numeric(5, 2);
   dsc3       numeric(5, 2);
   dsc4       numeric(5, 2);
   dsc5       numeric(5, 2);
   dsc6       numeric(5, 2);

   int_price  numeric(17, 5);
   net_price  numeric(17, 5);

begin

   price := v_price;

   if v_dsc1 is null 
   then
      dsc1 := 0.00;
   else
      dsc1 := v_dsc1;
   end if;
   if v_dsc2 is null 
   then
      dsc2 := 0.00;
   else
      dsc2 := v_dsc2;
   end if;
   if v_dsc3 is null 
   then
      dsc3 := 0.00;
   else
      dsc3 := v_dsc3;
   end if;
   if v_dsc4 is null 
   then
      dsc4 := 0.00;
   else
      dsc4 := v_dsc4;
   end if;
   if v_dsc5 is null 
   then
      dsc5 := 0.00;
   else
      dsc5 := v_dsc5;
   end if;
   if v_dsc6 is null 
   then
      dsc6 := 0.00;
   else
      dsc6 := v_dsc6;
   end if;

   -- applico gli sconti in cascata   
   net_price := price - price * dsc1 / 100;
   net_price := net_price - net_price * dsc2 / 100;
   net_price := net_price - net_price * dsc3 / 100;
   net_price := net_price - net_price * dsc4 / 100;
   net_price := net_price - net_price * dsc5 / 100;
   net_price := net_price - net_price * dsc6 / 100;

--   net_price := ((price - price * dsc1 / 100) - (price - price * dsc1 / 100) * dsc2 / 100) - ((price - price * dsc1 / 100) - (price - price * dsc1 / 100) * dsc2 / 100) * dsc3 / 100; 

   return net_price;

end;' language 'plpgsql';

create or replace function ah_history_party_name (integer, date)
returns varchar as '
declare

  p_party_id               alias for $1;  
  p_end_date               alias for $2;

  v_party_name             varchar(1000);

begin

      select party_name into v_party_name              
      from mis_party_mod
      where end_date > p_end_date and 
            party_id = p_party_id
      order by end_date 
      limit 1;

    return v_party_name;

end;' language 'plpgsql';

create or replace function ah_doc_number (integer)
returns varchar as '
declare

  p_object_id              alias for $1;  

  v_doc_number             varchar(30);
  v_object_type            varchar(100);

begin

   if p_object_id is null 
   then
      v_doc_number := ''&nbsp;'';
      return v_doc_number;
   end if;      

   select object_type into v_object_type              
   from acs_objects
   where object_id = p_object_id;

   if v_object_type = ''mis_sale_invoice''
   then
       select invoice_num into v_doc_number
       from mis_sale_invoices
       where sale_invoice_id = p_object_id;
   end if;    

   if v_object_type = ''mis_purc_invoice''
   then
       select invoice_num into v_doc_number
       from mis_purc_invoices
       where purc_invoice_id = p_object_id;
   end if;  

   return v_doc_number;

end;' language 'plpgsql';

-- wrapper per accettare anche date come parametro
create or replace function substr(date, integer, integer) returns varchar as $sql$
declare
   dt         alias for $1;
   from_int   alias for $2;
   for_int    alias for $3;
begin

   return substr(dt::text, from_int, for_int);

end;$sql$ language 'plpgsql';

-- wrapper per accettare anche integer come parametro
create or replace function upper(integer) returns varchar as $sql$
declare
   num         alias for $1;
begin

   return upper(num::text);

end;$sql$ language 'plpgsql';

-- wrapper per accettare anche integer come terzo parametro
create or replace function lpad(text, integer, integer) returns varchar as $sql$
declare
   txt        alias for $1;
   num        alias for $2;
   sub        alias for $3;
begin

   return lpad(txt, num, sub::text);

end;$sql$ language 'plpgsql';

-- wrapper per accettare anche integer come primo parametro
create or replace function lpad(integer, integer, text) returns varchar as $sql$
declare
   int        alias for $1;
   num        alias for $2;
   sub        alias for $3;
begin

   return lpad(int::text, num, sub);

end;$sql$ language 'plpgsql';

-- wrapper per accettare anche integer come terzo parametro
create or replace function lpad(integer, integer, integer) returns varchar as $sql$
declare
   int        alias for $1;
   num        alias for $2;
   sub        alias for $3;
begin

   return lpad(int::text, num, sub::text);

end;$sql$ language 'plpgsql';

-- wrapper per accettare anche integer come terzo parametro
create or replace function rpad(text, integer, integer) returns varchar as $sql$
declare
   txt        alias for $1;
   num        alias for $2;
   sub        alias for $3;
begin

   return rpad(txt, num, sub::text);

end;$sql$ language 'plpgsql';

-- wrapper per accettare anche integer come primo parametro
create or replace function rpad(integer, integer, text) returns varchar as $sql$
declare
   int        alias for $1;
   num        alias for $2;
   sub        alias for $3;
begin

   return rpad(int::text, num, sub);

end;$sql$ language 'plpgsql';

-- wrapper per accettare anche integer come terzo parametro
create or replace function rpad(integer, integer, integer) returns varchar as $sql$
declare
   int        alias for $1;
   num        alias for $2;
   sub        alias for $3;
begin

   return rpad(int::text, num, sub::text);

end;$sql$ language 'plpgsql';

--wrapper per accettare timestamp come parametro
create or replace function to_date(timestamptz, text) returns date as $sql$
declare
   dt         alias for $1;
   txt        alias for $2;
begin

   return to_date(to_char(dt, 'YYYY-MM-DD'), txt);

end;$sql$ language 'plpgsql';

