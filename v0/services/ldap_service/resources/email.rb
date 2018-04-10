class V0
  module Services
    class LdapService
      module Resources
        module Email

          require_relative 'email/default_domain'
          require_relative 'email/distribution_groups'
          require_relative 'email/domains'
          require_relative 'email/email_addresses'

          include DefaultDomain
          include DistributionGroups
          include Domains
          include EmailAddresses

          def show_email
            net_ldap do |ldap|
              show_email_query ldap
            end
          end

        end
      end
    end
  end
end
