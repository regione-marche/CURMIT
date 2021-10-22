# controllo se il file di input esiste passato come parametro
if {![file exists $file_inp_path$file_inp_name]} {
    puts "File non trovato: $file_inp_path$file_inp_name"
    return
}

# apro il file in lettura e metto in file_inp_id l'identificativo del file
# per poterlo leggere successivamente
if {[catch {set file_inp_id [open $file_inp_path$file_inp_name r]}]} {
    puts "File di input non aperto: $file_inp_path$file_inp_name"
    return
}

# apro il file in scrittura e metto in file_out_id l'identificativo del file
# per poterlo scrivere successivamente
if {[catch {set file_out_id [open $file_out_path$file_out_name w]}]} {
    puts "File di output non aperto: $file_out_path$file_out_name"
    return
}

fconfigure $file_inp_id -encoding iso8859-1
fconfigure $file_out_id -encoding iso8859-1

# lettura
gets $file_inp_id file_inp_record

# Ciclo di lettura sul file di input
while {![eof $file_inp_id]} {

   set file_out_record ""
   set colonna_ctr  1
   set colonne_list [split $file_inp_record "|"]
   foreach colonna $colonne_list {
       set colonna [string trim $colonna]
       # if {$colonna == ""} {
       #     set colonna {\N}
       # }
       append file_out_record $colonna
       if {[llength $colonne_list] != $colonna_ctr} {
           append file_out_record "|"
       }
       incr colonna_ctr
   }

   # scrittura
   puts $file_out_id $file_out_record

   # lettura
   gets $file_inp_id file_inp_record
}

close $file_out_id
close $file_inp_id