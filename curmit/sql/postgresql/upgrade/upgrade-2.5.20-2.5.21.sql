
begin;

--Simone/Sandro 20/04/2015 Nuove colonne per nuovo rapporto di ispezione (coimcimp)

alter table coimcimp add potenza_effettiva_nom 	   numeric (10,2);
alter table coimcimp add potenza_effettiva_util    numeric (10,2);
alter table coimcimp add interna_locale_idoneo     char(1);
alter table coimcimp add esterna_generatore_idoneo char(1);
alter table coimcimp add canale_fumo_idoneo 	   char(1);
alter table coimcimp add ventilazione_locali 	   char(1);
alter table coimcimp add areazione_locali 	   char(1);
alter table coimcimp add ventilazione_locali_mis   numeric (10,2);
alter table coimcimp add verifica_disp_regolazione char(1) ; -- (P Positiva, A assente , N negativa, F Non funzionate  C non conforrme)
alter table coimcimp add frequenza_manut  	   char(1) ; -- (S Semestrale, A Annuale , B Biennale, T Altro )
alter table coimcimp add rcee_inviato  		   char(1);
alter table coimcimp add rcee_osservazioni  	   char(1);
alter table coimcimp add rcee_raccomandazioni  	   char(1);
alter table coimcimp add misurazione_rendimento    char(1);
alter table coimcimp add check_valvole  	   char(1);
alter table coimcimp add check_isolamento  	   char(1);
alter table coimcimp add check_trattamento  	   char(1);
alter table coimcimp add check_regolazione  	   char(1);
alter table coimcimp add dimensionamento_gen 	   char(1); -- (S corretto, N Non corretto, C non controllabile)
alter table coimcimp add esito_periodicita 	   char(1);
alter table coimcimp add mod_verde  		   char(1);
alter table coimcimp add mod_rosa 		   char(1);
alter table coimcimp add frequenza_manut_altro 	   numeric(4,0);
alter table coimcimp add potenza_nom_tot_foc  	   numeric (10,2);
alter table coimcimp add potenza_nom_tot_util 	   numeric (10,2);
alter table coimcimp add tratt_in_risc        	   char(2);
alter table coimcimp add tratt_in_acs         	   char(2);
alter table coimcimp add docu_152            	   char(1);
alter table coimcimp add auto_adeg_152        	   char(1);
alter table coimcimp add dich_152_presente    	   char(1); 


end;
