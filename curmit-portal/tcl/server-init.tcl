# schedulo la propagazione dei manutentori convalidati
ad_schedule_proc -thread t -schedule_proc ns_schedule_daily {4 30} iter::iter_instances_sync

#per le marche la schedulo ogni 30 min e non una volta al giorno
#ad_schedule_proc 1800 iter::iter_instances_sync

# schedulo la propagazione dei bollini
ad_schedule_proc -thread t -schedule_proc ns_schedule_daily {4 40} iter::propaga_bollini

# schedulo la propagazione dei bollini trasferiti
ad_schedule_proc -thread t -schedule_proc ns_schedule_daily {4 50} iter::propaga_bolltrasf

ad_schedule_proc -schedule_proc ns_schedule_daily [list 22 30] ns_shutdown
ad_schedule_proc -schedule_proc ns_schedule_daily {23 59} ns_logroll
ns_log Notice "ut_logroll scheduled" 

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

#ns_log Notice "\nwallet: procedure portafoglio Lottomatica e Sisal schedulate"
