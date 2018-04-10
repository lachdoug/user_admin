class V0
  module Api
    module Controllers
      module Users
        module Accounts
          module PasswordsController
            extend Sinatra::Extension

            # Update :users :account :password
            #  params
            #  :user_uid [String]
            #  :password [Hash] { current: [String], new: [String] }
            # @return [Hash] {}
            put '/users/accounts/password' do
              ldap.update_users_account_password params[:user_uid], params[:password]
            end

          end
        end
      end
    end
  end
end
