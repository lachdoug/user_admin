class V0
  module Services
    class LdapService
      module Resources
        module Users
          module Accounts
            module Email
              module DistributionGroups

                def new_users_account_email_distribution_group( user_uid )
                  net_ldap do |ldap|
                    new_users_account_email_distribution_group_query( ldap, user_uid )
                  end
                end

                def create_users_account_email_distribution_group( user_uid, distribution_group )
                  net_ldap do |ldap|
                    begin
                      raise Error unless create_users_account_email_distribution_group_query( ldap, user_uid, distribution_group[:name] )
                      return distribution_group
                    rescue Error => e
                      ldap_op_error( ldap, "Failed to create email distribution group." )
                    end
                  end
                end

                # def delete_users_account_email_distribution_group( user_uid, distribution_group_name, email_address )
                #   net_ldap do |ldap|
                #     begin
                #       raise Error unless delete_users_account_email_distribution_group_query( ldap, user_uid, distribution_group_name, email_address )
                #       return {}
                #     rescue Error => e
                #       ldap_op_error( ldap, "Failed to delete email distribution group." )
                #     end
                #   end
                # end

              end
            end
          end
        end
      end
    end
  end
end
