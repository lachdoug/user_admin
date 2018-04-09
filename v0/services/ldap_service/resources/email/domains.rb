class V0
  module Services
    class LdapService
      module Resources
        module Email
          module Domains

            def create_email_domain( email_domain )
              net_ldap do |ldap|
                begin
                  raise Error unless create_email_domain_query( ldap, email_domain[:name] )
                  return email_domain
                rescue Error => e
                  ldap_op_error( ldap, "Failed to create email domain." )
                end
              end
            end

            def delete_email_domain( name )
              net_ldap do |ldap|
                email = show_email_query( ldap )
                if name == email[:default_domain]
                  if email[:domains].length > 1
                    raise Error.new "Default email domain must be deleted last."
                  else
                    delete_email_default_domain_query ldap
                  end
                end
                begin
                  raise Error unless delete_email_domain_query( ldap, name )
                  return {}
                rescue Error => e
                  ldap_op_error( ldap, "Failed to delete email domain." )
                end
              end
            end


          end
        end
      end
    end
  end
end
