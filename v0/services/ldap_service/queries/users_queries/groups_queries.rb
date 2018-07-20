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
              result.sort_by { |group| group[:name].downcase }
            end

            def show_users_groupofnames_group_query( ldap, dn )
              entry = find_entry_by_dn_helper ldap, dn
              member_dns = entry.respond_to?(:member) ? entry.member : []
              members = member_dns.map do |member_dn|
                member_entry = find_entry_by_dn_helper ldap, member_dn
                member_entry.uid[0]
              end
              { name: entry.cn[0],
                dn: dn,
                members: members }
            end

            def show_users_posix_group_query( ldap, dn )
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
