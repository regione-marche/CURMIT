<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_cimp2">
       <querytext>
        select cod_impianto
          from coimcimp
         where cod_cimp = :cod_cimp_dimp
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp2">
       <querytext>
        select cod_impianto
          from coimdimp
         where cod_dimp = :cod_cimp_dimp
       </querytext>
    </fullquery>

    <partialquery name="sel_d_anom">
       <querytext>
select a.cod_cimp_dimp
     , a.prog_anom
     , a.cod_tanom
     , iter_edit_data(a.dat_utile_inter) as data_edit
     , b.descr_breve
  from coim_d_anom a
     , coim_d_tano b
 where 1 = 1
   and a.cod_cimp_dimp = :cod_cimp_dimp
   and a.flag_origine  = :flag_origine
   and b.cod_tano      = a.cod_tanom 
$where_last
order by to_number(prog_anom,'99999999')
       </querytext>
    </partialquery>

</queryset>
