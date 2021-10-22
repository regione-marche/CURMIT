drop trigger trig_coimcitt_st on coimcitt;
create or replace function coimcitt_st_tr() returns trigger
as '
declare
st_ope coimcitt_st.st_operazione%TYPE;
begin
IF (TG_OP = ''DELETE'') THEN
	 st_ope := ''C'';
 END IF;
IF (TG_OP = ''UPDATE'') THEN
	 st_ope := ''M'';
 END IF;
IF (TG_OP = ''INSERT'') THEN
	 st_ope = ''I'';
 END IF;
--
IF (TG_OP = ''UPDATE'') or  (TG_OP = ''DELETE'') THEN 
insert into coimcitt_st (
 cod_cittadino,    
 natura_giuridica, 
 cognome,          
 nome,             
 indirizzo,        
 numero,           
 cap,              
 localita,         
 comune,           
 provincia,        
 cod_fiscale,      
 cod_piva,         
 telefono,         
 cellulare,        
 fax,              
 email,            
 data_nas,         
 comune_nas,       
 utente,           
 data_ins,         
 data_mod ,        
 utente_ult,       
 note,
 --st_progressivo
 st_utente,
 st_operazione,
 st_data_validita          
        )  values (
 OLD.cod_cittadino,    
 OLD.natura_giuridica, 
 OLD.cognome,          
 OLD.nome,             
 OLD.indirizzo,        
 OLD.numero,           
 OLD.cap,              
 OLD.localita,         
 OLD.comune,           
 OLD.provincia ,       
 OLD.cod_fiscale,      
 OLD.cod_piva,         
 OLD.telefono,         
 OLD.cellulare,        
 OLD.fax,              
 OLD.email,            
 OLD.data_nas,         
 OLD.comune_nas,       
 OLD.utente,           
 OLD.data_ins,         
 OLD.data_mod,         
 OLD.utente_ult,       
 OLD.note,
 --null
 NEW.utente_ult,
 st_ope, 
 current_timestamp
 );
END IF;
  return new;
end;
' language 'plpgsql';
create trigger trig_coimcitt_st after update on coimcitt
for each row
execute procedure coimcitt_st_tr ();

