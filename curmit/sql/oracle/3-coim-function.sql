CREATE OR REPLACE PACKAGE iter_edit AS

   FUNCTION num
     (nume  in number
     ,deci  in number default 0
     )
     return varchar2;
  
   FUNCTION data
     (data_in in date
     )
     return varchar2;

   FUNCTION time
     (time_in in varchar2
     )
     return varchar2;

END iter_edit;
/
show error package iter_edit;

CREATE OR REPLACE PACKAGE BODY iter_edit AS

  FUNCTION num
     (nume  in number
     ,deci  in number default 0
     )
     return varchar2
  IS
     risultato varchar2(31);
     edit_deci varchar2(11);

  BEGIN -- num

     if deci > 10 then
        return 'Error: max 10 decimali';
     end if;

     if nume > 999999999999999.9999999999
     or nume < -99999999999999.9999999999
     then
        return 'Error';
     end if;

     if deci < 1
     or deci is null then
        edit_deci := '';
     else
        edit_deci := 'd'||rpad(0,deci,0);
     end if;
     risultato := to_char(nume, '999g999g999g999g990'||edit_deci);
     risultato := translate (risultato,',','!');
     risultato := translate (risultato,'.',',');
     risultato := translate (risultato,'!','.');
     risultato := trim (risultato);
   
     return risultato;
  END num;

  -- --------------

  FUNCTION data
     (data_in in date
     )
     return  varchar2
  IS
     data_out varchar2(10);

  BEGIN -- date

     data_out := to_char(data_in,'DD/MM/YYYY');
     
     return data_out;
  
  END data;
       
  -- --------------

  FUNCTION time
     (time_in in varchar2
     )
     return  varchar2
  IS
     time_out varchar2(05);

  BEGIN -- time

     time_out := substr(time_in,1,5);
     
     return time_out;
  
  END time;
       
END iter_edit;
/
show error package body iter_edit;

-- funzione per calcolare la data scadenza del modello F e modello G 
-- per ora recupero il periodo di scadenza dalla tabella coimtgen sia per il mod G
-- che per il modello F, nella funzione richiedo anche il codice ipianto per poter
-- stabilire se l'impianto è con potenza < o > a 35 kW  per poi 
-- utilizzare l'intervallo corretto di tempo per creare la data scadenza del modello di 
-- autocertificazione corretto.
CREATE OR REPLACE PACKAGE iter_get AS

   FUNCTION dt_scad
     (data_documento in varchar2
     ,cod_imp        in varchar2
     )
     return varchar2;
END iter_get;
/
show error package iter_edit;

CREATE OR REPLACE PACKAGE BODY iter_get AS

   FUNCTION dt_scad
     (data_documento in varchar2
     ,cod_imp        in varchar2
     )
     return varchar2
   IS
     data_scadenza    varchar2(08);
     mesi_validita_g  number(08);
     mesi_validita_f  number(08);
     potenza          number(9,2);
     data_doc         date;   
  BEGIN 
     data_doc        := to_date(data_documento, 'YYYYMMDD');
     select valid_mod_h into mesi_validita_g  from coimtgen where cod_tgen = 1;
     select valid_mod_h_b into mesi_validita_f from coimtgen where cod_tgen = 1;
     select a.potenza into potenza  from coimaimp a where a.cod_impianto = cod_imp;
     if potenza >= 35
     then
         data_scadenza :=  to_char(add_months(data_doc, + to_number(mesi_validita_f,99999990)), 'YYYYMMDD');
     else
         data_scadenza :=  to_char(add_months(data_doc, + to_number(mesi_validita_g,99999990)), 'YYYYMMDD');
     end if;
     return data_scadenza;
  END dt_scad;
END iter_get;
/
show error package body iter_get;
