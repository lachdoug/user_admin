class V0
  module Services
    class LdapService
      module Resources
        module Users
          module Accounts
            module Password

              def update_users_account_password( user_uid, password )
                net_ldap do |ldap|
                  begin
                    raise Error unless update_users_account_password_query( ldap, user_uid, password )
                    return {}
                  rescue Error => e
                    ldap_op_error( ldap, "Failed to update account password." )
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
