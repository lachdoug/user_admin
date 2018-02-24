class V0
  module Services
    class LdapService
      module Queries
        module EmailQueries
          module DistributionGroupsQueries

            require_relative 'distribution_groups_queries/email_addresses_queries'

            include EmailAddressesQueries

            def index_email_distribution_groups_query( ldap )
              dn = "ou=Distribution Groups,dc=engines,dc=internal"
              entries = find_children_entries_of_dn_helper( ldap, dn )
              entries.map do |entry|
                {
                  name: entry.cn[0],
                  description: entry.respond_to?(:description) ? entry.description[0] : ""
                }
              end
            end

            def show_email_distribution_group_query( ldap, name )
              dn = "cn=#{name},ou=Distribution Groups,dc=engines,dc=internal"
              entry = find_entry_by_dn_helper(ldap, dn)
              {
                name: entry.cn[0],
                description: entry.respond_to?(:description) ? entry.description[0] : "",
                email_addresses: entry.respond_to?(:memberuid) ? entry.memberuid : []
              }
            end

            def create_email_distribution_group_query ldap, distribution_group
              cn = "#{distribution_group[:local_part]}@#{distribution_group[:domain]}"
              dn = "cn=#{cn},ou=Distribution Groups,dc=engines,dc=internal"
              gidnumber = next_available_gidnumber_helper ldap
              attributes = {
                cn: cn,
                gidnumber: gidnumber,
                objectclass: [
                  "posixGroup",
                  "top" ],
              }
              attributes.merge! description: distribution_group[:description] if
                distribution_group[:description].to_s.length > 0
              add_entry_helper ldap, dn, attributes
            end

            def update_email_distribution_group_query( ldap, name, distribution_group )
              dn = "cn=#{name},ou=Distribution Groups,dc=engines,dc=internal"
              entry = find_entry_by_dn_helper(ldap, dn)
              update_email_distribution_group_description_query( ldap, entry, distribution_group ) &&
              update_email_distribution_group_cn_query( ldap, entry, distribution_group )
            end

            def update_email_distribution_group_description_query( ldap, entry, distribution_group )
              distribution_group[:description].nil? ||
              if entry.respond_to?(:description)
                replace_attribute_value_on_entry_helper ldap, entry, "description", distribution_group[:description]
              else
                add_attribute_value_to_entry_helper ldap, entry, "description", distribution_group[:description]
              end
            end

            def update_email_distribution_group_cn_query( ldap, entry, distribution_group )
              new_name = "#{distribution_group[:local_part]}@#{distribution_group[:domain]}"
              distribution_group[:local_part].nil? || distribution_group[:domain].nil? ||
              new_name == entry.cn[0] || (
                  new_rdn = "cn=" + new_name
                  update_entry_rdn_helper ldap, entry, new_rdn
              )
            end

            def delete_email_distribution_group_query( ldap, name )
              dn = "cn=#{name},ou=Distribution Groups,dc=engines,dc=internal"
              entry = find_entry_by_dn_helper(ldap, dn)
              delete_entry_helper ldap, entry
            end

          end
        end
      end
    end
  end
end
