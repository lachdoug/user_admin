require_relative 'v0/module'
# require 'rack/contrib'
# use Rack::PostBodyContentTypeParser
map('/v0') { run V0 }
