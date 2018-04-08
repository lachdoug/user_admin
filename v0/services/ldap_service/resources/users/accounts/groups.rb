class V0
  module Services
    class LdapService
      module Resources
        module Users
          module Accounts
            module Groups

              def create_users_account_groups( user_uid, groups )
                net_ldap do |ldap|
                  groups.each do |group|
                    begin
                      raise Error unless create_users_account_group_query( ldap, user_uid, group[:name] )
                      return group
                    rescue Error => e
                      ldap_op_error( ldap, "Failed to create account group" )
                    end
                  end
                end
              end

              def delete_users_account_groups( user_uid, group_names )
                net_ldap do |ldap|
                  begin
                    group_names.each do |group_name|
                      raise Error unless delete_users_account_group_query( ldap, user_uid, group_name )
                    end
                    return {}
                  rescue Error => e
                    ldap_op_error( ldap, "Failed to delete account group" )
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
