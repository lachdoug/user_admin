class V0
  module Services
    class LdapService
      module Queries
        module EmailQueries
          module DefaultDomainQueries

            def show_email_default_domain_query( ldap )
              dn = "ou=default domain,ou=email,ou=Services,ou=Containers,ou=Engines,dc=engines,dc=internal"
              entry = find_singleton_child_entry_of_dn_helper(ldap, dn)
              entry.dc[0]
            rescue Error::EntryMissing
              ""
            end

            def create_email_default_domain_query( ldap, name )
              dn = "dc=#{name},ou=default domain,ou=email,ou=Services,ou=Containers,ou=Engines,dc=engines,dc=internal"
              add_entry_helper( ldap, dn, { dc: name, objectclass: [ "dNSDomain" ] } )
            end

            def update_email_default_domain_query( ldap, name )
              dn = "ou=default domain,ou=email,ou=Services,ou=Containers,ou=Engines,dc=engines,dc=internal"
              entry = find_singleton_child_entry_of_dn_helper(ldap, dn)
              update_entry_rdn_helper( ldap, entry, "dc=#{name}" )
            end

            def delete_email_default_domain_query ldap
              dn = "ou=default domain,ou=email,ou=Services,ou=Containers,ou=Engines,dc=engines,dc=internal"
              entry = find_singleton_child_entry_of_dn_helper(ldap, dn)
              delete_entry_helper ldap, entry
            end

          end
        end
      end
    end
  end
end
