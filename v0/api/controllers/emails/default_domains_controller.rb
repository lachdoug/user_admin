class V0
  module Api
    module Controllers
      module Emails
        module DefaultDomainsController
          extend Sinatra::Extension

          # Create :email :default_domain
          #  params
          #  :default_domain [Hash] { name: [String] }
          # @return [Hash] :default_domain
          post '/email/default_domain' do
            ldap.create_email_default_domain( params[:default_domain] )
          end

          # Update :email :default_domain
          #  params
          #  :default_domain [Hash] { name: [String] }
          # @return [Hash] :default_domain
          put '/email/default_domain' do
            ldap.update_email_default_domain( params[:default_domain] )
          end

          # Delete :email :default_domain
          #  params
          #  none
          # @return [Hash] {}
          delete '/email/default_domain' do
            ldap.delete_email_default_domain
          end

        end
      end
    end
  end
end
