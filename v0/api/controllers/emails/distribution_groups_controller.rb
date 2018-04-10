class V0
  module Api
    module Controllers
      module Emails
        module DistributionGroupsController
          extend Sinatra::Extension

          # Index :distribution_groups
          # @return [Array]
          get '/email/distribution_groups' do
            ldap.index_email_distribution_groups
          end

          # Create :distribution_group
          #  params
          #  :distribution_group [Hash]
          #  {
          #   local_part: [String],
          #   domain: [String],
          #   description: [String]
          #  }
          # @return [Hash] :distribution_group
          post '/email/distribution_groups/' do
            ldap.create_email_distribution_group params[:distribution_group]
            name = "#{params[:distribution_group][:local_part]}@#{params[:distribution_group][:domain]}"
            ldap.show_email_distribution_group name
          end

          # Show :distribution_group
          #  params
          #  :name [String] <local_part>@<domain>
          # @return [Hash] :distribution_group
          get '/email/distribution_groups/' do
            ldap.show_email_distribution_group params[:name]
          end

          # Edit distribution_group
          #  params
          # :name [String] <local_part>@<domain>
          #  :distribution_group [Hash] distribution_group data
          # @return [Hash] :distribution_group
          get '/email/distribution_groups/edit' do
            ldap.edit_distribution_group params[:name]
          end

          # Update distribution_group
          #  params
          #  :name [String] <local_part>@<domain>
          #  :distribution_group [Hash] same as create
          # @return [Hash] distribution_group details
          put '/email/distribution_groups/' do
            ldap.update_email_distribution_group params[:name], params[:distribution_group]
            name = (
              params[:distribution_group][:local_part] &&
              params[:distribution_group][:domain]
              ) ?
              "#{params[:distribution_group][:local_part]}@#{params[:distribution_group][:domain]}" :
              params[:name]
            ldap.show_email_distribution_group name
          end

          # Delete distribution_group
          #  params
          #  :name [String] <local_part>@<domain>
          # @return [Hash] empty
          delete '/email/distribution_groups/' do
            ldap.delete_email_distribution_group params[:name]
          end

        end
      end
    end
  end
end
