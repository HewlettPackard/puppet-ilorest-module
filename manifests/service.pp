class ilorest::service inherits ilorest {

  $ilo_ip       = $ilorest::ilo_ip
  $ilo_username = $ilorest::ilo_username
  $ilo_password = $ilorest::ilo_password
  
  if $osfamily == 'Debian' {

    #Setting default Exec parameters, path is designated in case environmental variables were not set
    Exec {
      path      => '/usr/bin',
      cwd       => '/etc/puppetlabs/code/environments/production/modules/ilorest/files',
      logoutput => true,
      loglevel  => notice,
      require   => File['/etc/puppetlabs/code/environments/production/modules/ilorest/files'],
  	  }
  }
  
    if $osfamily == 'redhat' {

    #Setting default Exec parameters, path is designated in case environmental variables were not set
    Exec {
      path      => '/usr/bin',
      cwd       => '/etc/puppet/modules/ilorest/files',
      logoutput => true,
      loglevel  => notice,
      require   => File['/etc/puppet/modules/ilorest/files'],
  	  }
  }
  
  if $osfamily == 'windows'{
  
    #Setting default Exec parameters, path is designated in case environmental variables were not set
    #Two \ are required since only one is viewed as an exit character
    Exec {
      path      => 'C:\\Python27\\',
      cwd       => 'C:\\ilorest\\files',
      logoutput => true,
      loglevel  => notice,
      require   => File['C:\\ilorest\\files'],
  	  }
  }
  
  #Start of examples execution, double quote use to allow variable use. 
  exec { 'ex09':
    command => "python ex09_find_ilo_mac_address.py ${ilo_ip} ${ilo_username} ${ilo_password}",
    } ->

  exec { 'ex14':
    command => "python ex14_sessions.py ${ilo_ip} ${ilo_username} ${ilo_password}",
    } ->

  exec { 'ex03':
    command => "python ex03_change_bios_setting.py ${ilo_ip} ${ilo_username} ${ilo_password}",
    }

}
