iLOrest Puppet Module
======

[![Build Status](https://travis-ci.org/HewlettPackard/puppet-ilorest-module.svg?branch=master)](https://travis-ci.org/HewlettPackard/puppet-ilorest-module)
[![Puppet Forge](https://img.shields.io/puppetforge/v/lumbajack/ilorest.svg?maxAge=2592000)](https://forge.puppet.com/lumbajack/ilorest)
[![GitHub license](https://img.shields.io/badge/license-Apache%202-blue.svg)](https://raw.githubusercontent.com/HewlettPackard/puppet-ilorest-module/master/LICENSE)
[![Codacy grade](https://img.shields.io/codacy/grade/5b7b9a4eb9fa4ac2af343c0a2641202e.svg?maxAge=2592000)](https://www.codacy.com/app/rexysmydog/puppet-ilorest-module)

#### Table of Contents

1. [Overview](#overview)
2. [Description](#description)
3. [Setup](#setup)
4. [Installation](#installation)
5. [Usage](#usage)
6. [History](#history)
7. [License](#license)
8. [Authors](#authors)

## Overview

Puppet module for installing the Python iLOrest library and showcasing a few examples.

## Description

iLOrest is a puppet module that installs the [Python iLOrest library] and runs a handful of examples included in the library. Currently iLOrest works with Windows Server and any ’nix distribution. iLOrest was written primarily as an example for server administrators to use as a template or basis for writing their own modules using the iLOrest library. iLOrest installs the iLOrest library as part of the installation to preserve idempotency along with managing the example scripts.

## Setup

iLOrest requires an installation of Python 2.7.6+ to work. This may be installed with Stankevich’s [Python] module from the Puppet Forge. Alternatively, a pre-installed version of Python would work as well, as long as it satisfies the version 2.7.6+ requirements.

## Installation

Use this command to install iLOrest:

``` sourceCode
puppet module install lumbajack-ilorest
```

On the node servers, by default, in debian distributions, the iLOrest module will install files into the iLOrest module path. (/etc/puppetlabs/code/environments/production/modules/iLOrest). In Windows, it will install into the C: drive. (C:iLOrest). In RedHat, it installs into Puppet’s module path (/etc/puppet/modules/iLOrest)

On master servers, the module installation is handled through Puppet.

For a manual installtion, download this module as a zip, and unzip it in your modules folder. The iLOrest module directory should be simply named “iLOrest”, so the node definition will recognize the module as iLOrest.

**Note:** If installing manually, or from this repository, ensure the folder is named “iLOrest” so Puppet can locate the module.

## Usage

**iLOrest** is used by setting your parameters in the site.pp node definitions. Here is an example of it in use as a default node definition. iLOrest is hardcoded to show off a few examples, namely examples 9, 14, and 3. Since the intent of iLOrest is to provide user with a template on how to build their own modules, the examples are hardcoded in. These examples are from the python iLOrest library and are intended to be just examples. Server admins should look into building their own scripts to meet their needs and then refer to this module for implementation using Puppet.

``` sourceCode
node default {
  class { 'ilorest':
    ilo_ip       => '10.0.0.100',
    ilo_username => 'admin',
    ilo_password => 'password
  }
}
```

## History

* 08/18/2016: Initial Commit

## License

Copyright 2017 Hewlett Packard Enterprise Development LP

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## Authors

* [Jack Garcia](http://github.com/LumbaJack)
* [Matthew Kocurek](http://github.com/Yergidy)
* [Prithvi Subrahmanya](http://github.com/PrithviBS)

