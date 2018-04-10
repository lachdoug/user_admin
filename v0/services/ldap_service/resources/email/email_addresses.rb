class V0
  module Services
    class LdapService
      module Resources
        module Email
          module EmailAddresses

            def index_email_email_addresses
              net_ldap do |ldap|
                index_email_email_addresses_query ldap
              end
            end

            # def show_email_email_address( email_address )
            #   net_ldap do |ldap|
            #     show_email_email_address_query ldap, email_address
            #   end
            # end

          end
        end
      end
    end
  end
end
