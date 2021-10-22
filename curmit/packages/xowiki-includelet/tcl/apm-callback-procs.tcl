ad_library {

    Xowiki includelet for use with the layout manager

    @creation-date 2008-07-16
    @author Don Baccus <dhogaza@pacifier.com>
    @version $Id: apm-callback-procs.tcl,v 1.1.1.1 2008/08/02 12:48:57 donb Exp $
}

namespace eval xowiki_includelet::install {}

ad_proc -private xowiki_includelet::install::package_install {} {
    Package installation callback proc
} {

    db_transaction {

        # Admin includelet
        layout::includelet::new \
            -name xowiki_admin_includelet \
            -description "Displays xowiki admin includelet" \
            -title #xowiki-includelet.admin_includelet_pretty_name# \
            -application xowiki \
            -template /packages/xowiki-includelet/lib/xowiki-admin-includelet \
            -required_privilege admin \
            -initializer xowiki_includelet_utilities::configure_admin_includelet

        # User includelet
        layout::includelet::new \
            -name xowiki_includelet \
            -description "Displays the xowiki includelet" \
            -title #xowiki-includelet.admin_includelet_element_pretty_name# \
            -application xowiki \
            -template /packages/xowiki-includelet/lib/xowiki-includelet \
            -internally_managed_p t
    }
}

ad_proc -private xowiki_includelet::install::package_uninstall {} {
    Package uninstallation callback proc
} {
    layout::includelet::delete -name xowiki_includelet
    layout::includelet::delete -name xowiki_admin_includelet
}

