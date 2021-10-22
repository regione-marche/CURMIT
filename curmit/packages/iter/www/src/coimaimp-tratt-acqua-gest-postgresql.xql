<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_tratt_acqua">
       <querytext>
	      select iter_edit_num(tratt_acqua_contenuto,2) as tratt_acqua_contenuto
                     , iter_edit_num(tratt_acqua_durezza,2) as tratt_acqua_durezza
                     , tratt_acqua_clima_tipo
                     , iter_edit_num(tratt_acqua_clima_addolc, 2) as tratt_acqua_clima_addolc
                     , tratt_acqua_clima_prot_gelo
                     , iter_edit_num(tratt_acqua_clima_prot_gelo_eti, 2) as tratt_acqua_clima_prot_gelo_eti
                     , iter_edit_num(tratt_acqua_clima_prot_gelo_eti_perc, 2) as tratt_acqua_clima_prot_gelo_eti_perc
                     , iter_edit_num(tratt_acqua_clima_prot_gelo_pro, 2) as tratt_acqua_clima_prot_gelo_pro
                     , iter_edit_num(tratt_acqua_clima_prot_gelo_pro_perc, 2) as tratt_acqua_clima_prot_gelo_pro_perc
                     , tratt_acqua_calda_sanit_tipo
                     , iter_edit_num(tratt_acqua_calda_sanit_addolc, 2) as tratt_acqua_calda_sanit_addolc
                     , tratt_acqua_raff_assente
                     , tratt_acqua_raff_tipo_circuito
                     , tratt_acqua_raff_origine
                     , tratt_acqua_raff_filtraz_flag
                     , tratt_acqua_raff_filtraz_1
                     , tratt_acqua_raff_filtraz_2
                     , tratt_acqua_raff_filtraz_3
                     , tratt_acqua_raff_filtraz_4
                     , tratt_acqua_raff_tratt_flag
                     , tratt_acqua_raff_tratt_1
                     , tratt_acqua_raff_tratt_2
                     , tratt_acqua_raff_tratt_3
                     , tratt_acqua_raff_tratt_4
                     , tratt_acqua_raff_tratt_5
                     , tratt_acqua_raff_cond_flag
                     , tratt_acqua_raff_cond_1
                     , tratt_acqua_raff_cond_2
                     , tratt_acqua_raff_cond_3
                     , tratt_acqua_raff_cond_4
                     , tratt_acqua_raff_cond_5
                     , tratt_acqua_raff_cond_6
                     , tratt_acqua_raff_spurgo_flag
                     , iter_edit_num(tratt_acqua_raff_spurgo_cond_ing, 2) as tratt_acqua_raff_spurgo_cond_ing
                     , iter_edit_num(tratt_acqua_raff_spurgo_tara_cond, 2) as tratt_acqua_raff_spurgo_tara_cond
		     , tratt_acqua_raff_filtraz_note_altro --rom01 07/11/2018
		     , tratt_acqua_raff_tratt_note_altro   --rom01 07/11/2018
		     , tratt_acqua_raff_cond_note_altro    --rom01 07/11/2018
               from coimaimp
              where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <partialquery name="upd_tratt_acqua">
       <querytext>
                update coimaimp
		set    tratt_acqua_contenuto                        = :tratt_acqua_contenuto                       
                     , tratt_acqua_durezza                          = :tratt_acqua_durezza                 
                     , tratt_acqua_clima_tipo                       = :tratt_acqua_clima_tipo              
                     , tratt_acqua_clima_addolc                     = :tratt_acqua_clima_addolc            
                     , tratt_acqua_clima_prot_gelo                  = :tratt_acqua_clima_prot_gelo         
                     , tratt_acqua_clima_prot_gelo_eti              = :tratt_acqua_clima_prot_gelo_eti     
                     , tratt_acqua_clima_prot_gelo_eti_perc         = :tratt_acqua_clima_prot_gelo_eti_perc
                     , tratt_acqua_clima_prot_gelo_pro              = :tratt_acqua_clima_prot_gelo_pro     
                     , tratt_acqua_clima_prot_gelo_pro_perc         = :tratt_acqua_clima_prot_gelo_pro_perc
                     , tratt_acqua_calda_sanit_tipo                 = :tratt_acqua_calda_sanit_tipo        
                     , tratt_acqua_calda_sanit_addolc               = :tratt_acqua_calda_sanit_addolc      
                     , tratt_acqua_raff_assente                     = :tratt_acqua_raff_assente            
                     , tratt_acqua_raff_tipo_circuito               = :tratt_acqua_raff_tipo_circuito      
                     , tratt_acqua_raff_origine                     = :tratt_acqua_raff_origine            
                     , tratt_acqua_raff_filtraz_flag                = :tratt_acqua_raff_filtraz_flag       
                     , tratt_acqua_raff_filtraz_1                   = :tratt_acqua_raff_filtraz_1          
                     , tratt_acqua_raff_filtraz_2                   = :tratt_acqua_raff_filtraz_2          
                     , tratt_acqua_raff_filtraz_3                   = :tratt_acqua_raff_filtraz_3          
                     , tratt_acqua_raff_filtraz_4                   = :tratt_acqua_raff_filtraz_4          
                     , tratt_acqua_raff_tratt_flag                  = :tratt_acqua_raff_tratt_flag         
                     , tratt_acqua_raff_tratt_1                     = :tratt_acqua_raff_tratt_1            
                     , tratt_acqua_raff_tratt_2                     = :tratt_acqua_raff_tratt_2            
                     , tratt_acqua_raff_tratt_3                     = :tratt_acqua_raff_tratt_3            
                     , tratt_acqua_raff_tratt_4                     = :tratt_acqua_raff_tratt_4            
                     , tratt_acqua_raff_tratt_5                     = :tratt_acqua_raff_tratt_5            
                     , tratt_acqua_raff_cond_flag                   = :tratt_acqua_raff_cond_flag          
                     , tratt_acqua_raff_cond_1                      = :tratt_acqua_raff_cond_1             
                     , tratt_acqua_raff_cond_2                      = :tratt_acqua_raff_cond_2             
                     , tratt_acqua_raff_cond_3                      = :tratt_acqua_raff_cond_3             
                     , tratt_acqua_raff_cond_4                      = :tratt_acqua_raff_cond_4             
                     , tratt_acqua_raff_cond_5                      = :tratt_acqua_raff_cond_5             
                     , tratt_acqua_raff_cond_6                      = :tratt_acqua_raff_cond_6             
                     , tratt_acqua_raff_spurgo_flag                 = :tratt_acqua_raff_spurgo_flag        
                     , tratt_acqua_raff_spurgo_cond_ing             = :tratt_acqua_raff_spurgo_cond_ing    
                     , tratt_acqua_raff_spurgo_tara_cond            = :tratt_acqua_raff_spurgo_tara_cond 
                     , tratt_acqua_raff_filtraz_note_altro          = :tratt_acqua_raff_filtraz_note_altro --rom01 07/11/2018
		     , tratt_acqua_raff_tratt_note_altro            = :tratt_acqua_raff_tratt_note_altro   --rom01 07/11/2018
                     , tratt_acqua_raff_cond_note_altro             = :tratt_acqua_raff_cond_note_altro    --rom01 07/11/2018
		 where cod_impianto = :cod_impianto				    
       </querytext>
    </partialquery>

</queryset>
