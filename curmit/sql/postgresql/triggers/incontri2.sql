drop trigger trig_coiminco_st on coiminco;
create or replace function coiminco_st_tr() returns trigger
as '
declare
st_ope coiminco_st.st_operazione%TYPE;
begin
IF (TG_OP = ''DELETE'') THEN
	 st_ope := ''C'';
 END IF;
IF (TG_OP = ''UPDATE'') THEN
	 st_ope := ''M'';
 END IF;

--
IF (TG_OP = ''UPDATE'') or  (TG_OP = ''DELETE'') THEN 
insert into coiminco_st (
 cod_inco,         
 cod_cinc,         
 tipo_estrazione, 
 cod_impianto,     
 data_estrazione,  
 data_assegn,    
 cod_opve,  
 data_verifica, 
 ora_verifica,  
 data_avviso_01,  
 cod_documento_01, 
 data_avviso_02,
 cod_documento_02, 
 stato,          
 esito,          
 note,            
 data_ins,       
 data_mod,         
 utente,           
 tipo_lettera,     
 cod_noin, 
 --st_progressivo,
 st_utente,
 st_operazione,
 st_data_validita          
        )  values (
 OLD.cod_inco,         
 OLD.cod_cinc,         
 OLD.tipo_estrazione, 
 OLD.cod_impianto,     
 OLD.data_estrazione,  
 OLD.data_assegn,    
 OLD.cod_opve,  
 OLD.data_verifica, 
 OLD.ora_verifica,  
 OLD.data_avviso_01,  
 OLD.cod_documento_01, 
 OLD.data_avviso_02,
 OLD.cod_documento_02, 
 OLD.stato,          
 OLD.esito,          
 OLD.note,            
 OLD.data_ins,       
 OLD.data_mod,         
 OLD.utente,           
 OLD.tipo_lettera,     
 OLD.cod_noin, 
 --null,
 NEW.utente,
 st_ope, 
 current_timestamp
 );
END IF;

  return new;
end;
' language 'plpgsql';
create trigger trig_coiminco_st after update on coiminco
for each row
execute procedure coiminco_st_tr ();
 

