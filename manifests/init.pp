# Class: phing
#
# This class downloads Phing
#
# Parameters:
#
#  source: (default http://www.phing.info/get/phing-latest.phar )
#    Location of the download
#
# Actions:
#   - Install Phing
#   - Make phing.phar executable
#   - Symlink phing.phar to phing
#
# Requires:
#
# Sample Usage:
#
#  For a standard installation, use:
#
#    class { 'phing': }
#
#  To specify an alternate download link, use:
#
#    class { 'phing':
#      source => 'http://alternate.domain.tld/get/phing-latest.phar'
#    }
#
class phing (
  $source = 'http://www.phing.info/get/phing-latest.phar'
){
  exec { 'get-phing':
    path    => '/bin:/usr/bin',
    command => "wget ${source}",
    cwd     => '/usr/local/bin',
    creates => '/usr/local/bin/phing.phar',
    timeout => 10000,
    onlyif  => "test ! -f /usr/local/bin/phing.phar",
  }

  file { '/usr/local/bin/phing.phar':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Exec['get-phing'],
  }

  file { '/usr/local/bin/phing':
    ensure  => 'link',
    owner   => 'root',
    group   => 'root',
    target  => "/usr/local/bin/phing.phar",
    require => Exec['get-phing'],
  }

}
