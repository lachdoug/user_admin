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
            post '/users/accounts/groups' do
              ldap.create_users_account_groups params[:user_uid], params[:groups]
            end

            # Delete :users :account :group
            #  params
            #  :user_uid [String]
            #  :names [Array] group names
            # @return [Hash] {}
            delete '/users/accounts/groups' do
              ldap.delete_users_account_groups params[:user_uid], params[:names]
            end

          end
        end
      end
    end
  end
end
