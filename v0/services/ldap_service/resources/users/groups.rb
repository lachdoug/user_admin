class V0
  module Services
    class LdapService
      module Resources
        module Groups

          def index_users_groups
            net_ldap do |ldap|
              index_users_groups_query( ldap )
            end
          end

          def show_users_group( name )
            net_ldap do |ldap|
              show_users_group_query ldap, name
            end
          end

        end
      end
    end
  end
end
