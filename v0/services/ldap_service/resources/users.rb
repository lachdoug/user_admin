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

        end
      end
    end
  end
end
