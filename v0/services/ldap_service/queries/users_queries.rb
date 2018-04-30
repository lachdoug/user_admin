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

          def show_user_account_dn_query( ldap, uid )
            # , user_auth[:password]
            { dn: find_user_entry_helper( ldap, uid ).dn }
          end

        end
      end
    end
  end
end
