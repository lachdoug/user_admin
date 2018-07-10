require 'sinatra/base'
require 'sinatra/extension'
require 'sinatra/json'
require 'byebug' if Sinatra::Base.development?

class V0 < Sinatra::Base

  # Output request details for debugging in development
  before do
    log "\nRequest:\n #{request.query_string}\n #{request.body.rewind; request.body.read}\n #{request.request_method}\n #{request.path_info}\n #{params.inspect}"
  end

  def log(text)
    $stderr.puts text
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

  # if Sinatra::Base.development?
  #   ENV["ldap_dn"] = "uid=uadmin,ou=hosts,ou=Engines,dc=engines,dc=internal"
  #   ENV["ldap_password"] = "e4d29c5c"
  # end

  set logging: true
  set dump_errors: true # Sinatra::Base.development?
  set public_folder: 'public'
  set show_exceptions: false
  set ldap_admin_username: ENV["ldap_dn"]
  set ldap_admin_password: ENV["ldap_password"]

  # Services

  module Services; end
  Dir.glob( [ "./v0/services/*.rb" ] ).each { |file| require file }
  include Services

  # LDAP service

  before do
    if params[:token_owner] == "sysadmin"
      # byebug
      @ldap_username = settings.ldap_admin_username
      @ldap_password = settings.ldap_admin_password
    else
      @ldap_username = params[:token_owner]
      @ldap_password = params[:ldap_password]
    end
  end

  def ldap
    LdapService.new(
      username: @ldap_username,
      password: @ldap_password
    )
  end

  # Register controllers

  require_relative 'api/api'
  register Api::Controllers

  # Register helpers

  helpers Api::Helpers

  # Send JSON

  after do
    content_type :json
    response.body = response.body.to_json
    log "Response:\n#{response.body}\n#{response.status}"
  end

  # Handle errors

  not_found do
    return 404, "Not a valid v0 route"
  end

  error do |error|
    return [ 405, { error: { message: error.message } } ] if error.is_a? LdapService::Error
    [ 500, { error: { message: error.message, backtrace: error.backtrace } } ]
  end

end
