class V0
  module Services
    class LdapService
      module Queries
        module UsersQueries
          module AccountsQueries
            module GroupsQueries

              def create_users_account_posix_group_query( ldap, user_uid, group_dn )
                ldap.modify(
                  dn: group_dn,
                  operations: [ [:add, :memberUid, user_uid ] ]
                )
              end

              def create_users_account_groupofnames_group_query( ldap, user_dn, group_dn )
                ldap.modify(
                  dn: group_dn,
                  operations: [ [:add, :member, user_dn ] ]
                )
              end

              def delete_users_account_posix_group_query( ldap, user_uid, group_dn )
                ldap.modify(
                  dn: group_dn,
                  operations: [ [:delete, :memberUid, user_uid ] ]
                )
              end

              def delete_users_account_groupofnames_group_query( ldap, user_dn, group_dn )
                ldap.modify(
                  dn: group_dn,
                  operations: [ [:delete, :member, user_dn ] ]
                )
              end

              def index_users_account_groups_query(ldap, user_uid)
                user_dn = find_user_entry_helper(ldap, user_uid).dn
                ( index_users_account_posix_groups_query(ldap, user_uid) +
                index_users_account_groupofnames_groups_query(ldap, user_dn) ).sort_by { |group| group[:name].downcase }
              end

              def index_users_account_posix_groups_query(ldap, user_uid)
                result = []
                ldap.search(
                  filter: Net::LDAP::Filter.eq( "memberUid", user_uid ),
                  base: "ou=Groups,dc=engines,dc=internal" ) do |entry|
                  result << { name: entry.cn[0], dn: entry.dn }
                end
                result
              end

              def index_users_account_groupofnames_groups_query(ldap, user_dn)
                result = []
                ldap.search(
                  filter: Net::LDAP::Filter.eq( "member", user_dn ),
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
