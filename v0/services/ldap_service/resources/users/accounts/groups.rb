class V0
  module Services
    class LdapService
      module Resources
        module Users
          module Accounts
            module Groups

              def create_users_account_group( user_uid, group )
                net_ldap do |ldap|
                  begin
                    raise Error unless create_users_account_group_query( ldap, user_uid, group[:name] )
                    return group
                  rescue Error => e
                    ldap_op_error( ldap, "Failed to create account group" )
                  end
                end
              end

              def delete_users_account_group( user_uid, group_name )
                net_ldap do |ldap|
                  begin
                    raise Error unless delete_users_account_group_query( ldap, user_uid, group_name )
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
