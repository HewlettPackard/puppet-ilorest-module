iLOrest ====== .. image:: <https://img.shields.io/pypi/pyversions/python-ilorest-library.svg?maxAge=2592000> :target: <https://github.com/HewlettPackard/python-iLOrest-library>

Description
===========

> iLOrest is a puppet module that installs the [Python iLOrest library] and runs a handful of examples included in the library. Currently iLOrest works with Windows Server and any ’nix distribution. iLOrest was written primarily as an example for server administrators to use as a template or basis for writing their own modules using the iLOrest library. iLOrest installs the iLOrest library as part of the installation to preserve idempotency along with managing the example scripts.

Setup
=====

iLOrest requires an installation of Python 2.7.6+ to work. This may be installed with Stankevich’s [Python] module from the Puppet Forge. Alternatively, a pre-installed version of Python would work as well, as long as it satisfies the version 2.7.6+ requirements.

**Note:** The iLOrest library was not written with Python 3’s compatability in mind. The recommended version of Python to be used is 2.7.11

Installation
============

Use this command to install iLOrest:

``` sourceCode
puppet module install puppetrest-iLOrest
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
