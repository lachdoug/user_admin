class V0
  module Api
    module Controllers
      module Emails
        module DomainsController
          extend Sinatra::Extension

          # # Index :email:domains
          # # @return [Hash] index of email_domains
          # get '/email/domains' do
          #   ldap.index_email_domains
          # end

          # Create :email :domain
          #  params
          #  :domain [Hash] new :email_domain data
          # @return [Hash] :domain
          post '/email/domains/' do
            ldap.create_email_domain params[:domain]
            # params[:domain]
          end

          # Delete :email :domain
          #  params
          #  :name [String] name of the :email_domain, e.g. 'engines.org'
          # @return [Hash] {}
          delete '/email/domains/' do
            ldap.delete_email_domain params[:name]
            # {}
          end

        end
      end
    end
  end
end
