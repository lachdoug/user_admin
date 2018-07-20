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

          def show_users_group( group_dn )
            net_ldap do |ldap|
              entry = find_entry_by_dn_helper(ldap, group_dn)
              if entry.objectClass.include? "posixGroup"
                raise Error unless result = show_users_posix_group_query( ldap, group_dn )
              else
                raise Error unless result = show_users_groupofnames_group_query( ldap, group_dn )
              end
              result
            end
          end

        end
      end
    end
  end
end
