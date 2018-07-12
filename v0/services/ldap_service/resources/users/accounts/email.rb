class V0
  module Services
    class LdapService
      module Resources
        module Users
          module Accounts
            module Email

              require_relative 'email/distribution_groups'
              require_relative 'email/email_aliases'

              include DistributionGroups
              include EmailAliases


              def create_users_account_email( user_uid, email )
                net_ldap do |ldap|
                  begin
                    raise Error unless create_users_account_email_query( ldap, user_uid, email )
                    return email
                  rescue Error => e
                    ldap_op_error( ldap, "Failed to create account email." )
                  end
                end
              end

              def edit_users_account_email( user_uid )
                net_ldap do |ldap|
                  edit_users_account_email_query( ldap, user_uid )
                end
              end

              def update_users_account_email( user_uid, email )
                net_ldap do |ldap|
                  begin
                    raise Error unless update_users_account_email_query( ldap, user_uid, email )
                    return email
                  rescue Error => e
                    ldap_op_error( ldap, "Failed to update account email." )
                  end
                end
              end

              def delete_users_account_email( user_uid )
                net_ldap do |ldap|
                  begin
                    email = show_users_account_email_query( ldap, user_uid )
                    raise Error unless email[:aliases].empty? && email[:distribution_groups].empty?
                    raise Error unless delete_users_account_email_query( ldap, user_uid )
                    return {}
                  rescue Error => e
                    ldap_op_error( ldap, "Failed to delete account email." )
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
