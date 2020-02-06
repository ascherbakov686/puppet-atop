# == Class: atop
#
# Allow to install and configure atop.
#
# === Parameters
#
# [*package_name*]
#   Package name, default to atop.
#
# [*service_name*]
#   Service name, default to atop.
#
# [*service_run*]
#   Ensure atop service running, default to false.
#
# [*service_enable*]
#   Enable atop service, default to false.
#
# [*interval*]
#   Interval between snapshots, default to 600.
#
# [*logpath*]
#   Directory were the log will be saved by the service.
#   Default is /var/log/atop.
#
# [*rotate_count*]
#   Number of saved log files
#
# [*rotate_days*]
#   Remove old files
#
class atop (
  $package_name = 'atop',
  $service_name = 'atop',
  $service_run = true,
  $service_enable = true,
  $interval = 600,
  $logpath = '/var/log/atop',
  $confpath = '/etc/sysconfig/atop',
  $rotate_count = '1',
  $rotate_days = '+6',
) {

  package { $package_name:
    ensure => 'installed',
  }

  file { $confpath:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('atop/atop.epp'),
    notify  => Service[$service_name],
  }

  file { '/etc/logrotate.d/atop':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('atop/atop.logrotate.epp'),
  }

  file { '/usr/lib/systemd/system/atop.service':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/atop/atop.service',
  }
  ~>
  exec { 'service-systemd-reload':
       command     => 'systemctl daemon-reload',
       path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
       refreshonly => true,
       notify      => Service[$service_name],
  }

  service { $service_name:
    ensure => $service_run,
    enable => $service_enable,
    require => Package[$package_name],
  }
}
