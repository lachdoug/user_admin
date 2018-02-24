class V0
  module Services
    class LdapService
      module Resources
        module Users
          module Accounts
            module Email
              module EmailAliases

                def create_users_account_email_alias( user_uid, email_alias )
                  net_ldap do |ldap|
                    begin
                      raise Error unless create_users_account_email_alias_query( ldap, user_uid, email_alias[:address] )
                      return email_alias
                    rescue Error => e
                      ldap_op_error( ldap, "Failed to create email alias." )
                    end
                  end
                end

                def delete_users_account_email_alias( user_uid, email_address )
                  net_ldap do |ldap|
                    begin
                      raise Error unless delete_users_account_email_alias_query( ldap, user_uid, email_address )
                      return {}
                    rescue Error => e
                      ldap_op_error( ldap, "Failed to delete email alias." )
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
end
