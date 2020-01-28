node 'loki', 'ultron', 'hela' {
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
    ensure             => 'present',
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
  }
  
  service {'docker':
    ensure => 'running',
    enable => 'true',
  }

  # puppet module install AlexCline/fstab
  fstab { 'NFS test-environment':
    source => '172.31.10.20:/compartilhado',
    dest   => '/home/mgeweb/compartilhado',
    type   => 'nfs',
    opts   => 'defaults',
    dump   => 0,
    passno => 0,
  }

  # puppet module install thias-sysctl
  sysctl {'vm.swappiness':
    value => '0'
  }

  # puppet module install thias-sysctl
  sysctl {'vm.overcommit_memory':
    value => '1'
  }

  # puppet module install thias-sysctl
  sysctl {'fs.inotify.max_user_watches':
    value => '16384'
  }

  # puppet module install thias-sysctl
  sysctl {'fs.inotify.max_user_instances':
    value => '1024'
  }
}
