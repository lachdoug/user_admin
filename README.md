Engines User Admin Service
==========================

This application provides an api for administering users on an Engines instance.

Framework
---------
Sinatra (module style, with config.ru)

Needs
-----
public directory: public  
No DB. No Volumes.

config.ru
---------
require_relative 'v0/module'  
map('/') { run V0 }  

Tests
-----
`bundle exec rspec test.rb`

Docs
----
`/doc/top-level-namespace.html`

Environment
-----------
