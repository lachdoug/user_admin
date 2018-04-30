class V0
  module Api
    module Controllers
      module DnLookupsController
        extend Sinatra::Extension

        # Show :dn for :uid
        # params:
        #   user_auth:
        #     uid: [String] UID for :account
        #     password: [String] password for :account
        # @return [Hash]
        #   dn: [String] dn for :uid
        get '/dn_lookup' do
          @ldap_username = settings.ldap_admin_username
          @ldap_password = settings.ldap_admin_password
          dn = ldap.show_user_account_dn( params[:user_auth][:uid] )[:dn]
          @ldap_username = dn
          @ldap_password = (params[:user_auth] || {} )[:password]
          ldap.show_user_account_dn( params[:user_auth][:uid] )
        end

      end
    end
  end
end
