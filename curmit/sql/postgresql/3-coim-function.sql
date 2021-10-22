create function iter_edit_num(float, integer) returns varchar as '
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
      edit_deci := ''d''||rpad(0,deci,0);
   end if;

   risultato := to_char(nume, ''999g999g999g999g990''||edit_deci);
   risultato := translate (risultato,'','',''!'');
   risultato := translate (risultato,''.'','','');
   risultato := translate (risultato,''!'',''.'');
   risultato := trim (risultato);

   return risultato;

end;' language 'plpgsql';

-- function per editare una data
create function iter_edit_data(date) returns varchar as '
declare
   data_in   alias for $1;
   data_out  varchar;
begin
   data_out  := to_char(data_in,''DD/MM/YYYY'');
   return data_out;
end;' language 'plpgsql';

-- se non faccio questa function, potrei richiamare la function precedenti
-- anche con valori varchar, ed in tal caso postgres cerca di convertire
-- il valore varchar in date inventandosi date assurde se il varchar non
-- contiene una data.
-- questa function permette di verificare se la data va bene e solo in tal
-- caso di editarla!
create function iter_edit_data(varchar) returns varchar as '
declare
   data_in   alias for $1;
   data_ws   date;
   data_form varchar;
   data_test varchar;
   data_out  varchar;
begin
   if length(data_in) = 8
   then
      data_form := ''YYYYMMDD'';
   else
      data_form := ''YYYY-MM-DD'';
   end if;

   data_ws   := to_date(data_in,data_form);
   data_test := to_char(data_ws,data_form);
   if data_test <> data_in
   then
      return ''Error: date not valid'';
   end if;
   data_out  := iter_edit_data(data_ws);
   return data_out;
end;' language 'plpgsql';


-- function per editare un time
create function iter_edit_time(time) returns varchar as '
declare
   time_in   alias for $1;
   time_out  varchar;
begin
   time_out  := to_char(time_in,''hh24:mi'');
   return time_out;
end;' language 'plpgsql';

-- function per editare un timestamp
create function iter_edit_time(timestamp) returns varchar as '
declare
   time_in   alias for $1;
   time_out  varchar;
begin
   time_out  := to_char(time_in,''hh24:mi'');
   return time_out;
end;' language 'plpgsql';

-- se non faccio questa function, potrei richiamare la function precedenti
-- anche con valori varchar, ed in tal caso postgres cerca di convertire
-- il valore varchar in time inventandosi date assurde se il varchar non
-- contiene una data.
-- questa function permette di verificare se il time va bene e solo in tal
-- caso di editarlo!
create function iter_edit_time(varchar) returns varchar as '
declare
   time_in    alias for $1;
   time_trunc varchar;
   time_ws    timestamp;
   time_test  varchar;
   time_out   varchar;
begin
   time_trunc := substr(time_in,1,5);
   time_ws    := to_timestamp(time_trunc,''hh24:mi'');
   time_test  := to_char(time_ws,''hh24:mi'');
   if time_test <> time_trunc
   then
      return ''Error: time not valid'';
   end if;
   time_out  := iter_edit_time(time_ws);
   return time_out;
end;' language 'plpgsql';


-- funzione per calcolare la data scadenza del modello F e modello G 
-- per ora recupero il periodo di scadenza dalla tabella coimtgen sia per il mod G
-- che per il modello F, nella funzione richiedo anche il codice ipianto per poter
-- stabilire se l'impianto è con potenza < o > a 35 kW  per poi 
-- utilizzare l'intervallo corretto di tempo per creare la data scadenza del modello di 
-- autocertificazione corretto.

create function iter_get_dt_scad(varchar, varchar) returns date as '
declare
   data_documento   alias for $1;
   cod_impianto     alias for $2;
   data_scadenza    date;
   mesi_validita_g  numeric(08);
   mesi_validita_f  numeric(08);
   potenza          numeric(9,2);
   data_doc         date;
begin
   data_doc        := to_date(data_documento, ''YYYYMMDD'');
   mesi_validita_g := valid_mod_h from coimtgen where cod_tgen = 1;
   mesi_validita_f := valid_mod_h_b from coimtgen where cod_tgen =1;
   potenza         := a.potenza from coimaimp a where a.cod_impianto = cod_impianto;
   if potenza >= 35.00
   then
       data_scadenza :=  to_char(add_months(data_doc, + to_number(mesi_validita_f,99999990)), ''YYYYMMDD'');
   else
       data_scadenza :=  to_char(add_months(data_doc, + to_number(mesi_validita_g,99999990)), ''YYYYMMDD'');
   end if;
   return data_scadenza;
end;' language 'plpgsql';


