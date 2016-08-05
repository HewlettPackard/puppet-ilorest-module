# ilorest [![PyPI](https://img.shields.io/pypi/pyversions/python-ilorest-library.svg?maxAge=2592000)](https://pypi.python.org/pypi/python-ilorest-library) 

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with ilorest](#setup)
    * [What ilorest affects](#what-ilorest-affects)
    * [Setup requirements](#setup-requirements)
    * [Installation](#installation)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
    * [init.pp](#initpp)
    * [params.pp](#paramspp)
    * [install.pp](#installpp)
    * [service.pp](#servicepp)
    * [.travis.yml](#travisyml)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

**ilorest** is a puppet module that installs the [Python ilorest library](https://github.com/HewlettPackard/python-ilorest-library) and runs a handful of examples included in the library. Currently ilorest works with Windows Server and any 'nix distribution.

**ilorest** was written primarily as an example for server administrators to use as a template or basis for writing their own modules using the ilorest library. ilorest installs the ilorest library as part of the installation to preserve idempotency along with managing the example scripts.

## Setup

### What ilorest affects

**ilorest** both fetchs and sets iLO settings from the target server through the usage of the ilorest library.
**ilorest** also automatically installs the python ilorest library through the use of pip install as a dependancy. Additionally, it uses Puppet for file management and copies example scripts from the master to the node server.

### Setup Requirements

**ilorest** requires an installation of Python 2.7.6+ to work. This may be installed with Stankevich's [Python](https://forge.puppet.com/stankevich/python) module from the Puppet Forge. Alternatively, a pre-installed version of Python would work as well, as long as it satisfies the version 2.7.6+ requirements.

**Note:** The ilorest library was not written with Python 3's compatability in mind. The recommended version of Python to be used is 2.7.11

### Installation

Use this command to install ilorest:

`puppet module install puppetrest-ilorest`

On the node servers, by default, in debian distributions, the ilorest module will install files into the ilorest module path. (/etc/puppetlabs/code/environments/production/modules/ilorest). In Windows, it will install into the C: drive. (C:\ilorest). In RedHat, it installs into Puppet's module path (/etc/puppet/modules/ilorest)

On master servers, the module installation is handled through Puppet.

For a manual installtion, download this module as a zip, and unzip it in your modules folder. The ilorest module directory should be simply named "ilorest", so the node definition will recognize the module as ilorest.

**Note:** If installing manually, or from this repository, ensure the folder is named "ilorest" so Puppet can locate the module.

## Usage

**ilorest** is used by setting your parameters in the site.pp node definitions. Here is an example of it in use as a default node definition. ilorest is hardcoded to show off a few examples, namely examples 9, 14, and 3. Since the intent of ilorest is to provide user with a template on how to build their own modules, the examples are hardcoded in. These examples are from the python ilorest library and are intended to be just examples. Server admins should look into building their own scripts to meet their needs and then refer to this module for implementation using Puppet.

```puppet
  node default {
  
    if $osfamily != 'windows' {
      include python
    }
    
    class { 'ilorest':
      ilo_ip       => '10.0.0.100',
      ilo_username => 'admin',
      ilo_password => 'password',
    }
  }
```

## Reference

#### init.pp

init.pp is the base class. It inherits default parameters from params.pp, and calls install.pp and service.pp

```puppet
  $ilo_username = $ilorest::params::ilo_username,
  $ilo_password = $ilorest::params::ilo_password,
  $ilo_ip       = $ilorest::params::ilo_ip,
```
Variables are declared here based on their values in the params.pp file. This provides a default value to be used if no value is set, e.g. using `include ilorest` in the node definition, as opposed to adding the module as a class.

### params.pp

params.pp stores the parameters defaults. The defaults are used if no parameters are supplied to init.pp unless the node definition overrides it.

```puppet
  $ilo_username = "username"
  $ilo_password = "password"
  $ilo_ip       = "10.0.0.100"
```
Default parameters are listed here. These are hardcoded and can be changed if you want to have a different default value when setting your own node definitions.

### install.pp

install.pp installs any required dependencies before anything else is done. This installs the python ilorest library through pip install as well as ensuring the examples to be run are present on the node.

```puppet
if $osfamily == 'Debian' {
if $osfamily == 'RedHat' {
if $osfamily == 'windows' {
```
The **$osfamily** fact is used as a conditional to determine what file structure will have to be used. This is automatically obtained by puppet.

If Windows, we also need to ensure that Python is installed since Windows does not include Python out of the box.

```puppet
    package {'python':
      ensure          => installed,
      source          => 'https://www.python.org/ftp/python/2.7.12/python-2.7.12.msi',
      provider        => windows,
      install_options => [{ 'ALLUSERS'=>'1' }, { 'IACCEPTSQLNCLILICENSETERMS' => 'YES' }, ],
      }
```

We can utilize the package resource since 2.7.12 utilizes .msi and Puppet can manage it through the package resource. We specify that we want to ensure it to be installed, and provide it with a source. Provider lets Puppet know how the package should be installed. Lastly, we note the install_options so it can be run silently with need for user input.

```puppet
    file { '/etc/puppetlabs/code/environments/production/modules/ilorest/':
      ensure => directory,
      mode   => '0755',
  	  }

    file { '/etc/puppetlabs/code/environments/production/modules/ilorest/files':
      ensure  => directory,
      source  => 'puppet:///modules/ilorest',
      recurse => true,
      require => File['/etc/puppetlabs/code/environments/production/modules/ilorest'],
          }
```
File directories are created and files copied over, then managed by the master server to ensure that each node will have the required files. Note that the folder containing ilorest must already exist. Since Puppet is installed, this folder should already exist. If not, the directory path must be adjusted or the directory created.

### service.pp

service.pp runs the examples with variables passed from init.pp.

```puppet
  $ilo_ip       = $ilorest::ilo_ip
  $ilo_username = $ilorest::ilo_username
  $ilo_password = $ilorest::ilo_password
```

service.pp takes variables from init.pp since it is the top-level $ilorest. This way we can ensure it is taking the variables passed when a class is declared in the node definition.

Again, there is a check for operating system with a conditional to ensure that directory structure is correct.

```puppet
  if $osfamily == 'Debian' {
```

We set a template for future exec commands by declaring all the parameters first in Exec[]. We ensure that python can be run by point to the path, incase environmental variables were not set. Additionally, the cwd points to the directory we just copied the ilorest files to. Setting require forces the required command to be run first before this can be executed. In this case, we can requiring the dependancies to be present before attempting to execute the examples.

```puppet
  Exec {
    path      => '/usr/bin',
    cwd       => '/etc/puppetlabs/code/environments/production/modules/ilorest/files',
    logoutput => true,
    loglevel  => notice,
    require   => File['/etc/puppetlabs/code/environments/production/modules/ilorest/files'],
	}
```

Lastly, we run the examples by calling them. We **must** use double quotes in this command line to allow the usage of variables. They are written in ${variablename} format. The **->** is an ordering arrow, telling Puppet what order to execute commands. By default, Puppet will run in the order the resources are declared, but it is still best practice to declare an order.

```puppet
  exec { 'ex09':
    command   => "python ex09_find_ilo_mac_address.py ${ilo_ip} ${ilo_username} ${ilo_password}",
	} ->
```
###.travis.yml

.travis.yml is used for Travis CI, a continuous integration service being used to check build status. This file is not required to run the module at all, and is simply used for Travis CI. When adapting this module to your needs, you may want to adapt .travis.yml as well. 

```ruby
language: ruby
rvm:
  - 2.1.9
  - 2.2.5
  - 2.3.1
env:
  - PUPPET_VERSION=4.2
  - PUPPET_VERSION=4.3
  - PUPPET_VERSION=4.4

notifications:
  email: false
```

We declare versions of Ruby to be tested, as well as which Puppet Version to test for. Lastly notifications has been opted out. (Defaults to true)

Note that the rvm, must be able to support rake. Additionally, one can set the Puppet version to build for specific puppet version. Ensure that the Gem for that version can be found, or the build will fail. See [https://rubygems.org/gems/puppet/versions](https://rubygems.org/gems/puppet/versions).

## Limitations

**ilorest** works with any 'nix distribution, as well as any Windows Server. For the examples to work, the machine targeted by the IP address must have iLO for ilorest to work properly. Additionally, ilorest is written to support Python 2.7.6+, and it has not been fully tested with Python 3+. ilorest also requires facter, which is included with Puppet agent 1.2.3 and up (Puppet 4.2).

Additionally, ilorest is written primarily as an example and would not be fit for being used in production out of the box. It's main purpose is to show off how the ilorest library can be deployed through Puppet. Tailoring this module to accomplish specific tasks would be the best usage of **ilorest**.

**Note:** Puppet agent runs by default as `root`, but can also be run as a non-root user, as long as it is started by that user. ilorest was written with the assumption that the agent would be running as root. In Windows, Puppet agent runs by default as `LocalSystem`. Additionally, when a user is selected, the Puppet installer will add it to the `Administrators` group.

**ilorest** has been tested on:
* Puppet 4.4
* Puppet Enterprise 2016.2

**Puppet References** 
* ['nix agent](https://docs.puppet.com/puppet/4.5/reference/services_agent_unix.html)
* [Windows agent](https://docs.puppet.com/puppet/4.5/reference/services_agent_windows.html)

## Development

* Fork it!
* Create your feature branch: git checkout -b my-new-feature
* Commit your changes: git commit -am 'Add some feature'
* Push to the branch: git push origin my-new-feature
* Submit a pull request

## Release Notes/Contributors/Etc.

Version 1.0

1. Initial Release
  * Support for 'nix and Windows
  * Accepts credentials
  * Installs Python on 'nix (No support for Windows)

For further information on the python ilorest library, visit this [link](https://github.com/HewlettPackard/python-ilorest-library).

Tested on:
* Ubuntu 16.04 (Xenial Xerus)
* Red Hat Enterprise Linux 7.2 (Maipo)
* Windows Server 2012
