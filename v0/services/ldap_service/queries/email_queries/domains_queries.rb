class V0
  module Services
    class LdapService
      module Queries
        module EmailQueries
          module DomainsQueries

            def index_email_domains_query( ldap )
              dn = "ou=domains,ou=email,ou=Services,ou=Containers,ou=Engines,dc=engines,dc=internal"
              entries = find_children_entries_of_dn_helper( ldap, dn )
              entries.map do |entry|
                entry.dc[0]
              end
            end

            def create_email_domain_query( ldap, name )
              dn = "dc=#{name},ou=domains,ou=email,ou=Services,ou=Containers,ou=Engines,dc=engines,dc=internal"
              attributes = {
                dc: name,
                objectclass: [ "dNSDomain" ],
              }
              add_entry_helper ldap, dn, attributes
            end

            def delete_email_domain_query ldap, name
              dn = "dc=#{name},ou=domains,ou=email,ou=Services,ou=Containers,ou=Engines,dc=engines,dc=internal"
              entry = find_entry_by_dn_helper(ldap, dn)
              delete_entry_helper ldap, entry
            end

          end
        end
      end
    end
  end
end
