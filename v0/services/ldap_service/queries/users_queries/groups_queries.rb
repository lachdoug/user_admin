class V0
  module Services
    class LdapService
      module Queries
        module UsersQueries
          module GroupsQueries

            def index_users_groups_query( ldap )
              result = []
              ldap.search(
                filter: Net::LDAP::Filter.present( "objectClass" ),
                base: "ou=Groups,dc=engines,dc=internal" ) do |entry|
                  # byebug
                result << { name: entry.cn[0], dn: entry.dn } unless entry.objectClass[0] == "organizationalUnit"
              end
              result
            end

            def show_users_group_query( ldap, dn )
              entry = find_entry_by_dn_helper ldap, dn
              { name: entry.cn[0],
                dn: dn,
                members: entry.respond_to?(:memberuid) ? entry.memberuid : [] }
            end

          end
        end
      end
    end
  end
end
