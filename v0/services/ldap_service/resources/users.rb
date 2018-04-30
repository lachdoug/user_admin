class V0
  module Services
    class LdapService
      module Resources
        module Users

          require_relative 'users/accounts'
          require_relative 'users/groups'

          include Accounts
          include Groups

          def show_users
            net_ldap do |ldap|
              show_users_query ldap
            end
          end

          def show_user_account_dn( user_auth )
            net_ldap do |ldap|
              show_user_account_dn_query ldap, user_auth
            end
          end

        end
      end
    end
  end
end
