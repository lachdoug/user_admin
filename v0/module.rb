require 'sinatra/base'
require 'sinatra/extension'
require 'sinatra/json'
require 'byebug' if Sinatra::Base.development?

class V0 < Sinatra::Base

  # require 'rack'
  # require 'rack/contrib'
  # Automatically parse JSON params
  # use Rack::PostBodyContentTypeParser

  # Output request details for debugging in development
  before do
    if Sinatra::Base.development?
      puts "Request #{request.body.rewind; request.body.read} #{request.request_method} #{request.path_info} #{params.inspect}"
    else
      logger.info "Request #{request.body.rewind; request.body.read} #{request.request_method} #{request.path_info} #{params.inspect}"
    end
  end

  # Parse JSON params
  before do
    if request.content_type == 'application/json'
      request.body.rewind
      params.merge! JSON.parse( request.body.read )
    end
  end

  # Settings

  set logging: true
  set dump_errors: Sinatra::Base.development?
  set public_folder: 'public'
  # set ldap_admin_keytab_path: ENV['ENGINES_ADMIN_GUI_KERBEROS_LDAP_KEYTAB_PATH'] || "/etc/krb5kdc/keys/control.keytab"
  set show_exceptions: false

  # Services

  module Services; end
  Dir.glob( [ "./v0/services/*.rb" ] ).each { |file| require file }
  include Services

  # API

  # LDAP service interface

  def ldap
    @ldap ||= LdapService.new
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
  end

  # Handle errors

  not_found do
    raise "Not a valid route"
  end

  error do |error|
    return [ 405, { error: { message: error.message } } ] if error.is_a? LdapService::Error
    [ 500, { error: { message: error.message, backtrace: error.backtrace } } ]
  end

end
