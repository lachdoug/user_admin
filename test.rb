ENV['RACK_ENV'] = 'test'
$ldap_dn = "uid=uadmin,ou=hosts,ou=Engines,dc=engines,dc=internal"
$ldap_password = "e4d29c5c"

ENV["ldap_dn"] = "uid=uadmin,ou=hosts,ou=Engines,dc=engines,dc=internal"
ENV["ldap_password"] = "e4d29c5c"

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

# def ldap
#   @ldap ||= V0::Services::LdapService.new
# end

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
  # params = params.to_json
  clear_response
  # super route, params, { 'CONTENT_TYPE' => "application/json" }
  super
end

def delete! *args
  delete *args
rescue V0::Services::LdapService::Error::EntryMissing,
       V0::Services::LdapService::Error::Operation
end



# describe V0 do
#   it 'restores ldap to initial state' do
#     ldap.reset_ldap
#   end
# end

Dir.glob( [ "./spec/**/*.rb" ] ).each { |file| require file }
