# nominatim postgres

Attempts to install a database pod which will consist of:

- https://github.com/welshstew/nominatim-centos8-s2i-postgresql12
- https://github.com/welshstew/nodejs-runsqlscript

Why?

To initialise a postgres database with postgis extensions installed.  The postgis extensions are enabled by running a post install hook job 