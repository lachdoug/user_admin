class V0
  module Services
    class LdapService
      module Queries
        module EmailQueries
          module DistributionGroupsQueries
            module EmailAddressesQueries

              def create_email_distribution_group_email_address_query( ldap, distribution_list_name, email_address )
                dn = "cn=#{distribution_list_name},ou=Distribution Groups,dc=engines,dc=internal"
                entry = find_entry_by_dn_helper(ldap, dn)
                add_attribute_value_to_entry_helper( ldap, entry, "memberuid", email_address )
              end

              def delete_email_distribution_group_email_address_query( ldap, distribution_list_name, email_address )
                dn = "cn=#{distribution_list_name},ou=Distribution Groups,dc=engines,dc=internal"
                entry = find_entry_by_dn_helper(ldap, dn)
                delete_attribute_value_from_entry_helper( ldap, entry, "memberuid", email_address || "" )
              end

            end
          end
        end
      end
    end
  end
end
