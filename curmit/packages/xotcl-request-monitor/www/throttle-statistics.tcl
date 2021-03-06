ad_page_contract {
  present throttle statistics, active users, etc

  @author Gustaf Neumann
  @cvs-id $Id: throttle-statistics.tcl,v 1.2.2.1 2013/09/17 19:29:57 gustafn Exp $
} -properties {
  title:onevalue
  context:onevalue
  throttle_statistics
  throttle_url_statistics
}

set title "Throttle statistics"
set throttle_statistics [throttle statistics]
set data [throttle url_statistics]

template::list::create \
    -name url_statistics \
    -elements { 
      time {label Time}
      type {label Type}
      user {
	label Userid
	link_url_col user_url}
      IPadress  {label "IP Address"}
      URL {label "URL"}
    }

multirow create url_statistics type user user_url time IPadress URL
foreach l [lsort -index 2 $data] {
  lassign $l type user time IPadress URL
  if {[string match *.* $user]} {
    set user "Anonymous"
    set user_url ""
  } else {
    acs_user::get -user_id $user -array userinfo
    set user_url /acs-admin/users/one?user_id=$user
    set user "$userinfo(first_names) $userinfo(last_name)"
  }
  set time [clock format $time -format "%Y-%m-%d %H:%M:%S"]
  multirow append url_statistics $type $user $user_url $time $IPadress $URL
}

#set throttle_url_statistics [throttle url_statistics]

