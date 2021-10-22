# lanciare questo script con tclsh cmd_trimright.jcl
# definisci il percorso del file di dati
set file_out_path    "/usr/local/aolserver/servers/acs46/packages/iter/sql/oracle/file"
set file_inp_path    $file_out_path

set file_inp_name "/coimfunz.dat"
set file_out_name "/coimfunz.dat.new"
source cmd_trimright.tcl

set file_inp_name "/coimogge.dat"
set file_out_name "/coimogge.dat.new"
source cmd_trimright.tcl

set file_inp_name "/coimmenu.dat"
set file_out_name "/coimmenu.dat.new"
source cmd_trimright.tcl
