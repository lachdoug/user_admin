class V0
  module Api
    module Controllers
      module Users
        module Accounts
          module EmailsController
            extend Sinatra::Extension

            # Create :users :account :email
            #  params
            #  :user_uid [String]
            #  :email [Hash] new :users :account :email data
            #  {
            #    domain_name: String
            #  }
            # @return [Hash] :users :account :email
            post '/users/accounts/email' do
              ldap.create_users_account_email params[:user_uid], params[:email]
            end

            # Edit :users :account :email
            #  params
            #  :user_uid [String]
            # @return [Hash] :users :account :email
            get '/users/accounts/email/edit' do
              ldap.edit_users_account_email params[:user_uid]
            end

            # Update :users :account :email
            #  params
            #  :user_uid [String]
            #  :email [Hash] new :users :account :email data
            #  {
            #    domain_name: String
            #  }
            # @return [Hash] :users :account :email
            put '/users/accounts/email' do
              ldap.update_users_account_email params[:user_uid], params[:email]
            end

            # Delete :users :account :email
            #  params
            #  :user_uid [String]
            # @return [Hash] {}
            delete '/users/accounts/email' do
              ldap.delete_users_account_email params[:user_uid]
            end

          end
        end
      end
    end
  end
end
