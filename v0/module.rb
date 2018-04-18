require 'sinatra/base'
require 'sinatra/extension'
require 'sinatra/json'
require 'byebug' if Sinatra::Base.development?

class V0 < Sinatra::Base

  # Output request details for debugging in development
  before do
    log "Request #{request.query_string} #{request.body.rewind; request.body.read} #{request.request_method} #{request.path_info} #{params.inspect}"
  end

  def log text
    if Sinatra::Base.production?
      logger.info text
    else
      puts text
    end
  end

  # Parse JSON params
  before do
    if request.content_type == 'application/json'
      request.body.rewind
      body = request.body.read
      params.merge! JSON.parse( body ) unless body == ""
    end
  end

  # Settings

  set logging: true
  set dump_errors: Sinatra::Base.development?
  set public_folder: 'public'
  # set ldap_admin_keytab_path: ENV['ENGINES_ADMIN_GUI_KERBEROS_LDAP_KEYTAB_PATH'] || "/etc/krb5kdc/keys/control.keytab"
  set show_exceptions: false
  set ldap_username: ENV["access_dn"]
  set ldap_password: ENV["ldap_password"]

  # Services

  module Services; end
  Dir.glob( [ "./v0/services/*.rb" ] ).each { |file| require file }
  include Services

  # API

  # LDAP service interface

  def ldap
    @ldap ||= LdapService.new settings
  end

  # Register controllers

  require_relative 'api/api'
  register Api::Controllers

  # Register helpers

  helpers Api::Helpers

  # Send JSON

  # before do
  # end

  after do
    content_type :json
    response.body = response.body.to_json # JSON.dump(response.body)
    log response.body
  end

  # Handle errors

  not_found do
    raise "Not a valid route"
  end

  error do |error|
    # log "ERROR: #{error.inspect}"
    return [ 405, { error: { message: error.message } } ] if error.is_a? LdapService::Error
    [ 500, { error: { message: error.message, backtrace: error.backtrace } } ]
  end

end
