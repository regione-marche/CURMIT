
#Nicola 13/05/2015: il roll del log viene gia' fatto in automatico alle 00:00
#                   (vedere da web monitoring e scheduled procedures)
#ad_schedule_proc -schedule_proc ns_schedule_daily {23 59} ns_logroll

#Riavvio NaviServer
ad_schedule_proc -schedule_proc ns_schedule_daily [list 04 00] ns_shutdown

# schedulo la preparazione dei file di carico per Lottomatica e Sisal ogni Giovedì alle h 4:10
#ad_schedule_proc -thread t -schedule_proc ns_schedule_weekly {4 4 10} wal::prepare_holders_file

# schedulo l'invio dei file di carico a Lottomatica ogni Giovedì alle h 4:30
#ad_schedule_proc -thread t -schedule_proc ns_schedule_weekly {4 4 30} wal::send_holders_file_lotto

# schedulo l'invio dei file di carico a Sisal ogni Giovedì alle h 4:40
#ad_schedule_proc -thread t -schedule_proc ns_schedule_weekly {4 4 40} wal::send_holders_file_sisal

# schedulo la ricezione della risposta al file di carico a Lottomatica ogni Venerdì alle h 4:00
#ad_schedule_proc -thread t -schedule_proc ns_schedule_weekly {5 4 0} wal::get_holders_response_lotto

# schedulo la ricezione della risposta al file di carico a Sisal ogni Venerdì alle h 4:15
#ad_schedule_proc -thread t -schedule_proc ns_schedule_weekly {5 4 15} wal::get_holders_response_sisal

# schedulo la ricezione del file movimenti da Lottomatica ogni giorno alle h 6:30
#ad_schedule_proc -thread t -schedule_proc ns_schedule_daily {06 30} wal::get_transactions_file_lotto

# schedulo la ricezione del file movimenti da Sisal ogni giorno alle h 6:45
#ad_schedule_proc -thread t -schedule_proc ns_schedule_daily {06 45} wal::get_transactions_file_sisal

# schedulo la ricezione giornaliera dei bonifici ogni giorno alle h 9:00
#ad_schedule_proc -thread t -schedule_proc ns_schedule_daily {9 0} wal::daily_transfers

# ns_log Notice "\nwallet: procedure portafoglio Lottomatica e Sisal schedulate"
