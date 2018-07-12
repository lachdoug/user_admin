class V0
  module Services
    class LdapService
      module Resources
        module Email
          module DistributionGroups
            module EmailAddresses

              def new_email_distribution_group_email_address( distribution_list_name )
                net_ldap do |ldap|
                  mailbox_and_alias_email_addresses =
                    index_email_mailboxes_email_addresses_query(ldap).map{ |email_address| email_address[:email_address] } +
                    index_email_aliases_email_addresses_query(ldap).map{ |email_address| email_address[:email_address] }
                  existing_email_addresses =
                    show_email_distribution_group_query(ldap, distribution_list_name)[:email_addresses]
                  { email_addresses: mailbox_and_alias_email_addresses - existing_email_addresses }
                end
              end

              # args
              #  :distribution_list_name [String]
              #  :email_address [Hash] { address: [String] }
              # @return [Hash] :email_address
              def create_email_distribution_group_email_address( distribution_list_name, email_address )
                net_ldap do |ldap|
                  begin
                    raise Error unless email_address && email_address[:address]
                    raise Error unless create_email_distribution_group_email_address_query( ldap, distribution_list_name, email_address[:address] )
                    return email_address
                  rescue Error => e
                    ldap_op_error( ldap, "Failed to create distribution group email address." )
                  end
                end
              end
              #
              # args
              #  :distribution_list_name [String]
              #  :address [String]
              # @return [Hash] {}
              def delete_email_distribution_group_email_address( distribution_list_name, address )
                # raise Error.new "Requires address." unless address
                net_ldap do |ldap|
                  begin
                    # raise Error unless email_address && email_address[:address]
                    raise Error unless delete_email_distribution_group_email_address_query( ldap, distribution_list_name, address )
                    return {}
                  rescue Error => e
                    ldap_op_error( ldap, "Failed to delete distribution group email address." )
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
