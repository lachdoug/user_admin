class V0
  module Api
    module Controllers
      module Users
        module Accounts
          module GroupsController
            extend Sinatra::Extension

            # New :users :account :groups
            #  params
            #  :user_uid [String]
            # @return [Hash] :groups (that are available to be created)
            get '/users/accounts/groups/new' do
              ldap.new_users_account_groups params[:user_uid]
            end

            # Create :users :account :groups
            #  params
            #  :user_uid [String]
            #  :group [Hash] { name: [String] }
            # @return [Hash] :users :account :group
            post '/users/accounts/groups' do
              ldap.create_users_account_groups params[:user_uid], params[:dns]
            end

            # Delete :users :account :groups
            #  params
            #  :user_uid [String]
            #  :names [Array] group names
            # @return [Hash] {}
            delete '/users/accounts/groups' do
              ldap.delete_users_account_groups params[:user_uid], params[:dns]
            end

          end
        end
      end
    end
  end
end
