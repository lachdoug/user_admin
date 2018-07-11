class V0
  module Api
    module Controllers
      module Users
        module AccountsController
          extend Sinatra::Extension

          # Index :users :accounts
          # @return [Array] index of :users :accounts
          get '/users/accounts' do
            ldap.index_users_accounts
          end

          # Create :users :account
          #  params
          #  :account [Hash] new :users :account data
          # @return [Hash] :users :account
          post '/users/accounts/' do
            ldap.create_users_account params[:account]
            ldap.show_users_account params[:account][:uid]
          end

          # Show :users :account
          #  params
          #  :uid [String] UID for the :users :account
          # @return [Hash] :users :account
          get '/users/accounts/' do
            ldap.show_users_account params[:uid]
          end

          # Update :users :account
          #  params
          #  :uid [String] UID for the :users :account
          #  :account [Hash] :users :account data
          # @return [Hash] :users :account details
          put '/users/accounts/' do
            # byebug
            ldap.update_users_account( params[:uid], params[:account] )
            ldap.show_users_account params[:uid]
          end

          # Delete :users :account
          #  params
          #  :uid [String] UID for the :users :account
          # @return [Hash] {}
          delete '/users/accounts/' do
            ldap.delete_users_account params[:uid]
          end

        end
      end
    end
  end
end
