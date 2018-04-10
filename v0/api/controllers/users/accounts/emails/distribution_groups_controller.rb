class V0
  module Api
    module Controllers
      module Users
        module Accounts
          module Emails
            module DistributionGroupsController
              extend Sinatra::Extension

              # Create :users :email :distribution_group
              #  params
              #  :user_uid [String]
              #  :distribution_group [Hash] { name: [String] }
              # @return [String] :users :account :email_distribution_group
              post '/users/accounts/email/distribution_groups/' do
                ldap.create_users_account_email_distribution_group params[:user_uid], params[:distribution_group]
              end

              # # Delete :users :email :distribution_group
              # #  params
              # #  :user_uid [String]
              # #  :name [String]
              # # @return [Hash] {}
              # delete '/users/accounts/email/distribution_groups/' do
              #   ldap.delete_users_account_email_distribution_group params[:user_uid], params[:email_address]
              # end

            end
          end
        end
      end
    end
  end
end
