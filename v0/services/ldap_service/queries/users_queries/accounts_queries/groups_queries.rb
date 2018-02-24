class V0
  module Services
    class LdapService
      module Queries
        module UsersQueries
          module AccountsQueries
            module GroupsQueries

              def create_users_account_group_query( ldap, user_uid, group_name )
                ldap.modify(
                  dn: "cn=#{group_name},ou=Groups,dc=engines,dc=internal",
                  operations: [ [:add, :memberUid, user_uid ] ]
                )
              end

              def delete_users_account_group_query( ldap, user_uid, group_name )
                ldap.modify(
                  dn: "cn=#{group_name},ou=Groups,dc=engines,dc=internal",
                  operations: [ [:delete, :memberUid, user_uid ] ]
                )
              end

              def index_users_account_groups_query(ldap, user_uid)
                result = []
                ldap.search(
                  filter: Net::LDAP::Filter.eq( "memberUid", user_uid ),
                  base: "ou=Groups,dc=engines,dc=internal" ) do |entry|
                  result << entry.cn[0]
                end
                result
              end

            end
          end
        end
      end
    end
  end
end
