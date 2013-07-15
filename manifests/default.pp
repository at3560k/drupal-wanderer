# Define filebucket 'main':
filebucket { 'main':
  path   => '/root/puppet_backup',
}

# Make filebucket 'main' the default backup location for all File resources:
File { backup => 'main' }

package { 'openssh-server':
  ensure => present,
#  before => File['/etc/ssh/sshd_config'],
}

file { '/etc/ssh/sshd_config':
  ensure => file,
  mode   => 600,
  source => '/vagrant/manifests/cnf/sshd_config',
  # And yes, that's the first time we've used the "source" attribute. It accepts
  # absolute local paths and puppet:/// URLs, which we'll say more about later.
}



# ubuntu is ssh, not sshd
service {'ssh':
  ensure    => running,
  enable    => true,
  subscribe => File['/etc/ssh/sshd_config'],
}


package { "openssh-blacklist" : ensure => "installed"}
package { "openssl-blacklist" : ensure => "installed"}

package { "git" : ensure => "installed" }
package { "mercurial" : ensure => "installed" }
package { "subversion" : ensure => "installed" }

include lamp
include drupal
