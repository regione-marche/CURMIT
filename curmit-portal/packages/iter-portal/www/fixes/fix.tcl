ad_page_contract {

    One time fix.    
    Usare se gli aggiornamenti su iter sono andati bene, ma non quelli su curit.
    Le liste maintainers, operators e trustees devono essere popolate con i dati
    presi dal file iter-update.log.

    @author Claudio Pasolini
    @cvs-id $Id: fix.tcl

} {
}

db_transaction {
    # new maintainers
    set maintainers [list {MA008748 {AL.L. GLOBAL SERVICE S.R.L.} {VIA CORRADI 17} {} MB 20030 SEVESO 02985440961 02985440961 0362650181 3455845163 0362650181 allglobalservice@email.it 1618931 {MONZA BRIANZA} {MB 1618931} {MONZA BRIANZA} {} 0 141553} {MA008749 {LM MARCHESINI SRL} {VIA DEI CAVALERI 12} LUGAGNANO VR 37060 SONA 03822620237 03822620237 0458680151 3386237056 0458699316 lmmarlu@tiscali.it 03822620237 VERONA VR368603 VERONA 20000.00 1 141561} {MA008750 {SUICO FABIO} {VIA COLONNE, 2/4} COLONNE PV 27100 {TRAVACÒ SICCOMARIO} SCUFBA66H29G388G 01343690184 {339 2969433} {} {} fabio.suico@libero.it {} {} {} {} {} 0 141569} {MA008751 {MAGLIA CRISTIAN} {VIA PINO 17} FIUMELATTE LC 23829 VARENNA MGLCST80H20F712Y 03244260133 3337003566 {} {} magliacristian@alice.it {} {} {} {} {} 0 141625} {MA008752 {TERMOIDRAULICA DI MARCARINI ANTONIO} {VIA XI SETTEMBRE 1} {} BS 25020 {AZZANO MELLA} MRCNTN62A30B157V 02950210985 3358162190 {} {} Termoidraulica.Marcarini@alice.it {} {} {} {} {} 0 141632} {MA008753 {SANDRINI GIOVANMARIA} {VIA BOTTA 42} {} BS 25124 BRESCIA SNDGNM47E05E883Q 02963380171 030/3533147 335/6289780 {} . SNDGNM47E05E883Q BRESCIA 307848 BRESCIA {} 0 1003121} {MA008754 {BONFADELLI ERMINIO} {VIA ROMA, 96/F} {} BS 25064 GUSSAGO BNFRMN41R18E271Y 00471510171 3391545542 3391545542 {} . 1996-24357 BRESCIA 176728 BRESCIA {} 0 1003122} {MA008755 {TERMOIDRAULICA DI BONOMETTI PAOLO} {VIA BEVILACQUA,9} {} BS 25073 BOVEZZO BNMPLA66T06B157T 03185950171 0302712964 {} {} . {} {} 337598 BRESCIA {} 0 1003123} {MA008756 {DIEFFE IMPIANTI DI FEDELE DAVIDE} {PIAZZA BERNINI, 6} {} MI 20032 CORMANO FDLDVD69R11F205O 13292370155 347/2737805 {} {} . {} {} {} {} {} 0 1003124} {MA008757 {BANDERA ANDREA} {VIA DELLA LIBERTÀ, 5} {} MI 20020 LAINATE BNDNDR75S22H264V 04071630968 338/2511652 {} {} . {} {} {} {} {} 0 1003125}]

    set operators [list {MA00874801 {LAURINO } LUIGI 07 LRNLGU58L04L181K {} {} {} {} 56894718 13711} {MA00874802 {QUERO } LORENZO 37 QRULNZ92L06F704M {} {} {} {} 98911607 13712} {MA00874901 MARCHESINI LUCA 01 MRCLCU67R30F861K {} {} {} {} 98001542 13715} {MA00874902 {DE MORI} ROBERTO 06 DMRRRT67P11L781D {} {} {} {} 33485510 13716} {MA00874903 CERIANI {ANDREA } 02 CRNNDR66E12L781V {} {} {} {} 69869683 13717} {MA00875001 SUICO FABIO 001 SCUFBA66H29G388G {} {} {} {} 79067643 13718} {MA00875101 MAGLIA CRISTIAN . MGLCST80H20F712Y 3337003566 {} {} {} 29289265 13722} {MA00875201 MARCARINI ANTONIO 12345678 MRCNTN62A30B157V {} 3358162190 {} {} 40596278 13723} {MA00875301 SANDRINI GIOVANMARIA 01 SNDGNM47E05E883Q 030/3533147 335/6289780 {} {} 7124485 13713} {MA00875401 BONFADELLI ERMINIO 01 BNFRMN41R18E271Y {} {} {} {} 85972650 13714} {MA00875501 BONOMETTI PAOLO 01 BNMPLA66T06B157T {} {} {} {} 52758058 13719} {MA00875601 FEDELE DAVIDE 1 FDLDVD69R11F205O {} {} {} {} 23838734 13720} {MA00875701 BANDERA ANDREA 1 BNDNDR75S22H264V {} {} {} {} 45202331 13721}]

    foreach maintainer $maintainers {
	set iter_code     [lindex $maintainer 0]
 	set maintainer_id [lindex $maintainer 19]

        set cait_id [db_string cait "select cait_id from iter_maintainers where maintainer_id = :maintainer_id"]
        lappend maintainers_to_notify [list $maintainer_id $cait_id]
	
	db_dml validate "
            update iter_maintainers set 
                validating_date = current_date
              , iter_code       = :iter_code 
              , validated_p     = 't'
            where maintainer_id = :maintainer_id"
    }

    # aggiorno operatori
    foreach operator $operators {
	set iter_no     [lindex $operator 0]
	set password    [lindex $operator 9]
	set operator_id [lindex $operator 10]

	db_dml op_upd "
            update iter_operators set 
                iter_no  = :iter_no, 
                password = :password 
            where operator_id = :operator_id"
    }

    # upd maintainers

    set operators [list {MA00487101 {CASTELLI } {FRANCESCO } 1 CSTFNC53L25B639J {} {} {} {} 51655092 t} {MA00551701 TACCHINI EGIDIO 25 TCCGDE60H14D142O {} {} {} {} 30458675 t} {MA00551702 LOCATELLI ALESSANDRO 103 LCTLSN87M19D142E {} {} {} {} 17280092 t} {MA00551703 {VAILATI CANTA} {GIAN MICHELE} 114 VLTGMC73T23D142K {} {} {} {} 43273319 t} {MA00551704 MOMBELLI {MARCO EGIDIO} 1 MMBMCG68D07D142I {} {} {} {} 97811641 t} {MA00749301 NICOSIA {CARMELO } NICO5319 NCSCML53R19C351V 0298243865 337287456 {VIA ROMILLI  20/6} {} 26010802 t} {MA00862601 {BARATTI } VITTORIO 0 BRTVTR66P05D999S {} {} {} {} 18634259 t} {MA00862602 BARATTI GIANMARIO 0 BRTGMR65P06D999I {} {} {} {} 38377485 t}]

    # aggiorno operatori
    foreach operator $operators {
	set iter_no     [lindex $operator 0]
	set password    [lindex $operator 9]
	set operator_id [lindex $operator 11]

	# aggiorno operatore                
	db_dml op_upd "
            update iter_operators set 
                iter_no = :iter_no, 
                password = :password 
            where operator_id = :operator_id"
    }

    # trustees new

    set trustees [list {AM003325 ZANZOTTERA GIOVANNI {VIA G.FERRARIS, 41} LEGNANO {} MI 20025 ZNZGNN39L08F205E {} 0331/451880 {} 0331/451880 studiozanzotterag@email.it F 48021690 141570} {AM003326 UBOLDI VITTORIO {VIA BATTOCLETTI SNC} GARGNANO {} BS 25080 BLDVTR50T15L319V {} 036571294 {} {} info@abitareilgarda.com F 70877056 141613}]

    # aggiorno amministratori
    foreach trustee $trustees {
	set iter_code   [lindex $trustee 0]
	set password    [lindex $trustee 15]
	set trustee_id  [lindex $trustee 16]

        set office_id [db_string office "select office_id from iter_trustees where trustee_id = :trustee_id"]
        lappend trustees_to_notify [list $trustee_id $office_id]

	db_dml query "
            update iter_trustees set 
                validating_date = current_date, 
                iter_code       = :iter_code 
              , password        = :password 
              , validated_p     = 't'
            where trustee_id = :trustee_id"
    }
}

# tutto è andato bene e quindi posso notificare i manutentori e gli amministratori
# di condominio

# notifica manutentori 
foreach maintainer $maintainers_to_notify {
    util_unlist $maintainer maintainer_id cait_id

    if {$cait_id ne ""} {
	iter::notify_maintainer_with_cait -maintainer_id $maintainer_id -cait_id $cait_id
    } else {
	iter::notify_maintainer -maintainer_id $maintainer_id
    }
}

# notifica gli amministratori di condominio
foreach trustee $trustees_to_notify {
    util_unlist $trustee trustee_id office_id

    if {$office_id ne ""} {
	iter::notify_trustee_with_office -trustee_id $trustee_id -office_id $office_id
    } else {
	iter::notify_trustee -trustee_id $trustee_id
    }
}

ns_return 200 text/html OK
