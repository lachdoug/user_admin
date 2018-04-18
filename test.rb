ENV['RACK_ENV'] = 'test'
ENV["access_dn"] = "uid=uadmin,ou=hosts,ou=Engines,dc=engines,dc=internal"
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

def ldap
  @ldap ||= V0::Services::LdapService.new
end

def response
  @response ||= JSON.parse( last_response.body, symbolize_names: true )
end

def clear_response
  @response = nil
end

def get *args
  clear_response
  super
end

def post *args
  args[1] = args[1].to_json
  args << { 'CONTENT_TYPE' => "application/json" }
  clear_response
  super
end

def put *args
  args[1] = args[1].to_json
  args << { 'CONTENT_TYPE' => "application/json" }
  clear_response
  super
end

def delete *args
  clear_response
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
