ad_library {

    initialization for bulk-mail module

    @author yon (yon@openforce.net)
    @creation-date 2002-05-07
    @cvs-id $Id: bulk-mail-init.tcl,v 1.4 2008/01/16 10:00:08 emmar Exp $

}

# default interval is 1 minute
ad_schedule_proc -thread t 60 bulk_mail::sweep
nsv_set bulk_mail_sweep bulk_mail_sweep 0
