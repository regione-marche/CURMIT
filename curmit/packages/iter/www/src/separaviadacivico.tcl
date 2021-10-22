ad_page_contract {
    Divide l'indirizzo dal numero

    @author        Adhoc
    @creation-date 13/11/2007

    @cvs-id dividi.tcl
}

ReturnHeaders


ns_write "<br> inizio elaborazione"       

    db_foreach  sel_ind "select cod_impianto,
                                   indirizzo as indirizzo_v,
                                   cod_impianto_est,
                                   position ('.' in indirizzo) as pos_punto,
                                   position ('S.' in indirizzo) as pos_santo,
                                   replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(indirizzo,',',' '),' F1',''),' F2',''),' F3',''),' F4',''),' F5',''),' F6',''),' F7',''),' F8',''),' F9',''),'SN','  ') as indirizzo,
                                   case when position('0' in indirizzo) > 0 then position('0' in indirizzo)
                                        else 999
                                   end                        as p0, 
                                   case when position('1' in indirizzo) > 0 then position('1' in indirizzo)
                                        else 999
                                   end                        as p1, 
                                   case when position('2' in indirizzo) > 0 then position('2' in indirizzo)
                                        else 999
                                   end                        as p2, 
                                   case when position('3' in indirizzo) > 0 then position('3' in indirizzo)
                                        else 999
                                   end                        as p3, 
                                   case when position('4' in indirizzo) > 0 then position('4' in indirizzo)
                                        else 999
                                   end                        as p4, 
                                   case when position('5' in indirizzo) > 0 then position('5' in indirizzo)
                                        else 999
                                   end                        as p5, 
                                   case when position('6' in indirizzo) > 0 then position('6' in indirizzo)
                                        else 999
                                   end                        as p6, 
                                   case when position('7' in indirizzo) > 0 then position('7' in indirizzo)
                                        else 999
                                   end                        as p7, 
                                   case when position('8' in indirizzo) > 0 then position('8' in indirizzo)
                                        else 999
                                   end                        as p8, 
                                   case when position('9' in indirizzo) > 0 then position('9' in indirizzo)
                                        else 999
                                   end                        as p9 

                               from coimaimp 
                              where indirizzo is not null 
                                and numero is null 
                                and cod_comune = '1127'
                                and ( indirizzo like '%0%' or
                                      indirizzo like '%1%' or
                                      indirizzo like '%2%' or
                                      indirizzo like '%3%' or
                                      indirizzo like '%4%' or
                                      indirizzo like '%5%' or
                                      indirizzo like '%6%' or
                                      indirizzo like '%7%' or
                                      indirizzo like '%8%' or
                                      indirizzo like '%9%') 
   " {
       set position $p0 
       if {$position > $p1} {
	   set position $p1
       } 
       if {$position > $p2} {
	   set position $p2
       } 
       if {$position > $p3} {
	   set position $p3
       } 
       if {$position > $p4} {
	   set position $p4
       } 
       if {$position > $p5} {
	   set position $p5
       } 
       if {$position > $p6} {
	   set position $p6
       } 
       if {$position > $p7} {
	   set position $p7
       } 
       if {$position > $p8} {
	   set position $p8
       } 
       if {$position > $p9} {
	   set position $p9
       } 

       
       set ind [string trim [string range $indirizzo 0 [expr $position - 2]]]


       if {$pos_punto > 0 && $pos_santo == 0} {
           set pp [expr $pos_punto - 1]  
	   set civ [string trim [string range $indirizzo [expr $pp - 2] [expr $pp - 1]]]
           set int [string trim [string range $indirizzo [expr $pp + 1]  999]]
       } else {
	   set civ [string trim [string range $indirizzo [expr $position - 1] 999]]
           set int ''
       }

       set civ [db_string query "select trim(replace (:civ,'.',''))"]

       ns_write "<br> $cod_impianto_est - $indirizzo_v - $ind - $civ "

       
       if {[string is integer $civ]} {
       db_dml upd_cog "update coimaimp set  numero  = :civ
                                            where cod_impianto = :cod_impianto"


       }
   }

    
ns_write "<br> fine elaborazione"       


