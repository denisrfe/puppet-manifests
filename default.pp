file {'/etc/localtime':
  ensure => link,
  target => '/usr/share/zoneinfo/America/Sao_Paulo',
}

#notify {"Ajustado arquivo localtime":
#  require => File['/etc/localtime'],
#}

file {'/etc/ssh/sshd_config':
  ensure     => file,
  mode       => '0644',
  owner      => 'root',
  group      => 'root',
  source     => 'puppet:///modules/ssh/sshd_config',
  notify     => Service['ssh'],
}

case $::operatingsystem {
  centos: { $openssh = 'sshd'}
  redhat: { $openssh = 'sshd'}
  debian: { $openssh = 'ssh'}
  ubuntu: { $openssh = 'ssh'}

  default: {
    fail("Unknown Operating System")
  }
}

service { $openssh:
  ensure     => running,
  enable     => true,
  hasrestart => true,
  hasstatus  => true,
}

case $::operatingsystem {
  centos: { $ntp = 'ntpd'}
  redhat: { $ntp = 'ntpd'}
  debian: { $ntp = 'ntp'}
  ubuntu: { $ntp = 'ntp'}
  
  default: {
    fail("Unknown Operating System")
  }
}

package { $ntp:
  ensure     => 'installed',
}
 
service { 'ntp':
  ensure     => running,
  enable     => true,
  hasrestart => true,
  hasstatus  => true,
  require    => Package['ntp'],
}

package { 'net-tools':
  ensure     => 'installed'
}

package { 'vim':
  ensure => 'installed'
}

package { 'telnet':
  ensure => 'installed'
}

package { 'deborphan':
  ensure => 'installed'
}

package { 'aptitude':
  ensure => 'installed'
}

package { 'unzip':
  ensure => 'installed'
}

package {'zile':
  ensure => 'installed'
}

package {'nano':
  ensure => 'absent'
}

package {'xinetd':
  ensure => 'installed'
}

service {'xinetd':
  ensure => 'running',
  enable => 'true',
}
