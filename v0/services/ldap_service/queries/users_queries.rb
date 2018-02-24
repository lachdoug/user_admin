class V0
  module Services
    class LdapService
      module Queries
        module UsersQueries

          require_relative 'users_queries/accounts_queries'
          require_relative 'users_queries/groups_queries'

          include AccountsQueries
          include GroupsQueries

          def show_users_query( ldap )
            {
              accounts: index_users_accounts_query( ldap ),
              groups: index_users_groups_query( ldap )
            }
          end

        end
      end
    end
  end
end
