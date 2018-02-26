Engines User Admin Service
==========================

This application provides an api for administering users on an Engines instance.

System API calls this service using 'splat' routes at '/v0/system/uadmin/*' for get/post/put/delete. System then relays params[:splat] + params[:api_vars] to uadmin and returns response. Example: Admin GUI calls POST '/v0/system/uadmin/users/accounts/lachlan/groups/' { api_vars: { group: { name: "ftp" } } } and system calls uadmin with POST '/v0/users/accounts/lachlan/groups/' { group: { name: "ftp" } }.


Framework
---------
Sinatra (module style, with config.ru)

Services
--------
Neds LDAP.

No DB. No Volumes.

Tests
-----
`rspec test.rb`

Docs
----
Read docs `sensible-browser ./doc/top-level-namespace.html`
Generate docs `yardoc v0/* --plugin yard-sinatra`

Environment
-----------
