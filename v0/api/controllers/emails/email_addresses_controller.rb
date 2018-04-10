class V0
  module Api
    module Controllers
      module Emails
        module EmailAddressesController
          extend Sinatra::Extension

          # Index :email_addresses
          # @return [Array]
          get '/email/email_addresses' do
            ldap.index_email_email_addresses
          end

          # # Show :email_address
          # #  params
          # #  :email_address [String] <local_part>@<domain>
          # # @return [Hash] :email_address
          # get '/email/email_addresses/' do
          #   ldap.show_email_email_address params[:email_address]
          # end

        end
      end
    end
  end
end
