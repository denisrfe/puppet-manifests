node 'ranchermaster' {
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

  group {'mgeweb':
    ensure             => 'present',
    gid                => '1002',
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
    ensure   => 'present',
    content  => "ubuntu ALL=(ALL) NOPASSWD: ALL",
  }
  sudo::conf { 'mgeweb':
    priority => 80,
    ensure   => 'absent',
    content  => "mgeweb ALL=(ALL) NOPASSWD: ALL",
  }
  
  host {'puppetmaster.sankhya.com.br':
    ensure             => 'present',
    host_aliases       => ['puppetmaster'],
    ip                 => '172.31.10.11',
  }
  
  service{'docker':
    ensure             => 'running',
    enable             => 'true',
  }
}
