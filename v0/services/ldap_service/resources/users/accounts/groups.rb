class V0
  module Services
    class LdapService
      module Resources
        module Users
          module Accounts
            module Groups

              def new_users_account_groups( user_uid )
                net_ldap do |ldap|
                  existing_groups = index_users_account_groups_query(ldap, user_uid)
                  all_groups = index_users_groups_query( ldap )
                  available_groups = all_groups - existing_groups
                  return { groups: available_groups }
                end
              end

              def create_users_account_groups( user_uid, group_dns )
                net_ldap do |ldap|
                  begin
                    group_dns.each do |group_dn|
                      # byebug
                      entry = find_entry_by_dn_helper(ldap, group_dn)
                      if entry.objectClass.include? "posixGroup"
                        raise Error unless create_users_account_posix_group_query( ldap, user_uid, group_dn )
                      else
                        user_dn = find_user_entry_helper(ldap, user_uid).dn
                        raise Error unless create_users_account_groupofnames_group_query( ldap, user_dn, group_dn )
                      end
                    end
                    group_dns.map do |group_dn|
                      entry = find_entry_by_dn_helper ldap, group_dn
                      {
                        name: entry.cn[0],
                        dn: entry.dn
                      }
                    end
                  rescue Error => e
                    ldap_op_error( ldap, "Failed to create account group." )
                  end
                end
              end

              def delete_users_account_groups( user_uid, group_dns )
                net_ldap do |ldap|
                  begin
                    group_dns.each do |group_dn|
                      entry = find_entry_by_dn_helper(ldap, group_dn)
                      if entry.objectClass.include? "posixGroup"
                        raise Error unless delete_users_account_posix_group_query( ldap, user_uid, group_dn )
                      else
                        user_dn = find_user_entry_helper(ldap, user_uid).dn
                        raise Error unless delete_users_account_groupofnames_group_query( ldap, user_dn, group_dn )
                      end
                    end
                    return {}
                  rescue Error => e
                    ldap_op_error( ldap, "Failed to delete account group." )
                  end
                end
              end

            end
          end
        end
      end
    end
  end
end
