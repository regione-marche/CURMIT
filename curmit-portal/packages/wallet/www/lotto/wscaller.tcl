#
# N.B. esempi da utilizzare chiamando da un altro server
#

# Istruzione per far andare il programma in errore perchè questo programma non deve essere
# chiamato da nessuno.
ad_script_abort

# ======================================================================================
# ( Esempio di chiamata al WEB SERVICE : 'move.tcl' )
# ======================================================================================
# ( Importo la 'URL' per la chiamata al 'WEB SERVICE' che crea i movimenti di portafolgio )
# set url "http://www.curit.it:$port/lotto/move?wallet_id=$wallet_id&body_id=$body_id&tran_type_id=$tran_type_id&payment_t\
# ype=C&payment_date=$data_storno&reference=$reference&description=$description&amount=$amount"

# esempio di chiamata al web service ec
#set url "http://www.curit.it:8009/lotto/ec?wallet_id=000100052450083161&from_date=2008-05-18&to_date=2008-05-23"

# esempio di chiamata al web service ec
set url "http://192.168.11.7:8009/lotto/balance?iter_code=MAxyz"

set data [ad_httpget -url $url -timeout 3]
array set result $data

ns_return 200 text/html "$result(page)"
