class V0
  module Services
    class LdapService
      module Resources
        module Email
          module DefaultDomain

            def delete_email_default_domain
              net_ldap do |ldap|
                raise Error unless delete_email_default_domain_query( ldap ) ||
                ldap_op_error( ldap, "Failed to delete email default domain." )
                return {}
              end
            end

            def create_email_default_domain( default_domain )
              net_ldap do |ldap|
                begin
                  raise Error unless create_email_domain_query( ldap, default_domain[:name] ) &&
                    create_email_default_domain_query( ldap, default_domain[:name] )
                  return default_domain
                rescue Error => e
                  byebug
                  ldap_op_error( ldap, "Failed to create email default domain." )
                end
              end
            end

            def update_email_default_domain( default_domain )
              net_ldap do |ldap|
                raise Error unless update_email_default_domain_query( ldap, default_domain[:name] ) ||
                ldap_op_error( ldap, "Failed to update email default domain." )
                return default_domain
              end
            end

          end
        end
      end
    end
  end
end
