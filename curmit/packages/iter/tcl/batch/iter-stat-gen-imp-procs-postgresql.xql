<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

	<fullquery name="iter-stat-gen-imp.sel_database_enti">
      <querytext>
		select database_ente as nome_database
		       , denominazione_ente
		from coimereg
		order by denominazione_ente asc
      </querytext>
    </fullquery>
	
    <fullquery name="iter-stat-gen-imp.sel_aimp">
       <querytext>
           select count(*) from coimaimp 
       </querytext>
    </fullquery>

	<fullquery name="iter-stat-gen-imp.sel_att">
       <querytext>
          select count(*) from coimaimp where stato = 'A' 
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_pot">
       <querytext>
         select count(*) from coimaimp where potenza <> 0 
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_pot_uti">
       <querytext>
         select count(*) from coimaimp where potenza_utile <> 0 
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_manu">
       <querytext>
         select count(*) from coimaimp where cod_manutentore is not null 
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_gend">
       <querytext>
         select count(*) from coimgend a left outer join coimaimp g on g.cod_impianto = a.cod_impianto
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_gend_pots">
       <querytext>
         select count(*) from coimgend a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.pot_focolare_nom <> 0
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_gend_potu">
       <querytext>
         select count(*) from coimgend a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.pot_utile_nom <> 0 
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_gend_matr">
       <querytext>
         select count(*) from coimgend a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.matricola is not null 
    
       </querytext>
    </fullquery>
     
    <fullquery name="iter-stat-gen-imp.sel_gend_cost">
       <querytext>
         select count(*) from coimgend a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.cod_cost is not null 
    
       </querytext>
    </fullquery>
     
    <fullquery name="iter-stat-gen-imp.sel_viae">
       <querytext>
         select count(*) from coimviae 
    
       </querytext>
    </fullquery>
     
    <fullquery name="iter-stat-gen-imp.sel_dimp">
       <querytext>
         select count(*) from coimdimp a left outer join coimaimp g on g.cod_impianto = a.cod_impianto 
  	
       </querytext>
    </fullquery>
     
    <fullquery name="iter-stat-gen-imp.sel_dimp_manu">
       <querytext>
         select count(*) from coimdimp a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where length(a.cod_manutentore) = 8 
  	
       </querytext>
    </fullquery>
     
    <fullquery name="iter-stat-gen-imp.sel_dimp_fumi">
       <querytext>
         select count(*) from coimdimp a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.temp_fumi <> 0 
  	
       </querytext>
    </fullquery>
     
    <fullquery name="iter-stat-gen-imp.sel_dimp_ambi">
       <querytext>
         select count(*) from coimdimp a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.temp_ambi <> 0 
  		</querytext>
    </fullquery>
     
    <fullquery name="iter-stat-gen-imp.sel_dimp_o2">
       <querytext>
         select count(*) from coimdimp a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.o2 <> 0 
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_dimp_co2">
       <querytext>
         select count(*) from coimdimp a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.co2 <> 0 
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_dimp_bach">
       <querytext>
         select count(*) from coimdimp a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.bacharach <> 0 
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_dimp_co">
       <querytext>
         select count(*) from coimdimp a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.co <> 0 
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_dimp_rend">
       <querytext>
         select count(*) from coimdimp a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.rend_combust <> 0 
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_cimp">
       <querytext>
         select count(*) from coimcimp a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.data_controllo between '$f_data1' and '$f_data2' 
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_dimp_ma_2008">
       <querytext>
         select count(*) from coimdimp a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.data_controllo between '$f_data1' and '$f_data2' and a.utente_ins like 'MA%' 
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_dimp_cait_2008">
       <querytext>
         select count(*) from coimdimp a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.data_controllo between '$f_data1' and '$f_data2' and a.utente_ins not like 'MA%'
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_dimp_cait_upa">
       <querytext>
         select count(*) from coimdimp a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.data_controllo between '$f_data1' and '$f_data2' and a.utente_ins like 'UPA%' 
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_dimp_cait_cna">
       <querytext>
         select count(*) from coimdimp a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.data_controllo between '$f_data1' and '$f_data2' and a.utente_ins like 'CNA%' 
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_dimp_cait_claai">
       <querytext>
         select count(*) from coimdimp a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.data_controllo between '$f_data1' and '$f_data2' and a.utente_ins like 'CLAAI%'
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_dimp_cait_asso">
       <querytext>
         select count(*) from coimdimp a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.data_controllo between '$f_data1' and '$f_data2' and a.utente_ins  like 'ASSO%' 
       </querytext>
    </fullquery>
    
      <fullquery name="iter-stat-gen-imp.sel_dimp_cait_assistal">
       <querytext>
         select count(*) from coimdimp a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.data_controllo between '$f_data1' and '$f_data2' and a.utente_ins  like 'ASSI%' 
       </querytext>
    </fullquery>


    <fullquery name="iter-stat-gen-imp.sel_dimp_min_35">
       <querytext>
         select count(*) from coimdimp a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.data_controllo between '$f_data1' and '$f_data2' and a.potenza < '34.99'
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_dimp_mag_35_min_50">
       <querytext>
         select count(*) from coimdimp a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.data_controllo between '$f_data1' and '$f_data2' and a.potenza >= 35 and a.potenza < 50
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_dimp_mag_50_min_116">
       <querytext>
         select count(*) from coimdimp a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.data_controllo between '$f_data1' and '$f_data2' and a.potenza >'50.01' and a.potenza < '116.3' 
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_dimp_mag_116_min_350">
       <querytext>
         	select count(*) from coimdimp a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.data_controllo between '$f_data1' and '$f_data2' and a.potenza >= '116.4' and a.potenza < 350 
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_dimp_mag_350">
       <querytext>
         select count(*) from coimdimp a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.data_controllo between '$f_data1' and '$f_data2' and a.potenza >= '350.01' 
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_dimp_scad_75">
       <querytext>
        	select count(*) from coimdimp a left outer join coimaimp g on g.cod_impianto = a.cod_impianto where a.data_controllo between '$f_data1' and '$f_data2' and a.data_ins > a.data_controllo+75 and a.utente_ins not like 'MA000%'
       </querytext>
    </fullquery>
    
    <fullquery name="iter-stat-gen-imp.sel_aimp_ma">
       <querytext>
        	select count(*) from coimaimp where stato = 'A' and cod_manutentore is not null and  cod_potenza = 'MA';
       </querytext>
    </fullquery>

   <fullquery name="iter-stat-gen-imp.sel_aimp_c">
       <querytext>
        	select count(*) from coimaimp where stato = 'A' and cod_manutentore is not null and  cod_potenza = 'C';
       </querytext>
    </fullquery>

   <fullquery name="iter-stat-gen-imp.sel_aimp_mb">
       <querytext>
        	select count(*) from coimaimp where stato = 'A' and cod_manutentore is not null and  cod_potenza = 'MB';
       </querytext>
    </fullquery>

   <fullquery name="iter-stat-gen-imp.sel_aimp_a">
       <querytext>
        	select count(*) from coimaimp where stato = 'A' and cod_manutentore is not null and  cod_potenza = 'A';
       </querytext>
    </fullquery>

     <fullquery name="iter-stat-gen-imp.sel_aimp_0">
       <querytext>
        	select count(*) from coimaimp where stato = 'A' and cod_manutentore is not null and  cod_potenza = '0';
       </querytext>
    </fullquery>

    <fullquery name="iter-stat-gen-imp.sel_aimp_b">
       <querytext>
        	select count(*) from coimaimp where stato = 'A' and cod_manutentore is not null and  cod_potenza = 'B';
       </querytext>
    </fullquery>

    <fullquery name="iter-stat-gen-imp.sel_aimp_n">
       <querytext>
        	select count(*) from coimaimp where stato = 'A' and cod_manutentore is not null and  cod_potenza is null;
       </querytext>
    </fullquery>



</queryset>
