require_relative 'v0/module'
require_relative 'root/module'
map('/v0') { run V0 }
map('/') { run Root }
