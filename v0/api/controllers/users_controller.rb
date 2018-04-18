class V0
  module Api
    module Controllers
      module UsersController
        extend Sinatra::Extension

        # Show :users
        # @return [Hash]
        #   accounts: [Array] of user accounts,
        #   groups: [Array] of user groups
        get '/users' do
          # ldap.show_users
          {
            :username => ENV["access_dn"],
            :password => ENV["ldap_password"]
            }
        end

      end
    end
  end
end
