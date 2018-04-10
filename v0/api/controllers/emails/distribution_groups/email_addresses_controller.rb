class V0
  module Api
    module Controllers
      module Emails
        module DistributionGroups
          module EmailAddressesController
            extend Sinatra::Extension

            # New :distribution_group :email_address
            #
            #  params
            #  :distribution_group_name [String]
            # @return [Hash]
            get '/email/distribution_groups/email_addresses/new' do
              ldap.new_email_distribution_group_email_address( params[:distribution_group_name] )
            end

            # Create :distribution_group :email_address
            #
            #  params
            #  :distribution_group_name [String]
            #  :email_address [Hash]
            #   { address: [String] }
            # @return [Hash]
            post '/email/distribution_groups/email_addresses/' do
              ldap.create_email_distribution_group_email_address( params[:distribution_group_name], params[:email_address] )
            end

            # Delete :distribution_group :email_address
            #
            #  params
            #  :distribution_group_name [String]
            #  :address [String]
            # @return [Hash] {}
            delete '/email/distribution_groups/email_addresses/' do
              ldap.delete_email_distribution_group_email_address( params[:distribution_group_name], params[:address] )
            end

          end
        end
      end
    end
  end
end
