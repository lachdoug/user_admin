ENV['RACK_ENV'] = 'test'
ENV["ldap_dn"] = "uid=uadmin,ou=hosts,ou=Engines,dc=engines,dc=internal"
ENV["ldap_password"] = "3dee3b9b"

$ldap_dn = ENV["ldap_dn"]
$ldap_password = ENV["ldap_password"]

require_relative 'v0/module'
require 'rspec'
require 'rack/test'
require 'byebug'

include Rack::Test::Methods

RSpec.configure do |c|
  c.fail_fast = true
end

def app
  V0
end

def response
  @response ||= JSON.parse( last_response.body, symbolize_names: true )
end

def clear_response
  @response = nil
end

def get route, params={}
  params.merge!( { token_owner: $ldap_dn, ldap_password: $ldap_password } ) unless route == '/dn_lookup'
  clear_response
  super
end

def post route, params={}
  params.merge!( { token_owner: $ldap_dn, ldap_password: $ldap_password } )
  params = params.to_json
  clear_response
  super route, params, { 'CONTENT_TYPE' => "application/json" }
end

def put route, params={}
  params.merge!( { token_owner: $ldap_dn, ldap_password: $ldap_password } )
  params = params.to_json
  clear_response
  super route, params, { 'CONTENT_TYPE' => "application/json" }
end

def delete route, params={}
  params.merge!( { token_owner: $ldap_dn, ldap_password: $ldap_password } )
  clear_response
  super
end

def delete! *args
  delete *args
rescue V0::Services::LdapService::Error::EntryMissing,
       V0::Services::LdapService::Error::Operation
end


Dir.glob( [ "./spec/**/*.rb" ] ).each { |file| require file }
