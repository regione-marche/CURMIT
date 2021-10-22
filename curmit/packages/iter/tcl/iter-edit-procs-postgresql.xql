<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="iter_edit_num.sel_dual_edit_num">
       <querytext>
             select iter_edit_num(:numero,:max_decimali) as num_edit
       </querytext>
    </fullquery>

    <fullquery name="iter_check_time.sel_dual_time_chk">
       <querytext>
         select to_char(to_timestamp(:time_edit,:formato),:formato) as time_chk
       </querytext>
    </fullquery>

    <fullquery name="iter_check_date.sel_dual_data_chk">
       <querytext>
            select to_char(to_date(:data_edit,:formato),:formato) as data_chk
       </querytext>
    </fullquery>

    <fullquery name="iter_check_date.sel_dual_data_int">
       <querytext>
            select to_char(to_date(:data_edit,:formato),'yyyymmdd') as data_int
       </querytext>
    </fullquery>

    <fullquery name="iter_calc_date.sel_dual_dif_between_date">
       <querytext>
            select to_date(:data_1,'yyyymmdd')
                 - to_date(:data_2,'yyyymmdd')
       </querytext>
    </fullquery>

    <fullquery name="iter_calc_date.sel_dual_add_number_to_date">
       <querytext>
            select to_char(
                   to_date(:data_1,'yyyymmdd') $operatore $numero
                   ,'yyyymmdd')
       </querytext>
    </fullquery>

    <fullquery name="iter_calc_rend.sel_gend_parm">
       <querytext>
           select 
	        mod_funz as fluido_termovettore
	      , pot_utile_nom as potenza_nominale
	      , iter_edit_data(data_installaz) as data_installazione
	      , dpr_660_96 as class_dpr
	   from coimgend
	   where cod_impianto = :cod_impianto
	     and gen_prog = :gen_prog
       </querytext>
    </fullquery>

</queryset>
