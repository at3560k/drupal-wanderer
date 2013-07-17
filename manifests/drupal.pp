## drupal.pp ##

class drupal {

    #package{"drupal7":
    #    ensure => present
    #}
    
    package{"drush":
        ensure => present
    }

    file{"/var/www/drupal":
        ensure => link,
        #target => "/var/www/drupal-7.22",
        target => "/drupal_inst/drupal-7.22",
        require => [Package["apache2"]],
    }

    #file{"/var/www/drupal-7.22":
    #file{"/drupal_inst/drupal-7.22":
    #    #owner => "www-data",
    #    #group => "www-data",
    #    recurse => true, # recursive ownership
    #    ensure => directory,
    #    # mode => 655,  # Don't execute bit text files...
    #    require => [Exec["drupal_dl"]]
    #}

    #exec{"drupal_dl": 
    #   #command => "/usr/bin/sudo -u www-data /usr/bin/drush dl drupal",
    #   command => "/usr/bin/drush dl drupal",
    #   #cwd => "/var/www",
    #   cwd => "/drupal_inst",
    #   #user => "vagrant",
    #   #creates => "/var/www/drupal-7.22",
    #   #creates => "/drupal_inst/drupal-7.22",
    #   #creates => "/drupal_inst/drupal-7.22/themes",  # still too fast
    #   creates => "/drupal_inst/drupal-7.22/modules/locale/tests/locale_test.module",
    #   require => [Package["drush"], Package["apache2"]],
    #   #before => [Exec["drush_build"]],
    #}

    exec{"vagrant_www_data":
        command => "/usr/bin/sudo /usr/sbin/usermod -a -G www-data vagrant",
        require => [Package["apache2"]]
    }


    #exec {"drush_build":
    #   # As vagrant, change to www-data, run drush answering yes to hose the database...
    #   #command => "/usr/bin/sudo -u www-data /usr/bin/drush --yes site-install standard --account-name=admin --account-pass=ChangeThis1 --db-url=mysql://root:ChangeThis1@127.0.0.1/drupal",
    #   command => "/usr/bin/drush --yes site-install standard --account-name=admin --account-pass=ChangeThis1 --db-url=mysql://root:ChangeThis1@127.0.0.1/drupal",
    #   # TODO: how do I pick this up... ?
    #   #cwd => "/var/www/drupal-7.22",
    #   cwd => "/drupal_inst/drupal-7.22",
    #   require => [Package["drush"], Service["mysql"], Exec["drupal_dl"], Exec["enable_drupal"]],
    #   user => "vagrant",
    #}

    file{"/etc/apache2/sites-available/drupal":
        notify => Service["apache2"],
        ensure => "present",
        source => "/vagrant/modules/drupal/drupal.conf",
        owner => "root",
        group => "root",
        mode => 644,
        require => [Package["apache2"], Package["php5"]],
    }

    exec { "rewrite":
        notify => Service["apache2"],
        command => "/usr/sbin/a2enmod rewrite",
        require => Package["apache2"]
    }

    exec { "enable_drupal":
        notify => Service["apache2"],
        command => "/usr/sbin/a2ensite drupal",
        require => [Package["apache2"], File["/etc/apache2/sites-available/drupal"]],
    }

    #notice("Please configure at: http://localhost:8080/drupal7/install.php")
    notice("Please check at: http://localhost:8080/drupal7/")

}
