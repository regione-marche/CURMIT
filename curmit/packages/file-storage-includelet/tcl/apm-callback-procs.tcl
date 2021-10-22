ad_library {

    Forums Portlet Install library

    Procedures that deal with installing, instantiating, mounting.

    @creation-date 2003-12-31
    @author Don Baccus <dhogaza@pacifier.com>
    @cvs-id 
}

namespace eval file_storage_includelet::install {}

ad_proc -private file_storage_includelet::install::package_install {} {
    Package installation callback proc
} {

    db_transaction {

        # admin includelet
        layout::includelet::new \
            -name file_storage_admin_includelet \
            -description #file-storage-includelet.admin_pretty_name# \
            -title #file-storage-includelet.admin_pretty_name# \
            -application file-storage \
            -template /packages/file-storage-includelet/lib/file-storage-admin-includelet \
            -initializer file_storage_includelet::initialize \
            -required_privilege admin

        # contents includelet
        layout::includelet::new \
            -name file_storage_contents_includelet \
            -description #file-storage-includelet.content_pretty_name# \
            -title #file-storage-includelet.content_pretty_name# \
            -application file-storage \
            -template /packages/file-storage-includelet/lib/file-storage-contents-includelet \
            -initializer file_storage_includelet::initialize

        # User includelet
        layout::includelet::new \
            -name file_storage_includelet \
            -description #file-storage-includelet.pretty_name# \
            -title #file-storage-includelet.pretty_name# \
            -application file-storage \
            -template /packages/file-storage-includelet/lib/file-storage-includelet \
            -initializer file_storage_includelet::initialize
    }
}

ad_proc -private file_storage_includelet::install::package_uninstall {} {
    Package uninstallation callback proc
} {
    layout::includelet::delete -name file_storage_admin_includelet
    layout::includelet::delete -name file_storage_includelet
    layout::includelet::delete -name file_storage_contents_includelet
}
