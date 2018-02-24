class V0
  module Services
    class LdapService
      module Resources
        module Email
          module DistributionGroups

            require_relative 'distribution_groups/email_addresses'

            include EmailAddresses

            def index_email_distribution_groups
              net_ldap do |ldap|
                index_email_distribution_groups_query ldap
              end
            end
            #
            # def new_distribution_group
            #   net_ldap do |ldap|
            #     show_email_query ldap
            #   end
            # end

            def create_email_distribution_group(distribution_group)
              net_ldap do |ldap|
                begin
                  raise Error unless create_email_distribution_group_query( ldap, distribution_group )
                  return distribution_group
                rescue Error => e
                  ldap_op_error( ldap, "Failed to create distribution list." )
                end
              end
            end

            def show_email_distribution_group( name )
              net_ldap do |ldap|
                show_email_distribution_group_query ldap, name
              end
            end

            def update_email_distribution_group(name, distribution_group)
              net_ldap do |ldap|
                begin
                  raise Error unless update_email_distribution_group_query( ldap, name, distribution_group )
                  return distribution_group
                rescue Error => e
                  ldap_op_error( ldap, "Failed to update distribution list." )
                end
              end
            end

            # def edit_distribution_group( name )
            #   net_ldap do |ldap|
            #     dn = "cn=#{name},ou=Distribution Groups,dc=engines,dc=internal"
            #     entry = find_entry_by_dn_helper(ldap, dn)
            #     local_part, domain = entry.cn[0].split('@')
            #     {
            #       local_part: local_part,
            #       domain: domain,
            #       description: entry.respond_to?(:description) ? entry.description[0] : "",
            #       email_domains: email_domains(ldap)
            #     }
            #   end
            # end


            def delete_email_distribution_group(name)
              net_ldap do |ldap|
                begin
                  delete_email_distribution_group_query( ldap, name )
                  return {}
                rescue Error => e
                  ldap_op_error( ldap, "Failed to delete distribution list." )
                end
              end
            end


          end
        end
      end
    end
  end
end
