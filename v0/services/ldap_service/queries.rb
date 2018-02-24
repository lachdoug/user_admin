class V0
  module Services
    class LdapService
      module Queries
        
        require_relative 'queries/email_queries'
        require_relative 'queries/users_queries'

        include EmailQueries
        include UsersQueries

      end
    end
  end
end
