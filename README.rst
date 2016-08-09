.. image:: https://img.shields.io/pypi/pyversions/python-iLOrest-library.svg?maxAge=2592000   :target: https://github.com/HewlettPackard/python-iLOrest-library

iLOrest
===========

.. contents:: :depth: 1

Description
------------

 iLOrest is a puppet module that installs the `Python iLOrest library <https://github.com/HewlettPackard/python-iLOrest-library>`_ and runs a handful of examples included in the library. Currently iLOrest works with Windows Server and any 'nix distribution.
 iLOrest was written primarily as an example for server administrators to use as a template or basis for writing their own modules using the iLOrest library. iLOrest installs the iLOrest library as part of the installation to preserve idempotency along with managing the example scripts.

Setup
-----

iLOrest requires an installation of Python 2.7.6+ to work. This may be installed with Stankevich's `Python <https://forge.puppet.com/stankevich/python>`_ module from the Puppet Forge. Alternatively, a pre-installed version of Python would work as well, as long as it satisfies the version 2.7.6+ requirements.

**Note:** The iLOrest library was not written with Python 3's compatability in mind. The recommended version of Python to be used is 2.7.11

Installation
-------------

Use this command to install iLOrest:

.. code-block:: puppet

  puppet module install puppetrest-iLOrest

On the node servers, by default, in debian distributions, the iLOrest module will install files into the iLOrest module path. (/etc/puppetlabs/code/environments/production/modules/iLOrest). In Windows, it will install into the C: drive. (C:\iLOrest). In RedHat, it installs into Puppet's module path (/etc/puppet/modules/iLOrest)

On master servers, the module installation is handled through Puppet.

For a manual installtion, download this module as a zip, and unzip it in your modules folder. The iLOrest module directory should be simply named "iLOrest", so the node definition will recognize the module as iLOrest.

**Note:** If installing manually, or from this repository, ensure the folder is named "iLOrest" so Puppet can locate the module.

Usage
------

**iLOrest** is used by setting your parameters in the site.pp node definitions. Here is an example of it in use as a default node definition. iLOrest is hardcoded to show off a few examples, namely examples 9, 14, and 3. Since the intent of iLOrest is to provide user with a template on how to build their own modules, the examples are hardcoded in. These examples are from the python iLOrest library and are intended to be just examples. Server admins should look into building their own scripts to meet their needs and then refer to this module for implementation using Puppet.

.. code-block:: puppet

  node default {
  
    if $osfamily != 'windows' {
      include python
    }
    
    class { 'iLOrest':
      ilo_ip       => '10.0.0.100',
      ilo_username => 'admin',
      ilo_password => 'password',
    }
  }


Limitations
--------------

**iLOrest** works with any 'nix distribution, as well as any Windows Server. For the examples to work, the machine targeted by the IP address must have iLO for iLOrest to work properly. Additionally, iLOrest is written to support Python 2.7.6+, and it has not been fully tested with Python 3+. iLOrest also requires facter, which is included with Puppet agent 1.2.3 and up (Puppet 4.2).

Additionally, iLOrest is written primarily as an example and would not be fit for being used in production out of the box. It's main purpose is to show off how the iLOrest library can be deployed through Puppet. Tailoring this module to accomplish specific tasks would be the best usage of **iLOrest**.

**Note:** Puppet agent runs by default as `root`, but can also be run as a non-root user, as long as it is started by that user. iLOrest was written with the assumption that the agent would be running as root. In Windows, Puppet agent runs by default as `LocalSystem`. Additionally, when a user is selected, the Puppet installer will add it to the `Administrators` group.

**iLOrest** has been tested on:

* Puppet 4.4

* Puppet Enterprise 2016.2

**Puppet References** 

* `'nix agent <https://docs.puppet.com/puppet/4.5/reference/services_agent_unix.html>`_

* `Windows agent <https://docs.puppet.com/puppet/4.5/reference/services_agent_windows.html>`_

Development
~~~~~~~~~~~

* Fork it!
* Create your feature branch: git checkout -b my-new-feature
* Commit your changes: git commit -am 'Add some feature'
* Push to the branch: git push origin my-new-feature
* Submit a pull request

Release Notes/Contributors/Etc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Version 1.0

1. Initial Release

  * Support for 'nix and Windows
  
  * Accepts credentials
  
  * Installs Python on 'nix (No support for Windows)

For further information on the python iLOrest library, visit this `link <https://github.com/HewlettPackard/python-iLOrest-library>`_.

Tested on:

* Ubuntu 16.04 (Xenial Xerus)

* Red Hat Enterprise Linux 7.2 (Maipo)

* Windows Server 2012
