class V0
  module Api
    module Controllers
      module Users
        module Accounts
          module GroupsController
            extend Sinatra::Extension

            # Create :users :account :group
            #  params
            #  :user_uid [String]
            #  :group [Hash] { name: [String] }
            # @return [Hash] :users :account :group
            post '/users/accounts/groups/' do
              ldap.create_users_account_group params[:user_uid], params[:group]
            end

            # Delete :users :account :group
            #  params
            #  :user_uid [String]
            #  :name [String] group name
            # @return [Hash] {}
            delete '/users/accounts/groups/' do
              ldap.delete_users_account_group params[:user_uid], params[:name]
            end

          end
        end
      end
    end
  end
end
