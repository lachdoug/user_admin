class V0
  module Services
    class LdapService
      module Queries
        module UsersQueries
          module AccountsQueries
            module GroupsQueries

              def create_users_account_group_query( ldap, user_uid, dn )
                ldap.modify(
                  dn: dn,
                  operations: [ [:add, :memberUid, user_uid ] ]
                )
              end

              def delete_users_account_group_query( ldap, user_uid, dn )
                ldap.modify(
                  dn: dn,
                  operations: [ [:delete, :memberUid, user_uid ] ]
                )
              end

              def index_users_account_groups_query(ldap, user_uid)
                result = []
                ldap.search(
                  filter: Net::LDAP::Filter.eq( "memberUid", user_uid ),
                  base: "ou=Groups,dc=engines,dc=internal" ) do |entry|
                  result << { name: entry.cn[0], dn: entry.dn }
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
