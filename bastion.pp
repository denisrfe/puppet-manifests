node 'bastion' {
  group {'ubuntu':
    ensure             => 'present',
    gid                => '1001',
  }

  user {'ubuntu':
    ensure             => 'present',
    comment            => 'Ubuntu',
    gid                => 1001,
    home               => '/home/ubuntu',
    password           => '!',
    password_max_age   => 99999,
    password_min_age   => 0,
    password_warn_days => 7,
    shell              => '/bin/bash',
    uid                => 1001,
  }

  user {'mgeweb':
    ensure             => 'absent',
    comment            => 'Application User',
    gid                => 1002,
    groups             => ['docker', 'sudo'],
    home               => '/home/mgeweb',
    password           => '!',
    password_max_age   => 99999,
    password_min_age   => 0,
    password_warn_days => 7,
    shell              => '/bin/bash',
    uid                => 1002,
    managehome	       => true,
  }
  
  # puppet module install saz-sudo
  class { 'sudo': }
  sudo::conf { 'ubuntu':
    priority => 90,
    content => "ubuntu ALL=(ALL) NOPASSWD: ALL",
  }
  
  sudo::conf { 'mgeweb':
    priority => 80,
    content => "mgeweb ALL=(ALL) NOPASSWD: ALL",
  }
  
  host {'ranchermaster.sankhya.com.br':
    ensure => 'present',
    host_aliases => ['ranchermaster'],
    ip => '172.31.20.2',
  }

  host {'puppetmaster.sankhya.com.br':
    ensure => 'present',
    host_aliases => ['puppetmaster'],
    ip => '172.31.10.11',
  }

  host {'bastion.sankhya.com.br':
    ensure => 'present',
    host_aliases => ['bastion'],
    ip => '172.31.40.3',
  }

  host {'loki.sankhya.com.br':
    ensure => 'present',
    host_aliases => ['loki'],
    ip => '172.31.10.8',
  }

  host {'ultron.sankhya.com.br':
    ensure => 'present',
    host_aliases => ['ultron'],
    ip => '172.31.10.12',
  }

  host {'hela.sankhya.com.br':
    ensure => 'present',
    host_aliases => ['hela'],
    ip => '172.31.10.7',
  }
  
  host {'visao.sankhya.com.br':
    ensure => 'present',
    host_aliases => ['visao'],
    ip => '172.31.20.7',
  }

  host {'terminalserver.sankhya.com.br':
    ensure => 'present',
    host_aliases => ['terminalserver'],
    ip => '172.31.40.6',
  }
}
