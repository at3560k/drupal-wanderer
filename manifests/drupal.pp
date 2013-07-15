## drupal.pp ##

class drupal {

    package{"drupal7":
        ensure => present
    }

    file {'/etc/apache2/mods-enabled/drupal.conf':
        ensure => file,
        mode => 644,
        require => Package["drupal7"],
        source => '/etc/drupal/7/apache2.conf'
    }

    notice("Please configure at: http://localhost:8080/drupal7/install.php")

}
