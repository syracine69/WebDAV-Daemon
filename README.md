# webdavd(1) - WebDAV daemon

# About

webdavd-pgsql is a WebDAV server designed to be a replace for SAMBA providing access to a system's files without taking ownership of them.  It aims to differ from most WebDAV servers on a number of points:

 - Users are authenticated through Postgresql database users.
 - The webserver switches Postgresql database user to match the authenticated user before accessing any files.
 - The daemon operates without any prior knowledge of the files it's serving.  
 - The daemon does NOT take ownership of the files it modifies and serves. It does not take ownership of any files in any way.  Even locking operations are implemented using the native OS `flock()` function.

# Licence

(c) Copyright Sylvain Racine 2021
(c) Copyright Philip Couling 2013-2017

This code may be used under an MIT Licence.  Please see [LICENCE.md](LICENCE.md) for details.
#  Starting the server

If properly installed the server can be started with:

    service webdavd start

The server can be started manually by calling:

    webdavd config-file [config-file ...] 
    
where config-file is the path for the webdavd configuration file. Default path is /etc/webdavd.
See [Configuration](Configuration.md) for details of the config file.

# Known Issues

 - Locking file is limited and it is currently not possible to lock a directory
 - Postgresql database sessions are of a fixed length and their length is not affected by user activity.
 
# Building from source

### Under Ubuntu

    sudo apt-get install gcc libmicrohttpd-dev libpq-dev libxml2-dev libgnutls28-dev libgnutls30 uuid-dev
    make

### Under Raspbian (Not yet tested: help is welcome!)

    sudo apt-get install gcc libmicrohttpd-dev libpq-dev libxml2-dev libgnutls28-dev uuid-dev
    make

### Packaging into a dpkg (Not yet tested: help is welcom!)

To assemble everything into a DPKG you can either read one of the manifest files [`package-control/manifest.ubuntu`](package-control/manifest.ubuntu) or [`package-control/manifest.rpi`](package-control/manifest.rpi)

Or you can use my [`package-project` script](https://github.com/couling/DpkgBuildTools).  For example:

    package-project package-control/manifest.ubuntu

### Packaging into an rpm on RHEL8 (Not yet tested: help is welcome!)

Use the included SPEC file to build the rpm file. [`package-control/webdavd.spec`](package-control/webdavd.spec). It is sufficient to only download the SPEC file and run the below commands.

    sudo dnf builddep webdavd.spec
    rpmbuild --undefine=_disable_source_fetch -ba webdavd.spec

