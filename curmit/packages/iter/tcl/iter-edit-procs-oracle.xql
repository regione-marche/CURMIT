<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="iter_edit_num.sel_dual_edit_num">
       <querytext>
             select iter_edit.num(:numero,:max_decimali) as num_edit
               from dual
       </querytext>
    </fullquery>

    <fullquery name="iter_check_time.sel_dual_time_chk">
       <querytext>
         select to_char(to_date(:time_edit,:formato),:formato) as time_chk
           from dual
       </querytext>
    </fullquery>

    <fullquery name="iter_check_date.sel_dual_data_chk">
       <querytext>
            select to_char(to_date(:data_edit,:formato),:formato) as data_chk
              from dual
       </querytext>
    </fullquery>

    <fullquery name="iter_check_date.sel_dual_data_int">
       <querytext>
            select to_char(to_date(:data_edit,:formato),'yyyymmdd') as data_int
              from dual
       </querytext>
    </fullquery>

    <fullquery name="iter_calc_date.sel_dual_dif_between_date">
       <querytext>
            select to_date(:data_1,'yyyymmdd')
                 - to_date(:data_2,'yyyymmdd')
              from dual  
       </querytext>
    </fullquery>

    <fullquery name="iter_calc_date.sel_dual_add_number_to_date">
       <querytext>
            select to_char(
                   to_date(:data_1,'yyyymmdd') $operatore $numero
                   ,'yyyymmdd')
              from dual
       </querytext>
    </fullquery>

</queryset>
