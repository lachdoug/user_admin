class V0
  module Api
    module Controllers
      module Users
        module Accounts
          module Emails
            module AliasesController
              extend Sinatra::Extension

              # Create :users :email :alias
              #  params
              #  :user_uid [String]
              #  :alias [Hash] { address: [String] email address }
              # @return [String] :users :account :email_alias
              post '/users/accounts/email/aliases/' do
                ldap.create_users_account_email_alias params[:user_uid], params[:alias]
              end

              # Delete :users :email :alias
              #  params
              #  :user_uid [String]
              #  :address [String] alias address
              # @return [Hash] {}
              delete '/users/accounts/email/aliases/' do
                ldap.delete_users_account_email_alias params[:user_uid], params[:address]
              end

            end
          end
        end
      end
    end
  end
end
