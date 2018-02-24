class V0
  module Api
    module Controllers
      module EmailsController
        extend Sinatra::Extension

        # Show :email
        # @return [Hash]
        get '/email' do
          ldap.show_email
        end

      end
    end
  end
end
