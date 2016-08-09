iLOrest 
======

[![Travis](https://img.shields.io/travis/rust-lang/rust.svg?maxAge=2592000)](https://travis-ci.org/HewlettPackard/puppet-ilorest-module)
[![Puppet Forge](https://img.shields.io/puppetforge/v/vStone/percona.svg?maxAge=2592000)](https://forge.puppet.com/lumbajack/ilorest)
[![GitHub license](https://img.shields.io/badge/license-Apache%202-blue.svg)](https://raw.githubusercontent.com/HewlettPackard/puppet-ilorest-module/master/LICENSE)
[![Codacy grade](https://img.shields.io/codacy/grade/e27821fb6289410b8f58338c7e0bc686.svg?maxAge=2592000)](https://www.codacy.com/app/rexysmydog/puppet-ilorest-module)


Description
===========

iLOrest is a puppet module that installs the [Python iLOrest library] and runs a handful of examples included in the library. Currently iLOrest works with Windows Server and any ’nix distribution. iLOrest was written primarily as an example for server administrators to use as a template or basis for writing their own modules using the iLOrest library. iLOrest installs the iLOrest library as part of the installation to preserve idempotency along with managing the example scripts.

Setup
=====

iLOrest requires an installation of Python 2.7.6+ to work. This may be installed with Stankevich’s [Python] module from the Puppet Forge. Alternatively, a pre-installed version of Python would work as well, as long as it satisfies the version 2.7.6+ requirements.

Installation
============

Use this command to install iLOrest:

``` sourceCode
puppet module install lumbajack-ilorest
```

On the node servers, by default, in debian distributions, the iLOrest module will install files into the iLOrest module path. (/etc/puppetlabs/code/environments/production/modules/iLOrest). In Windows, it will install into the C: drive. (C:iLOrest). In RedHat, it installs into Puppet’s module path (/etc/puppet/modules/iLOrest)

On master servers, the module installation is handled through Puppet.

For a manual installtion, download this module as a zip, and unzip it in your modules folder. The iLOrest module directory should be simply named “iLOrest”, so the node definition will recognize the module as iLOrest.

**Note:** If installing manually, or from this repository, ensure the folder is named “iLOrest” so Puppet can locate the module.

Usage
=====

**iLOrest** is used by setting your parameters in the site.pp node definitions. Here is an example of it in use as a default node definition. iLOrest is hardcoded to show off a few examples, namely examples 9, 14, and 3. Since the intent of iLOrest is to provide user with a template on how to build their own modules, the examples are hardcoded in. These examples are from the python iLOrest library and are intended to be just examples. Server admins should look into building their own scripts to meet their needs and then refer to this module for implementation using Puppet.

``` sourceCode
node default {

  if $osfamily != 'windows' {
    include python
  }

  class { 'iLOrest':
    ilo_ip       => '10.0.0.100',
    ilo_username => 'admin',
    ilo_password => 'password
```

  [Python iLOrest library]: https://github.com/HewlettPackard/python-iLOrest-library
  [Python]: https://forge.puppet.com/stankevich/python
