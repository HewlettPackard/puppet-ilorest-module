## install.pp is the install class for iLOrest. It manages the required files as well as ensures 
## the required library is installed

class ilorest::install {

  if $::osfamily == 'Debian' {

    #Create initial directory for recursive management
    #Directory containing 'ilorest' MUST EXIST!
    file { '/etc/puppetlabs/code/environments/production/modules/ilorest/':
      ensure => directory,
      mode   => '0755',
      }

    #Recursive copy and management of library files
    file { '/etc/puppetlabs/code/environments/production/modules/ilorest/files':
      ensure  => directory,
      source  => 'puppet:///modules/ilorest',
      recurse => true,
      require => File['/etc/puppetlabs/code/environments/production/modules/ilorest'],
          }

    #Prepares examples by installing ilorest-library through pip and the internet
    exec { 'pipinstall':
      path    => '/usr/bin',
      command => 'pip install --force-reinstall python-ilorest-library',
    }
  }

    if $::osfamily == 'redhat' {

    #Create initial directory for recursive management
    #Directory containing 'ilorest' MUST EXIST!
    file { '/etc/puppet/modules/ilorest/':
      ensure => directory,
      mode   => '0755',
      }

    #Recursive copy and management of library files
    file { '/etc/puppet/modules/ilorest/files':
      ensure  => directory,
      source  => 'puppet:///modules/ilorest',
      recurse => true,
      require => File['/etc/puppet/modules/ilorest'],
          }

    #Prepares examples by installing ilorest-library through pip and the internet
    exec { 'pipinstall':
      path    => '/usr/bin',
      command => 'pip install --force-reinstall python-ilorest-library',
    }
  }

  if $::osfamily == 'windows' {

    #install Python 2.7.12
    package {'python27':
      ensure          => installed,
      source          => 'https://www.python.org/ftp/python/2.7.12/python-2.7.12.msi',
      provider        => windows,
      install_options => [{ 'ALLUSERS' => '1' }, { 'IACCEPTSQLNCLILICENSETERMS' => 'YES' }, ],
      }

    #Create initial directory for recursive management
    file { 'C:\\ilorest':
      ensure => directory,
      mode   => '0755',
      }
    #Recursive copy and management of library files
    file { 'C:\\ilorest\\files':
      ensure  => directory,
      source  => 'puppet:///modules/ilorest',
      recurse => true,
      require => File['C:\\ilorest'],
          }

    #install Python
    package {'python':
      ensure          => installed,
      source          => 'https://www.python.org/ftp/python/2.7.12/python-2.7.12.msi',
      provider        => windows,
      install_options => [ { 'INSTALLDIR'=>'C:\\python27' }, { 'ALLUSERS'=>'1' }, { 'IACCEPTSQLNCLILICENSETERMS' => 'YES' }, ],
    }

    #Prepares examples by installing ilorest-library through pip and the internet
    exec { 'pipinstall':
      path    => 'C:\\Python27\\Scripts',
      command => 'pip install --force-reinstall python-ilorest-library',
    }

  }

}
