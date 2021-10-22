-- 
-- @author  Claudio
-- @creation-date 2008-10-31
-- @cvs-id $Id: sync.sql,v 1.1.1.1 2014/03/06 15:04:07 nsadmin Exp $
--

--select acs_privilege__add_child('exec','read');

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
