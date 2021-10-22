begin;
--04/04/2019 Luca R. create e insert delle tabelle per gestione delle abilitazioni su cui opera l'impresa.

-- con questo upgrade va visto con gli enti come prevalorizzare la coimtpin_manu in modo da poter far lavorare i manutentori già presenti.

\i ../coimtpin.sql

insert into  coimtpin  
     values (1
            ,'CALDO_GAS_LIQ'
            ,'Impianti dotati di gruppi termici o caldaie alimentati da combustibili gassosi o liquidi'
	    );
insert into  coimtpin
     values (2
     	    ,'CALDO_SOLIDI'
	    ,'Impianti dotati di gruppi termici o caldaie alimentati da combustibili solidi/biomasse legnose'
	    );
insert into  coimtpin
     values (3
     	    ,'FREDDO_SOLIDI_LIQ'
	    ,'Impianti dotati di macchine frigorifere/pompe di calore non alimentate a gas'
	    );
insert into  coimtpin
     values (4
     	    ,'TELERISCALDAMENTO'
	    ,'Impianti di teleriscaldamento/teleraffrescamento'
	    );
insert into  coimtpin
     values (5
     	    ,'COGENERATORI'
	    ,'Cogeneratori/Trigeneratori'
	    );
insert into  coimtpin
     values (6
     	    ,'CAMPI_SOLARI'
	    ,'Campi solari termici'
 	    );
insert into  coimtpin
     values (7
     	    ,'ALTRO'
	    ,'Altre tipologie di generatori'
	    );
insert into  coimtpin
     values (8
      	    ,'FREDDO_GAS'
	    ,'Impianti dotati di macchine frigorifere/pompe di calore alimentate a gas'
	    );

\i ../coimtpin_manu.sql

\i ../coimtpin_abilitazioni.sql

insert into coimtpin_abilitazioni
          ( cod_tpin_abil
          , cod_coimtpin
          , flag_tipo_impianto
          , tipo_combustibile
          ) values
          ( 1
          , 1
          , 'R'
          , 'G'
          ) ;
insert into coimtpin_abilitazioni
          ( cod_tpin_abil
          , cod_coimtpin
          , flag_tipo_impianto
          , tipo_combustibile
          ) values
          ( 2
          , 1
          , 'R'
          , 'L'
          ) ;
insert into coimtpin_abilitazioni
          ( cod_tpin_abil
          , cod_coimtpin
          , flag_tipo_impianto
          , tipo_combustibile
          ) values
          ( 3
          , 2
          , 'R'
          , 'S'
          ) ;
insert into coimtpin_abilitazioni
          ( cod_tpin_abil
          , cod_coimtpin
          , flag_tipo_impianto
          , tipo_combustibile
          ) values
          ( 4
          , 3
          , 'F'
          , 'L'
          ) ;
insert into coimtpin_abilitazioni
          ( cod_tpin_abil
          , cod_coimtpin
          , flag_tipo_impianto
          , tipo_combustibile
          ) values
          ( 5
          , 4
          , 'T'
          , 'A'
          ) ;
insert into coimtpin_abilitazioni
          ( cod_tpin_abil
          , cod_coimtpin
          , flag_tipo_impianto
          , tipo_combustibile
          ) values
          ( 6
          , 5
          , 'C'
          , 'A'
          ) ;
insert into coimtpin_abilitazioni
          ( cod_tpin_abil
          , cod_coimtpin
          , flag_tipo_impianto
          , tipo_combustibile
          ) values
          ( 7
          , 6
          , ''
          , ''
          ) ;
insert into coimtpin_abilitazioni
          ( cod_tpin_abil
          , cod_coimtpin
          , flag_tipo_impianto
          , tipo_combustibile
          ) values
          ( 8
          , 7
          , ''
          , ''
          ) ;
insert into coimtpin_abilitazioni
          ( cod_tpin_abil
          , cod_coimtpin
          , flag_tipo_impianto
          , tipo_combustibile
          ) values
          ( 9
          , 3
          , 'F'
          , 'S'
          ) ;
insert into coimtpin_abilitazioni
          ( cod_tpin_abil
          , cod_coimtpin
          , flag_tipo_impianto
          , tipo_combustibile
          ) values
          ( 10
          , 8
          , 'F'
          , 'G'
          );

insert into coimfunz 
     values('manutentori'
           ,'Tipologie Impianti su cui lavora la ditta'
           , 'secondario'
           , 'coimtpin-list', 'src/',''
           );
insert into coimfunz
     values('manutentori'
	   ,'Tipologie Impianti su cui lavora la ditta'
           ,'secondario'
           ,'coimtpin-gest'
           ,'src/'
           ,''
           );

insert into coimcomb
 values(
  '20'
  ,upper('cogeneratore')
  ,'2018-06-29'
  ,null
  ,'gacalin'
  ,null
  );

update coimcomb 
   set tipo = 'G'                -- G=Gassoso - L=Liquido - S=Solido - A=Altro
 where cod_combustibile = '88';  -- Pompe di calore

end;
