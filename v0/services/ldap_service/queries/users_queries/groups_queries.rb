class V0
  module Services
    class LdapService
      module Queries
        module UsersQueries
          module GroupsQueries

            def index_users_groups_query( ldap )
              result = []
              ldap.search(
                filter: Net::LDAP::Filter.eq( "objectClass", "posixGroup" ),
                base: "ou=Groups,dc=engines,dc=internal" ) do |entry|
                result << entry.cn[0]
              end
              result

            end

            def show_users_group_query( ldap, name )
              dn = "cn=#{name},ou=Groups,dc=engines,dc=internal"
              entry = find_entry_by_dn_helper ldap, dn
              {
                name: name,
                members: entry.respond_to?(:memberuid) ? entry.memberuid : []
              }
            end


          end
        end
      end
    end
  end
end
