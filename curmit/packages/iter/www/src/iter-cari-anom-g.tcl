ad_page_contract {
    Elaborazione     Caricamento anomalie modelli G
    @author          vari
    @creation-date   2013 gennaio
    @cvs-id          iter_cari_anom_g
} {
    {funzione        "I"}
    {caller      "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
} -properties {
      context_bar:onevalue
}


set lvl 2
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
# controllo il parametro di "propagazione" per la navigation bar
if {[string equal $nome_funz_caller ""]} {
    set nome_funz_caller $nome_funz
}

set page_title   "Caricamento anomalie da Mod. G"
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
set form_name "carianomg"
set msg ""
db_1row sel_esit "select coalesce(to_char(max(data_elaborazione),'dd/mm/yyyy'),'01/01/2010') as data_ini_elab
                       , coalesce(max(data_elaborazione),'2010-01-01') as data_elaborazione
                               from coim_d_esit
                              where flag_tracciato = 'G'"

#ns_log Notice "Form Caricamento anomalie mod.G $form_name $data_ini_elab"

form create $form_name \
    -html    ""

element create $form_name data_ini_elab \
    -label   "Data inizio controlli " \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 readonly {} class form_element" \
    -optional

element create $form_name msg \
    -label   " " \
    -widget   textarea \
    -datatype text \
    -html    "rows 10 cols 80 readonly {} class form_element" \
    -optional

element create $form_name submit      -widget submit -datatype text -label "Conferma caricamento" -html "class form_submit"
element create $form_name funzione     -widget hidden -datatype text -optional
element create $form_name caller       -widget hidden -datatype text -optional
element create $form_name nome_funz    -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    element set_properties $form_name msg           -value ""
    element set_properties $form_name data_ini_elab -value $data_ini_elab
    element set_properties $form_name funzione      -value $funzione
    element set_properties $form_name caller        -value $caller
    element set_properties $form_name nome_funz     -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    set data_ini_elab    [element::get_value $form_name data_ini_elab]

    ns_log Notice "Inizio della procedura Caricamento anomalie mod.G"
    
    db_foreach sel_dimp_g "select a.cod_dimp
                                    , a.cod_impianto 
                                    , b.cod_cost
                                    , b.modello
                                    , b.matricola
                                    , b.data_costruz_gen
                                    , b.pot_focolare_nom
                                    , b.cod_combustibile
                                    , b.data_installaz as data_installazione
                                    , b.cod_emissione
                                    , a.data_controllo
                                    , a.conformita
                                    , a.lib_impianto
                                    , a.lib_uso_man 
                                    , a.idoneita_locale
                                    , a.ap_ventilaz
                                    , a.ap_vent_ostruz
                                    , a.pendenza
                                    , a.sezioni
                                    , a.curve
                                    , a.lunghezza
                                    , a.conservazione
                                    , a.disp_comando
                                    , a.ass_perdite
                                    , a.valvola_sicur
                                    , a.disp_sic_manom
                                    , a.assenza_fughe
                                    , a.coibentazione
                                    , a.eff_evac_fum
                                    , a.cont_rend
                                    , a.temp_fumi
                                    , a.temp_ambi
                                    , a.o2
                                    , a.co2
                                    , a.bacharach
                                    , a.co
                                    , a.rend_combust
                                    , a.tiraggio
                                    , b.tiraggio as tiraggio_gend
                                    , b.tipo_foco
                                    , b.mod_funz as fluido_termovettore 
                                    , b.dpr_660_96 as class_dpr
                                    , b.pot_focolare_nom as potenza_nominale
                                    , b.pot_utile_nom  as potenza_utile
                                    , a.prescrizioni
                                    , a.raccomandazioni
                                    , a.flag_status
                                    , a.potenza
                                    , a.scar_parete
                                    , a.scar_can_fu
                                    , a.scar_ca_si
                                    , a.riflussi_locale
                                    , a.pulizia_ugelli
                                    , a.antivento
                                    , a.scambiatore
                                    , a.accens_reg
                                    , a.assenza_perdite
                                    , a.vaso_esp
                                    , a.organi_integri
                                    , b.locale
                                 from coimdimp a
                                    , coimgend b
                                where a.cod_impianto = b.cod_impianto
                                  and a.gen_prog     = b.gen_prog
                                  and a.flag_tracciato = 'G'
                                  and (a.data_ins >= :data_elaborazione
                                    or a.data_mod >= :data_elaborazione)
                                  and not exists (select 1 from coimdimp aa 
                                                   where aa.cod_impianto = a.cod_impianto
                                                     and aa.cod_dimp <> a.cod_dimp  
                                                     and aa.data_controllo >= a.data_controllo
                                                     and aa.cod_manutentore is not null)
                                  and a.data_ins > '2008-05-01' and a.cod_manutentore is not null
     " {

	 set lista_anom [list]
	 set lista_anom_m [list]

          if {$potenza_utile > $potenza_nominale} {
	     lappend lista_anom "A1"
	   }
	
	 

	 if {$cod_combustibile != "7"} {
	     if {[string equal $cod_cost ""]} {
		 lappend lista_anom "C1"
	     }
	 }

	 if {$cod_combustibile != "7"} {
	     if {[string equal $modello ""]} {
		 lappend lista_anom "C2"
	     }
	 }

	 if {$cod_combustibile != "7"} {
	     if {[string equal $matricola ""]
	     } {
		 lappend lista_anom "C4"
	     }
	 }

	 if {$cod_combustibile != "7"} {
	     if {[string equal $potenza ""]
		 || $potenza >= 35.00} {
		 lappend lista_anom "C7"
	     }
	 }
	 
	 if {[string equal $cod_combustibile ""]} {
	     lappend lista_anom "C14"
	 }
	 if {$cod_combustibile != "7"} {
	     if {[string equal $data_installazione ""]
		 || [string equal $data_installazione "1900-01-01"]} {
		 lappend lista_anom "C16"
	     }
	 }
	 if {$cod_combustibile != "7"} {
	     if {[string equal $data_costruz_gen "1900-01-01"]} {
		 lappend lista_anom "C5"
	     }
	 }
	 
	 if {[string equal $conformita ""]
	 }  {
	     lappend lista_anom "E1"
	 }

	 if {[string equal $conformita "N"]
	 } {
	     lappend lista_anom "E3"
	 }
	 if {[string equal $conformita "C"]
	 }  {
	     lappend lista_anom "E4"
	 }

	 if {[string equal $lib_impianto ""]} {
	     lappend lista_anom "E5"
	 }
	 if {[string equal $lib_impianto "N"]} {
	     lappend lista_anom "E7"
	 }
	 if {[string equal $lib_impianto "C"]} {
	     lappend lista_anom "E8"
	 }
	 
	 if {[string equal $lib_uso_man ""]} {
	     lappend lista_anom "E9"
	 }
	 if {[string equal $lib_uso_man "N"]} {
	     lappend lista_anom "E11"
	 }
	 if {[string equal $lib_uso_man "C"]} {
	     lappend lista_anom "E12"
	 }


	 if {[string equal $idoneita_locale ""]} {
	     lappend lista_anom "F1"
	 }
	 if {[string equal $idoneita_locale "N"]} {
	     lappend lista_anom "F3"
	 }
	 if {$idoneita_locale != "E"} {
            if {$idoneita_locale != "S"} {
	       if {[string equal $ap_ventilaz "N"]} {
		 lappend lista_anom "F6"
	       }
            }  
         }

          if {$locale == "I"} {
             if {$tiraggio_gend != "F"} {
                if {![string equal $ap_ventilaz "S"]} {
                       lappend lista_anom "F10"
	           }
              }
           }

         if {$locale == ""} {
             if {$tiraggio_gend != "F"} {
                if {![string equal $ap_ventilaz "S"]} {
                       lappend lista_anom "F10"
	           }
              }
           }
             
         if {$locale == ""} {
            if {[string equal $tiraggio_gend "N"] } {
	      if {[string equal $ap_ventilaz ""]} {
		 lappend lista_anom "F4"
	      }
            }
          }


          if {$locale == "I"} {
            if {[string equal $tiraggio_gend "N"] } {
	      if {[string equal $ap_ventilaz ""]} {
		 lappend lista_anom "F4"
	      }
            }
          }

          if {$locale == "I"} {
             if {$tiraggio_gend != "F"} {
               if {$idoneita_locale == ""} {
                 if {[string equal $ap_vent_ostruz ""]} {
                     if {[string equal $ap_ventilaz ""]} {
                           lappend lista_anom "F8"
	                }
                     }
                 }
              }
           }


       if {$locale == ""} {
             if {$tiraggio_gend != "F"} {
              if {$idoneita_locale == ""} {
                 if {[string equal $ap_vent_ostruz ""]} {
                     if {[string equal $ap_ventilaz ""]} {
                           lappend lista_anom "F8"
	                }
                     }
                 }
              }
           }



       if {$idoneita_locale != "S"} {
           if {[string equal $tiraggio_gend "N"] } {
	       if {[string equal $ap_ventilaz "C"]} {
		 lappend lista_anom "F7"
	        }
            }
         }

     	     if {[string equal  $ap_vent_ostruz "C"]} {
		      lappend lista_anom "F9"
	           }
       
         
         if {$idoneita_locale != "S"} {
            if {[string equal $ap_vent_ostruz "C"]} {
		 lappend lista_anom "F11"
	     }

         }
      

# richiesta F5	 
        if {[string equal $locale  "E"]} {
          if {[string equal $idoneita_locale  "E"]} {
           if {[string equal $tiraggio_gend "F"] } {
            if {[string equal $ap_vent_ostruz ""]} {
	       if {[string equal $ap_ventilaz ""]} {
		 #lappend lista_anom "F5"
	     }
          }
        }
}
}
        if {[string equal $locale  "E"]} {
          if {[string equal $idoneita_locale  "E"]} {
            if {[string equal $tiraggio_gend "F"] } {
            if {[string equal $ap_vent_ostruz "N"]} {
	       if {[string equal $ap_ventilaz "N"]} {
		 lappend lista_anom "F5"
	     }
          }
        }
}
}
       if {[string equal $locale  "E"]} {
          if {[string equal $idoneita_locale  "E"]} {
             if {[string equal $tiraggio_gend "F"] } {
            if {[string equal $ap_vent_ostruz "C"]} {
	       if {[string equal $ap_ventilaz "C"]} {
		 lappend lista_anom "F5"
	     }
          }
        }
}
}
#------
       if {[string equal $locale  "E"]} {
          if {[string equal $idoneita_locale  "S"] } {
             if {[string equal $tiraggio_gend "F"] } {
            if {[string equal $ap_vent_ostruz ""]} {
	       if {[string equal $ap_ventilaz ""]} {
		 lappend lista_anom "F5"
	     }
          }
        }
}
}
       if {[string equal $locale  "E"]} {
          if {[string equal $idoneita_locale  "S"] } {
             if {[string equal $tiraggio_gend "F"] } {
            if {[string equal $ap_vent_ostruz "N"]} {
	       if {[string equal $ap_ventilaz "N"]} {
		 lappend lista_anom "F5"
	     }
          }
        }
}
}

         if {[string equal $locale  "E"]} {
          if {[string equal $idoneita_locale  "S"] } {
             if {[string equal $tiraggio_gend "F"] } {
            if {[string equal $ap_vent_ostruz "C"]} {
	       if {[string equal $ap_ventilaz "C"]} {
		 lappend lista_anom "F5"
	     }
          } 

        }
}
}
# ---- fine
 # Esame visivo dei canali da fumo
				      if {[string equal $pendenza ""]
					  || [string equal $sezioni ""]
					  || [string equal $curve ""]
					  || [string equal $lunghezza ""]
					  || [string equal $conservazione ""]
					  && [string equal $locale "I"]
					      || [string equal $locale ""]} {
					  lappend lista_anom "G1"
				      }
				      if {[string equal $pendenza ""]
					  || [string equal $sezioni ""]
					  || [string equal $curve ""]
					  || [string equal $lunghezza ""]
					  || [string equal $conservazione ""]
					  && [string equal $locale "E"]
					      ||  [string equal $locale "T"]} {
					  lappend list_anom "G2"
				      }
				      if {[string equal $pendenza "N"]
					  || [string equal $sezioni "N"]
					  || [string equal $curve "N"]
					  || [string equal $lunghezza "N"]
					  || [string equal $conservazione "N"]
					  && [string equal $locale  "I"]
					      || [string equal $locale ""]} {
					  lappend list_anom "G4"
				      }
				      if {[string equal $pendenza "N"]
					  || [string equal $sezioni "N"]
					  || [string equal $curve "N"]
					  || [string equal $lunghezza "N"]
					  || [string equal $conservazione "N"]
					  && [string equal $locale "E"]
					      || [ string equal $locale ""]} {
					  lappend list_anom "G5"
				      }


	 if {[string equal $scar_can_fu "N"]
	     && [string equal $scar_ca_si "N"]
	     && [string equal $scar_parete "N"]} {
	     lappend lista_anom "H2"
	 }
	 if {[string equal $scar_can_fu ""]
	     && [string equal $scar_ca_si ""]
	     && [string equal $scar_parete ""]} {
	     lappend lista_anom "H1"
	 }
	 if {[string equal $scar_can_fu "C"]
	     && [string equal $scar_ca_si "C"]
	     && [string equal $scar_parete "C"]} {
	     lappend lista_anom "H4"
	 }
if {[string equal $riflussi_locale ""]} {
if {[string equal $tiraggio_gend "N"]} {   
  if {[string equal $locale "I"]} {
    if {[string equal $scar_can_fu ""]
	     && [string equal $scar_ca_si ""]
	     && [string equal $scar_parete ""]} {
	     lappend lista_anom "H5"
	 }
}
}
}

# Richiesta H6

    if {![string equal $tiraggio_gend "F"]} {
        if {[string equal $riflussi_locale "N"]} {
          if {[string equal $assenza_perdite "S"]} {
	     lappend lista_anom "H6"
	 }
      }
}
 if {![string equal $tiraggio_gend "F"]} {
        if {[string equal $riflussi_locale "C"]} {
          if {[string equal $assenza_perdite "S"]} {
	     lappend lista_anom "H6"
	 }
      }
}
if {![string equal $tiraggio_gend "F"]} {
        if {[string equal $riflussi_locale ""]} {
          if {[string equal $assenza_perdite "S"]} {
	     lappend lista_anom "H6"
	 }
      }
}
#fine



# Richiesta H10

    if {[string equal $tiraggio_gend "N"]} {
        if {[string equal $riflussi_locale "N"]} {
            lappend lista_anom "H10"
	    }
}
 if {[string equal $tiraggio_gend "N"]} {
        if {[string equal $riflussi_locale "C"]} {
             lappend lista_anom "H10"
	      }
}
if {[string equal $tiraggio_gend "N"]} {
        if {[string equal $riflussi_locale ""]} {
           lappend lista_anom "H10"
	    }
}
#fine

       if {[string equal $tiraggio_gend "N"]} {
	 if {[string equal $riflussi_locale "N"]} {
	     lappend lista_anom "H7"
	 }
      }
    if {[string equal $tiraggio_gend "N"]} {
	 if {[string equal $riflussi_locale "C"]} {
	     lappend lista_anom "H8"
	 }
}
if {[string equal $tiraggio_gend "F"]} {
	 if {[string equal $assenza_perdite ""]} {
	     lappend lista_anom "H9"
	 }


if {[string equal $locale "I"]} {
     if {[string equal $tiraggio_gend "F"]} {
	 if {[string equal $assenza_perdite "N"]} {
	     lappend lista_anom "H11"
	 }
     }
}

if {[string equal $locale "T"]} {
     if {[string equal $tiraggio_gend "F"]} {
	 if {[string equal $assenza_perdite "N"]} {
	     lappend lista_anom "H11"
	 }
     }
}


	 if {[string equal $assenza_perdite "C"]} {
	     lappend lista_anom "H12"
	 }
}
	 if {[string equal $pulizia_ugelli ""]} {
	     lappend lista_anom "I1"
	 }

	 if {[string equal $pulizia_ugelli "N"]} {
	     lappend lista_anom "I3"
	 }
	 if {[string equal $pulizia_ugelli "C"]} {
	     lappend lista_anom "I4"
	 }
if {[string equal $tiraggio_gend "N"]} {
	 if {[string equal $antivento ""]} {
	     lappend lista_anom "I7"
	 }
}
	 if {[string equal $antivento "N"]} {
	     lappend lista_anom "I4"
	 }
	 if {[string equal $antivento "C"]} {
	     lappend lista_anom "I8"
	 }

	 if {[string equal $antivento "C"]} {
	     lappend lista_anom "I8"
	 }
	 
	 if {[string equal $scambiatore ""]} {
	     lappend lista_anom "I9"
	 }

 #----
   if {[string equal $tiraggio_gend "F"]} {
     if {[string equal $tipo_foco "C"]} {
        if {[string equal $antivento "C"]} {
	     lappend lista_anom "I6"
	 }
     }
}

 if {[string equal $tiraggio_gend "F"]} {
     if {[string equal $tipo_foco "C"]} {
        if {[string equal $antivento "N"]} {
	     lappend lista_anom "I6"
	 }
     }
}
 if {[string equal $tiraggio_gend "F"]} {
     if {[string equal $tipo_foco "C"]} {
        if {[string equal $antivento ""]} {
	     lappend lista_anom "I6"
	 }
     }
}

#-----

	 if {[string equal $scambiatore "N"]} {
	     lappend lista_anom "I11"
	 }

	 if {[string equal $scambiatore "C"]} {
	     lappend lista_anom "I12"
	 }

	 if {[string equal $accens_reg ""]} {
	     lappend lista_anom "I13"
	 }

	 if {[string equal $accens_reg "N"]} {
	     lappend lista_anom "I15"
	 }


	 if {[string equal $accens_reg "C"]} {
	     lappend lista_anom "I16"
	 }

	 if {[string equal $disp_comando ""]} {
	     lappend lista_anom "I17"
	 }

	 if {[string equal $disp_comando "N"]} {
	     lappend lista_anom "I19"
	 }
	 if {[string equal $disp_comando "C"]} {
	     lappend lista_anom "I20"
	 }
	 
	 if {[string equal $ass_perdite ""]} {
	     lappend lista_anom "I23"
	 }

	 if {[string equal $ass_perdite "N"]} {
	     lappend lista_anom "I25"
	 }

	 if {[string equal $ass_perdite "C"]} {
	     lappend lista_anom "I26"
	 }

	 if {[string equal $valvola_sicur ""]} {
	     lappend lista_anom "I27"
	 }
	 if {[string equal $valvola_sicur "N"]} {
	     lappend lista_anom "I29"
	 }

	 if {[string equal $valvola_sicur "C"]} {
	     lappend lista_anom "I30"
	 }
	 if {[string equal $vaso_esp ""]} {
	     lappend lista_anom "I31"
	 }
	 if {[string equal $vaso_esp "N"]} {
	     lappend lista_anom "I33"
	 }

	 if {[string equal $vaso_esp "C"]} {
	     lappend lista_anom "I34"
	 }


	 if {[string equal $disp_sic_manom ""]} {
	     lappend lista_anom "I35"
	 }
	 if {[string equal $disp_sic_manom "N"]} {
	     lappend lista_anom "I37"
	 }
	 if {[string equal $disp_sic_manom "C"]} {
	     lappend lista_anom "I38"
	 }

	 if {[string equal $organi_integri ""]} {
	     lappend lista_anom "I39"
	 }

	 if {[string equal $organi_integri "N"]} {
	     lappend lista_anom "I41"
	 }
	 if {[string equal $organi_integri "C"]} {
	     lappend lista_anom "I42"
	 }
	 #
	 if {[string equal $assenza_fughe "N"]} {
	     lappend lista_anom "L3"
	 }
	 if {[string equal $coibentazione "N"]} {
	     lappend lista_anom "L6"
	 }
	 if {[string equal $eff_evac_fum "N"]} {
	     lappend lista_anom "L9"
	 }
	 
	 if {[string equal $cont_rend ""]
	 } {
	     lappend lista_anom "M1"
	 }

	 if {[string equal $cont_rend "N"]
	     || [string equal $cont_rend ""]} {
	     lappend lista_anom "M1"
	 } else {
	     if {[string equal $temp_fumi ""]
		 || $temp_fumi > 220.00} {
		 lappend lista_anom "M4"
	     }
	     if {[string equal $temp_ambi ""]
		 || $temp_ambi < -5.00 || $temp_ambi > 50} {
		 lappend lista_anom "M5"
	     }
	     if {[string equal $o2 ""]
		 || $o2 < 0.21} {
		 lappend lista_anom "M6"
	     }
	     if {[string equal $co2 ""]
		 || $co2 > 30.00} {
		 lappend lista_anom "M7"
	     }
	     if {$cod_combustibile == "1"
		 &&  ([string equal $bacharach ""]
		      || $bacharach > 2.00
		      || [string equal $bacharach "0.00"])} {
		 lappend lista_anom "M9"
	     }
	     
	     if {$cod_combustibile == "2"
		 &&  ([string equal $bacharach ""]
		      || $bacharach > 6.00)} {
		 lappend lista_anom "M9"
	     }
	     if {[string equal $co ""]
		 || $co > 1000
		 || [string equal $co "0.00"]} {
		 lappend lista_anom "M10"
	     }
	     

# rendimento 
    set rend_min ""
    if {[string equal $potenza_nominale ""]} {
		set potenza_nominale 0.1
	     }
   if {[string equal $potenza_nominale "0"]} {
		set potenza_nominale 0.1
	     }

    switch $fluido_termovettore {
	1 {
	    if {[iter_check_date $data_installazione] <= "19931029"} {
		set rend_min [expr 82 + 2*[expr log10($potenza_nominale)]]
                if {$rend_combust < $rend_min} {
                   lappend lista_anom "M12"
                  }
			    }
	    if {([iter_check_date $data_installazione] > "19931029") && ([iter_check_date $data_installazione] <= "19971231")} {
		set rend_min [expr 84 + 2*[expr log10($potenza_nominale)]]
                 if {$rend_combust < $rend_min} {
                   lappend lista_anom "M12"
                  }
		    }
	    if {[iter_check_date $data_installazione] > "19980101" && [iter_check_date $data_installazione] <= "20051007"} {
		switch $class_dpr {
		    S { set rend_min [expr 84 + 2*[expr log10($potenza_nominale)]] 
					    }
		    B { set rend_min [expr 87,5 + 1,5*[expr log10($potenza_nominale)]] 
			
		    }
		    G { set rend_min [expr 91 + [expr log10($potenza_nominale)]] 
			
		    }
		    default { set rend_min [expr 84 + 2*[expr log10($potenza_nominale)]] 
					    }
		}
             if {$rend_combust < $rend_min} {
                   lappend lista_anom "M12"
                  }
	    }
	    if {[iter_check_date $data_installazione] >= "20051008"} {
		set rend_min [expr 89 + 2*[expr log10($potenza_nominale)]]
		if {$rend_combust < $rend_min} {
                   lappend lista_anom "M12"
                  }
	    }
	}

	2 {
	    if {[iter_check_date $data_installazione] <= "19931029"} {
		set rend_min [expr 77 + 2*[expr log10($potenza_nominale)]]
		if {$rend_combust < $rend_min} {
                   lappend lista_anom "M12"
                  }
	    }
	    if {[iter_check_date $data_installazione] > "19931029"} {
		set rend_min [expr 80 + 2*[expr log10($potenza_nominale)]]
		if {$rend_combust < $rend_min} {
                   lappend lista_anom "M12"
                  }
	    }

	}
    }

	     if {$rend_min == ""
                &&[iter_check_date $data_installazione] <= "19931029"} {
                 set rend_min [expr 77 + 2*[expr log10($potenza_nominale)]]
                  if {$rend_combust < $rend_min} {
                   lappend lista_anom "M12"
                  }
             } 


            if {$rend_min == ""
                &&([iter_check_date $data_installazione] > "19931029") && ([iter_check_date $data_installazione] <= "19971231")} {
                 set rend_min [expr 84 + 2*[expr log10($potenza_nominale)]]
                  if {$rend_combust < $rend_min} {
                   lappend lista_anom "M12"
                  }
             } 


           if {$rend_min == ""
                &&([iter_check_date $data_installazione] > "19980101") && ([iter_check_date $data_installazione] <= "20051007")} {
                 set rend_min [expr 80 + 2*[expr log10($potenza_nominale)]]
                  if {$rend_combust < $rend_min} {
                   lappend lista_anom "M12"
                  }
             } 

           if {$rend_min == ""
                &&([iter_check_date $data_installazione] >= "20051008")} {
                 set rend_min [expr 87 + 2*[expr log10($potenza_nominale)]]
                  if {$rend_combust < $rend_min} {
                   lappend lista_anom "M12"
                  }
             } 



	     if {![string equal $tiraggio ""]
		 && $tiraggio < 3
		 && $tiraggio_gend == "N"
		 && $scar_parete != "S"
               && $tipo_foco == "A" } {
		 lappend lista_anom "M11"
	     }
           if {![string equal $tiraggio ""]
		  && $tiraggio_gend == "F"
		 && $tipo_foco == "A" } {
		 lappend lista_anom "M13"
	     }
             if {![string equal $tiraggio ""]
		  && $tiraggio_gend == "F"
		 && $tipo_foco == "C" } {
		 lappend lista_anom "M13"
	     }
          if {![string equal $tiraggio ""]
		  && $tiraggio_gend == "N"
		 && $tipo_foco == "C" } {
		 lappend lista_anom "M13"
	     }

	 }

	 if {$flag_status == "N"} {
	     lappend lista_anom "M15"
	 }

         if {$flag_status == ""} {
	     lappend lista_anom "M14"
	 }


#	 if {![string equal $raccomandazioni ""]} {
#	     lappend lista_anom "GL1"
#	 }
	 


	 db_transaction {
	     db_dml del_anom "delete from coim_d_anom where cod_cimp_dimp = :cod_dimp"
	     set conta 0
	     foreach cod_d_tano $lista_anom {
		 if {[db_0or1row sel_descr "select descr_breve,
                                                                   gg_adattamento
                                                                 from coim_d_tano
                                                                  where cod_tano = :cod_d_tano"] == 0} {

		     append msg "tipo anomalia $cod_d_tano inesistente;
                                "
		     continue
		 }

		 incr conta
		 
		 set data_uti_inter [db_string query "select :data_controllo::date + :gg_adattamento::integer" -default ""]
#                                              ns_log Notice "prova Mariano dt uti inter $cod_d_tano $data_uti_inter"
                                              db_dml ins_anom "insert into coim_d_anom
                                                                           ( cod_cimp_dimp
                                                                           , prog_anom
                                                                           , tipo_anom
                                                                           , cod_tanom
                                                                           , dat_utile_inter
                                                                           , flag_origine
                                                                           ) values (
                                                                            :cod_dimp
                                                                           ,:conta
                                                                           , null
                                                                           ,:cod_d_tano
                                                                           ,:data_uti_inter
                                                                           , 'MH'
                                                                           )"
	     }
	 }
     }


    set progressivo [db_string query "select coalesce(max(progressivo) + 1,1) as progressivo from coim_d_esit"]
    db_dml ins_esit "insert into coim_d_esit ( progressivo
                                              , data_elaborazione
                                              , flag_tracciato
                                              ) values (
                                               :progressivo
                                              , current_date
                                              , 'G')"


    set msg " Fine caricamento."

    element set_properties $form_name msg -value $msg
    ad_return_template

}


