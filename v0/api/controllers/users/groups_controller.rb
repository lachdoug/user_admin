class V0
  module Api
    module Controllers
      module Users
        module GroupsController
          extend Sinatra::Extension

          # Index :users :groups
          # @return [Array] index of :users :groups
          get '/users/groups' do
            ldap.index_users_groups
          end

          # Show :users :group
          #  params
          #  :name [String] name of the :users :group
          # @return [Hash] :users :group
          get '/users/groups/' do
            ldap.show_users_group params[:name]
          end



        end
      end
    end
  end
end
