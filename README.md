[![Build Status](https://img.shields.io/travis/cjtoolseram/puppet-atop.svg)](https://travis-ci.org/cjtoolseram/puppet-atop)

# atop

#### Table of Contents

1. [Description](#description)
2. [Easy Setup](#easy-setup)
3. [Advance Usage](#advance-usage)
4. [Parameters](#parameters)
5. [Development](#development)

## Description

Puppet Module to manage atop

## Easy Setup

Install atop with default configuration
```
include atop
```

##Advance Usage

Example usage if having custom configuration

```
class { 'atop':
  service_run    => true,
  service_enable => false,
  interval       => 120,
  logpath        => '/var/log/myatop/atop',
  confpath       => '/etc/sysconfig/atop',
  rotate_count  => '1',
  rotate_days   => '+6',
}
```

##Parameters
##### `service_run`
Ensure the service running or stopped. Accept `true` or `false`. Default: `true`

##### `service_enable`
Ensure the service enabled or disable. Accept `true` or `false`. Default: `true`

##### `interval`
Interval between snapshots. Default: `600`

##### `logpath`
Path do snapshots logging. Default: `/var/log/atop`

##### `confpath`
Path do snapshots logging. Default: `/etc/sysconfig/atop`

##### `rotate_count`
Number of saved log files

##### `rotate_days`
Remove old files

##Development
Please help to expand this module across multiple linux distros.